// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthEvent _$AuthEventFromJson(Map<String, dynamic> json) {
  return _AuthEvent.fromJson(json);
}

/// @nodoc
mixin _$AuthEvent {
  String get id => throw _privateConstructorUsedError;
  AuthEventType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  String? get ipAddress => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this AuthEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthEventCopyWith<AuthEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
  @useResult
  $Res call(
      {String id,
      AuthEventType type,
      DateTime timestamp,
      String userId,
      String? deviceId,
      String? ipAddress,
      String? location,
      String? provider,
      Map<String, dynamic>? metadata,
      String? error});
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? timestamp = null,
    Object? userId = null,
    Object? deviceId = freezed,
    Object? ipAddress = freezed,
    Object? location = freezed,
    Object? provider = freezed,
    Object? metadata = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AuthEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthEventImplCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$$AuthEventImplCopyWith(
          _$AuthEventImpl value, $Res Function(_$AuthEventImpl) then) =
      __$$AuthEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      AuthEventType type,
      DateTime timestamp,
      String userId,
      String? deviceId,
      String? ipAddress,
      String? location,
      String? provider,
      Map<String, dynamic>? metadata,
      String? error});
}

/// @nodoc
class __$$AuthEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthEventImpl>
    implements _$$AuthEventImplCopyWith<$Res> {
  __$$AuthEventImplCopyWithImpl(
      _$AuthEventImpl _value, $Res Function(_$AuthEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? timestamp = null,
    Object? userId = null,
    Object? deviceId = freezed,
    Object? ipAddress = freezed,
    Object? location = freezed,
    Object? provider = freezed,
    Object? metadata = freezed,
    Object? error = freezed,
  }) {
    return _then(_$AuthEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AuthEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthEventImpl implements _AuthEvent {
  const _$AuthEventImpl(
      {required this.id,
      required this.type,
      required this.timestamp,
      required this.userId,
      this.deviceId,
      this.ipAddress,
      this.location,
      this.provider,
      final Map<String, dynamic>? metadata,
      this.error})
      : _metadata = metadata;

  factory _$AuthEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthEventImplFromJson(json);

  @override
  final String id;
  @override
  final AuthEventType type;
  @override
  final DateTime timestamp;
  @override
  final String userId;
  @override
  final String? deviceId;
  @override
  final String? ipAddress;
  @override
  final String? location;
  @override
  final String? provider;
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
  final String? error;

  @override
  String toString() {
    return 'AuthEvent(id: $id, type: $type, timestamp: $timestamp, userId: $userId, deviceId: $deviceId, ipAddress: $ipAddress, location: $location, provider: $provider, metadata: $metadata, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      timestamp,
      userId,
      deviceId,
      ipAddress,
      location,
      provider,
      const DeepCollectionEquality().hash(_metadata),
      error);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthEventImplCopyWith<_$AuthEventImpl> get copyWith =>
      __$$AuthEventImplCopyWithImpl<_$AuthEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthEventImplToJson(
      this,
    );
  }
}

abstract class _AuthEvent implements AuthEvent {
  const factory _AuthEvent(
      {required final String id,
      required final AuthEventType type,
      required final DateTime timestamp,
      required final String userId,
      final String? deviceId,
      final String? ipAddress,
      final String? location,
      final String? provider,
      final Map<String, dynamic>? metadata,
      final String? error}) = _$AuthEventImpl;

  factory _AuthEvent.fromJson(Map<String, dynamic> json) =
      _$AuthEventImpl.fromJson;

  @override
  String get id;
  @override
  AuthEventType get type;
  @override
  DateTime get timestamp;
  @override
  String get userId;
  @override
  String? get deviceId;
  @override
  String? get ipAddress;
  @override
  String? get location;
  @override
  String? get provider;
  @override
  Map<String, dynamic>? get metadata;
  @override
  String? get error;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthEventImplCopyWith<_$AuthEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
