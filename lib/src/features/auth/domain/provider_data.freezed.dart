// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProviderData _$ProviderDataFromJson(Map<String, dynamic> json) {
  return _ProviderData.fromJson(json);
}

/// @nodoc
mixin _$ProviderData {
  String get providerId => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// Serializes this ProviderData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProviderData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProviderDataCopyWith<ProviderData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderDataCopyWith<$Res> {
  factory $ProviderDataCopyWith(
          ProviderData value, $Res Function(ProviderData) then) =
      _$ProviderDataCopyWithImpl<$Res, ProviderData>;
  @useResult
  $Res call(
      {String providerId,
      String uid,
      String? displayName,
      String? photoURL,
      String? email,
      String? phoneNumber});
}

/// @nodoc
class _$ProviderDataCopyWithImpl<$Res, $Val extends ProviderData>
    implements $ProviderDataCopyWith<$Res> {
  _$ProviderDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProviderData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? uid = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_value.copyWith(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProviderDataImplCopyWith<$Res>
    implements $ProviderDataCopyWith<$Res> {
  factory _$$ProviderDataImplCopyWith(
          _$ProviderDataImpl value, $Res Function(_$ProviderDataImpl) then) =
      __$$ProviderDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String providerId,
      String uid,
      String? displayName,
      String? photoURL,
      String? email,
      String? phoneNumber});
}

/// @nodoc
class __$$ProviderDataImplCopyWithImpl<$Res>
    extends _$ProviderDataCopyWithImpl<$Res, _$ProviderDataImpl>
    implements _$$ProviderDataImplCopyWith<$Res> {
  __$$ProviderDataImplCopyWithImpl(
      _$ProviderDataImpl _value, $Res Function(_$ProviderDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProviderData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? uid = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_$ProviderDataImpl(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProviderDataImpl implements _ProviderData {
  const _$ProviderDataImpl(
      {required this.providerId,
      required this.uid,
      this.displayName,
      this.photoURL,
      this.email,
      this.phoneNumber});

  factory _$ProviderDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProviderDataImplFromJson(json);

  @override
  final String providerId;
  @override
  final String uid;
  @override
  final String? displayName;
  @override
  final String? photoURL;
  @override
  final String? email;
  @override
  final String? phoneNumber;

  @override
  String toString() {
    return 'ProviderData(providerId: $providerId, uid: $uid, displayName: $displayName, photoURL: $photoURL, email: $email, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProviderDataImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, providerId, uid, displayName, photoURL, email, phoneNumber);

  /// Create a copy of ProviderData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProviderDataImplCopyWith<_$ProviderDataImpl> get copyWith =>
      __$$ProviderDataImplCopyWithImpl<_$ProviderDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProviderDataImplToJson(
      this,
    );
  }
}

abstract class _ProviderData implements ProviderData {
  const factory _ProviderData(
      {required final String providerId,
      required final String uid,
      final String? displayName,
      final String? photoURL,
      final String? email,
      final String? phoneNumber}) = _$ProviderDataImpl;

  factory _ProviderData.fromJson(Map<String, dynamic> json) =
      _$ProviderDataImpl.fromJson;

  @override
  String get providerId;
  @override
  String get uid;
  @override
  String? get displayName;
  @override
  String? get photoURL;
  @override
  String? get email;
  @override
  String? get phoneNumber;

  /// Create a copy of ProviderData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProviderDataImplCopyWith<_$ProviderDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
