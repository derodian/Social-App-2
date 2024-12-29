// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:srbs_of_houston/srs/services/logger.dart';

// class NotificationNavigationHandler {
//   static final log = getLogger('NotificationNavigationHandler');

//   static Future<void> checkAndNavigateNotification(
//       Function(Map<String, dynamic>) navigationCallback) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? notificationJson = prefs.getString('lastNotification');

//     if (notificationJson != null) {
//       final notificationData =
//           json.decode(notificationJson) as Map<String, dynamic>;
//       final int? timestamp = notificationData['timestamp'];

//       // Check if the notification is recent (e.g., within the last 5 minutes)
//       if (timestamp != null &&
//           DateTime.now().millisecondsSinceEpoch - timestamp < 5 * 60 * 1000) {
//         navigationCallback(notificationData);
//       }

//       // Clear the stored notification data
//       await prefs.remove('lastNotification');
//     }
//   }

//   static void handleNotificationNavigation(
//       BuildContext context, Map<String, dynamic> notificationData) {
//     final String? type = notificationData['type'];
//     final String? id = notificationData['id'];

//     if (type != null && id != null) {
//       switch (type) {
//         case 'news':
//           Navigator.of(context).pushNamed('/news/$id');
//           break;
//         case 'event':
//           Navigator.of(context).pushNamed('/events/$id');
//           break;
//         case 'user':
//           Navigator.of(context).pushNamed('/users');
//           break;
//         default:
//           log.w('Unknown notification type: $type');
//       }
//     }
//   }

//   static Future<void> storeNotificationData(Map<String, dynamic> data) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(
//         'lastNotification',
//         json.encode({
//           'type': data['type'],
//           'id': data['id'],
//           'timestamp': DateTime.now().millisecondsSinceEpoch,
//         }));
//   }
// }
