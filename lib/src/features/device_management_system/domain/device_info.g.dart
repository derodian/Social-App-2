// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceInfoImpl _$$DeviceInfoImplFromJson(Map<String, dynamic> json) =>
    _$DeviceInfoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      platform: json['platform'] as String,
      model: json['model'] as String,
      osVersion: json['osVersion'] as String,
      appVersion: json['appVersion'] as String,
      lastLoginAt: DateTime.parse(json['lastLoginAt'] as String),
      isCurrentDevice: json['isCurrentDevice'] as bool,
      lastSeenAt: json['lastSeenAt'] == null
          ? null
          : DateTime.parse(json['lastSeenAt'] as String),
      fcmToken: json['fcmToken'] as String?,
      apnsToken: json['apnsToken'] as String?,
      ipAddress: json['ipAddress'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$DeviceInfoImplToJson(_$DeviceInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'platform': instance.platform,
      'model': instance.model,
      'osVersion': instance.osVersion,
      'appVersion': instance.appVersion,
      'lastLoginAt': instance.lastLoginAt.toIso8601String(),
      'isCurrentDevice': instance.isCurrentDevice,
      'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
      'fcmToken': instance.fcmToken,
      'apnsToken': instance.apnsToken,
      'ipAddress': instance.ipAddress,
      'metadata': instance.metadata,
    };
