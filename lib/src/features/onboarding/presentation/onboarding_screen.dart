import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app_2/src/common_widgets/primary_button.dart';
import 'package:social_app_2/src/common_widgets/responsive_center.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final scale = MediaQuery.of(context).textScaler.scale(1.0);
    final state = ref.watch(onboardingControllerProvider);
    return Scaffold(
      body: ResponsiveCenter(
        maxContentWidth: 450,
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to Social App'.hardcoded,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            gapH4,
            Text(
              'Your Community App'.hardcoded,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            gapH12,
            Text(
              'Some app info can be here'.hardcoded,
              textAlign: TextAlign.center,
            ),
            gapH12,
            FractionallySizedBox(
              widthFactor: 0.5,
              child: SvgPicture.asset(
                'assets/images/social-media-content-creator-icon.svg',
                width: 200,
                height: 200,
                semanticsLabel: 'Time tracking logo',
              ),
            ),
            gapH48,
            PrimaryButton(
              text: 'Get Started'.hardcoded,
              isLoading: state.isLoading,
              onPressed: state.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(onboardingControllerProvider.notifier)
                          .completeOnboarding();
                      if (context.mounted) {
                        // go to sign in page after completing onboarding
                        context.goNamed(AppRoute.signIn.name);
                      }
                    },
            )
          ],
        ),
      ),
    );
  }
}
