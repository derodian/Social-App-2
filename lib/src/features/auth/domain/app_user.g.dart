// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingsImpl _$$NotificationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsImpl(
      emailNotifications: json['email_notifications'] as bool? ?? true,
      pushNotifications: json['push_notifications'] as bool? ?? true,
      inAppNotifications: json['in_app_notifications'] as bool? ?? true,
    );

Map<String, dynamic> _$$NotificationSettingsImplToJson(
        _$NotificationSettingsImpl instance) =>
    <String, dynamic>{
      'email_notifications': instance.emailNotifications,
      'push_notifications': instance.pushNotifications,
      'in_app_notifications': instance.inAppNotifications,
    };

_$PrivacySettingsImpl _$$PrivacySettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$PrivacySettingsImpl(
      profileVisibleToPublic:
          json['profile_visible_to_public'] as bool? ?? true,
      hideOnlineStatus: json['hide_online_status'] as bool? ?? false,
      hideLastSeen: json['hide_last_seen'] as bool? ?? false,
    );

Map<String, dynamic> _$$PrivacySettingsImplToJson(
        _$PrivacySettingsImpl instance) =>
    <String, dynamic>{
      'profile_visible_to_public': instance.profileVisibleToPublic,
      'hide_online_status': instance.hideOnlineStatus,
      'hide_last_seen': instance.hideLastSeen,
    };

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String,
      profileImageURL: json['profile_image_url'] as String?,
      profileBannerImageURL: json['profile_banner_image_url'] as String?,
      familyId: json['family_id'] as String?,
      primaryAccountEmail: json['primary_account_email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      street: json['street'] as String?,
      city: json['city'] as String?,
      addressState: json['address_state'] as String?,
      zip: json['zip'] as String?,
      country: json['country'] as String?,
      createDate:
          const DateTimeConverter().fromJson(json['create_date'] as String),
      lastUpdateDate: const DateTimeConverter()
          .fromJson(json['last_update_date'] as String),
      lastLoginDate:
          const DateTimeConverter().fromJson(json['last_login_date'] as String),
      lastPasswordChangeDate: _$JsonConverterFromJson<String, DateTime>(
          json['last_password_change_date'],
          const DateTimeConverter().fromJson),
      isAdmin: json['is_admin'] as bool? ?? false,
      isEmailVerified: json['is_email_verified'] as bool? ?? false,
      isApproved: json['is_approved'] as bool? ?? false,
      isInfoShared: json['is_info_shared'] as bool? ?? false,
      isChatEnabled: json['is_chat_enabled'] as bool? ?? false,
      isPrimaryAccount: json['is_primary_account'] as bool? ?? false,
      provider:
          $enumDecodeNullable(_$AppAuthProviderEnumMap, json['provider']) ??
              AppAuthProvider.email,
      linkedProviders: (json['linked_providers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      accountStatus:
          $enumDecodeNullable(_$AccountStatusEnumMap, json['account_status']) ??
              AccountStatus.active,
      providerData: (json['provider_data'] as List<dynamic>?)
          ?.map((e) => ProviderData.fromJson(e as Map<String, dynamic>))
          .toList(),
      preferences: json['preferences'] == null
          ? const UserPreferences()
          : UserPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>),
      notificationSettings: json['notification_settings'] == null
          ? const NotificationSettings()
          : NotificationSettings.fromJson(
              json['notification_settings'] as Map<String, dynamic>),
      privacySettings: json['privacy_settings'] == null
          ? const PrivacySettings()
          : PrivacySettings.fromJson(
              json['privacy_settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_name': instance.displayName,
      'profile_image_url': instance.profileImageURL,
      'profile_banner_image_url': instance.profileBannerImageURL,
      'family_id': instance.familyId,
      'primary_account_email': instance.primaryAccountEmail,
      'phone_number': instance.phoneNumber,
      'street': instance.street,
      'city': instance.city,
      'address_state': instance.addressState,
      'zip': instance.zip,
      'country': instance.country,
      'create_date': const DateTimeConverter().toJson(instance.createDate),
      'last_update_date':
          const DateTimeConverter().toJson(instance.lastUpdateDate),
      'last_login_date':
          const DateTimeConverter().toJson(instance.lastLoginDate),
      'last_password_change_date': _$JsonConverterToJson<String, DateTime>(
          instance.lastPasswordChangeDate, const DateTimeConverter().toJson),
      'is_admin': instance.isAdmin,
      'is_email_verified': instance.isEmailVerified,
      'is_approved': instance.isApproved,
      'is_info_shared': instance.isInfoShared,
      'is_chat_enabled': instance.isChatEnabled,
      'is_primary_account': instance.isPrimaryAccount,
      'provider': _$AppAuthProviderEnumMap[instance.provider]!,
      'linked_providers': instance.linkedProviders,
      'account_status': _$AccountStatusEnumMap[instance.accountStatus]!,
      'provider_data': instance.providerData,
      'preferences': instance.preferences,
      'notification_settings': instance.notificationSettings,
      'privacy_settings': instance.privacySettings,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$AppAuthProviderEnumMap = {
  AppAuthProvider.email: 'email',
  AppAuthProvider.google: 'google',
  AppAuthProvider.apple: 'apple',
  AppAuthProvider.facebook: 'facebook',
  AppAuthProvider.github: 'github',
};

const _$AccountStatusEnumMap = {
  AccountStatus.active: 'active',
  AccountStatus.suspended: 'suspended',
  AccountStatus.deleted: 'deleted',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
