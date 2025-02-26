import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/auth/utils/provider_utils.dart';

class ProviderSelectionBottomSheet extends ConsumerWidget {
  final List<AppAuthProvider> providers;

  const ProviderSelectionBottomSheet({
    required this.providers,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          _buildProviderList(context, ref),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Email Already Registered',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'This email is already registered. Please sign in using:',
          ),
        ],
      ),
    );
  }

  Widget _buildProviderList(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: providers.length,
      itemBuilder: (context, index) {
        final provider = providers[index];
        return ListTile(
          leading: FaIcon(
            ProviderUtils.getProviderIcon(provider),
            color: ProviderUtils.getProviderColor(provider),
          ),
          title: Text(ProviderUtils.getProviderName(provider)),
          onTap: () => _handleProviderSelection(context, ref, provider),
        );
      },
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _handleProviderSelection(
    BuildContext context,
    WidgetRef ref,
    AppAuthProvider provider,
  ) async {
    Navigator.of(context).pop();

    try {
      await ref
          .read(authControllerProvider.notifier)
          .signInWithSocialProvider(provider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
