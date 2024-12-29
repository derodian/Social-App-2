// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'notification_handler_service.g.dart';

// class NotificationHandlerService {
//   void handleBackgroundMessage(RemoteMessage message) {
//     debugPrint('Handling a background message ${message.messageId}');
//   }

//   void handleForegroundNotification(RemoteMessage message) {
//     debugPrint('Foreground notification: ${message.notification?.title}');
//   }

//   void handleMessageClick(RemoteMessage message) {
//     debugPrint('Notification click: ${message.data}');
//     // Implement navigation or other actions based on `message.data`
//   }
// }

// @Riverpod(keepAlive: true)
// NotificationHandlerService notificationHandlerService(
//     NotificationHandlerServiceRef ref) {
//   return NotificationHandlerService();
// }
