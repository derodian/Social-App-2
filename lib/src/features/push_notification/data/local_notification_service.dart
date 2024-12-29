// import 'dart:convert';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:srbs_of_houston/srs/features/push_notification/data/notification_config.dart';
// import 'package:srbs_of_houston/srs/services/logger.dart';

// part 'local_notification_service.g.dart';

// class LocalNotificationService {
//   static final LocalNotificationService _instance =
//       LocalNotificationService._internal();

//   factory LocalNotificationService() {
//     return _instance;
//   }

//   LocalNotificationService._internal();

//   final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

//   final log = getLogger('LocalNotificationService');

//   Future<void> initialize() async {
//     try {
//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/app_logo');

//       final DarwinInitializationSettings initializationSettingsDarwin =
//           DarwinInitializationSettings(
//         requestAlertPermission: false,
//         requestBadgePermission: false,
//         requestSoundPermission: false,
//         onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
//       );

//       final InitializationSettings initializationSettings =
//           InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsDarwin,
//         macOS: initializationSettingsDarwin,
//       );

//       await _notificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
//       );

//       log.i('Local notifications initialized successfully');
//     } catch (e, stackTrace) {
//       log.e('Error initializing local notifications',
//           error: e, stackTrace: stackTrace);
//     }
//   }

//   Future<void> requestPermissions() async {
//     if (Platform.isIOS || Platform.isMacOS) {
//       await _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//       await _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               MacOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//     }
//   }

//   Future<void> displayNotification(RemoteMessage message) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

//       const androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         NotificationConfig.channelId,
//         NotificationConfig.channelName,
//         channelDescription: NotificationConfig.channelDescription,
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//       );

//       const notificationDetails = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: DarwinNotificationDetails(),
//       );

//       await _notificationsPlugin.show(
//         id,
//         message.notification?.title,
//         message.notification?.body,
//         notificationDetails,
//         payload: json.encode(message.data),
//       );

//       log.i('Notification displayed: ${message.notification?.title}');
//     } catch (e, stackTrace) {
//       log.e('Error displaying notification', error: e, stackTrace: stackTrace);
//     }
//   }

//   Future<void> cancelAllNotifications() async {
//     try {
//       await _notificationsPlugin.cancelAll();
//       log.i('All notifications cancelled');
//     } catch (e, stackTrace) {
//       log.e('Error cancelling all notifications',
//           error: e, stackTrace: stackTrace);
//     }
//   }

//   Future<void> cancelNotification(int id) async {
//     try {
//       await _notificationsPlugin.cancel(id);
//       log.i('Notification with id $id cancelled');
//     } catch (e, stackTrace) {
//       log.e('Error cancelling notification with id $id',
//           error: e, stackTrace: stackTrace);
//     }
//   }

//   void _onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     log.i(
//         'Received local notification: id=$id, title=$title, body=$body, payload=$payload');
//   }

//   void _onDidReceiveNotificationResponse(NotificationResponse details) {
//     final payload = details.payload;
//     if (payload != null) {
//       log.i('Notification clicked with payload: $payload');
//       onNotificationClick.add(payload);
//     }
//   }

//   void dispose() {
//     onNotificationClick.close();
//   }
// }

// @Riverpod(keepAlive: true)
// LocalNotificationService localNotificationService(
//     LocalNotificationServiceRef ref) {
//   final service = LocalNotificationService();
//   ref.onDispose(() {
//     service.dispose();
//   });
//   return service;
// }
