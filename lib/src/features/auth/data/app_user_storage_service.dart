import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/constants/firebase_collection_name.dart';
import 'package:social_app_2/src/constants/firebase_field_name.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/domain/app_user_payload.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';
import 'package:social_app_2/src/features/services/logger.dart';

part 'app_user_storage_service.g.dart';

/// Custom exception for AppUserStorageRepository
class AppUserException implements Exception {
  final String message;
  AppUserException(this.message);

  @override
  String toString() => 'AppUserException: $message';
}

/// Class for handling User info
class AppUserStorageService {
  AppUserStorageService(this._firestore, this._storage);
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  final Map<UserID, AppUser> _cache = {};
  final _log = getLogger('AppUserStorageRepository');

  int getCurrentTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String usersPath() => FirebaseCollectionName.users;
  static String userPath(UserID id) => '${FirebaseCollectionName.users}/$id';

  /// Fetches a list of AppUsers with pagination
  ///
  /// [limit] determines the number of users to fetch per page
  /// [startAfter] is the last document from the previous fetch, used for pagination
  Future<List<AppUser>> fetchAppUsersList(
      {int limit = 20, DocumentSnapshot? startAfter}) async {
    try {
      Query<AppUser> query = _appUsersRef().limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snapshot = await query.get();
      final users = snapshot.docs.map((doc) => doc.data()).toList();

      // Update cache
      for (var user in users) {
        _cache[user.id] = user;
      }

      return users;
    } catch (e, stackTrace) {
      _log.e('Failed to fetch users list', error: e, stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw AppUserException('Failed to fetch users list: $e');
    }
  }

  /// Watches a stream of AppUsers list
  Stream<List<AppUser>> watchAppUsersList() {
    final ref = _appUsersRef();
    return ref.snapshots().map((snapshot) {
      final users = snapshot.docs.map((doc) => doc.data()).toList();
      // Update cache
      for (var user in users) {
        _cache[user.id] = user;
      }
      return users;
    });
  }

  /// Fetch a single AppUser with ID
  Future<AppUser?> fetchAppUser(UserID id) async {
    try {
      if (_cache.containsKey(id)) {
        return _cache[id];
      }

      final ref = _appUserRef(id);
      final snapshot = await ref.get();
      final user = snapshot.data();

      if (user != null) {
        _cache[id] = user;
      }

      return user;
    } catch (e, stackTrace) {
      _log.e('Failed to fetch user', error: e, stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw AppUserException('Failed to fetch user: $e');
    }
  }

  /// Watches a stream of a single AppUser
  Stream<AppUser?> watchAppUser(UserID id) {
    final ref = _appUserRef(id);
    return ref.snapshots().map((snapshot) {
      final user = snapshot.data();
      if (user != null) {
        _cache[id] = user;
      }
      return user;
    });
  }

  /// Watches a stream of AppUsers who are sharing their info
  Stream<List<AppUser>> watchAppUsersDirectory() {
    final ref = _firestore
        .collection(usersPath())
        .withConverter(
          fromFirestore: (doc, _) => AppUser.fromMap(doc.data()!),
          toFirestore: (AppUser appUser, options) => appUser.toMap(),
        )
        .orderBy(FirebaseFieldName.displayName)
        .where(FirebaseFieldName.isInfoShared, isEqualTo: true);
    return ref.snapshots().map((snapshot) {
      final users = snapshot.docs.map((doc) => doc.data()).toList();
      // Update cache
      for (var user in users) {
        _cache[user.id] = user;
      }
      return users;
    });
  }

  // gets list of users who is sharing their info with other users
  Future<List<AppUser>> fetchAppUsersDirectory() async {
    try {
      final ref = _firestore
          .collection(usersPath())
          .withConverter(
            fromFirestore: (doc, _) => AppUser.fromMap(doc.data()!),
            toFirestore: (AppUser appUser, options) => appUser.toMap(),
          )
          .orderBy(FirebaseFieldName.displayName)
          .where(FirebaseFieldName.isInfoShared, isEqualTo: true);
      final snapshot = await ref.get();
      return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
    } catch (e) {
      throw Exception('Failed to fetch Directory: $e');
    }
  }

  /// Checks if a given user is approved
  Future<bool> isGivenUserApproved(UserID id) async {
    try {
      final user = await fetchAppUser(id);
      return user?.isApproved ?? false;
    } catch (e, stackTrace) {
      _log.e('Failed to check user approval status',
          error: e, stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw AppUserException('Failed to check user approval status: $e');
    }
  }

  /// Watches a stream of a user's admin status
  Stream<bool> isAppUserAdmin(UserID id) {
    return _firestore
        .collection(FirebaseCollectionName.users)
        .doc(id)
        .snapshots()
        .map(
            (snapshot) => snapshot.data()?[FirebaseFieldName.isAdmin] ?? false);
  }

  /// Watches a stream of a user's approval status
  Stream<bool> isAppUserApproved(UserID id) {
    return _firestore
        .collection(FirebaseCollectionName.users)
        .doc(id)
        .snapshots()
        .map((snapshot) =>
            snapshot.data()?[FirebaseFieldName.isApproved] ?? false);
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
            FirebaseFieldName.deviceToken: deviceToken,
            FirebaseFieldName.apnsToken: apnsToken,
            FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
            FirebaseFieldName.platform: Platform.operatingSystem,
          },
          SetOptions(merge: true));
    }

    final deviceTokenDocRef = firestore
        .collection(FirebaseCollectionName.deviceToken)
        .doc(uid ?? deviceToken);

    batch.set(
        deviceTokenDocRef,
        {
          FirebaseFieldName.deviceToken: FieldValue.arrayUnion([deviceToken]),
          FirebaseFieldName.apnsToken:
              FieldValue.arrayUnion([if (apnsToken != null) apnsToken]),
          FirebaseFieldName.userId: uid,
          FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true));

    await batch.commit();
  }

