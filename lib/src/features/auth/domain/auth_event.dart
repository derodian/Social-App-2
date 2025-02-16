// auth_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';
part 'auth_event.g.dart';

enum AuthEventType {
  signIn,
  signOut,
  signUp,
  passwordReset,
  emailVerification,
  providerLinked,
  providerUnlinked,
  deviceRegistered,
  deviceRevoked,
  accountDeleted,
  adminApproval,
  adminRejection,
  adminRoleGranted,
  adminRoleRevoked,
  accountLocked,
  accountUnlocked,
  passwordChanged,
  emailChanged,
  profileUpdated,
  mfaEnabled,
  mfaDisabled,
  sessionTimeout,
  loginAttemptFailed,
}

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent({
    required String id,
    required AuthEventType type,
    required DateTime timestamp,
    required String userId,
    String? deviceId,
    String? ipAddress,
    String? location,
    String? provider,
    Map<String, dynamic>? metadata,
    String? error,
  }) = _AuthEvent;

  factory AuthEvent.fromJson(Map<String, dynamic> json) =>
      _$AuthEventFromJson(json);
}
