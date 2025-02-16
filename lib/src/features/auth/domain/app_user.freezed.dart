// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
  @JsonKey(name: FirestoreFieldName.darkMode)
  bool get darkMode => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.language)
  String get language => throw _privateConstructorUsedError;

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
          UserPreferences value, $Res Function(UserPreferences) then) =
      _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.darkMode) bool darkMode,
      @JsonKey(name: FirestoreFieldName.language) String language});
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkMode = null,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      darkMode: null == darkMode
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(_$UserPreferencesImpl value,
          $Res Function(_$UserPreferencesImpl) then) =
      __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.darkMode) bool darkMode,
      @JsonKey(name: FirestoreFieldName.language) String language});
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
      _$UserPreferencesImpl _value, $Res Function(_$UserPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkMode = null,
    Object? language = null,
  }) {
    return _then(_$UserPreferencesImpl(
      darkMode: null == darkMode
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl
    with DiagnosticableTreeMixin
    implements _UserPreferences {
  const _$UserPreferencesImpl(
      {@JsonKey(name: FirestoreFieldName.darkMode) this.darkMode = true,
      @JsonKey(name: FirestoreFieldName.language) this.language = 'en'});

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

  @override
  @JsonKey(name: FirestoreFieldName.darkMode)
  final bool darkMode;
  @override
  @JsonKey(name: FirestoreFieldName.language)
  final String language;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserPreferences(darkMode: $darkMode, language: $language)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserPreferences'))
      ..add(DiagnosticsProperty('darkMode', darkMode))
      ..add(DiagnosticsProperty('language', language));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            (identical(other.darkMode, darkMode) ||
                other.darkMode == darkMode) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, darkMode, language);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(
      this,
    );
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences(
          {@JsonKey(name: FirestoreFieldName.darkMode) final bool darkMode,
          @JsonKey(name: FirestoreFieldName.language) final String language}) =
      _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

  @override
  @JsonKey(name: FirestoreFieldName.darkMode)
  bool get darkMode;
  @override
  @JsonKey(name: FirestoreFieldName.language)
  String get language;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationSettings _$NotificationSettingsFromJson(Map<String, dynamic> json) {
  return _NotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettings {
  @JsonKey(name: FirestoreFieldName.emailNotifications)
  bool get emailNotifications => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.pushNotifications)
  bool get pushNotifications => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.inAppNotifications)
  bool get inAppNotifications => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsCopyWith<NotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsCopyWith<$Res> {
  factory $NotificationSettingsCopyWith(NotificationSettings value,
          $Res Function(NotificationSettings) then) =
      _$NotificationSettingsCopyWithImpl<$Res, NotificationSettings>;
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.emailNotifications)
      bool emailNotifications,
      @JsonKey(name: FirestoreFieldName.pushNotifications)
      bool pushNotifications,
      @JsonKey(name: FirestoreFieldName.inAppNotifications)
      bool inAppNotifications});
}

/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res,
        $Val extends NotificationSettings>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailNotifications = null,
    Object? pushNotifications = null,
    Object? inAppNotifications = null,
  }) {
    return _then(_value.copyWith(
      emailNotifications: null == emailNotifications
          ? _value.emailNotifications
          : emailNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotifications: null == pushNotifications
          ? _value.pushNotifications
          : pushNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      inAppNotifications: null == inAppNotifications
          ? _value.inAppNotifications
          : inAppNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsImplCopyWith<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  factory _$$NotificationSettingsImplCopyWith(_$NotificationSettingsImpl value,
          $Res Function(_$NotificationSettingsImpl) then) =
      __$$NotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.emailNotifications)
      bool emailNotifications,
      @JsonKey(name: FirestoreFieldName.pushNotifications)
      bool pushNotifications,
      @JsonKey(name: FirestoreFieldName.inAppNotifications)
      bool inAppNotifications});
}

