import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/auth/presentation/account/app_user_controller.dart';

class AdminOnlyWidget extends ConsumerWidget {
  final Widget child;
  final Widget? fallback;

  const AdminOnlyWidget({
    required this.child,
    this.fallback,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isUserAdminProvider);

    if (!isAdmin) {
      return fallback ?? const SizedBox.shrink();
    }

    return child;
  }
}
