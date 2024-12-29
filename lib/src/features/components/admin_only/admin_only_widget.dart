import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';

class AdminOnlyWidget extends ConsumerWidget {
  const AdminOnlyWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final userId = authRepository.currentUser?.id;

    // If there's no user logged in, return an empty widget
    if (userId == null) {
      return const SizedBox.shrink();
    }

    final isAdminAsyncValue = ref.watch(isAppUserAdminProvider(userId));

    return isAdminAsyncValue.when(
      data: (isAdmin) {
        if (isAdmin) {
          return child;
        } else {
          return const SizedBox.shrink(); // or some "not authorized" widget
        }
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('Error checking admin status'),
    );
  }
}
