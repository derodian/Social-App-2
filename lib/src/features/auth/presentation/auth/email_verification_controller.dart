import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/routing/app_router.dart';

part 'email_verification_controller.g.dart';

@riverpod
class EmailVerificationController extends _$EmailVerificationController {
  Timer? _timer;
  bool _disposed = false;
  StreamSubscription<bool>? _verificationSubscription;

  // Cancel Timer
  void _cleanupTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  bool build() {
    // Setup cleanup
    ref.onDispose(() {
      _cleanupTimer();
      _disposed = true;
      _verificationSubscription?.cancel();
      debugPrint('EmailVerificationController disposed');
    });

    // Start listening to verification status
    _listenToVerificationStatus();

    // Return current verification status
    final authController = ref.read(authControllerProvider.notifier);
    return authController.currentUser?.isEmailVerified ?? false;
  }

  // Listen to verification changes
  void _listenToVerificationStatus() {
    // Listen to auth state changes
    ref.listen<AsyncValue<AuthResult?>>(authControllerProvider,
        (previous, next) {
      if (_disposed) return;

      next.whenData((result) {
        if (result case AuthUser(:final user)) {
          if (user.isEmailVerified && !state) {
            state = true;
            _timer?.cancel();

            // Navigate after brief delay
            Future.delayed(const Duration(milliseconds: 500), () {
              ref.read(routerControllerProvider.notifier).goToWaitingApproval();
            });
          }
        }
      });
    });
  }

  Future<void> startVerificationCheck() async {
    _cleanupTimer();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => checkVerification(showError: false),
    );
  }

  Future<void> checkVerification({bool showError = false}) async {
    if (_disposed) return;

    try {
      debugPrint('Checking email verification');

      // Force fresh Firestore read
      await ref.read(authControllerProvider.notifier).reload();
    } catch (e) {
      if (showError) {
        rethrow;
      }
    }
  }

  Future<void> sendVerificationEmail() async {
    if (_disposed) return;

    try {
      await ref.read(authControllerProvider.notifier).sendEmailVerification();
      startVerificationCheck(); // Start checking for verification
    } catch (e) {
      debugPrint('Error sending verification email: $e');
      rethrow;
    }
  }

  void stopVerificationCheck() {
    _timer?.cancel();
  }
}
