import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/circular_profile_image.dart';
import 'package:social_app_2/src/routing/app_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileControllerProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () async {
            await ref.read(authControllerProvider.notifier).signOut();
            if (context.mounted) {
              ref.read(routerControllerProvider.notifier).goToAuth();
            }
          },
          icon: Icon(Icons.logout_rounded),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircularProfileImage(
              imageUrl: user?.profileImageURL,
              radius: 18,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Rest of your home screen implementation
    );
  }
}
