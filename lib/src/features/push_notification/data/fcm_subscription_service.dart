// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'fcm_subscription_service.g.dart';

// class FCMSubscriptionService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   FCMSubscriptionService();

//   Future<void> init(String userId) async {
//     String? token = await _firebaseMessaging.getToken();
//     debugPrint("FCM Token: $token");
//     // Example function to save the token to your backend or Firestore
//     saveTokenToDatabase(userId, token);
//   }

//   Future<void> subscribeToTopics() async {
//     await _firebaseMessaging.subscribeToTopic('news');
//     await _firebaseMessaging.subscribeToTopic('event');
//     // Additional topics can be added here
//   }

//   Future<void> unsubscribeFromTopics() async {
//     await _firebaseMessaging.unsubscribeFromTopic('news');
//     await _firebaseMessaging.unsubscribeFromTopic('event');
//     // Additional topics can be managed here
//   }

//   void saveTokenToDatabase(String userId, String? token) {
//     // Save the token to your database or backend server
//   }
// }

// @Riverpod(keepAlive: true)
// FCMSubscriptionService fcmSubscriptionService(FcmSubscriptionServiceRef ref) {
//   return FCMSubscriptionService();
// }
