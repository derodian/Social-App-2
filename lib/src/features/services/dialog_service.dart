import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/push_notification/presentation/permission_dialog.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/features/services/logger.dart';

part 'dialog_service.g.dart';

/// Service for showing dialogs in the app
@Riverpod(keepAlive: true)
class DialogService extends _$DialogService {
  final _log = getLogger('DialogService');

  @override
  void build() {
    // Stateless provider
  }

  /// Show the notification permission dialog
  Future<bool> showNotificationPermissionDialog() async {
    try {
      // Get the root navigator context
      final context = rootNavigatorKey.currentContext;
      if (context == null) {
        _log.w('No valid context found for notification permission dialog');
        return false;
      }

      // Show the dialog as a fullscreen dialog
      final result =
          await Navigator.of(context, rootNavigator: true).push<bool>(
        MaterialPageRoute(
          builder: (context) => const NotificationPermissionDialog(),
          fullscreenDialog: true,
        ),
      );

      return result ?? false;
    } catch (e) {
      _log.e('Error showing notification permission dialog: $e');
      return false;
    }
  }

  /// Show a confirmation dialog with customizable title, message, and buttons
  Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool barrierDismissible = true,
  }) async {
    try {
      final context = rootNavigatorKey.currentContext;
      if (context == null) {
        _log.w('No valid context found for confirmation dialog');
        return false;
      }

      final result = await showDialog<bool>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (dialogContext) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(cancelText),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(confirmText),
            ),
          ],
        ),
      );

      return result ?? false;
    } catch (e) {
      _log.e('Error showing confirmation dialog: $e');
      return false;
    }
  }

  /// Show an information dialog with an OK button
  Future<void> showInfoDialog({
    required String title,
    required String message,
    String buttonText = 'OK',
  }) async {
    try {
      final context = rootNavigatorKey.currentContext;
      if (context == null) {
        _log.w('No valid context found for info dialog');
        return;
      }

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(buttonText),
            ),
          ],
        ),
      );
    } catch (e) {
      _log.e('Error showing info dialog: $e');
    }
  }

  /// Show a custom dialog with any widget content
  Future<T?> showCustomDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    bool useSafeArea = true,
  }) async {
    try {
      final context = rootNavigatorKey.currentContext;
      if (context == null) {
        _log.w('No valid context found for custom dialog');
        return null;
      }

      return await showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        useSafeArea: useSafeArea,
        builder: builder,
      );
    } catch (e) {
      _log.e('Error showing custom dialog: $e');
      return null;
    }
  }

  /// Show a bottom sheet
  Future<T?> showAppBottomSheet<T>({
    required WidgetBuilder builder,
    bool isScrollControlled = true,
    bool isDismissible = true,
    Color? backgroundColor,
    ShapeBorder? shape,
  }) async {
    try {
      final context = rootNavigatorKey.currentContext;
      if (context == null) {
        _log.w('No valid context found for bottom sheet');
        return null;
      }

      return await showModalBottomSheet<T>(
        context: context,
        isScrollControlled: isScrollControlled,
        isDismissible: isDismissible,
        backgroundColor: backgroundColor,
        shape: shape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
        builder: builder,
      );
    } catch (e) {
      _log.e('Error showing bottom sheet: $e');
      return null;
    }
  }
}
