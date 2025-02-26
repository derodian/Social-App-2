import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/constants/firebase_collection_name.dart';
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/features/auth/data/app_user_filter.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/domain/provider_data.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';
import 'package:social_app_2/src/features/services/logger.dart';
import 'package:social_app_2/src/utils/image_utils.dart';

part 'app_user_storage_service.g.dart';

/// Custom exception for AppUserStorageRepository
class AppUserException implements Exception {
  final String message;
  AppUserException(this.message);

  @override
  String toString() => 'AppUserException: $message';
}

// Supporting classes
enum FetchStrategy {
  fetchAll,
  paginatedWithCache,
  paginatedRealTime,
}

class UserFetchResult {
  final List<AppUser> users;
  final FetchStrategy strategy;
  final bool hasMore;
  final DocumentSnapshot? lastDocument;

  const UserFetchResult({
    required this.users,
    required this.strategy,
    required this.hasMore,
    this.lastDocument,
  });
}

class CacheEntry<T> {
  final T data;
  final DateTime timestamp;

  CacheEntry({
    required this.data,
    required this.timestamp,
  });
}

/// Class for handling User info
@riverpod
class AppUserStorageService extends _$AppUserStorageService {
  // Firebase instances
  late final FirebaseFirestore _firestore;
  late final FirebaseStorage _storage;
  late final CollectionReference<Map<String, dynamic>> _usersCollection;

  // Constants for optimization
  static const int _smallDatasetLimit = 100;
  static const int _defaultPageSize = 20;
  static const Duration _cacheExpiry = Duration(minutes: 15);

  // Cache for storing frequently accessed data
  final Map<String, CacheEntry<UserFetchResult>> _cache = {};

  final _log = getLogger('AppUserStorageRepository');

  @override
  AppUserStorageService build() {
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
    _usersCollection = _firestore.collection(FirebaseCollectionName.users);
    return this; // Return the service instance
  }

  int getCurrentTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String usersPath() => FirebaseCollectionName.users;
  static String userPath(UserID id) => '${FirebaseCollectionName.users}/$id';

  /// Fetches a list of AppUsers with pagination
  ///
  /// [limit] determines the number of users to fetch per page
  /// [startAfter] is the last document from the previous fetch, used for pagination

