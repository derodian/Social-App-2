// lib/services/snackbar_service.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/theme/app_colors.dart';

class SnackBarService {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;

  void showErrorSnackBar({required String message, Duration? duration}) {
    showSnackBar(
      message: message,
      duration: duration,
      backgroundColor: AppColors.kcRedColor,
    );
  }

  void showSuccessSnackBar({required String message, Duration? duration}) {
    showSnackBar(
      message: message,
      duration: duration,
      backgroundColor: AppColors.kcDarkBackgroundColor,
    );
  }

  void showSnackBar({
    required String message,
    Duration? duration,
    Color? backgroundColor,
    SnackBarAction? action,
  }) {
    if (_scaffoldMessengerKey.currentState != null) {
      _scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration ?? const Duration(seconds: 4),
          backgroundColor: backgroundColor,
          action: action,
        ),
      );
    }
  }

  void hideSnackBar() {
    if (_scaffoldMessengerKey.currentState != null) {
      _scaffoldMessengerKey.currentState!.hideCurrentSnackBar();
    }
  }
}

final snackBarServiceProvider = Provider<SnackBarService>((ref) {
  return SnackBarService();
});
