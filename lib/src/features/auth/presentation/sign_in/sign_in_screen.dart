import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/apple_sign_in_button.dart';
import 'package:social_app_2/src/common_widgets/facebook_button.dart';
import 'package:social_app_2/src/common_widgets/google_button.dart';
import 'package:social_app_2/src/common_widgets/primary_button.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/keys.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/extensions/async_value_ui.dart';
import 'package:social_app_2/src/features/auth/presentation/sign_in/email_password_sign_in_contents.dart';
import 'package:social_app_2/src/features/auth/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:social_app_2/src/features/auth/presentation/sign_in/sign_in_screen_controller.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  // * Keys for testing using find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');
  static const fullNameKey = Key('fullName');

  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      signInScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(signInScreenControllerProvider);
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: min(constraints.maxWidth, 600),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH32,
                  // Sign in text or loading UI
                  SizedBox(
                    height: 50.0,
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const Text(
                            Strings.signIn,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  const EmailPasswordSignInContents(
                      formType: EmailPasswordSignInFormType.signIn),
                  gapH8,
                  const Text(
                    Strings.or,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.black87),
                  ),
                  gapH8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (Platform.isIOS)
                        AppleButton(
                          isCompact: true,
                          onPressed: state.isLoading
                              ? null
                              : () async {
                                  await ref
                                      .read(signInScreenControllerProvider
                                          .notifier)
                                      .loginWithApple();
                                },
                        ),
                      gapW16,
                      GoogleButton(
                        isCompact: true,
                        onPressed: state.isLoading
                            ? null
                            : () => ref
                                .read(signInScreenControllerProvider.notifier)
                                .loginWithGoogle(),
                      ),
                      gapW16,
                      FacebookButton(
                        isCompact: true,
                        onPressed: state.isLoading ? null : () {},
                      ),
                    ],
                  ),
                  gapH16,
                  const Text(
                    Strings.or,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.black87),
                  ),
                  gapH16,
                  PrimaryButton(
                    key: anonymousButtonKey,
                    text: Strings.goAnonymous,
                    onPressed: state.isLoading
                        ? null
                        : () => ref
                            .read(signInScreenControllerProvider.notifier)
                            .signInAnonymously(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
