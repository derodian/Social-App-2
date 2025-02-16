import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/primary_button.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends ConsumerWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32,
            ),
            PrimaryButton(
              onPressed: () {
                // final isLoggedIn =
                //     ref.watch(authControllerProvider).hasValue != null;
                // context.goNamed(
                //     isLoggedIn ? AppRoute.home.name : AppRoute.signIn.name);
              },
              text: 'Go Home',
            )
          ],
        ),
      ),
    );
  }
}
