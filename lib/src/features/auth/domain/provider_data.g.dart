// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProviderDataImpl _$$ProviderDataImplFromJson(Map<String, dynamic> json) =>
    _$ProviderDataImpl(
      providerId: json['providerId'] as String,
      uid: json['uid'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$$ProviderDataImplToJson(_$ProviderDataImpl instance) =>
    <String, dynamic>{
      'providerId': instance.providerId,
      'uid': instance.uid,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
