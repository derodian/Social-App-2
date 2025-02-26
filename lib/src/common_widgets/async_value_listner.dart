import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/loading_overlay.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/merge_account_dialog.dart';
import 'package:social_app_2/src/features/services/snackbar_service.dart';

enum ErrorDisplayType {
  dialog,
  snackbar,
}

class AsyncValueListener<T> extends ConsumerWidget {
  const AsyncValueListener({
    super.key,
    required this.value,
    required this.child,
    this.errorDisplayType = ErrorDisplayType.snackbar,
    this.skipLoadingOnRefresh = false,
    this.skipLoadingOnReload = true,
    this.onError,
  });

  final AsyncValue<T> value;
  final Widget child;
  final ErrorDisplayType errorDisplayType;
  final bool skipLoadingOnRefresh;
  final bool skipLoadingOnReload;
  final void Function(Object error)? onError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Handle Loading
    final showLoading = switch (value) {
      AsyncData(:final isRefreshing, :final isReloading) =>
        isRefreshing && !skipLoadingOnRefresh ||
            isReloading && !skipLoadingOnReload,
      AsyncLoading() => true,
      _ => false,
    };

    // Handle errors
    if (value.hasError && !value.isLoading) {
      final snackBarController = ref.read(snackBarControllerProvider.notifier);
      final error = value.error.toString();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onError?.call(value.error!);

        switch (errorDisplayType) {
          case ErrorDisplayType.dialog:
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(error),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          case ErrorDisplayType.snackbar:
            snackBarController.showError(error);
        }
      });
    }

    return LoadingOverlay(
      isLoading: showLoading,
      child: child,
    );
  }
}

// Helper extension for AuthResult checks
extension AuthResultX on AsyncValue<AuthResult?> {
  AppUser? get user {
    if (!hasValue || value == null) return null;
    return switch (value!) {
      AuthUser(:final user) => user,
      _ => null,
    };
  }

  bool get hasMergeInfo {
    return hasValue && value != null && value is MergeAccountInfo;
  }

  MergeAccountInfo? get mergeInfo {
    if (!hasValue || value == null) return null;
    return switch (value!) {
      MergeAccountInfo info => info,
      _ => null,
    };
  }

  // Helper methods for common checks
  bool get isAuthenticated => user != null;
  bool get isVerified => user?.isEmailVerified ?? false;
  bool get isApproved => user?.isApproved ?? false;
}
