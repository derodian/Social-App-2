import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/exceptions/firestore_exception.dart';
import 'package:social_app_2/src/features/auth/constants/app_user_constants.dart';
import 'package:social_app_2/src/features/auth/domain/provider_data.dart';
import 'package:social_app_2/src/features/auth/domain/user_cache_manager.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

enum AppAuthProvider {
  email,
  google,
  apple,
  facebook,
  github;

  String get providerId {
    switch (this) {
      case AppAuthProvider.email:
        return 'password';
      case AppAuthProvider.google:
        return 'google.com';
      case AppAuthProvider.apple:
        return 'apple.com';
      case AppAuthProvider.facebook:
        return 'facebook.com';
      case AppAuthProvider.github:
        return 'github.com';
    }
  }
}

enum AccountStatus {
  active,
  suspended,
  deleted,
}

// Create an interface for Firestore operations
abstract class FirestoreDoc {
  Map<String, dynamic> toFirestore();
}

@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @JsonKey(name: FirestoreFieldName.darkMode) @Default(true) bool darkMode,
    @JsonKey(name: FirestoreFieldName.language) @Default('en') String language,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    @JsonKey(name: FirestoreFieldName.emailNotifications)
    @Default(true)
    bool emailNotifications,
    @JsonKey(name: FirestoreFieldName.pushNotifications)
    @Default(true)
    bool pushNotifications,
    @JsonKey(name: FirestoreFieldName.inAppNotifications)
    @Default(true)
    bool inAppNotifications,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
}

@freezed
class PrivacySettings with _$PrivacySettings {
  const factory PrivacySettings({
    @JsonKey(name: FirestoreFieldName.profileVisibleToPublic)
    @Default(true)
    bool profileVisibleToPublic,
    @JsonKey(name: FirestoreFieldName.hideOnlineStatus)
    @Default(false)
    bool hideOnlineStatus,
    @JsonKey(name: FirestoreFieldName.hideLastSeen)
    @Default(false)
    bool hideLastSeen,
  }) = _PrivacySettings;

  factory PrivacySettings.fromJson(Map<String, dynamic> json) =>
      _$PrivacySettingsFromJson(json);
}

@freezed
class AppUser with _$AppUser implements FirestoreDoc {
  const AppUser._();

  static final _cacheManager = UserCacheManager();

  // Cache for both JSON and Firestore data
  static final Map<String, Map<String, dynamic>> _firestoreCache = {};
  static final Map<String, Map<String, dynamic>> _jsonCache = {};