/// @nodoc
class __$$NotificationSettingsImplCopyWithImpl<$Res>
    extends _$NotificationSettingsCopyWithImpl<$Res, _$NotificationSettingsImpl>
    implements _$$NotificationSettingsImplCopyWith<$Res> {
  __$$NotificationSettingsImplCopyWithImpl(_$NotificationSettingsImpl _value,
      $Res Function(_$NotificationSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailNotifications = null,
    Object? pushNotifications = null,
    Object? inAppNotifications = null,
  }) {
    return _then(_$NotificationSettingsImpl(
      emailNotifications: null == emailNotifications
          ? _value.emailNotifications
          : emailNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotifications: null == pushNotifications
          ? _value.pushNotifications
          : pushNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      inAppNotifications: null == inAppNotifications
          ? _value.inAppNotifications
          : inAppNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsImpl
    with DiagnosticableTreeMixin
    implements _NotificationSettings {
  const _$NotificationSettingsImpl(
      {@JsonKey(name: FirestoreFieldName.emailNotifications)
      this.emailNotifications = true,
      @JsonKey(name: FirestoreFieldName.pushNotifications)
      this.pushNotifications = true,
      @JsonKey(name: FirestoreFieldName.inAppNotifications)
      this.inAppNotifications = true});

  factory _$NotificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsImplFromJson(json);

  @override
  @JsonKey(name: FirestoreFieldName.emailNotifications)
  final bool emailNotifications;
  @override
  @JsonKey(name: FirestoreFieldName.pushNotifications)
  final bool pushNotifications;
  @override
  @JsonKey(name: FirestoreFieldName.inAppNotifications)
  final bool inAppNotifications;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationSettings(emailNotifications: $emailNotifications, pushNotifications: $pushNotifications, inAppNotifications: $inAppNotifications)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationSettings'))
      ..add(DiagnosticsProperty('emailNotifications', emailNotifications))
      ..add(DiagnosticsProperty('pushNotifications', pushNotifications))
      ..add(DiagnosticsProperty('inAppNotifications', inAppNotifications));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsImpl &&
            (identical(other.emailNotifications, emailNotifications) ||
                other.emailNotifications == emailNotifications) &&
            (identical(other.pushNotifications, pushNotifications) ||
                other.pushNotifications == pushNotifications) &&
            (identical(other.inAppNotifications, inAppNotifications) ||
                other.inAppNotifications == inAppNotifications));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, emailNotifications, pushNotifications, inAppNotifications);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith =>
          __$$NotificationSettingsImplCopyWithImpl<_$NotificationSettingsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettings implements NotificationSettings {
  const factory _NotificationSettings(
      {@JsonKey(name: FirestoreFieldName.emailNotifications)
      final bool emailNotifications,
      @JsonKey(name: FirestoreFieldName.pushNotifications)
      final bool pushNotifications,
      @JsonKey(name: FirestoreFieldName.inAppNotifications)
      final bool inAppNotifications}) = _$NotificationSettingsImpl;

  factory _NotificationSettings.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsImpl.fromJson;

  @override
  @JsonKey(name: FirestoreFieldName.emailNotifications)
  bool get emailNotifications;
  @override
  @JsonKey(name: FirestoreFieldName.pushNotifications)
  bool get pushNotifications;
  @override
  @JsonKey(name: FirestoreFieldName.inAppNotifications)
  bool get inAppNotifications;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PrivacySettings _$PrivacySettingsFromJson(Map<String, dynamic> json) {
  return _PrivacySettings.fromJson(json);
}

/// @nodoc
mixin _$PrivacySettings {
  @JsonKey(name: FirestoreFieldName.profileVisibleToPublic)
  bool get profileVisibleToPublic => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.hideOnlineStatus)
  bool get hideOnlineStatus => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.hideLastSeen)
  bool get hideLastSeen => throw _privateConstructorUsedError;

  /// Serializes this PrivacySettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrivacySettingsCopyWith<PrivacySettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrivacySettingsCopyWith<$Res> {
  factory $PrivacySettingsCopyWith(
          PrivacySettings value, $Res Function(PrivacySettings) then) =
      _$PrivacySettingsCopyWithImpl<$Res, PrivacySettings>;
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.profileVisibleToPublic)
      bool profileVisibleToPublic,
      @JsonKey(name: FirestoreFieldName.hideOnlineStatus) bool hideOnlineStatus,
      @JsonKey(name: FirestoreFieldName.hideLastSeen) bool hideLastSeen});
}

/// @nodoc
class _$PrivacySettingsCopyWithImpl<$Res, $Val extends PrivacySettings>
    implements $PrivacySettingsCopyWith<$Res> {
  _$PrivacySettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileVisibleToPublic = null,
    Object? hideOnlineStatus = null,
    Object? hideLastSeen = null,
  }) {
    return _then(_value.copyWith(
      profileVisibleToPublic: null == profileVisibleToPublic
          ? _value.profileVisibleToPublic
          : profileVisibleToPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      hideOnlineStatus: null == hideOnlineStatus
          ? _value.hideOnlineStatus
          : hideOnlineStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      hideLastSeen: null == hideLastSeen
          ? _value.hideLastSeen
          : hideLastSeen // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrivacySettingsImplCopyWith<$Res>
    implements $PrivacySettingsCopyWith<$Res> {
  factory _$$PrivacySettingsImplCopyWith(_$PrivacySettingsImpl value,
          $Res Function(_$PrivacySettingsImpl) then) =
      __$$PrivacySettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.profileVisibleToPublic)
      bool profileVisibleToPublic,
      @JsonKey(name: FirestoreFieldName.hideOnlineStatus) bool hideOnlineStatus,
      @JsonKey(name: FirestoreFieldName.hideLastSeen) bool hideLastSeen});
}

