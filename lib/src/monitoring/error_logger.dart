import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/exceptions/app_exception.dart';

part 'error_logger.g.dart';

class ErrorLogger {
  const ErrorLogger();

  // ignore:avoid-unnecessary-futures,avoid-redundant-async
  FutureOr<void> logException(Object exception, StackTrace? stackTrace) async {
    // TODO: Error monitoring
    log(exception.toString(),
        name: 'Exception', error: exception, stackTrace: stackTrace);
  }

  void logError(Object error, StackTrace? stackTrace) {
    // * This can be replaced with a call to a crash reporting tool of choice
    debugPrint('$error, $stackTrace');
  }

  void logAppException(AppException exception) {
    // * This can be replaced with a call to a crash reporting tool of choice
    debugPrint('$exception');
  }
}

@Riverpod(keepAlive: true)
ErrorLogger errorLogger(Ref ref) {
  return const ErrorLogger();
}
