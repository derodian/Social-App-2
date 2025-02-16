import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/constants/keys.dart';

// class SnackBarService {
//   static String? _lastMessage;
//   static DateTime? _lastMessageTime;

//   static void showError(String message) {
//     // Prevent duplicate messages within 2 seconds
//     if (_lastMessage == message &&
//         _lastMessageTime != null &&
//         DateTime.now().difference(_lastMessageTime!) <
//             const Duration(seconds: 2)) {
//       return;
//     }

//     _lastMessage = message;
//     _lastMessageTime = DateTime.now();

//     final messenger = scaffoldMessengerKey.currentState;
//     if (messenger == null) return;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       messenger.clearSnackBars();
//       messenger.showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           margin: const EdgeInsets.all(16),
//           duration: const Duration(seconds: 4),
//           action: SnackBarAction(
//             label: 'Dismiss',
//             textColor: Colors.white,
//             onPressed: () => messenger.hideCurrentSnackBar(),
//           ),
//         ),
//       );
//     });
//   }

//   static void showSuccess(String message) {
//     debugPrint('SnackBarService - Attempting to show success: $message');

//     // Prevent duplicate messages within 2 seconds
//     if (_lastMessage == message &&
//         _lastMessageTime != null &&
//         DateTime.now().difference(_lastMessageTime!) <
//             const Duration(seconds: 2)) {
//       return;
//     }

//     _lastMessage = message;
//     _lastMessageTime = DateTime.now();

//     final messenger = scaffoldMessengerKey.currentState;
//     if (messenger == null) {
//       debugPrint('SnackBarService - ScaffoldMessengerState is null');
//       return;
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       messenger.clearSnackBars();
//       messenger.showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//           margin: const EdgeInsets.all(16),
//           duration: const Duration(seconds: 4),
//           action: SnackBarAction(
//             label: 'Dismiss',
//             textColor: Colors.white,
//             onPressed: () => messenger.hideCurrentSnackBar(),
//           ),
//         ),
//       );
//     });

//     // messenger.showSnackBar(snackBar);
//     debugPrint('SnackBarService - SnackBar shown');
//   }

//   static void showWarning(String message) {
//     debugPrint('SnackBarService - Attempting to show success: $message');

//     // Prevent duplicate messages within 2 seconds
//     if (_lastMessage == message &&
//         _lastMessageTime != null &&
//         DateTime.now().difference(_lastMessageTime!) <
//             const Duration(seconds: 2)) {
//       return;
//     }

//     _lastMessage = message;
//     _lastMessageTime = DateTime.now();

//     final messenger = scaffoldMessengerKey.currentState;
//     if (messenger == null) {
//       debugPrint('SnackBarService - ScaffoldMessengerState is null');
//       return;
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       messenger.clearSnackBars();
//       messenger.showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//           margin: const EdgeInsets.all(16),
//           duration: const Duration(seconds: 4),
//           action: SnackBarAction(
//             label: 'Dismiss',
//             textColor: Colors.white,
//             onPressed: () => messenger.hideCurrentSnackBar(),
//           ),
//         ),
//       );
//     });

//     // messenger.showSnackBar(snackBar);
//     debugPrint('SnackBarService - SnackBar shown');
//   }

//   static void _show(
//     String message, {
//     Color? backgroundColor,
//     Widget? icon,
//     Duration duration = const Duration(seconds: 4),
//   }) {
//     final messenger = scaffoldMessengerKey.currentState;
//     if (messenger == null) return;

//     messenger.showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             if (icon != null) ...[
//               icon,
//               const SizedBox(width: 8),
//             ],
//             Expanded(
//               child: Text(message),
//             ),
//           ],
//         ),
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: backgroundColor,
//         duration: duration,
//         action: SnackBarAction(
//           label: 'Dismiss',
//           textColor: Colors.white,
//           onPressed: () => messenger.hideCurrentSnackBar(),
//         ),
//       ),
//     );
//   }
// }

part 'snackbar_service.g.dart';

@riverpod
class SnackBarController extends _$SnackBarController {
  String? _lastMessage;
  DateTime? _lastMessageTime;
  static const _debounceDuration = Duration(seconds: 2);

  @override
  void build() {
    // No state needed, just using for methods
    return;
  }

  void showError(String message) {
    if (_shouldDebounce(message)) return;
    _updateLastMessage(message);

    _show(
      message,
      backgroundColor: Colors.red,
      icon: const Icon(Icons.error_outline, color: Colors.white),
    );
  }

  void showSuccess(String message) {
    if (_shouldDebounce(message)) return;
    _updateLastMessage(message);

    _show(
      message,
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
    );
  }

  void showWarning(String message) {
    if (_shouldDebounce(message)) return;
    _updateLastMessage(message);

    _show(
      message,
      backgroundColor: Colors.orange,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
    );
  }

  void showInfo(String message) {
    if (_shouldDebounce(message)) return;
    _updateLastMessage(message);

    _show(
      message,
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.info_outline, color: Colors.white),
    );
  }

  bool _shouldDebounce(String message) {
    return _lastMessage == message &&
        _lastMessageTime != null &&
        DateTime.now().difference(_lastMessageTime!) < _debounceDuration;
  }

  void _updateLastMessage(String message) {
    _lastMessage = message;
    _lastMessageTime = DateTime.now();
  }

  void _show(
    String message, {
    Color? backgroundColor,
    Widget? icon,
    Duration duration = const Duration(seconds: 4),
  }) {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      messenger.clearSnackBars();
      messenger.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              if (icon != null) ...[
                icon,
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(message),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: backgroundColor,
          duration: duration,
          margin: const EdgeInsets.all(16),
          dismissDirection: DismissDirection.horizontal,
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () => messenger.hideCurrentSnackBar(),
          ),
        ),
      );
    });
  }
}