  /// Fetches a single user by ID
  Future<AppUser?> getAppUser(String userId) async {
    try {
      final doc = await _usersCollection.doc(userId).get();
      if (!doc.exists) {
        debugPrint('No user document found for ID: $userId');
        return null;
      }
      // return AppUser.fromFirestore(doc);
      return doc.toAppUser();
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e);
    }
  }

  /// Watches a single user for real-time updates
  Stream<AppUser?> watchAppUser(String userId) {
    return _usersCollection.doc(userId).snapshots().distinct((previous, next) {
      // Only emit if data actually changed
      return previous.data()?.toString() == next.data()?.toString();
    }).map((doc) {
      if (!doc.exists) return null;
      return doc.toAppUser();
    });
  }

  /// Fetches users with smart pagination and caching strategy
  Future<UserFetchResult> fetchAppUsers({
    int? limit,
    DocumentSnapshot? startAfter,
    AppUserFilter? filter,
  }) async {
    final strategy = await _determineStrategy();

    switch (strategy) {
      case FetchStrategy.fetchAll:
        return _fetchAllUsers(filter);
      case FetchStrategy.paginatedWithCache:
        return _fetchPaginatedWithCache(
          limit: limit ?? _defaultPageSize,
          startAfter: startAfter,
          filter: filter,
        );
      case FetchStrategy.paginatedRealTime:
        return _fetchPaginatedRealTime(
          limit: limit ?? _defaultPageSize,
          startAfter: startAfter,
          filter: filter,
        );
    }
  }

  /// Watches users list with real-time updates
  Stream<List<AppUser>> watchAppUsers({
    int limit = _defaultPageSize,
    AppUserFilter? filter,
  }) {
    Query<Map<String, dynamic>> query = _usersCollection;

    if (filter != null) {
      query = _applyFilters(query, filter);
    }

    return query
        .orderBy('lastLoginAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.toAppUser())
            .whereType<AppUser>()
            .toList());
  }

  /// Searches users by name or email
  Stream<List<AppUser>> searchAppUsers(
    String searchTerm, {
    int limit = _defaultPageSize,
    Duration debounceTime = const Duration(milliseconds: 300),
  }) {
    if (searchTerm.trim().isEmpty) {
      return Stream.value([]);
    }

    // Convert to lowercase for case-insensitive search
    final term = searchTerm.toLowerCase();

    return _usersCollection
        .where('searchTerms', arrayContains: term)
        .orderBy('lastLoginAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.toAppUser())
            .whereType<AppUser>()
            .toList());
  }

  // Private helper methods for fetching data

  // Efficient data fetching strategy based on data size
  Future<FetchStrategy> _determineStrategy() async {
    final totalCount = await _getTotalUserCount();

    if (totalCount < _smallDatasetLimit) {
      return FetchStrategy.fetchAll;
    } else if (totalCount < 1000) {
      return FetchStrategy.paginatedWithCache;
    } else {
      return FetchStrategy.paginatedRealTime;
    }
  }

  // Get total count efficiently using counter collection
  Future<int> _getTotalUserCount() async {
    final countDoc = await _firestore.collection('metadata').doc('users').get();
    return countDoc.data()?['count'] ?? 0;
  }

  /// Fetches all users at once (for small datasets)
  Future<UserFetchResult> _fetchAllUsers(AppUserFilter? filter) async {
    Query<Map<String, dynamic>> query = _usersCollection;

    if (filter != null) {
      query = _applyFilters(query, filter);
    }

    final snapshot = await query.orderBy('lastLoginAt', descending: true).get();
    final users = snapshot.docs
        .map((doc) => doc.toAppUser())
        .whereType<AppUser>()
        .toList();

    return UserFetchResult(
      users: users,
      strategy: FetchStrategy.fetchAll,
      hasMore: false,
    );
  }

  /// Fetches users with caching (for medium datasets)
  Future<UserFetchResult> _fetchPaginatedWithCache({
    required int limit,
    DocumentSnapshot? startAfter,
    AppUserFilter? filter,
  }) async {
    final cacheKey = _generateCacheKey(limit, startAfter, filter);
    final cachedData = _cache[cacheKey];

    if (cachedData != null && !_isCacheExpired(cachedData.timestamp)) {
      return cachedData.data;
    }

    final result = await _fetchFromFirestore(limit, startAfter, filter);
    _cache[cacheKey] = CacheEntry(
      data: result,
      timestamp: DateTime.now(),
    );

    return result;
  }

  // For large datasets - real-time pagination
  Future<UserFetchResult> _fetchPaginatedRealTime({
    required int limit,
    DocumentSnapshot? startAfter,
    AppUserFilter? filter,
  }) async {
    return _fetchFromFirestore(limit, startAfter, filter);
  }

  // Helper for Firestore fetching
  Future<UserFetchResult> _fetchFromFirestore(
    int limit,
    DocumentSnapshot? startAfter,
    AppUserFilter? filter,
  ) async {
    Query<Map<String, dynamic>> query = _usersCollection;

    if (filter != null) {
      query = _applyFilters(query, filter);
    }

    query = query.orderBy('lastLoginAt', descending: true).limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();
    final users = snapshot.docs
        .map((doc) => doc.toAppUser())
        .whereType<AppUser>()
        .toList();

    return UserFetchResult(
      users: users,
      strategy: FetchStrategy.paginatedRealTime,
      hasMore: users.length >= limit,
      lastDocument: users.isNotEmpty ? snapshot.docs.last : null,
    );
  }

  /// Applies filters to query
  Query<Map<String, dynamic>> _applyFilters(
    Query<Map<String, dynamic>> query,
    AppUserFilter filter,
  ) {
    if (filter.isEmailVerified != null) {
      query = query.where('isEmailVerified', isEqualTo: filter.isEmailVerified);
    }
    if (filter.isAdminApproved != null) {
      query = query.where('isAdminApproved', isEqualTo: filter.isAdminApproved);
    }
    if (filter.isAdmin != null) {
      query = query.where('isAdmin', isEqualTo: filter.isAdmin);
    }
    if (filter.provider != null) {
      query = query.where('provider', isEqualTo: filter.provider?.name);
    }
    if (filter.domain != null) {
      query = query
          .where('email', isGreaterThanOrEqualTo: filter.domain)
          .where('email', isLessThan: '${filter.domain}z');
    }
    if (filter.searchTerm?.isNotEmpty ?? false) {
      final searchTerms = _generateSearchTerms(filter.searchTerm!);
      query = query.where('searchTerms', arrayContainsAny: searchTerms);
    }
    if (filter.createdAfter != null) {
      query =
          query.where('createdAt', isGreaterThanOrEqualTo: filter.createdAfter);
    }
    if (filter.createdBefore != null) {
      query =
          query.where('createdAt', isLessThanOrEqualTo: filter.createdBefore);
    }

    // Apply sorting
    query = query.orderBy(
      filter.sortField.fieldName,
      descending: !filter.sortOrder.isAscending,
    );

    return query;
  }

  List<String> _generateSearchTerms(String searchTerm) {
    final normalizedTerm = searchTerm.toLowerCase().trim();
    final terms = <String>[];

    // Add full term
    terms.add(normalizedTerm);

    // Add individual words
    terms.addAll(normalizedTerm.split(' ').where((term) => term.isNotEmpty));

    // Add email domain if search term looks like an email
    if (normalizedTerm.contains('@')) {
      final domain = normalizedTerm.split('@').last;
      terms.add(domain);
    }

    return terms;
  }

  // Cache management

  bool _isCacheExpired(DateTime timestamp) {
    return DateTime.now().difference(timestamp) > _cacheExpiry;
  }

  String _generateCacheKey(
    int limit,
    DocumentSnapshot? startAfter,
    AppUserFilter? filter,
  ) {
    return 'users_${limit}_${startAfter?.id}_${filter.hashCode}';
  }

  void clearCache() {
    _cache.clear();
  }

  /// Watches a stream of a user's admin status
  Stream<bool> isAppUserAdmin(UserID id) {
    return _firestore
        .collection(FirebaseCollectionName.users)
        .doc(id)
        .snapshots()
        .map((snapshot) =>
            snapshot.data()?[FirestoreFieldName.isAdmin] ?? false);
  }

  /// Watches a stream of a user's approval status
  Stream<bool> isAppUserApproved(UserID id) {
    return _firestore
        .collection(FirebaseCollectionName.users)
        .doc(id)
        .snapshots()
        .map((snapshot) =>
            snapshot.data()?[FirestoreFieldName.isApproved] ?? false);
  }

  /// Saves or updates a device token for push notifications
  static Future<void> saveDeviceToken({
    required String deviceToken,
    String? uid,
    String? apnsToken,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    if (uid != null) {
      final userDocRef = firestore.collection(usersPath()).doc(uid);
      final deviceTokenDocRef = userDocRef
          .collection(FirebaseCollectionName.deviceToken)
          .doc(deviceToken);

      batch.set(
          deviceTokenDocRef,
          {
            FirestoreFieldName.deviceToken: deviceToken,
            FirestoreFieldName.apnsToken: apnsToken,
            FirestoreFieldName.createDate: FieldValue.serverTimestamp(),
            FirestoreFieldName.platform: Platform.operatingSystem,
          },
          SetOptions(merge: true));
    }

    final deviceTokenDocRef = firestore
        .collection(FirebaseCollectionName.deviceToken)
        .doc(uid ?? deviceToken);

    batch.set(
        deviceTokenDocRef,
        {
          FirestoreFieldName.deviceToken: FieldValue.arrayUnion([deviceToken]),
          FirestoreFieldName.apnsToken:
              FieldValue.arrayUnion([if (apnsToken != null) apnsToken]),
          FirestoreFieldName.userId: uid,
          FirestoreFieldName.createDate: FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true));

    await batch.commit();
  }

  // use this to delete any document created by user that is being deleted.
  Future<void> _deleteAllDocuments({
    required String userId,
    required String inCollection,
  }) {
    return FirebaseFirestore.instance.runTransaction(
      maxAttempts: 3,
      timeout: const Duration(
        seconds: 20,
      ),
      (transaction) async {
        final query = await FirebaseFirestore.instance
            .collection(inCollection)
            .where(
              FirestoreFieldName.id,
              isEqualTo: userId,
            )
            .get();
        for (final doc in query.docs) {
          transaction.delete(doc.reference);
        }
      },
    );
  }

  /// Updates user's admin status
  /// Only existing admins can grant/revoke admin status
  Future<void> updateAdminStatus(String userId, bool isAdmin) async {
    try {
      await _runTransactionSafely((transaction) async {
        final userDoc = _usersCollection.doc(userId);
        final snapshot = await transaction.get(userDoc);

        if (!snapshot.exists) {
          throw Exception('User not found');
        }

        final existingUser = snapshot.toAppUser();
        if (existingUser == null) throw Exception('Invalid user data');

        // Update user data
        final updatedUser = existingUser.copyWith(
          isAdmin: isAdmin,
          lastUpdateDate: DateTime.now(),
        );

        // Update in Firestore
        transaction.update(userDoc, updatedUser.toFirestore());

        // Send notification email to user
        await _sendStatusUpdateEmail(
          userEmail: existingUser.email,
          type: 'admin',
          granted: isAdmin,
        );
      });
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e);
    }
  }

  /// Updates user's approval status
  /// Only admins can approve/disapprove users
  Future<void> updateApprovalStatus(String userId, bool isApproved) async {
    try {
      await _runTransactionSafely((transaction) async {
        final userDoc = _usersCollection.doc(userId);
        final snapshot = await transaction.get(userDoc);

        if (!snapshot.exists) {
          throw Exception('User not found');
        }

        final existingUser = snapshot.toAppUser();
        if (existingUser == null) throw Exception('Invalid user data');

        // Update user data
        final updatedUser = existingUser.copyWith(
          isApproved: isApproved,
          lastUpdateDate: DateTime.now(),
        );

        // Update in Firestore
        transaction.update(userDoc, updatedUser.toFirestore());

        // Send notification email to user
        await _sendStatusUpdateEmail(
          userEmail: existingUser.email,
          type: 'approval',
          granted: isApproved,
        );
      });
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e);
    }
  }

  /// Private helper to send status update emails
  Future<void> _sendStatusUpdateEmail({
    required String userEmail,
    required String type,
    required bool granted,
  }) async {
    final templateData = switch (type) {
      'admin' when granted => {
          'subject': 'Admin Access Granted',
          'body': 'You have been granted admin access to the application.',
        },
      'admin' when !granted => {
          'subject': 'Admin Access Revoked',
          'body': 'Your admin access to the application has been revoked.',
        },
      'approval' when granted => {
          'subject': 'Account Approved',
          'body':
              'Your account has been approved. You can now access all features.',
        },
      'approval' when !granted => {
          'subject': 'Account Access Restricted',
          'body': 'Your account approval has been revoked.',
        },
      _ => throw Exception('Invalid status update type'),
    };

    // You can implement email sending here using your preferred method
    // For example, using Firebase Cloud Functions
    await _firestore.collection('mail').add({
      'to': userEmail,
      'message': {
        'subject': templateData['subject'],
        'text': templateData['body'],
      },
    });
  }

  // Save Device Token for push notification
  Future createDeviceToken({required String token, UserID? userId}) async {
    try {
      await _firestore
          .collection(FirebaseCollectionName.deviceToken)
          .doc(userId ?? token)
          .set({
        FirestoreFieldName.deviceToken: token,
        FirestoreFieldName.createDate: FieldValue.serverTimestamp(),
        FirestoreFieldName.platform: Platform.operatingSystem,
      });
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  // Basic CRUD with Transactions

  Future<void> createUser(AppUser user) async {
    debugPrint('Starting Firestore user creation');
    try {
      final userDoc = _usersCollection.doc(user.id);

      // Check if user exists
      final exists = await userDoc.get();
      if (exists.exists) {
        throw Exception('User already exists in Firestore');
      }

      // Convert user to Firestore data
      final userData = user.toFirestore();
      debugPrint('Converting user to Firestore data');

      // Save to Firestore
      await userDoc.set(userData);
      debugPrint('Successfully saved user to Firestore');
    } catch (e) {
      debugPrint('Error creating user in Firestore: $e');
      throw Exception('Failed to create user profile: ${e.toString()}');
    }
  }

  // Method to handle user creation or update from social auth
  Future<AppUser> createOrUpdateSocialUser(
      AppUser user, AppAuthProvider provider) async {
    return _runTransactionSafely((transaction) async {
      final userDoc = _usersCollection.doc(user.id);
      final snapshot = await transaction.get(userDoc);

      if (snapshot.exists) {
        // User exists, update last login and merge any new data
        final existingUser = snapshot.toAppUser();
        if (existingUser == null) throw Exception('Invalid user data');

        final updatedUser = existingUser.copyWith(
          lastLoginDate: DateTime.now(),
          lastUpdateDate: DateTime.now(),
          // Update these fields only if they're empty in existing user
          displayName: existingUser.displayName.isEmpty
              ? user.displayName
              : existingUser.displayName,
          profileImageURL: existingUser.profileImageURL ?? user.profileImageURL,
          phoneNumber: existingUser.phoneNumber ?? user.phoneNumber,
          // Always update these fields
          isEmailVerified: true, // Social auth emails are typically verified
          // TODO: Add new provider passed to providerData
          providerData: user.providerData,
        );

        transaction.update(userDoc, updatedUser.toFirestore());
        return updatedUser;
      } else {
        // New user, create with social auth data
        transaction.set(userDoc, user.toFirestore());
        return user;
      }
    });
  }

  // Method to link additional providers to existing user
  Future<AppUser> linkProvider(String userId, AppAuthProvider provider) async {
    return _runTransactionSafely((transaction) async {
      final userDoc = _usersCollection.doc(userId);
      final snapshot = await transaction.get(userDoc);

      if (!snapshot.exists) {
        throw Exception('User does not exist');
      }

      final existingUser = snapshot.toAppUser();
      if (existingUser == null) throw Exception('Invalid user data');

      // Update the user's linked providers
      final updatedProviders = [
        ...existingUser.linkedProviders
      ]; // Since it has default empty list
      if (!updatedProviders.contains(provider.name)) {
        updatedProviders.add(provider.name);
      }

      // Create updated user
      final updatedUser = existingUser.copyWith(
        linkedProviders: updatedProviders,
        lastUpdateDate: DateTime.now(),
      );

      // Update in Firestore
      transaction.update(userDoc, updatedUser.toFirestore());

      return updatedUser;
    });
  }

  // Method to unlink provider
  Future<AppUser> unlinkProvider(
      String userId, AppAuthProvider provider) async {
    return _runTransactionSafely((transaction) async {
      final userDoc = _usersCollection.doc(userId);
      final snapshot = await transaction.get(userDoc);

      if (!snapshot.exists) {
        throw Exception('User does not exist');
      }

      final existingUser = snapshot.toAppUser();
      if (existingUser == null) throw Exception('Invalid user data');

      // Remove the provider from linked providers
      final updatedProviders = List<String>.from(existingUser.linkedProviders)
        ..remove(provider.name);

      // Prevent unlinking if it's the only provider
      if (updatedProviders.isEmpty) {
        throw Exception('Cannot unlink the only authentication method');
      }

      // Create updated user
      final updatedUser = existingUser.copyWith(
        linkedProviders: updatedProviders,
        lastUpdateDate: DateTime.now(),
      );

      // Update in Firestore
      transaction.update(userDoc, updatedUser.toFirestore());

      return updatedUser;
    });
  }

  // Helper method to get user with updated provider data
  Future<AppUser> updateUserProviderData(
    String userId,
    ProviderData providerData,
  ) async {
    return _runTransactionSafely((transaction) async {
      final userDoc = _usersCollection.doc(userId);
      final snapshot = await transaction.get(userDoc);

      if (!snapshot.exists) {
        throw Exception('User does not exist');
      }

      final existingUser = snapshot.toAppUser();
      if (existingUser == null) throw Exception('Invalid user data');

      // Create updated user
      final updatedUser = existingUser.copyWith(
        providerData: [providerData],
        lastUpdateDate: DateTime.now(),
      );

      // Update in Firestore
      transaction.update(userDoc, updatedUser.toFirestore());

      return updatedUser;
    });
  }

  // Optional: Helper method to get user's linked providers
  Future<List<String>> getLinkedProviders(String userId) async {
    return _runTransactionSafely((transaction) async {
      final userDoc = _usersCollection.doc(userId);
      final snapshot = await transaction.get(userDoc);

      if (!snapshot.exists) {
        throw Exception('User does not exist');
      }

      final existingUser = snapshot.toAppUser();
      if (existingUser == null) throw Exception('Invalid user data');

      return existingUser.linkedProviders;
    });
  }

  // Method to check if email exists (for preventing duplicate accounts)
  Future<bool> checkEmailExists(String email) async {
    try {
      final querySnapshot = await _usersCollection
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e);
    }
  }

  // Method to merge accounts if needed
  // Future<void> mergeAccounts(
  //     String primaryUserId, String secondaryUserId) async {
  //   return _runTransactionSafely((transaction) async {
  //     final primaryDoc = _usersCollection.doc(primaryUserId);
  //     final secondaryDoc = _usersCollection.doc(secondaryUserId);

  //     final primarySnapshot = await transaction.get(primaryDoc);
  //     final secondarySnapshot = await transaction.get(secondaryDoc);

  //     if (!primarySnapshot.exists || !secondarySnapshot.exists) {
  //       throw Exception('One or both users do not exist');
  //     }

  //     final primaryUser = primarySnapshot.toAppUser();
  //     final secondaryUser = secondarySnapshot.toAppUser();

  //     if (primaryUser == null || secondaryUser == null) {
  //       throw Exception('Invalid user data');
  //     }

  //     // Merge user data
  //     final mergedProviders = <String>{
  //       ...List<String>.from(primaryUser.linkedProviders ?? []),
  //       ...List<String>.from(secondaryUser.linkedProviders ?? []),
  //     }.toList(); // Convert to Set and back to List to remove duplicates

  //     final mergedUser = primaryUser.copyWith(
  //       linkedProviders: mergedProviders,
  //       lastUpdateDate: DateTime.now(),
  //     );

  //     // Update primary user with merged data
  //     transaction.update(primaryDoc, mergedUser.toFirestore());

  //     // Delete secondary user
  //     transaction.delete(secondaryDoc);
  //   });
  // }

  Future<AppUser> mergeAccounts(
      AppUser newUser, AppAuthProvider newProvider) async {
    // Get existing user doc with same email
    final query = await _usersCollection
        .where(FirestoreFieldName.email, isEqualTo: newUser.email)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      throw Exception('No existing account found to merge');
    }

    final existingDoc = query.docs.first;
    final existingUser = existingDoc.toAppUser();

    if (existingUser == null) {
      throw Exception('Invalid existing user data');
    }

    // Merge user data
    final mergedProviders = <String>{
      ...existingUser.linkedProviders,
      newProvider.name,
    }.toList();

    // Update user data
    final mergedUser = existingUser.copyWith(
      linkedProviders: mergedProviders,
      providerData: [
        ...(existingUser.providerData ?? []),
        ...?newUser.providerData
      ],
      lastUpdateDate: DateTime.now(),
      // Keep existing data if present, otherwise use new user's data
      displayName: existingUser.displayName.isEmpty
          ? newUser.displayName
          : existingUser.displayName,
      profileImageURL: existingUser.profileImageURL ?? newUser.profileImageURL,
      phoneNumber: existingUser.phoneNumber ?? newUser.phoneNumber,
    );

    // Update in Firestore
    await _usersCollection
        .doc(existingUser.id)
        .update(mergedUser.toFirestore());

    return mergedUser;
  }

  Future<void> updateUser(AppUser user) async {
    return _runTransactionSafely((transaction) async {
      final userDoc = _usersCollection.doc(user.id);
      final snapshot = await transaction.get(userDoc);

      if (!snapshot.exists) {
        throw Exception('User does not exist');
      }

      transaction.update(userDoc, user.toFirestore());
    });
  }

  Future<AppUser?> getUser(String userId) async {
    // return _runTransactionSafely((transaction) async {
    //   final snapshot = await transaction.get(_usersCollection.doc(userId));
    //   return snapshot.toAppUser();
    // });
    return _runTransactionSafely((transaction) async {
      try {
        final snapshot = await transaction.get(_usersCollection.doc(userId));
        if (!snapshot.exists) {
          debugPrint('User document not found: $userId');
          return null;
        }
        final user = snapshot.toAppUser();
        if (user == null) {
          debugPrint('Failed to convert document to AppUser');
          return null;
        }
        return user;
      } catch (e) {
        debugPrint('Error getting user: $e');
        return null; // Return null instead of throwing
      }
    });
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _usersCollection.doc(userId).delete();
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e);
    }
  }

  Stream<AppUser?> watchUser(String userId) {
    return _usersCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      try {
        // return doc.toAppUser();
        return AppUser.fromFirestore(doc);
      } catch (e, st) {
        debugPrint('Error converting user document: $e\n$st');
        return null;
      }
    }).handleError((error) {
      debugPrint('Error watching user: $error');
      return null;
    });
  }

  Future<void> updateLastLogin(String userId) async {
    await _usersCollection.doc(userId).update({
      FirestoreFieldName.lastLoginDate: Timestamp.now(),
    });
  }

  // Complex Transactions

  Future<void> updateUserWithRelatedData({
    required AppUser user,
    required Map<String, dynamic> additionalData,
    required String relatedCollectionPath,
  }) async {
    return _runTransactionSafely((transaction) async {
      final userDoc = _usersCollection.doc(user.id);
      final userSnapshot = await transaction.get(userDoc);

      if (!userSnapshot.exists) {
        throw Exception('User does not exist');
      }

      final relatedDoc = _firestore.doc(relatedCollectionPath);
      final relatedSnapshot = await transaction.get(relatedDoc);

      if (!relatedSnapshot.exists) {
        throw Exception('Related document does not exist');
      }

      transaction.update(userDoc, user.toFirestore());
      transaction.update(relatedDoc, additionalData);
    });
  }

  Future<void> updateEmailVerificationStatus(
      String userId, bool isVerified) async {
    return _firestore.runTransaction((transaction) async {
      final userDoc = _usersCollection.doc(userId);
      final snapshot = await transaction.get(userDoc);

      if (!snapshot.exists) {
        throw Exception('User does not exist');
      }

      transaction.update(userDoc, {
        FirestoreFieldName.isEmailVerified: isVerified,
        FirestoreFieldName.lastUpdateDate: FieldValue.serverTimestamp(),
      });
    });
  }

  // Image Upload Methods with Transactions
  Future<String> uploadProfileImage(String userId, File image) async {
    try {
      // Compress image before upload
      final compressedImage = await ImageUtils.compressImage(image);
      if (compressedImage == null) {
        throw Exception('Failed to compress image');
      }

      return await _firestore.runTransaction<String>((transaction) async {
        // Check if user exists
        final userDoc = _usersCollection.doc(userId);
        final userSnapshot = await transaction.get(userDoc);

        if (!userSnapshot.exists) {
          throw Exception('User does not exist');
        }

        // Create storage reference
        final storageRef = _storage.ref().child('users/$userId/profile.jpg');

        // Delete old image if exists
        try {
          final oldImageUrl =
              userSnapshot.data()?['profileImageUrl'] as String?;
          if (oldImageUrl != null) {
            await _storage.refFromURL(oldImageUrl).delete();
          }
        } catch (e) {
          debugPrint('Error deleting old profile image: $e');
        }
        // Upload new image
        final uploadTask = await storageRef.putFile(
          compressedImage,
          SettableMetadata(
            contentType: 'image/jpeg',
            customMetadata: {
              'uploadedAt': DateTime.now().toIso8601String(),
              'userId': userId,
            },
          ),
        );

        // Get download URL
        final downloadUrl = await uploadTask.ref.getDownloadURL();

        // Update user document with new image URL
        transaction.update(userDoc, {
          'profileImageUrl': downloadUrl,
          'lastUpdatedAt': FieldValue.serverTimestamp(),
        });

        return downloadUrl;
      });
    } on FirebaseException catch (e) {
      throw _handleStorageException(e);
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  Future<String> uploadProfileBackground(String userId, File image) async {
    try {
      // Compress image before upload
      final compressedImage = await ImageUtils.compressImage(image);
      if (compressedImage == null) {
        throw Exception('Failed to compress image');
      }

      return await _firestore.runTransaction<String>((transaction) async {
        // Check if user exists
        final userDoc = _usersCollection.doc(userId);
        final userSnapshot = await transaction.get(userDoc);

        if (!userSnapshot.exists) {
          throw Exception('User does not exist');
        }

        // Create storage reference
        final storageRef = _storage.ref().child('users/$userId/background.jpg');

        // Delete old image if exists
        try {
          final oldImageUrl =
              userSnapshot.data()?['profileBackgroundUrl'] as String?;
          if (oldImageUrl != null) {
            await _storage.refFromURL(oldImageUrl).delete();
          }
        } catch (e) {
          debugPrint('Error deleting old background image: $e');
        }
        // Upload new image
        final uploadTask = await storageRef.putFile(
          compressedImage,
          SettableMetadata(
            contentType: 'image/jpeg',
            customMetadata: {
              'uploadedAt': DateTime.now().toIso8601String(),
              'userId': userId,
            },
          ),
        );

        // Get download URL
        final downloadUrl = await uploadTask.ref.getDownloadURL();

        // Update user document with new image URL
        transaction.update(userDoc, {
          'profileBackgroundUrl': downloadUrl,
          'lastUpdatedAt': FieldValue.serverTimestamp(),
        });

        return downloadUrl;
      });
    } on FirebaseException catch (e) {
      throw _handleStorageException(e);
    } catch (e) {
      throw Exception('Failed to upload profile background: $e');
    }
  }

  // Delete image methods with Transactions
  Future<void> deleteProfileImage(String userId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final userDoc = _usersCollection.doc(userId);
        final userSnapshot = await transaction.get(userDoc);

        if (!userSnapshot.exists) {
          throw Exception('User does not exist');
        }

        final imageUrl = userSnapshot.data()?['profileImageUrl'] as String?;
        if (imageUrl != null) {
          // Delete from storage
          await _storage.refFromURL(imageUrl).delete();

          // Update user document
          transaction.update(userDoc, {
            'profileImageUrl': FieldValue.delete(),
            'lastUpdatedAt': FieldValue.serverTimestamp(),
          });
        }
      });
    } on FirebaseException catch (e) {
      throw _handleStorageException(e);
    }
  }

  Future<void> deleteProfileBackground(String userId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final userDoc = _usersCollection.doc(userId);
        final userSnapshot = await transaction.get(userDoc);

        if (!userSnapshot.exists) {
          throw Exception('User does not exist');
        }

        final imageUrl =
            userSnapshot.data()?['profileBackgroundUrl'] as String?;
        if (imageUrl != null) {
          // Delete from storage
          await _storage.refFromURL(imageUrl).delete();

          // Update user document
          transaction.update(userDoc, {
            'profileBackgroundUrl': FieldValue.delete(),
            'lastUpdatedAt': FieldValue.serverTimestamp(),
          });
        }
      });
    } on FirebaseException catch (e) {
      throw _handleStorageException(e);
    }
  }

  // Batch delete all user images
  Future<void> deleteAllUserImages(String userId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final userDoc = _usersCollection.doc(userId);
        final userSnapshot = await transaction.get(userDoc);

        if (!userSnapshot.exists) {
          throw Exception('User does not exist');
        }

        final data = userSnapshot.data()!;
        final profileImageUrl = data['profileImageUrl'] as String?;
        final backgroundImageUrl = data['profileBackgroundUrl'] as String?;

        // Delete images from storage
        if (profileImageUrl != null) {
          await _storage.refFromURL(profileImageUrl).delete();
        }
        if (backgroundImageUrl != null) {
          await _storage.refFromURL(backgroundImageUrl).delete();
        }

        // Update user document
        transaction.update(userDoc, {
          'profileImageUrl': FieldValue.delete(),
          'profileBackgroundUrl': FieldValue.delete(),
          'lastUpdatedAt': FieldValue.serverTimestamp(),
        });
      });
    } on FirebaseException catch (e) {
      throw _handleStorageException(e);
    }
  }

  // Helper method to safely delete a storage file
  Future<void> _safeDeleteStorageFile(String? imageUrl) async {
    if (imageUrl != null) {
      try {
        await _storage.refFromURL(imageUrl).delete();
      } catch (e) {
        debugPrint('Error deleting storage file: $e');
      }
    }
  }

  // Update user with image URLs
  Future<void> updateUserImages(
    String userId, {
    String? profileImageUrl,
    String? backgroundImageUrl,
  }) async {
    await _firestore.runTransaction((transaction) async {
      final userDoc = _usersCollection.doc(userId);
      final userSnapshot = await transaction.get(userDoc);

      if (!userSnapshot.exists) {
        throw Exception('User does not exist');
      }

      final updates = <String, dynamic>{
        'lastUpdatedAt': FieldValue.serverTimestamp(),
      };

      if (profileImageUrl != null) {
        updates['profileImageUrl'] = profileImageUrl;
      }
      if (backgroundImageUrl != null) {
        updates['profileBackgroundUrl'] = backgroundImageUrl;
      }

      transaction.update(userDoc, updates);
    });
  }

  // Batch Operations

  Future<void> batchCreateUsers(List<AppUser> users) async {
    try {
      const maxBatchSize = 500;

      for (var i = 0; i < users.length; i += maxBatchSize) {
        final batch = _firestore.batch();
        final chunk = users.skip(i).take(maxBatchSize);

        for (final user in chunk) {
          final userDoc = _usersCollection.doc(user.id);
          batch.set(userDoc, user.toFirestore());
        }

        await batch.commit();
      }
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e);
    }
  }

  Future<void> batchUpdateUsers(List<AppUser> users) async {
    try {
      const maxBatchSize = 500;

      for (var i = 0; i < users.length; i += maxBatchSize) {
        final batch = _firestore.batch();
        final chunk = users.skip(i).take(maxBatchSize);

        for (final user in chunk) {
          final userDoc = _usersCollection.doc(user.id);
          batch.update(userDoc, user.toFirestore());
        }

        await batch.commit();
      }
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e);
    }
  }

  Future<void> batchDeleteUsers(List<String> userIds) async {
    try {
      const maxBatchSize = 500;

      for (var i = 0; i < userIds.length; i += maxBatchSize) {
        final batch = _firestore.batch();
        final chunk = userIds.skip(i).take(maxBatchSize);

        for (final userId in chunk) {
          final userDoc = _usersCollection.doc(userId);
          batch.delete(userDoc);
        }

        await batch.commit();
      }
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e);
    }
  }

  // Atomic Counter Updates
  Future<void> incrementUserMetric(String userId, String field) async {
    return _runTransactionSafely((transaction) async {
      final userDoc = _usersCollection.doc(userId);
      final snapshot = await transaction.get(userDoc);

      if (!snapshot.exists) {
        throw Exception('User does not exist');
      }

      final currentValue = snapshot.data()?[field] ?? 0;
      transaction.update(userDoc, {field: currentValue + 1});
    });
  }

  // Conditional Updates
  Future<void> updateUserIfNotModified(
    AppUser user,
    DateTime lastKnownUpdate,
  ) async {
    return _runTransactionSafely((transaction) async {
      final userDoc = _usersCollection.doc(user.id);
      final snapshot = await transaction.get(userDoc);

      if (!snapshot.exists) {
        throw Exception('User does not exist');
      }

      final currentUser = snapshot.toAppUser();
      if (currentUser == null) {
        throw Exception('Invalid user data');
      }

      if (currentUser.lastUpdateDate != lastKnownUpdate) {
        throw Exception('User has been modified');
      }

      transaction.update(userDoc, user.toFirestore());
    });
  }

  // Stream with Transactions
  Stream<AppUser?> watchUserWithTransactions(String userId) {
    return _usersCollection.doc(userId).snapshots().asyncMap((snapshot) async {
      if (!snapshot.exists) return null;

      return await _runTransactionSafely((transaction) async {
        final user = snapshot.toAppUser();
        if (user == null) return null;

        // You could fetch additional data here if needed
        return user;
      });
    });
  }

  // Helper methods for error handling
  Future<T> _runTransactionSafely<T>(
    Future<T> Function(Transaction transaction) action,
  ) async {
    try {
      // return await _firestore.runTransaction(action);
      return await _firestore.runTransaction(
        action,
        timeout: const Duration(seconds: 10), // Increase timeout
        maxAttempts: 3, // Add retry attempts
      );
    } on FirebaseException catch (e) {
      debugPrint('Firestore transaction error: ${e.code} - ${e.message}');
      if (e.code == 'deadline-exceeded') {
        // Retry logic for timeout
        return await _retryOperation(() => _firestore.runTransaction(action));
      }
      // FirebaseCrashlytics.instance.recordError(e);
      throw _handleFirestoreException(e);
    }
  }

  // Add retry helper
  Future<T> _retryOperation<T>(
    Future<T> Function() operation, {
    int maxAttempts = 3,
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    int attempts = 0;
    while (true) {
      try {
        attempts++;
        return await operation();
      } catch (e) {
        if (attempts >= maxAttempts) rethrow;
        await Future.delayed(delay * attempts);
        debugPrint('Retrying operation (attempt $attempts)');
      }
    }
  }

  Exception _handleFirestoreException(FirebaseException e) {
    switch (e.code) {
      case 'not-found':
        return Exception('Document not found');
      case 'already-exists':
        return Exception('Document already exists');
      case 'permission-denied':
        return Exception('Permission denied');
      case 'aborted':
        return Exception('Transaction was aborted');
      case 'cancelled':
        return Exception('Operation was cancelled');
      case 'deadline-exceeded':
        return Exception('Operation timed out');
      case 'failed-precondition':
        return Exception('Operation failed due to server state');
      case 'unavailable':
        return Exception('Service is currently unavailable');
      default:
        return Exception(e.message ?? 'Unknown error occurred');
    }
  }

  // Helper method to handle storage exceptions
  Exception _handleStorageException(FirebaseException e) {
    switch (e.code) {
      case 'unauthorized':
        return Exception('Unauthorized to perform this action');
      case 'canceled':
        return Exception('Upload was canceled');
      case 'storage/retry-limit-exceeded':
        return Exception('Upload failed: too many retries');
      case 'storage/invalid-checksum':
        return Exception('Upload failed: file integrity check failed');
      case 'storage/unknown':
        return Exception('An unknown error occurred');
      default:
        return Exception(e.message ?? 'An error occurred during upload');
    }
  }
}

