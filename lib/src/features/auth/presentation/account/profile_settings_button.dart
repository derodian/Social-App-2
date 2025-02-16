import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/custom_icon_button.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/address_widget.dart';

class ProfileSettingsButton extends ConsumerWidget {
  const ProfileSettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomIconButton(
      icon: Icons.settings,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const ProfileSettingsSheet(),
        );
      },
    );
  }
}

class ProfileSettingsSheet extends ConsumerWidget {
  const ProfileSettingsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Distance Unit Preference',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const DistanceUnitSelector(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