/// @nodoc
class __$$PrivacySettingsImplCopyWithImpl<$Res>
    extends _$PrivacySettingsCopyWithImpl<$Res, _$PrivacySettingsImpl>
    implements _$$PrivacySettingsImplCopyWith<$Res> {
  __$$PrivacySettingsImplCopyWithImpl(
      _$PrivacySettingsImpl _value, $Res Function(_$PrivacySettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileVisibleToPublic = null,
    Object? hideOnlineStatus = null,
    Object? hideLastSeen = null,
  }) {
    return _then(_$PrivacySettingsImpl(
      profileVisibleToPublic: null == profileVisibleToPublic
          ? _value.profileVisibleToPublic
          : profileVisibleToPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      hideOnlineStatus: null == hideOnlineStatus
          ? _value.hideOnlineStatus
          : hideOnlineStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      hideLastSeen: null == hideLastSeen
          ? _value.hideLastSeen
          : hideLastSeen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrivacySettingsImpl
    with DiagnosticableTreeMixin
    implements _PrivacySettings {
  const _$PrivacySettingsImpl(
      {@JsonKey(name: FirestoreFieldName.profileVisibleToPublic)
      this.profileVisibleToPublic = true,
      @JsonKey(name: FirestoreFieldName.hideOnlineStatus)
      this.hideOnlineStatus = false,
      @JsonKey(name: FirestoreFieldName.hideLastSeen)
      this.hideLastSeen = false});

  factory _$PrivacySettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrivacySettingsImplFromJson(json);

  @override
  @JsonKey(name: FirestoreFieldName.profileVisibleToPublic)
  final bool profileVisibleToPublic;
  @override
  @JsonKey(name: FirestoreFieldName.hideOnlineStatus)
  final bool hideOnlineStatus;
  @override
  @JsonKey(name: FirestoreFieldName.hideLastSeen)
  final bool hideLastSeen;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrivacySettings(profileVisibleToPublic: $profileVisibleToPublic, hideOnlineStatus: $hideOnlineStatus, hideLastSeen: $hideLastSeen)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrivacySettings'))
      ..add(
          DiagnosticsProperty('profileVisibleToPublic', profileVisibleToPublic))
      ..add(DiagnosticsProperty('hideOnlineStatus', hideOnlineStatus))
      ..add(DiagnosticsProperty('hideLastSeen', hideLastSeen));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrivacySettingsImpl &&
            (identical(other.profileVisibleToPublic, profileVisibleToPublic) ||
                other.profileVisibleToPublic == profileVisibleToPublic) &&
            (identical(other.hideOnlineStatus, hideOnlineStatus) ||
                other.hideOnlineStatus == hideOnlineStatus) &&
            (identical(other.hideLastSeen, hideLastSeen) ||
                other.hideLastSeen == hideLastSeen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, profileVisibleToPublic, hideOnlineStatus, hideLastSeen);

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrivacySettingsImplCopyWith<_$PrivacySettingsImpl> get copyWith =>
      __$$PrivacySettingsImplCopyWithImpl<_$PrivacySettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrivacySettingsImplToJson(
      this,
    );
  }
}

abstract class _PrivacySettings implements PrivacySettings {
  const factory _PrivacySettings(
      {@JsonKey(name: FirestoreFieldName.profileVisibleToPublic)
      final bool profileVisibleToPublic,
      @JsonKey(name: FirestoreFieldName.hideOnlineStatus)
      final bool hideOnlineStatus,
      @JsonKey(name: FirestoreFieldName.hideLastSeen)
      final bool hideLastSeen}) = _$PrivacySettingsImpl;

  factory _PrivacySettings.fromJson(Map<String, dynamic> json) =
      _$PrivacySettingsImpl.fromJson;

  @override
  @JsonKey(name: FirestoreFieldName.profileVisibleToPublic)
  bool get profileVisibleToPublic;
  @override
  @JsonKey(name: FirestoreFieldName.hideOnlineStatus)
  bool get hideOnlineStatus;
  @override
  @JsonKey(name: FirestoreFieldName.hideLastSeen)
  bool get hideLastSeen;

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrivacySettingsImplCopyWith<_$PrivacySettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  @JsonKey(name: FirestoreFieldName.id)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.email)
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.displayName)
  String get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.profileImageUrl)
  String? get profileImageURL => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.profileBannerImageUrl)
  String? get profileBannerImageURL => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.familyId)
  String? get familyId => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.primaryAccountEmail)
  String? get primaryAccountEmail => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.phoneNumber)
  String? get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.street)
  String? get street => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.city)
  String? get city => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.addressState)
  String? get addressState => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.zip)
  String? get zip => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.country)
  String? get country => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.createDate)
  @DateTimeConverter()
  DateTime get createDate => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.lastUpdateDate)
  @DateTimeConverter()
  DateTime get lastUpdateDate => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.lastLoginDate)
  @DateTimeConverter()
  DateTime get lastLoginDate => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.lastPasswordChangeDate)
  @DateTimeConverter()
  DateTime? get lastPasswordChangeDate => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.isAdmin)
  bool get isAdmin => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.isEmailVerified)
  bool get isEmailVerified => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.isApproved)
  bool get isApproved => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.isInfoShared)
  bool get isInfoShared => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.isChatEnabled)
  bool get isChatEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.isPrimaryAccount)
  bool get isPrimaryAccount => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.provider)
  AppAuthProvider get provider => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.linkedProviders)
  List<String> get linkedProviders => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.accountStatus)
  AccountStatus get accountStatus => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.providerData)
  List<ProviderData>? get providerData => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.preferences)
  UserPreferences get preferences => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.notificationSettings)
  NotificationSettings get notificationSettings =>
      throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.privacySettings)
  PrivacySettings get privacySettings => throw _privateConstructorUsedError;

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.id) String id,
      @JsonKey(name: FirestoreFieldName.email) String email,
      @JsonKey(name: FirestoreFieldName.displayName) String displayName,
      @JsonKey(name: FirestoreFieldName.profileImageUrl)
      String? profileImageURL,
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
      DateTime createDate,
      @JsonKey(name: FirestoreFieldName.lastUpdateDate)
      @DateTimeConverter()
      DateTime lastUpdateDate,
      @JsonKey(name: FirestoreFieldName.lastLoginDate)
      @DateTimeConverter()
      DateTime lastLoginDate,
      @JsonKey(name: FirestoreFieldName.lastPasswordChangeDate)
      @DateTimeConverter()
      DateTime? lastPasswordChangeDate,
      @JsonKey(name: FirestoreFieldName.isAdmin) bool isAdmin,
      @JsonKey(name: FirestoreFieldName.isEmailVerified) bool isEmailVerified,
      @JsonKey(name: FirestoreFieldName.isApproved) bool isApproved,
      @JsonKey(name: FirestoreFieldName.isInfoShared) bool isInfoShared,
      @JsonKey(name: FirestoreFieldName.isChatEnabled) bool isChatEnabled,
      @JsonKey(name: FirestoreFieldName.isPrimaryAccount) bool isPrimaryAccount,
      @JsonKey(name: FirestoreFieldName.provider) AppAuthProvider provider,
      @JsonKey(name: FirestoreFieldName.linkedProviders)
      List<String> linkedProviders,
      @JsonKey(name: FirestoreFieldName.accountStatus)
      AccountStatus accountStatus,
      @JsonKey(name: FirestoreFieldName.providerData)
      List<ProviderData>? providerData,
      @JsonKey(name: FirestoreFieldName.preferences)
      UserPreferences preferences,
      @JsonKey(name: FirestoreFieldName.notificationSettings)
      NotificationSettings notificationSettings,
      @JsonKey(name: FirestoreFieldName.privacySettings)
      PrivacySettings privacySettings});

  $UserPreferencesCopyWith<$Res> get preferences;
  $NotificationSettingsCopyWith<$Res> get notificationSettings;
  $PrivacySettingsCopyWith<$Res> get privacySettings;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
    Object? profileImageURL = freezed,
    Object? profileBannerImageURL = freezed,
    Object? familyId = freezed,
    Object? primaryAccountEmail = freezed,
    Object? phoneNumber = freezed,
    Object? street = freezed,
    Object? city = freezed,
    Object? addressState = freezed,
    Object? zip = freezed,
    Object? country = freezed,
    Object? createDate = null,
    Object? lastUpdateDate = null,
    Object? lastLoginDate = null,
    Object? lastPasswordChangeDate = freezed,
    Object? isAdmin = null,
    Object? isEmailVerified = null,
    Object? isApproved = null,
    Object? isInfoShared = null,
    Object? isChatEnabled = null,
    Object? isPrimaryAccount = null,
    Object? provider = null,
    Object? linkedProviders = null,
    Object? accountStatus = null,
    Object? providerData = freezed,
    Object? preferences = null,
    Object? notificationSettings = null,
    Object? privacySettings = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageURL: freezed == profileImageURL
          ? _value.profileImageURL
          : profileImageURL // ignore: cast_nullable_to_non_nullable
              as String?,
      profileBannerImageURL: freezed == profileBannerImageURL
          ? _value.profileBannerImageURL
          : profileBannerImageURL // ignore: cast_nullable_to_non_nullable
              as String?,
      familyId: freezed == familyId
          ? _value.familyId
          : familyId // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryAccountEmail: freezed == primaryAccountEmail
          ? _value.primaryAccountEmail
          : primaryAccountEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      addressState: freezed == addressState
          ? _value.addressState
          : addressState // ignore: cast_nullable_to_non_nullable
              as String?,
      zip: freezed == zip
          ? _value.zip
          : zip // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdateDate: null == lastUpdateDate
          ? _value.lastUpdateDate
          : lastUpdateDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLoginDate: null == lastLoginDate
          ? _value.lastLoginDate
          : lastLoginDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastPasswordChangeDate: freezed == lastPasswordChangeDate
          ? _value.lastPasswordChangeDate
          : lastPasswordChangeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      isInfoShared: null == isInfoShared
          ? _value.isInfoShared
          : isInfoShared // ignore: cast_nullable_to_non_nullable
              as bool,
      isChatEnabled: null == isChatEnabled
          ? _value.isChatEnabled
          : isChatEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrimaryAccount: null == isPrimaryAccount
          ? _value.isPrimaryAccount
          : isPrimaryAccount // ignore: cast_nullable_to_non_nullable
              as bool,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as AppAuthProvider,
      linkedProviders: null == linkedProviders
          ? _value.linkedProviders
          : linkedProviders // ignore: cast_nullable_to_non_nullable
              as List<String>,
      accountStatus: null == accountStatus
          ? _value.accountStatus
          : accountStatus // ignore: cast_nullable_to_non_nullable
              as AccountStatus,
      providerData: freezed == providerData
          ? _value.providerData
          : providerData // ignore: cast_nullable_to_non_nullable
              as List<ProviderData>?,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreferences,
      notificationSettings: null == notificationSettings
          ? _value.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      privacySettings: null == privacySettings
          ? _value.privacySettings
          : privacySettings // ignore: cast_nullable_to_non_nullable
              as PrivacySettings,
    ) as $Val);
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPreferencesCopyWith<$Res> get preferences {
    return $UserPreferencesCopyWith<$Res>(_value.preferences, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationSettingsCopyWith<$Res> get notificationSettings {
    return $NotificationSettingsCopyWith<$Res>(_value.notificationSettings,
        (value) {
      return _then(_value.copyWith(notificationSettings: value) as $Val);
    });
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrivacySettingsCopyWith<$Res> get privacySettings {
    return $PrivacySettingsCopyWith<$Res>(_value.privacySettings, (value) {
      return _then(_value.copyWith(privacySettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
          _$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.id) String id,
      @JsonKey(name: FirestoreFieldName.email) String email,
      @JsonKey(name: FirestoreFieldName.displayName) String displayName,
      @JsonKey(name: FirestoreFieldName.profileImageUrl)
      String? profileImageURL,
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
      DateTime createDate,
      @JsonKey(name: FirestoreFieldName.lastUpdateDate)
      @DateTimeConverter()
      DateTime lastUpdateDate,
      @JsonKey(name: FirestoreFieldName.lastLoginDate)
      @DateTimeConverter()
      DateTime lastLoginDate,
      @JsonKey(name: FirestoreFieldName.lastPasswordChangeDate)
      @DateTimeConverter()
      DateTime? lastPasswordChangeDate,
      @JsonKey(name: FirestoreFieldName.isAdmin) bool isAdmin,
      @JsonKey(name: FirestoreFieldName.isEmailVerified) bool isEmailVerified,
      @JsonKey(name: FirestoreFieldName.isApproved) bool isApproved,
      @JsonKey(name: FirestoreFieldName.isInfoShared) bool isInfoShared,
      @JsonKey(name: FirestoreFieldName.isChatEnabled) bool isChatEnabled,
      @JsonKey(name: FirestoreFieldName.isPrimaryAccount) bool isPrimaryAccount,
      @JsonKey(name: FirestoreFieldName.provider) AppAuthProvider provider,
      @JsonKey(name: FirestoreFieldName.linkedProviders)
      List<String> linkedProviders,
      @JsonKey(name: FirestoreFieldName.accountStatus)
      AccountStatus accountStatus,
      @JsonKey(name: FirestoreFieldName.providerData)
      List<ProviderData>? providerData,
      @JsonKey(name: FirestoreFieldName.preferences)
      UserPreferences preferences,
      @JsonKey(name: FirestoreFieldName.notificationSettings)
      NotificationSettings notificationSettings,
      @JsonKey(name: FirestoreFieldName.privacySettings)
      PrivacySettings privacySettings});

  @override
  $UserPreferencesCopyWith<$Res> get preferences;
  @override
  $NotificationSettingsCopyWith<$Res> get notificationSettings;
  @override
  $PrivacySettingsCopyWith<$Res> get privacySettings;
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
      _$AppUserImpl _value, $Res Function(_$AppUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
    Object? profileImageURL = freezed,
    Object? profileBannerImageURL = freezed,
    Object? familyId = freezed,
    Object? primaryAccountEmail = freezed,
    Object? phoneNumber = freezed,
    Object? street = freezed,
    Object? city = freezed,
    Object? addressState = freezed,
    Object? zip = freezed,
    Object? country = freezed,
    Object? createDate = null,
    Object? lastUpdateDate = null,
    Object? lastLoginDate = null,
    Object? lastPasswordChangeDate = freezed,
    Object? isAdmin = null,
    Object? isEmailVerified = null,
    Object? isApproved = null,
    Object? isInfoShared = null,
    Object? isChatEnabled = null,
    Object? isPrimaryAccount = null,
    Object? provider = null,
    Object? linkedProviders = null,
    Object? accountStatus = null,
    Object? providerData = freezed,
    Object? preferences = null,
    Object? notificationSettings = null,
    Object? privacySettings = null,
  }) {
    return _then(_$AppUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageURL: freezed == profileImageURL
          ? _value.profileImageURL
          : profileImageURL // ignore: cast_nullable_to_non_nullable
              as String?,
      profileBannerImageURL: freezed == profileBannerImageURL
          ? _value.profileBannerImageURL
          : profileBannerImageURL // ignore: cast_nullable_to_non_nullable
              as String?,
      familyId: freezed == familyId
          ? _value.familyId
          : familyId // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryAccountEmail: freezed == primaryAccountEmail
          ? _value.primaryAccountEmail
          : primaryAccountEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      addressState: freezed == addressState
          ? _value.addressState
          : addressState // ignore: cast_nullable_to_non_nullable
              as String?,
      zip: freezed == zip
          ? _value.zip
          : zip // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdateDate: null == lastUpdateDate
          ? _value.lastUpdateDate
          : lastUpdateDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLoginDate: null == lastLoginDate
          ? _value.lastLoginDate
          : lastLoginDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastPasswordChangeDate: freezed == lastPasswordChangeDate
          ? _value.lastPasswordChangeDate
          : lastPasswordChangeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      isInfoShared: null == isInfoShared
          ? _value.isInfoShared
          : isInfoShared // ignore: cast_nullable_to_non_nullable
              as bool,
      isChatEnabled: null == isChatEnabled
          ? _value.isChatEnabled
          : isChatEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrimaryAccount: null == isPrimaryAccount
          ? _value.isPrimaryAccount
          : isPrimaryAccount // ignore: cast_nullable_to_non_nullable
              as bool,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as AppAuthProvider,
      linkedProviders: null == linkedProviders
          ? _value._linkedProviders
          : linkedProviders // ignore: cast_nullable_to_non_nullable
              as List<String>,
      accountStatus: null == accountStatus
          ? _value.accountStatus
          : accountStatus // ignore: cast_nullable_to_non_nullable
              as AccountStatus,
      providerData: freezed == providerData
          ? _value._providerData
          : providerData // ignore: cast_nullable_to_non_nullable
              as List<ProviderData>?,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreferences,
      notificationSettings: null == notificationSettings
          ? _value.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      privacySettings: null == privacySettings
          ? _value.privacySettings
          : privacySettings // ignore: cast_nullable_to_non_nullable
              as PrivacySettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl extends _AppUser with DiagnosticableTreeMixin {
  const _$AppUserImpl(
      {@JsonKey(name: FirestoreFieldName.id) required this.id,
      @JsonKey(name: FirestoreFieldName.email) required this.email,
      @JsonKey(name: FirestoreFieldName.displayName) required this.displayName,
      @JsonKey(name: FirestoreFieldName.profileImageUrl) this.profileImageURL,
      @JsonKey(name: FirestoreFieldName.profileBannerImageUrl)
      this.profileBannerImageURL,
      @JsonKey(name: FirestoreFieldName.familyId) this.familyId,
      @JsonKey(name: FirestoreFieldName.primaryAccountEmail)
      this.primaryAccountEmail,
      @JsonKey(name: FirestoreFieldName.phoneNumber) this.phoneNumber,
      @JsonKey(name: FirestoreFieldName.street) this.street,
      @JsonKey(name: FirestoreFieldName.city) this.city,
      @JsonKey(name: FirestoreFieldName.addressState) this.addressState,
      @JsonKey(name: FirestoreFieldName.zip) this.zip,
      @JsonKey(name: FirestoreFieldName.country) this.country,
      @JsonKey(name: FirestoreFieldName.createDate)
      @DateTimeConverter()
      required this.createDate,
      @JsonKey(name: FirestoreFieldName.lastUpdateDate)
      @DateTimeConverter()
      required this.lastUpdateDate,
      @JsonKey(name: FirestoreFieldName.lastLoginDate)
      @DateTimeConverter()
      required this.lastLoginDate,
      @JsonKey(name: FirestoreFieldName.lastPasswordChangeDate)
      @DateTimeConverter()
      this.lastPasswordChangeDate,
      @JsonKey(name: FirestoreFieldName.isAdmin) this.isAdmin = false,
      @JsonKey(name: FirestoreFieldName.isEmailVerified)
      this.isEmailVerified = false,
      @JsonKey(name: FirestoreFieldName.isApproved) this.isApproved = false,
      @JsonKey(name: FirestoreFieldName.isInfoShared) this.isInfoShared = false,
      @JsonKey(name: FirestoreFieldName.isChatEnabled)
      this.isChatEnabled = false,
      @JsonKey(name: FirestoreFieldName.isPrimaryAccount)
      this.isPrimaryAccount = false,
      @JsonKey(name: FirestoreFieldName.provider)
      this.provider = AppAuthProvider.email,
      @JsonKey(name: FirestoreFieldName.linkedProviders)
      final List<String> linkedProviders = const [],
      @JsonKey(name: FirestoreFieldName.accountStatus)
      this.accountStatus = AccountStatus.active,
      @JsonKey(name: FirestoreFieldName.providerData)
      final List<ProviderData>? providerData,
      @JsonKey(name: FirestoreFieldName.preferences)
      this.preferences = const UserPreferences(),
      @JsonKey(name: FirestoreFieldName.notificationSettings)
      this.notificationSettings = const NotificationSettings(),
      @JsonKey(name: FirestoreFieldName.privacySettings)
      this.privacySettings = const PrivacySettings()})
      : _linkedProviders = linkedProviders,
        _providerData = providerData,
        super._();

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  @JsonKey(name: FirestoreFieldName.id)
  final String id;
  @override
  @JsonKey(name: FirestoreFieldName.email)
  final String email;
  @override
  @JsonKey(name: FirestoreFieldName.displayName)
  final String displayName;
  @override
  @JsonKey(name: FirestoreFieldName.profileImageUrl)
  final String? profileImageURL;
  @override
  @JsonKey(name: FirestoreFieldName.profileBannerImageUrl)
  final String? profileBannerImageURL;
  @override
  @JsonKey(name: FirestoreFieldName.familyId)
  final String? familyId;
  @override
  @JsonKey(name: FirestoreFieldName.primaryAccountEmail)
  final String? primaryAccountEmail;
  @override
  @JsonKey(name: FirestoreFieldName.phoneNumber)
  final String? phoneNumber;
  @override
  @JsonKey(name: FirestoreFieldName.street)
  final String? street;
  @override
  @JsonKey(name: FirestoreFieldName.city)
  final String? city;
  @override
  @JsonKey(name: FirestoreFieldName.addressState)
  final String? addressState;
  @override
  @JsonKey(name: FirestoreFieldName.zip)
  final String? zip;
  @override
  @JsonKey(name: FirestoreFieldName.country)
  final String? country;
  @override
  @JsonKey(name: FirestoreFieldName.createDate)
  @DateTimeConverter()
  final DateTime createDate;
  @override
  @JsonKey(name: FirestoreFieldName.lastUpdateDate)
  @DateTimeConverter()
  final DateTime lastUpdateDate;
  @override
  @JsonKey(name: FirestoreFieldName.lastLoginDate)
  @DateTimeConverter()
  final DateTime lastLoginDate;
  @override
  @JsonKey(name: FirestoreFieldName.lastPasswordChangeDate)
  @DateTimeConverter()
  final DateTime? lastPasswordChangeDate;
  @override
  @JsonKey(name: FirestoreFieldName.isAdmin)
  final bool isAdmin;
  @override
  @JsonKey(name: FirestoreFieldName.isEmailVerified)
  final bool isEmailVerified;
  @override
  @JsonKey(name: FirestoreFieldName.isApproved)
  final bool isApproved;
  @override
  @JsonKey(name: FirestoreFieldName.isInfoShared)
  final bool isInfoShared;
  @override
  @JsonKey(name: FirestoreFieldName.isChatEnabled)
  final bool isChatEnabled;
  @override
  @JsonKey(name: FirestoreFieldName.isPrimaryAccount)
  final bool isPrimaryAccount;
  @override
  @JsonKey(name: FirestoreFieldName.provider)
  final AppAuthProvider provider;
  final List<String> _linkedProviders;
  @override
  @JsonKey(name: FirestoreFieldName.linkedProviders)
  List<String> get linkedProviders {
    if (_linkedProviders is EqualUnmodifiableListView) return _linkedProviders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_linkedProviders);
  }

  @override
  @JsonKey(name: FirestoreFieldName.accountStatus)
  final AccountStatus accountStatus;
  final List<ProviderData>? _providerData;
  @override
  @JsonKey(name: FirestoreFieldName.providerData)
  List<ProviderData>? get providerData {
    final value = _providerData;
    if (value == null) return null;
    if (_providerData is EqualUnmodifiableListView) return _providerData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: FirestoreFieldName.preferences)
  final UserPreferences preferences;
  @override
  @JsonKey(name: FirestoreFieldName.notificationSettings)
  final NotificationSettings notificationSettings;
  @override
  @JsonKey(name: FirestoreFieldName.privacySettings)
  final PrivacySettings privacySettings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppUser(id: $id, email: $email, displayName: $displayName, profileImageURL: $profileImageURL, profileBannerImageURL: $profileBannerImageURL, familyId: $familyId, primaryAccountEmail: $primaryAccountEmail, phoneNumber: $phoneNumber, street: $street, city: $city, addressState: $addressState, zip: $zip, country: $country, createDate: $createDate, lastUpdateDate: $lastUpdateDate, lastLoginDate: $lastLoginDate, lastPasswordChangeDate: $lastPasswordChangeDate, isAdmin: $isAdmin, isEmailVerified: $isEmailVerified, isApproved: $isApproved, isInfoShared: $isInfoShared, isChatEnabled: $isChatEnabled, isPrimaryAccount: $isPrimaryAccount, provider: $provider, linkedProviders: $linkedProviders, accountStatus: $accountStatus, providerData: $providerData, preferences: $preferences, notificationSettings: $notificationSettings, privacySettings: $privacySettings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppUser'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('profileImageURL', profileImageURL))
      ..add(DiagnosticsProperty('profileBannerImageURL', profileBannerImageURL))
      ..add(DiagnosticsProperty('familyId', familyId))
      ..add(DiagnosticsProperty('primaryAccountEmail', primaryAccountEmail))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('street', street))
      ..add(DiagnosticsProperty('city', city))
      ..add(DiagnosticsProperty('addressState', addressState))
      ..add(DiagnosticsProperty('zip', zip))
      ..add(DiagnosticsProperty('country', country))
      ..add(DiagnosticsProperty('createDate', createDate))
      ..add(DiagnosticsProperty('lastUpdateDate', lastUpdateDate))
      ..add(DiagnosticsProperty('lastLoginDate', lastLoginDate))
      ..add(
          DiagnosticsProperty('lastPasswordChangeDate', lastPasswordChangeDate))
      ..add(DiagnosticsProperty('isAdmin', isAdmin))
      ..add(DiagnosticsProperty('isEmailVerified', isEmailVerified))
      ..add(DiagnosticsProperty('isApproved', isApproved))
      ..add(DiagnosticsProperty('isInfoShared', isInfoShared))
      ..add(DiagnosticsProperty('isChatEnabled', isChatEnabled))
      ..add(DiagnosticsProperty('isPrimaryAccount', isPrimaryAccount))
      ..add(DiagnosticsProperty('provider', provider))
      ..add(DiagnosticsProperty('linkedProviders', linkedProviders))
      ..add(DiagnosticsProperty('accountStatus', accountStatus))
      ..add(DiagnosticsProperty('providerData', providerData))
      ..add(DiagnosticsProperty('preferences', preferences))
      ..add(DiagnosticsProperty('notificationSettings', notificationSettings))
      ..add(DiagnosticsProperty('privacySettings', privacySettings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.profileImageURL, profileImageURL) ||
                other.profileImageURL == profileImageURL) &&
            (identical(other.profileBannerImageURL, profileBannerImageURL) ||
                other.profileBannerImageURL == profileBannerImageURL) &&
            (identical(other.familyId, familyId) ||
                other.familyId == familyId) &&
            (identical(other.primaryAccountEmail, primaryAccountEmail) ||
                other.primaryAccountEmail == primaryAccountEmail) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.addressState, addressState) ||
                other.addressState == addressState) &&
            (identical(other.zip, zip) || other.zip == zip) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.lastUpdateDate, lastUpdateDate) ||
                other.lastUpdateDate == lastUpdateDate) &&
            (identical(other.lastLoginDate, lastLoginDate) ||
                other.lastLoginDate == lastLoginDate) &&
            (identical(other.lastPasswordChangeDate, lastPasswordChangeDate) ||
                other.lastPasswordChangeDate == lastPasswordChangeDate) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.isInfoShared, isInfoShared) ||
                other.isInfoShared == isInfoShared) &&
            (identical(other.isChatEnabled, isChatEnabled) ||
                other.isChatEnabled == isChatEnabled) &&
            (identical(other.isPrimaryAccount, isPrimaryAccount) ||
                other.isPrimaryAccount == isPrimaryAccount) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            const DeepCollectionEquality()
                .equals(other._linkedProviders, _linkedProviders) &&
            (identical(other.accountStatus, accountStatus) ||
                other.accountStatus == accountStatus) &&
            const DeepCollectionEquality()
                .equals(other._providerData, _providerData) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.notificationSettings, notificationSettings) ||
                other.notificationSettings == notificationSettings) &&
            (identical(other.privacySettings, privacySettings) ||
                other.privacySettings == privacySettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        email,
        displayName,
        profileImageURL,
        profileBannerImageURL,
        familyId,
        primaryAccountEmail,
        phoneNumber,
        street,
        city,
        addressState,
        zip,
        country,
        createDate,
        lastUpdateDate,
        lastLoginDate,
        lastPasswordChangeDate,
        isAdmin,
        isEmailVerified,
        isApproved,
        isInfoShared,
        isChatEnabled,
        isPrimaryAccount,
        provider,
        const DeepCollectionEquality().hash(_linkedProviders),
        accountStatus,
        const DeepCollectionEquality().hash(_providerData),
        preferences,
        notificationSettings,
        privacySettings
      ]);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(
      this,
    );
  }
}