// @Riverpod(keepAlive: true)
// AppUserStorageService appUserStorageService(Ref ref) {
//   return AppUserStorageService();
// }

/// Provider for fetching a single user by ID
// @riverpod
// Future<AppUser?> fetchAppUser(Ref ref, String userId) {
//   return ref.watch(appUserStorageServiceProvider).(userId);
// }

// /// Provider for watching a single user
// @riverpod
// Stream<AppUser?> watchAppUser(Ref ref, String userId) {
//   return ref.watch(appUserStorageServiceProvider).watchAppUser(userId);
// }

// /// Provider for watching filtered users
// @riverpod
// Stream<List<AppUser>> watchFilteredUsers(
//   Ref ref,
//   AppUserFilter filter,
// ) {
//   return ref.watch(appUserStorageServiceProvider).watchAppUsers(filter: filter);
// }

// /// Provider for searching users
// @riverpod
// Stream<List<AppUser>> searchAppUsers(
//   Ref ref,
//   String searchTerm,
// ) {
//   return ref.watch(appUserStorageServiceProvider).searchAppUsers(searchTerm);
// }

// @riverpod
// Stream<bool> isAppUserApproved(Ref ref) {
//   final authService = ref.watch(authServiceProvider);
//   final userId = authService.currentUser?.id;
//   final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
//   return appUserStorageRepository.isAppUserApproved(userId!);
// }

// @riverpod
// Future<AppUser?> appUserFuture(Ref ref, UserID id) {
//   final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
//   return appUserStorageRepository.getAppUser(id);
// }

// @riverpod
// Future<bool> isUserApproved(Ref ref, UserID id) {
//   final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
//   return appUserStorageRepository.isGivenUserApproved(id);
// }

// @riverpod
// Future<bool> isUserApproved(Ref ref) async {
//   final authRepo = ref.watch(authServiceProvider);
//   final userId = authRepo.currentUser?.id;
//   if (userId == null) return false;

//   final userDoc =
//       await FirebaseFirestore.instance.collection('users').doc(userId).get();

//   return userDoc.data()?['is_user_approved'] ?? false;
// }

// @riverpod
// class AppUserApprovalState extends _$AppUserApprovalState {
//   @override
//   Stream<bool> build() {
//     final authRepository = ref.watch(authServiceProvider);
//     final userId = authRepository.currentUser?.id;
//     if (userId == null) return Stream.value(false);

//     final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
//     return appUserStorageRepository.isAppUserApproved(userId);
//   }
// }
