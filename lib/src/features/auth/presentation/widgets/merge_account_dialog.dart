import 'package:flutter/material.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/utils/provider_utils.dart';

class MergeAccountDialog extends StatelessWidget {
  final String email;
  final AppAuthProvider provider;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const MergeAccountDialog({
    required this.email,
    required this.provider,
    required this.onConfirm,
    required this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Account Found'),
      content: Text('An account with email $email already exists. '
          'Would you like to connect your ${ProviderUtils.getProviderName(provider)} '
          'account with your existing account?'),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: onConfirm,
          child: const Text('Connect Accounts'),
        ),
      ],
    );
  }
}
