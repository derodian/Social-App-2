import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
import 'package:social_app_2/src/common_widgets/primary_button.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/extensions/async_value_ui.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/auth/presentation/email_not_verified/email_not_verified_screen_controller.dart';
import 'package:social_app_2/src/features/components/animations/email_verification_animation_view.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/theme/app_theme.dart';

class EmailNotVerifiedScreen extends ConsumerWidget {
  const EmailNotVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      emailNotVerifiedScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    // Listen to changes in the email verification status
    ref.listen<AsyncValue<bool>>(isUserEmailVerifiedProvider, (previous, next) {
      // Check if the email is verified
      next.whenData((isVerified) {
        if (isVerified) {
          // Navigate to the specific page if email is verified
          context.go('/news'); // Replace '/specificPage' with your route
        }
      });
    });

    // Watch the provider to update the UI accordingly
    final isUserEmailVerified = ref.watch(isUserEmailVerifiedProvider);
    return AsyncValueWidget(
      value: isUserEmailVerified,
      data: (isVerified) =>
          isVerified == false ? EmailNotVerifiedContent() : Container(),
    );
  }
}

class EmailNotVerifiedContent extends ConsumerWidget {
  const EmailNotVerifiedContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(emailNotVerifiedScreenControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EmailVerificationAnimationView(),
                Text(
                  Strings.pleaseVerifyEmail,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                gapH32,
                Text(
                  Strings.emailNotVerified,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                gapH32,
                PrimaryButton(
                  text: Strings.sendEmailVerification,
                  onPressed: state.isLoading
                      ? null
                      : () => ref
                          .read(
                              emailNotVerifiedScreenControllerProvider.notifier)
                          .sendEmailVerification(),
                ),
                gapH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.isVerifiedSignIn),
                    TextButton(
                      onPressed: state.isLoading
                          ? null
                          : () async {
                              await ref
                                  .read(emailNotVerifiedScreenControllerProvider
                                      .notifier)
                                  .signOut();
                              if (context.mounted) {
                                context.goNamed(AppRoute.signIn.name);
                              }
                            },
                      child: Text(
                        Strings.signIn,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