  /// Creates or updates an AppUser
  Future<void> createOrUpdateAppUser({
    required UserID id,
    required AppUserPayload payload,
  }) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final userDocRef = _firestore.collection(usersPath()).doc(id);
        final userDoc = await transaction.get(userDocRef);

        final currentTime = getCurrentTimestamp();

        if (userDoc.exists) {
          // Update existing user
          transaction.update(userDocRef, {
            ...payload, // Spread the payload directly
            FirebaseFieldName.updateDate: currentTime,
          });
        } else {
          // Create new user
          transaction.set(userDocRef, {
            ...payload, // Spread the payload directly
            FirebaseFieldName.createDate: currentTime,
            FirebaseFieldName.updateDate: currentTime,
          });
        }
      });

      // Update cache
      final updatedUser = AppUser.fromPayload(payload).copyWith(
        updateDate: DateTime.fromMillisecondsSinceEpoch(getCurrentTimestamp()),
      );
      _cache[id] = updatedUser;
    } catch (e, stackTrace) {
      _log.e('Failed to create/update user', error: e, stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw AppUserException('Failed to create/update user: $e');
    }
  }

  Future<void> createUser({
    required AppUserPayload payload,
  }) async {
    try {
      final currentTime = getCurrentTimestamp();
      final userData = {
        ...payload,
        FirebaseFieldName.createDate: currentTime,
        FirebaseFieldName.updateDate: currentTime,
      };

      final userDocRef =
          _firestore.collection(usersPath()).doc(payload[FirebaseFieldName.id]);
      await userDocRef.set(userData);

      // Update cache
      final newUser = AppUser.fromPayload(payload);
      _cache[newUser.id] = newUser;
    } catch (e, stackTrace) {
      _log.e('Failed to create user', error: e, stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw AppUserException('Failed to create user: $e');
    }
  }

  Future<bool> saveAppUser({
    required UserID id,
    required String email,
    String? fullName,
    String? photoURL,
    String? profileBannerImageURL,
    String? photoFileName,
    String? providerId,
    String? familyId,
    DateTime? createDate,
    DateTime? updateDate,
    DateTime? lastLoginDate,
    bool? isAdmin,
    bool? isEmailVerified,
    bool? isApproved,
    bool? isInfoShared,
    bool? isChatEnabled,
    bool? isPrimaryAccount,
    String? primaryAccountEmail,
    String? phoneNumber,
    String? street,
    String? city,
    String? state,
    String? zip,
    String? country,
  }) async {
    try {
      // first check if the user already exists
      final userInfo = await _firestore
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.id, isEqualTo: id)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // user already exists, so just update data
        await userInfo.docs.first.reference.set(
          {
            FirebaseFieldName.providerId: providerId,
            FirebaseFieldName.familyId: familyId,
            FirebaseFieldName.isEmailVerified: isEmailVerified,
            FirebaseFieldName.isApproved: isApproved,
            FirebaseFieldName.createDate: createDate?.millisecondsSinceEpoch,
            FirebaseFieldName.lastLoginDate:
                lastLoginDate?.millisecondsSinceEpoch,
            FirebaseFieldName.updateDate: DateTime.now().millisecondsSinceEpoch,
            FirebaseFieldName.profileBannerImageURL:
                profileBannerImageURL ?? '',
            FirebaseFieldName.isInfoShared: isInfoShared,
            FirebaseFieldName.isChatEnabled: isChatEnabled,
            FirebaseFieldName.isPrimaryAccount: isPrimaryAccount,
            FirebaseFieldName.primaryAccountEmail: primaryAccountEmail ?? '',
          },
          SetOptions(merge: true),
        );

        return true;
      }

      // if user does not exist,
      // create a new user payload and add it to firebase firestore
      final payload = AppUserPayload(
        id: id,
        fullName: fullName,
        email: email,
        providerId: providerId,
        familyId: familyId,
        phoneNumber: phoneNumber,
        photoFileName: photoFileName,
        photoUrl: photoURL,
        profileBannerImageUrl: profileBannerImageURL,
        isEmailVerified: isEmailVerified = false,
        isApproved: isApproved = false,
        isAdmin: isAdmin = false,
        isInfoShared: isInfoShared = false,
        isChatEnabled: isChatEnabled = false,
        isPrimaryAccount: isPrimaryAccount = false,
        primaryAccountEmail: primaryAccountEmail,
        createDate: createDate?.millisecondsSinceEpoch,
        lastLoginDate: lastLoginDate?.millisecondsSinceEpoch,
        street: street,
        city: city,
        state: state,
        zip: zip,
        country: country,
      );
      await _firestore
          .collection(FirebaseCollectionName.users)
          .doc(id)
          .set(payload);

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Updates specific fields of an AppUser
  Future<void> updateUser({
    required UserID id,
    required AppUserPayload payload,
  }) async {
    try {
      final currentTime = getCurrentTimestamp();
      final updateData = {
        ...payload,
        FirebaseFieldName.updateDate: currentTime,
      };

      await _firestore.runTransaction((transaction) async {
        final userDocRef = _firestore.collection(usersPath()).doc(id);
        final userDoc = await transaction.get(userDocRef);

        if (!userDoc.exists) {
          throw AppUserException('User does not exist');
        }

        transaction.update(userDocRef, {
          ...updateData,
          FirebaseFieldName.updateDate: currentTime,
        });
      });

      // Update cache
      if (_cache.containsKey(id)) {
        _cache[id] = AppUser.fromMap({
          ..._cache[id]!.toMap(),
          ...updateData,
          FirebaseFieldName.updateDate: currentTime,
        });
      }
    } catch (e, stackTrace) {
      _log.e('Failed to update user', error: e, stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw AppUserException('Failed to update user: $e');
    }
  }

  /// Deletes all data associated with a user
  Future<void> deleteUserData(UserID id) async {
    try {
      final batch = _firestore.batch();

      // Delete profile images
      await _deleteUserImages(id);

      final userDeviceTokens = await _firestore
          .collection(FirebaseCollectionName.deviceToken)
          .doc(id)
          .get();
      batch.delete(userDeviceTokens.reference);

      // Delete device tokens
      final deviceTokens = await _firestore
          .collection(usersPath())
          .doc(id)
          .collection(FirebaseCollectionName.deviceToken)
          .get();
      for (var doc in deviceTokens.docs) {
        batch.delete(doc.reference);
      }

      // Delete user document
      batch.delete(_firestore.collection(usersPath()).doc(id));

      await batch.commit();

      // Remove from cache
      _cache.remove(id);

      _log.i('User data deleted successfully: $id');
    } catch (e, stackTrace) {
      _log.e('Failed to delete user data', error: e, stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw AppUserException('Failed to delete user data: $e');
    }
  }

  /// Deletes user images from Firebase Storage
  Future<void> _deleteUserImages(UserID id) async {
    try {
      final profileImageRef = _storage
          .ref()
          .child(FirebaseCollectionName.users)
          .child(id)
          .child('profile_image')
          .child('${id}_profile_image');

      final profileBannerImageRef = _storage
          .ref()
          .child(FirebaseCollectionName.users)
          .child(id)
          .child('profile_banner_image')
          .child('${id}_profile_banner_image');

      await Future.wait([
        profileImageRef
            .delete()
            .catchError((e) => _log.w('Profile image not found: $e')),
        profileBannerImageRef
            .delete()
            .catchError((e) => _log.w('Profile banner image not found: $e')),
      ]);
    } catch (e, stackTrace) {
      _log.e('Failed to delete user images', error: e, stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      // We don't throw here to allow the deletion process to continue
    }
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
              FirebaseFieldName.id,
              isEqualTo: userId,
            )
            .get();
        for (final doc in query.docs) {
          transaction.delete(doc.reference);
        }
      },
    );
  }

  /// Updates a user's approval status
  Future<void> updateUserApproval(AppUser appUser) async {
    try {
      await _firestore
          .collection(usersPath())
          .doc(appUser.id)
          .update({FirebaseFieldName.isApproved: !appUser.isApproved});

      // Update cache
      if (_cache.containsKey(appUser.id)) {
        _cache[appUser.id] = appUser.copyWith(isApproved: !appUser.isApproved);
      }
    } catch (e, stackTrace) {
      _log.e('Failed to update user approval',
          error: e, stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw AppUserException('Failed to update user approval: $e');
    }
  }

  // Save Device Token for push notification
  Future createDeviceToken({required String token, UserID? userId}) async {
    try {
      await _firestore
          .collection(FirebaseCollectionName.deviceToken)
          .doc(userId ?? token)
          .set({
        FirebaseFieldName.deviceToken: token,
        FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
        FirebaseFieldName.platform: Platform.operatingSystem,
      });
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  DocumentReference<AppUser> _appUserRef(UserID id) =>
      _firestore.doc(userPath(id)).withConverter(
            fromFirestore: (doc, _) => AppUser.fromMap(doc.data()!),
            toFirestore: (AppUser appUser, options) => appUser.toMap(),
          );

  Query<AppUser> _appUsersRef() => _firestore
      .collection(usersPath())
      .withConverter(
        fromFirestore: (doc, _) => AppUser.fromMap(doc.data()!),
        toFirestore: (AppUser appUser, options) => appUser.toMap(),
      )
      .orderBy(FirebaseFieldName.id);

  // * Temporary search implementation.
  // * Note: this is quite inefficient as it pulls the entire product
  // * list and then filters the data on the client
  // * instead we can use Algolia (TODO :)
  /// Searches for users based on a query string
  Future<List<AppUser>> searchUsers(String query) async {
    try {
      // This is a simple client-side search. For production, consider using Algolia or Firebase's full-text search
      final usersList =
          await fetchAppUsersList(limit: 1000); // Adjust limit as needed
      return usersList
          .where((user) =>
              user.displayName?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    } catch (e, stackTrace) {
      _log.e('Failed to search users', error: e, stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw AppUserException('Failed to search users: $e');
    }
  }
}

@Riverpod(keepAlive: true)
AppUserStorageService appUserStorageService(Ref ref) {
  return AppUserStorageService(
      FirebaseFirestore.instance, FirebaseStorage.instance);
}

@riverpod
Stream<List<AppUser>> appUsersListStream(Ref ref) {
  final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
  return appUserStorageRepository.watchAppUsersList();
}

@riverpod
Future<List<AppUser>> appUsersListFuture(Ref ref) {
  final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
  return appUserStorageRepository.fetchAppUsersList();
}

@riverpod
Stream<AppUser?> appUserStream(Ref ref, UserID id) {
  final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
  return appUserStorageRepository.watchAppUser(id);
}

@riverpod
Stream<bool> isAppUserAdmin(Ref ref, UserID id) {
  final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
  return appUserStorageRepository.isAppUserAdmin(id);
}

@riverpod
Stream<bool> isAppUserApproved(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userId = authRepository.currentUser?.id;
  final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
  return appUserStorageRepository.isAppUserApproved(userId!);
}

@riverpod
Future<AppUser?> appUserFuture(Ref ref, UserID id) {
  final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
  return appUserStorageRepository.fetchAppUser(id);
}

@riverpod
Future<bool> isUserApproved(Ref ref, UserID id) {
  final appUserStorageRepository = ref.watch(appUserStorageServiceProvider);
  return appUserStorageRepository.isGivenUserApproved(id);
}