  const factory AppUser({
    @JsonKey(name: FirestoreFieldName.id) required UserID id,
    @JsonKey(name: FirestoreFieldName.email) required String email,
    @JsonKey(name: FirestoreFieldName.displayName) required String displayName,
    @JsonKey(name: FirestoreFieldName.profileImageUrl) String? profileImageURL,
    @JsonKey(name: FirestoreFieldName.profileBannerImageUrl)
    String? profileBannerImageURL,
    @JsonKey(name: FirestoreFieldName.familyId) String? familyId,
    @JsonKey(name: FirestoreFieldName.primaryAccountEmail)
    String? primaryAccountEmail,
    @JsonKey(name: FirestoreFieldName.phoneNumber) String? phoneNumber,
    @JsonKey(name: FirestoreFieldName.street) String? street,
    @JsonKey(name: FirestoreFieldName.city) String? city,
    @JsonKey(name: FirestoreFieldName.addressState) String? addressState,
    @JsonKey(name: FirestoreFieldName.zip) String? zip,
    @JsonKey(name: FirestoreFieldName.country) String? country,
    @JsonKey(name: FirestoreFieldName.createDate)
    @DateTimeConverter()
    required DateTime createDate,
    @JsonKey(name: FirestoreFieldName.lastUpdateDate)
    @DateTimeConverter()
    required DateTime lastUpdateDate,
    @JsonKey(name: FirestoreFieldName.lastLoginDate)
    @DateTimeConverter()
    required DateTime lastLoginDate,
    @JsonKey(name: FirestoreFieldName.lastPasswordChangeDate)
    @DateTimeConverter()
    DateTime? lastPasswordChangeDate,
    @JsonKey(name: FirestoreFieldName.isAdmin) @Default(false) bool isAdmin,
    @JsonKey(name: FirestoreFieldName.isEmailVerified)
    @Default(false)
    bool isEmailVerified,
    @JsonKey(name: FirestoreFieldName.isApproved)
    @Default(false)
    bool isApproved,
    @JsonKey(name: FirestoreFieldName.isInfoShared)
    @Default(false)
    bool isInfoShared,
    @JsonKey(name: FirestoreFieldName.isChatEnabled)
    @Default(false)
    bool isChatEnabled,
    @JsonKey(name: FirestoreFieldName.isPrimaryAccount)
    @Default(false)
    bool isPrimaryAccount,
    @JsonKey(name: FirestoreFieldName.provider)
    @Default(AppAuthProvider.email)
    AppAuthProvider provider,
    @JsonKey(name: FirestoreFieldName.linkedProviders)
    @Default([])
    List<String> linkedProviders,
    @JsonKey(name: FirestoreFieldName.accountStatus)
    @Default(AccountStatus.active)
    AccountStatus accountStatus,
    @JsonKey(name: FirestoreFieldName.providerData)
    List<ProviderData>? providerData,
    @JsonKey(name: FirestoreFieldName.preferences)
    @Default(UserPreferences())
    UserPreferences preferences,
    @JsonKey(name: FirestoreFieldName.notificationSettings)
    @Default(NotificationSettings())
    NotificationSettings notificationSettings,
    @JsonKey(name: FirestoreFieldName.privacySettings)
    @Default(PrivacySettings())
    PrivacySettings privacySettings,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  // Implement toFirestore method
  @override
  Map<String, dynamic> toFirestore() {
    // // Try to get from cache first
    // final cached = _cacheManager.getCachedUser(id);
    // if (cached != null) {
    //   return Map.from(cached);
    // }

    debugPrint('Converting AppUser to Firestore data: $id');

    try {
      final firestoreData = {
        FirestoreFieldName.email: email,
        FirestoreFieldName.displayName: displayName,
        FirestoreFieldName.profileImageUrl: profileImageURL,
        FirestoreFieldName.profileBannerImageUrl: profileBannerImageURL,
        FirestoreFieldName.familyId: familyId,
        FirestoreFieldName.primaryAccountEmail: primaryAccountEmail,
        FirestoreFieldName.phoneNumber: phoneNumber,
        FirestoreFieldName.street: street,
        FirestoreFieldName.city: city,
        FirestoreFieldName.addressState: addressState,
        FirestoreFieldName.zip: zip,
        FirestoreFieldName.country: country,
        FirestoreFieldName.createDate: Timestamp.fromDate(createDate),
        FirestoreFieldName.lastUpdateDate: Timestamp.fromDate(lastUpdateDate),
        FirestoreFieldName.lastLoginDate: Timestamp.fromDate(lastLoginDate),
        FirestoreFieldName.isAdmin: isAdmin,
        FirestoreFieldName.isEmailVerified: isEmailVerified,
        FirestoreFieldName.isApproved: isApproved,
        FirestoreFieldName.isInfoShared: isInfoShared,
        FirestoreFieldName.isChatEnabled: isChatEnabled,
        FirestoreFieldName.isPrimaryAccount: isPrimaryAccount,
        FirestoreFieldName.provider: provider.name,
        FirestoreFieldName.linkedProviders: linkedProviders,
        FirestoreFieldName.accountStatus: accountStatus.name,
        FirestoreFieldName.preferences: preferences.toJson(),
        FirestoreFieldName.notificationSettings: notificationSettings.toJson(),
        FirestoreFieldName.privacySettings: privacySettings.toJson(),
        if (lastPasswordChangeDate != null)
          FirestoreFieldName.lastPasswordChangeDate:
              Timestamp.fromDate(lastPasswordChangeDate!),
        if (providerData != null)
          FirestoreFieldName.providerData:
              providerData!.map((data) => data.toJson()).toList(),
      };

      // // Cache the data
      // _cacheManager.cacheUser(id, firestoreData);
      // Remove null values
      // firestoreData.removeWhere((key, value) => value == null);
      // _cachedFirestoreData!.removeWhere((_, value) => value == null);

      debugPrint('Successfully converted user to Firestore data');
      // return firestoreData;
      return Map.from(firestoreData);
    } catch (e, st) {
      debugPrint('Error converting user to Firestore data: $e\n$st');
      rethrow;
    }
  }

  // Factory constructor for Firestore
  factory AppUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    // final userId = doc.id;

    // // Try to get from cache first
    // final cached = _cacheManager.getCachedUser(userId);
    // if (cached != null) {
    //   return AppUser.fromJson(cached);
    // }

    debugPrint('Converting document: ${doc.id}');

    try {
      final data = doc.data();
      if (data == null) {
        throw FirestoreException(
          'Document data is null',
          code: 'null-data',
          details: {'documentId': doc.id},
        );
      }

      // Add required field validation
      _validateRequiredFields(data);

      // Convert timestamps
      final timestamps = _convertTimestamps(data);

      // Convert provider data from Firestore
      final providerDataList = _convertProviderData(data);

      // Helper function to safely get String value
      String? nullableString(dynamic value) {
        if (value == null) return null;
        if (value is String) return value;
        return value.toString();
      }

      final Map<String, dynamic> jsonData = {
        FirestoreFieldName.id: doc.id,
        FirestoreFieldName.email: data[FirestoreFieldName.email] ?? '',
        FirestoreFieldName.displayName:
            data[FirestoreFieldName.displayName] ?? '',
        FirestoreFieldName.profileImageUrl:
            nullableString(data[FirestoreFieldName.profileImageUrl]),
        FirestoreFieldName.profileBannerImageUrl:
            nullableString(data[FirestoreFieldName.profileBannerImageUrl]),
        FirestoreFieldName.familyId:
            nullableString(data[FirestoreFieldName.familyId]),
        FirestoreFieldName.primaryAccountEmail:
            nullableString(data[FirestoreFieldName.primaryAccountEmail]),
        FirestoreFieldName.phoneNumber:
            nullableString(data[FirestoreFieldName.phoneNumber]),
        FirestoreFieldName.street:
            nullableString(data[FirestoreFieldName.street]),
        FirestoreFieldName.city: nullableString(data[FirestoreFieldName.city]),
        FirestoreFieldName.addressState:
            nullableString(data[FirestoreFieldName.addressState]),
        FirestoreFieldName.zip: nullableString(data[FirestoreFieldName.zip]),
        FirestoreFieldName.country:
            nullableString(data[FirestoreFieldName.country]),

        // Convert timestamps
        FirestoreFieldName.createDate: timestamps.createDate,
        FirestoreFieldName.lastUpdateDate: timestamps.lastUpdateDate,
        FirestoreFieldName.lastLoginDate: timestamps.lastLoginDate,
        FirestoreFieldName.lastPasswordChangeDate:
            timestamps.lastPasswordChangeDate,

        // Boolean flags
        FirestoreFieldName.isAdmin: data[FirestoreFieldName.isAdmin] ?? false,
        FirestoreFieldName.isEmailVerified:
            data[FirestoreFieldName.isEmailVerified] ?? false,
        FirestoreFieldName.isApproved:
            data[FirestoreFieldName.isApproved] ?? false,
        FirestoreFieldName.isInfoShared:
            data[FirestoreFieldName.isInfoShared] ?? false,
        FirestoreFieldName.isChatEnabled:
            data[FirestoreFieldName.isChatEnabled] ?? false,
        FirestoreFieldName.isPrimaryAccount:
            data[FirestoreFieldName.isPrimaryAccount] ?? false,

        // Default nested objects if not present
        FirestoreFieldName.preferences: data[FirestoreFieldName.preferences] ??
            const UserPreferences().toJson(),
        FirestoreFieldName.notificationSettings:
            data[FirestoreFieldName.notificationSettings] ??
                const NotificationSettings().toJson(),
        FirestoreFieldName.privacySettings:
            data[FirestoreFieldName.privacySettings] ??
                const PrivacySettings().toJson(),

        // Provider and linked providers
        FirestoreFieldName.provider:
            data[FirestoreFieldName.provider] ?? AppAuthProvider.email.name,
        if (providerDataList != null)
          FirestoreFieldName.providerData: providerDataList,
        FirestoreFieldName.linkedProviders:
            (data[FirestoreFieldName.linkedProviders] as List<dynamic>?)
                    ?.map((e) => e.toString())
                    .toList() ??
                [],

        // Account status
        FirestoreFieldName.accountStatus:
            data[FirestoreFieldName.accountStatus] ?? AccountStatus.active.name,
      };

      // // Cache the JSON data
      // _cacheManager.cacheUser(userId, jsonData);

      debugPrint('Converted data: $jsonData');
      return AppUser.fromJson(jsonData);
    } catch (e, st) {
      debugPrint('Error converting document to AppUser:');
      debugPrint('Error: $e');
      debugPrint('Stack trace: $st');
      debugPrint('Document data: ${doc.data()}');
      rethrow;
    }
  }

  // Method to clear cache for a specific user
  static void clearCache(String userId) {
    _firestoreCache.remove(userId);
    _jsonCache.remove(userId);
    debugPrint('Cleared cache for user: $userId');
  }

  // Method to clear all cache
  static void clearAllCache() {
    _firestoreCache.clear();
    _jsonCache.clear();
    debugPrint('Cleared all user cache');
  }

  // Helper method to invalidate cache when user data changes
  void invalidateCache() {
    clearCache(id);
  }

  // Helper method to validate required fields
  static void _validateRequiredFields(Map<String, dynamic> data) {
    final requiredFields = {
      FirestoreFieldName.email: 'Email',
      FirestoreFieldName.displayName: 'Display Name',
      FirestoreFieldName.createDate: 'Create Date',
    };

    final missingFields = requiredFields.entries
        .where((entry) => data[entry.key] == null)
        .map((entry) => entry.value)
        .toList();

    if (missingFields.isNotEmpty) {
      throw FirestoreException(
        'Missing required fields: ${missingFields.join(', ')}',
        code: 'missing-fields',
        details: {'fields': missingFields},
      );
    }
  }

  // Helper method to convert timestamps
  static ({
    String createDate,
    String lastUpdateDate,
    String lastLoginDate,
    String? lastPasswordChangeDate,
  }) _convertTimestamps(Map<String, dynamic> data) {
    final now = DateTime.now().toIso8601String();

    String convertTimestamp(dynamic value) {
      return switch (value) {
        Timestamp() => value.toDate().toIso8601String(),
        DateTime() => value.toIso8601String(),
        String() => DateTime.parse(value).toIso8601String(),
        _ => now,
      };
    }

    return (
      createDate: convertTimestamp(data[FirestoreFieldName.createDate]),
      lastUpdateDate: convertTimestamp(data[FirestoreFieldName.lastUpdateDate]),
      lastLoginDate: convertTimestamp(data[FirestoreFieldName.lastLoginDate]),
      lastPasswordChangeDate: data[FirestoreFieldName.lastPasswordChangeDate] !=
              null
          ? convertTimestamp(data[FirestoreFieldName.lastPasswordChangeDate])
          : null,
    );
  }

  // Helper method to convert provider data
  static List<Map<String, dynamic>>? _convertProviderData(
      Map<String, dynamic> data) {
    final providerDataRaw = data[FirestoreFieldName.providerData];
    if (providerDataRaw == null) return null;

    if (providerDataRaw is! List) {
      throw FirestoreException(
        'Provider data is not a list',
        code: 'invalid-provider-data',
        details: {'providerData': providerDataRaw},
      );
    }

    return providerDataRaw.map((item) => item as Map<String, dynamic>).toList();
  }

  // Validation methods
  bool get isValid =>
      email.isNotEmpty &&
      displayName.isNotEmpty &&
      id.isNotEmpty &&
      accountStatus != AccountStatus.deleted;

  bool get canLogin =>
      isValid &&
      (isEmailVerified || provider != AppAuthProvider.email) &&
      accountStatus == AccountStatus.active;

  bool get isSessionExpired {
    final sessionDuration = DateTime.now().difference(lastLoginDate);
    return sessionDuration > UserDefaults.sessionTimeout;
  }

  bool get requiresPasswordChange {
    if (lastPasswordChangeDate == null) return true;
    final passwordAge = DateTime.now().difference(lastPasswordChangeDate!);
    return passwordAge > const Duration(days: 90);
  }

  // Logging helper
  void logUserOperation(String operation, {Map<String, dynamic>? details}) {
    debugPrint('''
User Operation: $operation
User ID: $id
Email: $email
Details: $details
Timestamp: ${DateTime.now()}
''');
  }

  // Factory constructor for new users
  factory AppUser.create({
    required String id,
    required String email,
    required String displayName,
    String? phoneNumber,
    AppAuthProvider provider = AppAuthProvider.email,
    List<ProviderData>? providerData,
    String? profileImageURL,
  }) {
    final now = DateTime.now();
    return AppUser(
      id: id,
      email: email,
      displayName: displayName,
      phoneNumber: phoneNumber,
      provider: provider,
      linkedProviders: [provider.name],
      providerData: providerData,
      profileImageURL: profileImageURL,
      createDate: now,
      lastLoginDate: now,
      lastUpdateDate: now,
      lastPasswordChangeDate: provider == AppAuthProvider.email ? now : null,
    );
  }

  // Factory constructor for social auth
  factory AppUser.fromSocialAuth({
    required String id,
    required String email,
    required String displayName,
    required AppAuthProvider provider,
    String? phoneNumber,
    String? profileImageURL,
    List<ProviderData>? providerData,
  }) {
    final now = DateTime.now();
    return AppUser(
      id: id,
      email: email,
      displayName: displayName,
      phoneNumber: phoneNumber,
      provider: provider,
      linkedProviders: [provider.name],
      providerData: providerData,
      profileImageURL: profileImageURL,
      isEmailVerified: true, // Social auth emails are typically verified
      createDate: now,
      lastLoginDate: now,
      lastUpdateDate: now,
    );
  }

  // Helper methods
  AppUser withUpdatedLoginTime() {
    return copyWith(
      lastLoginDate: DateTime.now(),
      lastUpdateDate: DateTime.now(),
    );
  }

  AppUser withUpdatedProfile({
    String? displayName,
    String? phoneNumber,
    String? street,
    String? city,
    String? addressState,
    String? zip,
    String? country,
    String? profileImageURL,
    String? profileBannerImageURL,
  }) {
    return copyWith(
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      street: street ?? this.street,
      city: city ?? this.city,
      addressState: addressState ?? this.addressState,
      zip: zip ?? this.zip,
      country: country ?? this.country,
      profileImageURL: profileImageURL ?? this.profileImageURL,
      profileBannerImageURL:
          profileBannerImageURL ?? this.profileBannerImageURL,
      lastUpdateDate: DateTime.now(),
    );
  }

  AppUser withEmailVerification(bool isVerified) {
    return copyWith(
      isEmailVerified: isVerified,
      lastUpdateDate: DateTime.now(),
    );
  }

  AppUser withAdminApproval(bool isApproved) {
    return copyWith(
      isApproved: isApproved,
      lastUpdateDate: DateTime.now(),
    );
  }

  AppUser withIsAdmin(bool isAdmin) {
    return copyWith(
      isAdmin: isAdmin,
      lastUpdateDate: DateTime.now(),
    );
  }

  AppUser withIsChatEnabled(bool isChatEnabled) {
    return copyWith(
      isChatEnabled: isChatEnabled,
      lastUpdateDate: DateTime.now(),
    );
  }

  AppUser withIsInfoShared(bool isInfoShared) {
    return copyWith(
      isInfoShared: isInfoShared,
      lastUpdateDate: DateTime.now(),
    );
  }

  AppUser withIsPrimaryAccount(bool isPrimaryAccount) {
    return copyWith(
      isPrimaryAccount: isPrimaryAccount,
      lastUpdateDate: DateTime.now(),
    );
  }

  // Helper method to update user preferences
  AppUser withUpdatedPreferences(UserPreferences newPreferences) {
    return copyWith(
      preferences: newPreferences,
      lastUpdateDate: DateTime.now(),
    );
  }

  // Helper method to update notification settings
  AppUser withUpdatedNotificationSettings(NotificationSettings newSettings) {
    return copyWith(
      notificationSettings: newSettings,
      lastUpdateDate: DateTime.now(),
    );
  }

  // Helper method to update privacy settings
  AppUser withUpdatedPrivacySettings(PrivacySettings newSettings) {
    return copyWith(
      privacySettings: newSettings,
      lastUpdateDate: DateTime.now(),
    );
  }

  // Helper method to update account status
  AppUser withUpdatedAccountStatus(AccountStatus newStatus) {
    return copyWith(
      accountStatus: newStatus,
      lastUpdateDate: DateTime.now(),
    );
  }

  // Helper method to update password change date
  AppUser withUpdatedPasswordChangeDate() {
    return copyWith(
      lastPasswordChangeDate: DateTime.now(),
      lastUpdateDate: DateTime.now(),
    );
  }

  // Method to merge provider data
  List<ProviderData> _mergeProviderData(List<ProviderData>? otherProviderData) {
    final mergedProviderData = <ProviderData>[];

    // Add existing provider data
    if (providerData != null) {
      mergedProviderData.addAll(providerData!);
    }

    // Add other's provider data, avoiding duplicates
    if (otherProviderData != null) {
      for (final otherProvider in otherProviderData) {
        if (!mergedProviderData.any((p) =>
            p.providerId == otherProvider.providerId &&
            p.uid == otherProvider.uid)) {
          mergedProviderData.add(otherProvider);
        }
      }
    }

    return mergedProviderData;
  }

  // Method to merge data from provider auth
  AppUser mergeWithProviderData(ProviderData newProviderData) {
    final updatedProviderData = _mergeProviderData([newProviderData]);

    return copyWith(
      providerData: updatedProviderData,
      linkedProviders:
          [...linkedProviders, newProviderData.providerId].toSet().toList(),
      displayName: newProviderData.displayName ?? displayName,
      profileImageURL: profileImageURL ?? newProviderData.photoURL,
      // email: newProviderData.email ?? email,
      phoneNumber: phoneNumber ?? newProviderData.phoneNumber,
      lastUpdateDate: DateTime.now(),
    );
  }

  // Method to merge data from linked accounts
  AppUser mergeWithLinkedAccount(AppUser other) {
    debugPrint('Merging accounts:');
    debugPrint(
        'Main user ID: $id, providers: ${providerData?.map((p) => p.providerId).join(", ")}');
    debugPrint(
        'Other user ID: ${other.id}, providers: ${other.providerData?.map((p) => p.providerId).join(", ")}');

    // Validate before merge
    _validateMerge(other);

    // Merge provider data
    final mergedProviderData = _mergeProviderData(other.providerData);

    // Create merged user
    final mergedUser = copyWith(
      linkedProviders:
          [...linkedProviders, ...other.linkedProviders].toSet().toList(),
      providerData: mergedProviderData,
      displayName: displayName.isEmpty ? other.displayName : displayName,
      profileImageURL: profileImageURL ?? other.profileImageURL,
      phoneNumber: phoneNumber ?? other.phoneNumber,
      lastUpdateDate: DateTime.now(),
    );

    debugPrint(
        'Merged user providers: ${mergedUser.providerData?.map((p) => p.providerId).join(", ")}');
    return mergedUser;
  }

  // Validation method
  void _validateMerge(AppUser other) {
    // Check for same user
    if (id == other.id) {
      throw Exception('Cannot merge account with itself');
    }

    // Check for same email
    if (email != other.email && email.isNotEmpty && other.email.isNotEmpty) {
      throw Exception('Cannot merge accounts with different emails');
    }

    // Check for provider conflicts
    final existingProviderIds =
        providerData?.map((p) => p.providerId).toSet() ?? {};
    final otherProviderIds =
        other.providerData?.map((p) => p.providerId).toSet() ?? {};
    final conflictingProviders =
        existingProviderIds.intersection(otherProviderIds);

    if (conflictingProviders.isNotEmpty) {
      throw Exception(
          'Provider conflict found: ${conflictingProviders.join(", ")}');
    }
  }
}

// Extension method for DocumentSnapshot
extension FirestoreX on DocumentSnapshot<Map<String, dynamic>> {
  AppUser? toAppUser() {
    try {
      return AppUser.fromFirestore(this);
    } catch (e) {
      print('Error converting document to AppUser: $e');
      return null;
    }
  }
}

// DateTime converter for JSON serialization
class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}

// Provider converter for JSON serialization
class AuthProviderConverter implements JsonConverter<AppAuthProvider, String> {
  const AuthProviderConverter();

  @override
  AppAuthProvider fromJson(String json) {
    return AppAuthProvider.values.firstWhere(
      (e) => e.name == json,
      orElse: () => AppAuthProvider.email,
    );
  }

  @override
  String toJson(AppAuthProvider provider) => provider.name;
}

// Extension for cache management
extension AppUserCache on AppUser {
  bool get isCached =>
      AppUser._firestoreCache.containsKey(id) ||
      AppUser._jsonCache.containsKey(id);

  void refreshCache() {
    AppUser.clearCache(id);
    AppUser._firestoreCache[id] = toFirestore();
    AppUser._jsonCache[id] = toJson();
  }
}