abstract class _AppUser extends AppUser {
  const factory _AppUser(
      {@JsonKey(name: FirestoreFieldName.id) required final String id,
      @JsonKey(name: FirestoreFieldName.email) required final String email,
      @JsonKey(name: FirestoreFieldName.displayName)
      required final String displayName,
      @JsonKey(name: FirestoreFieldName.profileImageUrl)
      final String? profileImageURL,
      @JsonKey(name: FirestoreFieldName.profileBannerImageUrl)
      final String? profileBannerImageURL,
      @JsonKey(name: FirestoreFieldName.familyId) final String? familyId,
      @JsonKey(name: FirestoreFieldName.primaryAccountEmail)
      final String? primaryAccountEmail,
      @JsonKey(name: FirestoreFieldName.phoneNumber) final String? phoneNumber,
      @JsonKey(name: FirestoreFieldName.street) final String? street,
      @JsonKey(name: FirestoreFieldName.city) final String? city,
      @JsonKey(name: FirestoreFieldName.addressState)
      final String? addressState,
      @JsonKey(name: FirestoreFieldName.zip) final String? zip,
      @JsonKey(name: FirestoreFieldName.country) final String? country,
      @JsonKey(name: FirestoreFieldName.createDate)
      @DateTimeConverter()
      required final DateTime createDate,
      @JsonKey(name: FirestoreFieldName.lastUpdateDate)
      @DateTimeConverter()
      required final DateTime lastUpdateDate,
      @JsonKey(name: FirestoreFieldName.lastLoginDate)
      @DateTimeConverter()
      required final DateTime lastLoginDate,
      @JsonKey(name: FirestoreFieldName.lastPasswordChangeDate)
      @DateTimeConverter()
      final DateTime? lastPasswordChangeDate,
      @JsonKey(name: FirestoreFieldName.isAdmin) final bool isAdmin,
      @JsonKey(name: FirestoreFieldName.isEmailVerified)
      final bool isEmailVerified,
      @JsonKey(name: FirestoreFieldName.isApproved) final bool isApproved,
      @JsonKey(name: FirestoreFieldName.isInfoShared) final bool isInfoShared,
      @JsonKey(name: FirestoreFieldName.isChatEnabled) final bool isChatEnabled,
      @JsonKey(name: FirestoreFieldName.isPrimaryAccount)
      final bool isPrimaryAccount,
      @JsonKey(name: FirestoreFieldName.provider)
      final AppAuthProvider provider,
      @JsonKey(name: FirestoreFieldName.linkedProviders)
      final List<String> linkedProviders,
      @JsonKey(name: FirestoreFieldName.accountStatus)
      final AccountStatus accountStatus,
      @JsonKey(name: FirestoreFieldName.providerData)
      final List<ProviderData>? providerData,
      @JsonKey(name: FirestoreFieldName.preferences)
      final UserPreferences preferences,
      @JsonKey(name: FirestoreFieldName.notificationSettings)
      final NotificationSettings notificationSettings,
      @JsonKey(name: FirestoreFieldName.privacySettings)
      final PrivacySettings privacySettings}) = _$AppUserImpl;
  const _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  @JsonKey(name: FirestoreFieldName.id)
  String get id;
  @override
  @JsonKey(name: FirestoreFieldName.email)
  String get email;
  @override
  @JsonKey(name: FirestoreFieldName.displayName)
  String get displayName;
  @override
  @JsonKey(name: FirestoreFieldName.profileImageUrl)
  String? get profileImageURL;
  @override
  @JsonKey(name: FirestoreFieldName.profileBannerImageUrl)
  String? get profileBannerImageURL;
  @override
  @JsonKey(name: FirestoreFieldName.familyId)
  String? get familyId;
  @override
  @JsonKey(name: FirestoreFieldName.primaryAccountEmail)
  String? get primaryAccountEmail;
  @override
  @JsonKey(name: FirestoreFieldName.phoneNumber)
  String? get phoneNumber;
  @override
  @JsonKey(name: FirestoreFieldName.street)
  String? get street;
  @override
  @JsonKey(name: FirestoreFieldName.city)
  String? get city;
  @override
  @JsonKey(name: FirestoreFieldName.addressState)
  String? get addressState;
  @override
  @JsonKey(name: FirestoreFieldName.zip)
  String? get zip;
  @override
  @JsonKey(name: FirestoreFieldName.country)
  String? get country;
  @override
  @JsonKey(name: FirestoreFieldName.createDate)
  @DateTimeConverter()
  DateTime get createDate;
  @override
  @JsonKey(name: FirestoreFieldName.lastUpdateDate)
  @DateTimeConverter()
  DateTime get lastUpdateDate;
  @override
  @JsonKey(name: FirestoreFieldName.lastLoginDate)
  @DateTimeConverter()
  DateTime get lastLoginDate;
  @override
  @JsonKey(name: FirestoreFieldName.lastPasswordChangeDate)
  @DateTimeConverter()
  DateTime? get lastPasswordChangeDate;
  @override
  @JsonKey(name: FirestoreFieldName.isAdmin)
  bool get isAdmin;
  @override
  @JsonKey(name: FirestoreFieldName.isEmailVerified)
  bool get isEmailVerified;
  @override
  @JsonKey(name: FirestoreFieldName.isApproved)
  bool get isApproved;
  @override
  @JsonKey(name: FirestoreFieldName.isInfoShared)
  bool get isInfoShared;
  @override
  @JsonKey(name: FirestoreFieldName.isChatEnabled)
  bool get isChatEnabled;
  @override
  @JsonKey(name: FirestoreFieldName.isPrimaryAccount)
  bool get isPrimaryAccount;
  @override
  @JsonKey(name: FirestoreFieldName.provider)
  AppAuthProvider get provider;
  @override
  @JsonKey(name: FirestoreFieldName.linkedProviders)
  List<String> get linkedProviders;
  @override
  @JsonKey(name: FirestoreFieldName.accountStatus)
  AccountStatus get accountStatus;
  @override
  @JsonKey(name: FirestoreFieldName.providerData)
  List<ProviderData>? get providerData;
  @override
  @JsonKey(name: FirestoreFieldName.preferences)
  UserPreferences get preferences;
  @override
  @JsonKey(name: FirestoreFieldName.notificationSettings)
  NotificationSettings get notificationSettings;
  @override
  @JsonKey(name: FirestoreFieldName.privacySettings)
  PrivacySettings get privacySettings;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
