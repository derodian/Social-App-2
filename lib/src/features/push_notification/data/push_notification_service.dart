// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:srbs_of_houston/srs/features/auth/data/app_user_storage_repository.dart';
// import 'package:srbs_of_houston/srs/features/push_notification/data/local_notification_service.dart';
// import 'package:srbs_of_houston/srs/features/push_notification/data/notification_navigation_handler.dart';
// import 'package:srbs_of_houston/srs/routing/app_router.dart';
// import 'package:srbs_of_houston/srs/services/logger.dart';

// part 'push_notification_service.g.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   final log = getLogger('BackgroundHandler');
//   log.i('Handling a background message: ${message.messageId}');
//   log.i('Title: ${message.notification?.title}');
//   log.i('Body: ${message.notification?.body}');
//   log.i('Payload: ${message.data}');

//   // Store the notification data for later use
//   await NotificationNavigationHandler.storeNotificationData(message.data);
// }

// class PushNotificationService {
//   final log = getLogger('PushNotificationService');
//   static String? fcmToken;
//   static String? apnsToken;
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;

//   final LocalNotificationService localNotificationService;

//   PushNotificationService(this.localNotificationService);

//   Future<void> initPushNotification(
//       {required String userId, required bool isUserAdmin}) async {
//     try {
//       await localNotificationService.initialize();
//       await localNotificationService.requestPermissions();

//       await _requestPermissions();
//       await _initializeFCM(userId, isUserAdmin);

//       // Set up message handlers
//       _setupMessageHandlers();

//       // Check for stored notifications
//       await NotificationNavigationHandler.checkAndNavigateNotification(
//           (notificationData) {
//         final context = rootNavigatorKey.currentContext;
//         if (context != null) {
//           NotificationNavigationHandler.handleNotificationNavigation(
//               context, notificationData);
//         } else {
//           log.w('No valid context to navigate during initialization');
//         }
//       });

//       log.i('Push notifications initialized successfully');
//     } catch (e) {
//       log.e('Error initializing push notifications', error: e);
//     }
//   }

//   Future<void> dispose() async {
//     await unsubscribeFromAllTopics();
//     localNotificationService.dispose();
//   }

//   Future<void> _requestPermissions() async {
//     try {
//       if (Platform.isIOS || Platform.isMacOS) {
//         apnsToken = await _firebaseMessaging.getAPNSToken();
//       }

//       NotificationSettings notificationSettings =
//           await _firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );

//       await _firebaseMessaging.setAutoInitEnabled(true);

//       log.i(
//           'User authorization status: ${notificationSettings.authorizationStatus}');
//     } catch (e) {
//       log.e('Error requesting permissions', error: e);
//     }
//   }

//   Future<void> _initializeFCM(String userId, bool isUserAdmin) async {
//     try {
//       fcmToken = await _firebaseMessaging.getToken();
//       if (fcmToken != null) {
//         await saveDeviceToken(fcmToken: fcmToken!, userId: userId);
//       }
//       _firebaseMessaging.onTokenRefresh.listen((token) async {
//         await saveDeviceToken(fcmToken: token, userId: userId);
//       });
//       await _manageTopics(isUserAdmin);

//       FirebaseMessaging.onBackgroundMessage(
//           _firebaseMessagingBackgroundHandler);
//       await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );

//       await _handleInitialMessage();
//       _setupMessageHandlers();
//     } catch (e) {
//       log.e('Error initializing FCM', error: e);
//     }
//   }

//   Future<void> _manageTopics(bool isUserAdmin) async {
//     await _firebaseMessaging.subscribeToTopic('events');
//     await _firebaseMessaging.subscribeToTopic('news');
//     if (isUserAdmin) {
//       await _firebaseMessaging.subscribeToTopic('new_user');
//     } else {
//       await _firebaseMessaging.unsubscribeFromTopic('new_user');
//     }
//   }

//   Future<void> unsubscribeFromAllTopics() async {
//     await _firebaseMessaging.unsubscribeFromTopic('new_user');
//     await _firebaseMessaging.unsubscribeFromTopic('events');
//     await _firebaseMessaging.unsubscribeFromTopic('news');
//   }

//   static Future<String?> getFCMToken() async {
//     fcmToken = await _firebaseMessaging.getToken();
//     return fcmToken;
//   }

//   static Future<void> saveDeviceToken(
//       {required String fcmToken, String? userId, String? apnsToken}) async {
//     await AppUserStorageRepository.saveDeviceToken(
//       deviceToken: fcmToken,
//       uid: userId,
//       apnsToken: apnsToken,
//     );
//   }

//   Future<void> _handleInitialMessage() async {
//     try {
//       RemoteMessage? initialMessage =
//           await _firebaseMessaging.getInitialMessage();
//       if (initialMessage != null) {
//         _handleMessage(initialMessage);
//       }
//     } catch (e) {
//       log.e('Error handling initial message', error: e);
//     }
//   }

//   void _setupMessageHandlers() {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       log.i('A new onMessageOpenedApp event was published!');
//       _handleMessage(message);
//     });
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log.i('Got a message whilst in the foreground!');
//       log.i('Message data: ${message.data}');
//       localNotificationService.displayNotification(message);
//       _handleMessage(message);
//     });

//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }

//   void _handleMessage(RemoteMessage message) {
//     log.i('New Notification');
//     log.i('Title: ${message.notification?.title}');
//     log.i('Body: ${message.notification?.body}');
//     log.i('Payload: ${message.data}');

//     final data = message.data;
//     final context = rootNavigatorKey.currentContext;
//     if (context != null) {
//       NotificationNavigationHandler.handleNotificationNavigation(context, data);
//     } else {
//       log.w('No valid context to navigate');
//       // Optionally store the notification data for later handling
//       NotificationNavigationHandler.storeNotificationData(data);
//     }
//   }
// }

// @Riverpod(keepAlive: true)
// PushNotificationService pushNotificationService(
//     PushNotificationServiceRef ref) {
//   final localNotificationService = ref.watch(localNotificationServiceProvider);
//   return PushNotificationService(localNotificationService);
// }
