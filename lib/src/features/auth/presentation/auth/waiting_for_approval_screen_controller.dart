import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/routing/app_router.dart';

part 'waiting_for_approval_screen_controller.g.dart';

@riverpod
class WaitingApprovalScreenController
    extends _$WaitingApprovalScreenController {
  Timer? _refreshTimer;
  static const adminEmail = 'admin@yourapp.com';
  static const supportPhone = '+12345678900';

  @override
  bool build() {
    ref.onDispose(() {
      _refreshTimer?.cancel();
    });
    return false; // not checking initially
  }

  Future<void> startPeriodicRefresh() async {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => checkApprovalStatus(),
    );
  }

  Future<void> checkApprovalStatus() async {
    if (state) return; // Already checking

    state = true; // Start checking
    try {
      await ref.read(authControllerProvider.notifier).reload();
    } finally {
      state = false; // Done checking
    }
  }

  String getEmailBody() {
    final user = ref.read(authControllerProvider).value;
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
    await ref.read(authControllerProvider.notifier).signOut();
    ref.read(routerControllerProvider.notifier).goToAuth();
  }

  String getAdminEmail() => adminEmail;
  String getSupportPhone() => supportPhone;
}
