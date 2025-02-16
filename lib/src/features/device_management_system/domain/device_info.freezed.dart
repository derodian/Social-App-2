// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return _DeviceInfo.fromJson(json);
}

/// @nodoc
mixin _$DeviceInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  String get osVersion => throw _privateConstructorUsedError;
  String get appVersion => throw _privateConstructorUsedError;
  DateTime get lastLoginAt => throw _privateConstructorUsedError;
  bool get isCurrentDevice => throw _privateConstructorUsedError;
  DateTime? get lastSeenAt => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;
  String? get apnsToken => throw _privateConstructorUsedError;
  String? get ipAddress => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this DeviceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceInfoCopyWith<DeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoCopyWith<$Res> {
  factory $DeviceInfoCopyWith(
          DeviceInfo value, $Res Function(DeviceInfo) then) =
      _$DeviceInfoCopyWithImpl<$Res, DeviceInfo>;
  @useResult
  $Res call(
      {String id,
      String name,
      String platform,
      String model,
      String osVersion,
      String appVersion,
      DateTime lastLoginAt,
      bool isCurrentDevice,
      DateTime? lastSeenAt,
      String? fcmToken,
      String? apnsToken,
      String? ipAddress,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res, $Val extends DeviceInfo>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? platform = null,
    Object? model = null,
    Object? osVersion = null,
    Object? appVersion = null,
    Object? lastLoginAt = null,
    Object? isCurrentDevice = null,
    Object? lastSeenAt = freezed,
    Object? fcmToken = freezed,
    Object? apnsToken = freezed,
    Object? ipAddress = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: null == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      lastLoginAt: null == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCurrentDevice: null == isCurrentDevice
          ? _value.isCurrentDevice
          : isCurrentDevice // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeenAt: freezed == lastSeenAt
          ? _value.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      apnsToken: freezed == apnsToken
          ? _value.apnsToken
          : apnsToken // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceInfoImplCopyWith<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  factory _$$DeviceInfoImplCopyWith(
          _$DeviceInfoImpl value, $Res Function(_$DeviceInfoImpl) then) =
      __$$DeviceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String platform,
      String model,
      String osVersion,
      String appVersion,
      DateTime lastLoginAt,
      bool isCurrentDevice,
      DateTime? lastSeenAt,
      String? fcmToken,
      String? apnsToken,
      String? ipAddress,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$DeviceInfoImplCopyWithImpl<$Res>
    extends _$DeviceInfoCopyWithImpl<$Res, _$DeviceInfoImpl>
    implements _$$DeviceInfoImplCopyWith<$Res> {
  __$$DeviceInfoImplCopyWithImpl(
      _$DeviceInfoImpl _value, $Res Function(_$DeviceInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? platform = null,
    Object? model = null,
    Object? osVersion = null,
    Object? appVersion = null,
    Object? lastLoginAt = null,
    Object? isCurrentDevice = null,
    Object? lastSeenAt = freezed,
    Object? fcmToken = freezed,
    Object? apnsToken = freezed,
    Object? ipAddress = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$DeviceInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: null == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      lastLoginAt: null == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCurrentDevice: null == isCurrentDevice
          ? _value.isCurrentDevice
          : isCurrentDevice // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeenAt: freezed == lastSeenAt
          ? _value.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      apnsToken: freezed == apnsToken
          ? _value.apnsToken
          : apnsToken // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceInfoImpl implements _DeviceInfo {
  const _$DeviceInfoImpl(
      {required this.id,
      required this.name,
      required this.platform,
      required this.model,
      required this.osVersion,
      required this.appVersion,
      required this.lastLoginAt,
      required this.isCurrentDevice,
      this.lastSeenAt,
      this.fcmToken,
      this.apnsToken,
      this.ipAddress,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$DeviceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String platform;
  @override
  final String model;
  @override
  final String osVersion;
  @override
  final String appVersion;
  @override
  final DateTime lastLoginAt;
  @override
  final bool isCurrentDevice;
  @override
  final DateTime? lastSeenAt;
  @override
  final String? fcmToken;
  @override
  final String? apnsToken;
  @override
  final String? ipAddress;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'DeviceInfo(id: $id, name: $name, platform: $platform, model: $model, osVersion: $osVersion, appVersion: $appVersion, lastLoginAt: $lastLoginAt, isCurrentDevice: $isCurrentDevice, lastSeenAt: $lastSeenAt, fcmToken: $fcmToken, apnsToken: $apnsToken, ipAddress: $ipAddress, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.osVersion, osVersion) ||
                other.osVersion == osVersion) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.isCurrentDevice, isCurrentDevice) ||
                other.isCurrentDevice == isCurrentDevice) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.apnsToken, apnsToken) ||
                other.apnsToken == apnsToken) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      platform,
      model,
      osVersion,
      appVersion,
      lastLoginAt,
      isCurrentDevice,
      lastSeenAt,
      fcmToken,
      apnsToken,
      ipAddress,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      __$$DeviceInfoImplCopyWithImpl<_$DeviceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceInfoImplToJson(
      this,
    );
  }
}

abstract class _DeviceInfo implements DeviceInfo {
  const factory _DeviceInfo(
      {required final String id,
      required final String name,
      required final String platform,
      required final String model,
      required final String osVersion,
      required final String appVersion,
      required final DateTime lastLoginAt,
      required final bool isCurrentDevice,
      final DateTime? lastSeenAt,
      final String? fcmToken,
      final String? apnsToken,
      final String? ipAddress,
      final Map<String, dynamic>? metadata}) = _$DeviceInfoImpl;

  factory _DeviceInfo.fromJson(Map<String, dynamic> json) =
      _$DeviceInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get platform;
  @override
  String get model;
  @override
  String get osVersion;
  @override
  String get appVersion;
  @override
  DateTime get lastLoginAt;
  @override
  bool get isCurrentDevice;
  @override
  DateTime? get lastSeenAt;
  @override
  String? get fcmToken;
  @override
  String? get apnsToken;
  @override
  String? get ipAddress;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
