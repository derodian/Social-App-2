import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/routing/app_router.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        await ref.read(authControllerProvider.notifier).signOut();
        if (context.mounted) {
          ref.read(routerControllerProvider.notifier).goToAuth();
        }
      },
      icon: const Icon(Icons.logout),
    );
  }
}
