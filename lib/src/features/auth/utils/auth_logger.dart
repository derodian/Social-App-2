// auth_logger.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app_2/src/features/auth/domain/auth_event.dart';
import 'package:social_app_2/src/features/device_management_system/data/device_manager.dart';
import 'package:uuid/uuid.dart';

part 'auth_logger.g.dart';

@Riverpod(keepAlive: true)
class AuthLogger extends _$AuthLogger {
  static const String _collection = 'auth_logs';

  @override
  void build() {
    // Initialize any required resources
  }

  Future<void> logEvent(
    AuthEventType type, {
    required String userId,
    String? deviceId,
    String? provider,
    Map<String, dynamic>? metadata,
    String? error,
  }) async {
    final deviceManager = ref.read(deviceManagerProvider);
    final currentDevice = switch (deviceManager) {
      AsyncData(:final value) => value,
      _ => null,
    };

    final event = AuthEvent(
      id: const Uuid().v4(),
      type: type,
      timestamp: DateTime.now(),
      userId: userId,
      deviceId: deviceId ?? currentDevice?.id,
      provider: provider,
      metadata: {
        ...?metadata,
        if (currentDevice != null) 'device': currentDevice.toJson(),
      },
      error: error,
    );

    await _saveEvent(event);
    _notifyAdminIfNeeded(event);
  }

  Future<void> _saveEvent(AuthEvent event) async {
    final firestore = FirebaseFirestore.instance;

    // Save to main logs collection
    await firestore.collection(_collection).doc(event.id).set(event.toJson());

    // Save to user-specific logs subcollection
    await firestore
        .collection('users')
        .doc(event.userId)
        .collection('auth_logs')
        .doc(event.id)
        .set(event.toJson());
  }

  void _notifyAdminIfNeeded(AuthEvent event) {
    final criticalEvents = {
      AuthEventType.loginAttemptFailed,
      AuthEventType.accountLocked,
      AuthEventType.adminRoleGranted,
      AuthEventType.adminRoleRevoked,
      AuthEventType.accountDeleted,
    };

    if (criticalEvents.contains(event.type)) {
      // Implement admin notification (e.g., via Cloud Functions)
    }
  }

  Future<List<AuthEvent>> getUserEvents(
    String userId, {
    int limit = 50,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    var query = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('auth_logs')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (startTime != null) {
      query = query.where('timestamp', isGreaterThanOrEqualTo: startTime);
    }
    if (endTime != null) {
      query = query.where('timestamp', isLessThanOrEqualTo: endTime);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => AuthEvent.fromJson(doc.data())).toList();
  }

  Future<List<AuthEvent>> getDeviceEvents(
    String deviceId, {
    int limit = 50,
  }) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(_collection)
        .where('deviceId', isEqualTo: deviceId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) => AuthEvent.fromJson(doc.data())).toList();
  }

  Stream<List<AuthEvent>> watchUserEvents(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('auth_logs')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AuthEvent.fromJson(doc.data()))
            .toList());
  }
}
