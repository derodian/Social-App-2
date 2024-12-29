import 'package:flutter/material.dart';
import 'package:social_app_2/src/features/components/animations/empty_contents_animation_view.dart';

class EmptyContentsWithTextAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentsWithTextAnimationView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 64.0, 8.0, 32.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
            //TODO: change text color if needed
            // ?.copyWith(color: AppColors.kcCharcoalGray),
          ),
        ),
        const EmptyContentsAnimationView(),
      ],
    );
  }
}
