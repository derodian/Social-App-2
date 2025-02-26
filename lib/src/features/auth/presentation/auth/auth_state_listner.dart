import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/merge_account_dialog.dart';

class AuthStateListner extends ConsumerWidget {
  const AuthStateListner({
    super.key,
    required this.child,
    this.onMergeAccount,
    this.onError,
  });

  final Widget child;
  final void Function(MergeAccountInfo mergeInfo)? onMergeAccount;
  final void Function(Object error)? onError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<AuthResult?>>(
      authControllerProvider,
      (_, next) {
        if (next.hasValue && next.value != null) {
          switch (next.value) {
            case MergeAccountInfo(
                :final email,
                :final newProvider,
                :final existingProviders
              ):
              if (onMergeAccount != null) {
                onMergeAccount!(next.value! as MergeAccountInfo);
              } else {
                _showMergeDialog(context, ref, next.value! as MergeAccountInfo);
              }

            case AuthUser():
              // Handle authenticated user case if needed
              break;
            case null:
              break;
          }
        }
        if (next.hasError && onError != null) {
          onError!(next.error!);
        }
      },
    );
    return child;
  }

  void _showMergeDialog(
      BuildContext context, WidgetRef ref, MergeAccountInfo mergeInfo) {
    showDialog(
      context: context,
      builder: (context) => MergeAccountDialog(
        email: mergeInfo.email,
        provider: mergeInfo.newProvider,
        onConfirm: () {
          Navigator.of(context).pop();
          ref.read(authControllerProvider.notifier).confirmMerge(mergeInfo);
        },
        onCancel: () {
          Navigator.of(context).pop();
          ref.read(authControllerProvider.notifier).signOut();
        },
      ),
    );
  }
}
