import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/primary_button.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/features/auth/data/auth_service.dart';
import 'package:social_app_2/src/features/auth/data/firebase_auth_service.dart';
import 'package:social_app_2/src/features/components/animations/page_not_found_animation_view.dart';
import 'package:social_app_2/src/routing/app_router.dart';

class NotFoundScreen extends ConsumerWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PageNotFoundAnimationView(),
              PrimaryButton(
                text: Strings.homePage,
                onPressed: () async {
                  await ref.read(authServiceProvider).signOut();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
