import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/data/firebase_auth_service.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/routing/app_router.dart';

part 'email_verification_controller.g.dart';

@riverpod
class EmailVerificationController extends _$EmailVerificationController {
  Timer? _timer;
  StreamSubscription<bool>? _verificationSubscription;

  @override
  bool build() {
    ref.onDispose(() {
      _verificationSubscription?.cancel();
      debugPrint('EmailVerificationController disposed');
    });

    // Start listening to verification status
    _listenToVerificationStatus();

    // Return current verification status
    return ref.read(authControllerProvider).value?.isEmailVerified ?? false;
  }

  void _listenToVerificationStatus() {
    _verificationSubscription?.cancel();
    final authService = ref.read(authServiceProvider);

    _verificationSubscription =
        authService.isEmailVerified.distinct().listen((isVerified) {
      debugPrint('Email verification status changed: $isVerified');

      if (isVerified && !state) {
        // Update controller state
        state = true;

        // Navigate after a brief delay to allow UI to update
        Future.delayed(const Duration(milliseconds: 500), () {
          ref.read(routerControllerProvider.notifier).goToWaitingApproval();
        });
      }
    });
  }

  Future<void> startVerificationCheck() async {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => checkVerification(showError: false),
    );
  }

  Future<void> checkVerification({bool showError = false}) async {
    try {
      debugPrint('Checking email verification');

      // Force fresh Firestore read
      await ref.read(authControllerProvider.notifier).reload();

      final user = ref.read(authControllerProvider).value;
      if (user == null) return;

      if (user.isEmailVerified) {
        state = true;
        _timer?.cancel();
        await Future.delayed(
            const Duration(milliseconds: 500)); // Allow UI update
        ref.read(routerControllerProvider.notifier).goToWaitingApproval();
      }
    } catch (e) {
      if (showError) {
        rethrow;
      }
    }
  }

  Future<void> sendVerificationEmail() async {
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
