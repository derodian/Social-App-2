import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';

part 'waiting_for_approval_screen_controller.g.dart';

@riverpod
class WaitingApprovalScreenController
    extends _$WaitingApprovalScreenController {
  Timer? _refreshTimer;
  bool _disposed = false;

  static const adminEmail = 'admin@yourapp.com';
  static const supportPhone = '+12345678900';

  @override
  bool build() {
    ref.onDispose(() {
      _cleanupTimer();
      _refreshTimer?.cancel();
    });
    return false; // not checking initially
  }

  void _cleanupTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  Future<void> startPeriodicRefresh() async {
    if (_disposed) return;

    _cleanupTimer();
    _refreshTimer = Timer.periodic(
      const Duration(milliseconds: 500),
      (_) => checkApprovalStatus(),
    );
  }

  Future<void> checkApprovalStatus() async {
    if (_disposed || state) return; // Already checking

    state = true; // Start checking
    try {
      await ref.read(authControllerProvider.notifier).reload();
    } finally {
      if (!_disposed) {
        state = false; // Done checking
      }
    }
  }

  String getEmailBody() {
    final controller = ref.read(authControllerProvider.notifier);
    final user = controller.currentUser;
    if (user == null) return '';

    return '''
Account Approval Request

User Details:
Name: ${user.displayName}
Email: ${user.email}
ID: ${user.id}

I recently signed up for the app and am awaiting approval. Please review my account.

Thank you.''';
  }

  Future<void> signOut() async {
    // await ref.read(authControllerProvider.notifier).signOut();
    // ref.read(routerControllerProvider.notifier).goToAuth();
    if (_disposed) return;

    try {
      await ref.read(authControllerProvider.notifier).signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
      rethrow;
    }
  }

  String getAdminEmail() => adminEmail;
  String getSupportPhone() => supportPhone;
}
