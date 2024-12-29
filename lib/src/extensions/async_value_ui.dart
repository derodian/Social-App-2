import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/alert_dialogs.dart';
import 'package:social_app_2/src/exceptions/app_exception.dart';
import 'package:social_app_2/src/exceptions/firebase_error_handler.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

/// A helper [AsyncValue] extension to show an alert dialog on error
extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    /// Show an alert dialog if the current [AsyncValue] has an
    /// error and the stat is not loading
    debugPrint('isLoading: $isLoading, hasError: $hasError');
    if (!isLoading && hasError) {
      final message = _errorMessage(error);
      showExceptionAlertDialog(
        context: context,
        title: 'Error'.hardcoded,
        exception: message,
      );
    }
  }
}

String _errorMessage(Object? error) {
  if (error is FirebaseAuthException) {
    print(error);
    final errorMessage = FirebaseErrorHandler.getAuthErrorMessage(error.code);
    return errorMessage;
  } else if (error is AppException) {
    return error.message;
  } else if (error is PlatformException) {
    return error.message ?? error.code;
  } else {
    return error.toString();
  }
}
