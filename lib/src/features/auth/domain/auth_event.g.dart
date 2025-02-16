// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthEventImpl _$$AuthEventImplFromJson(Map<String, dynamic> json) =>
    _$AuthEventImpl(
      id: json['id'] as String,
      type: $enumDecode(_$AuthEventTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String,
      deviceId: json['deviceId'] as String?,
      ipAddress: json['ipAddress'] as String?,
      location: json['location'] as String?,
      provider: json['provider'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$AuthEventImplToJson(_$AuthEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$AuthEventTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'userId': instance.userId,
      'deviceId': instance.deviceId,
      'ipAddress': instance.ipAddress,
      'location': instance.location,
      'provider': instance.provider,
      'metadata': instance.metadata,
      'error': instance.error,
    };

const _$AuthEventTypeEnumMap = {
  AuthEventType.signIn: 'signIn',
  AuthEventType.signOut: 'signOut',
  AuthEventType.signUp: 'signUp',
  AuthEventType.passwordReset: 'passwordReset',
  AuthEventType.emailVerification: 'emailVerification',
  AuthEventType.providerLinked: 'providerLinked',
  AuthEventType.providerUnlinked: 'providerUnlinked',
  AuthEventType.deviceRegistered: 'deviceRegistered',
  AuthEventType.deviceRevoked: 'deviceRevoked',
  AuthEventType.accountDeleted: 'accountDeleted',
  AuthEventType.adminApproval: 'adminApproval',
  AuthEventType.adminRejection: 'adminRejection',
  AuthEventType.adminRoleGranted: 'adminRoleGranted',
  AuthEventType.adminRoleRevoked: 'adminRoleRevoked',
  AuthEventType.accountLocked: 'accountLocked',
  AuthEventType.accountUnlocked: 'accountUnlocked',
  AuthEventType.passwordChanged: 'passwordChanged',
  AuthEventType.emailChanged: 'emailChanged',
  AuthEventType.profileUpdated: 'profileUpdated',
  AuthEventType.mfaEnabled: 'mfaEnabled',
  AuthEventType.mfaDisabled: 'mfaDisabled',
  AuthEventType.sessionTimeout: 'sessionTimeout',
  AuthEventType.loginAttemptFailed: 'loginAttemptFailed',
};
