import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/custom_primary_button.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/email_verification_controller.dart';
import 'package:social_app_2/src/features/components/animations/email_verification_animation_view.dart';
import 'package:social_app_2/src/routing/app_router.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  bool _canResendEmail = true;
  bool _isLoading = false;
  Timer? _resendTimer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    // // Delay initial check to avoid build-time conflicts
    // Future(() => ref
    //     .read(emailVerificationControllerProvider.notifier)
    //     .startVerificationCheck());
    // Start verification check after initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(emailVerificationControllerProvider.notifier)
          .startVerificationCheck();
    });
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    // ref
    //     .read(emailVerificationControllerProvider.notifier)
    //     .stopVerificationCheck();
    super.dispose();
  }

  void _startResendTimer() {
    _remainingSeconds = 30;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        if (mounted) setState(() => _canResendEmail = true);
      }
    });
  }

  String _getTimeRemaining() => _remainingSeconds.toString();

  Future<void> _sendVerificationEmail() async {
    if (!_canResendEmail || _isLoading || !mounted) return;

    setState(() {
      _isLoading = true;
      _canResendEmail = false;
    });

    try {
      await ref.read(authControllerProvider.notifier).sendEmailVerification();

      if (mounted) {
        _showMessage('Verification email sent!', isError: false);
        _startResendTimer();
      }
    } catch (e) {
      if (mounted) {
        _showMessage(e.toString(), isError: true);
        setState(() => _canResendEmail = true);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await ref.read(authControllerProvider.notifier).signOut();
      if (mounted) {
        ref.read(routerControllerProvider.notifier).goToAuth();
      }
    } catch (e) {
      _showMessage('Failed to sign out: $e', isError: true);
    }
  }

  // Move timer management to this method for cleanup
  void _cleanupTimers() {
    _resendTimer?.cancel();
    _resendTimer = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Handle any dependency changes that might affect timers
    if (!mounted) {
      _cleanupTimers();
    }
  }

  @override
  void deactivate() {
    _cleanupTimers();
    super.deactivate();
  }

  // Update the build method to check mounted state for any async operations
  Future<void> _handleVerificationCheck() async {
    if (!mounted) return;

    try {
      await ref
          .read(emailVerificationControllerProvider.notifier)
          .checkVerification(showError: true);
    } catch (e) {
      if (mounted) {
        _showMessage(e.toString(), isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    // ref.listen<AsyncValue<AuthResult?>>(
    //   authControllerProvider,
    //   (_, next) {
    //     next.whenData((result) {
    //       if (result case AuthUser(:final user)) {
    //         if (user.isAdmin) {
    //           ref.read(routerControllerProvider.notifier).goToHome();
    //         } else if (!user.isEmailVerified) {
    //           ref
    //               .read(routerControllerProvider.notifier)
    //               .goToEmailVerification();
    //         } else if (!user.isApproved) {
    //           ref.read(routerControllerProvider.notifier).goToWaitingApproval();
    //         }
    //       }
    //     });
    //   },
    // );

    // return Scaffold(
    //   body: authState.when(
    //     data: (_) => Stack(
    //       children: [
    //         _buildContent(),
    //         Positioned(
    //           top: 16 + MediaQuery.of(context).padding.top,
    //           right: 16,
    //           child: IconButton.filled(
    //             onPressed: _signOut,
    //             icon: const Icon(Icons.logout),
    //             tooltip: 'Sign out',
    //           ),
    //         ),
    //       ],
    //     ),
    //     error: (error, _) => _buildErrorState(error),
    //     loading: () => const Center(child: CircularProgressIndicator()),
    //   ),
    // );
    return Scaffold(
      body: Stack(
        children: [
          _buildContent(),
          Positioned(
            top: 16 + MediaQuery.of(context).padding.top,
            right: 16,
            child: IconButton.filled(
              onPressed: _signOut,
              icon: const Icon(Icons.logout),
              tooltip: 'Sign out',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: RefreshIndicator(
          onRefresh: () => ref
              .read(emailVerificationControllerProvider.notifier)
              .checkVerification(showError: true),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mark_email_unread_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              EmailVerificationAnimationView(),
              const SizedBox(height: 32),
              Text(
                'Verify Your Email',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'We\'ve sent you an email verification link. Please check your email and click the link to verify your account.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomPrimaryButton(
                onPressed: (_canResendEmail && !_isLoading)
                    ? _sendVerificationEmail
                    : null,
                leadingIcon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Icon(Icons.send),
                text: _canResendEmail
                    ? 'Resend Verification Email'
                    : 'Wait ${_getTimeRemaining()} seconds...',
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => _handleVerificationCheck(),
                icon: const Icon(Icons.refresh),
                label: const Text('I\'ve verified my email'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => ref
                  .read(emailVerificationControllerProvider.notifier)
                  .checkVerification(showError: true),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
