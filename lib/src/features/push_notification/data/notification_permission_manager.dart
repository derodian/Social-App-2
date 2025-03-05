import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app_2/src/constants/firebase_collection_name.dart';
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/constants/keys.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';
import 'package:social_app_2/src/features/push_notification/domain/notification_category.dart';
import 'package:social_app_2/src/features/push_notification/presentation/permission_dialog.dart';
import 'package:social_app_2/src/features/services/dialog_service.dart';
import 'package:social_app_2/src/features/services/logger.dart';
import 'package:social_app_2/src/routing/app_router.dart';

part 'notification_permission_manager.g.dart';

/// Class to manage push notification permissions and device tokens
@Riverpod(keepAlive: true)
class NotificationPermissionManager extends _$NotificationPermissionManager {
  final _log = getLogger('Notification Permission Manager');
  late final FirebaseMessaging _firebaseMessaging;
  late final FirebaseFirestore _firestore;
  late final CollectionReference<Map<String, dynamic>> _deviceTokensCollection;

  static const String _permissionStatusKey = 'notification_permission_status';
  static const String _lastPermissionRequestKey =
      'last_notification_permission_request';
  static const Duration _minRequestInterval = Duration(days: 3);

  @override
  NotificationPermissionManager build() {
    _firebaseMessaging = FirebaseMessaging.instance;
    _firestore = FirebaseFirestore.instance;
    _deviceTokensCollection =
        _firestore.collection(FirebaseCollectionName.deviceTokens);
    return this;
  }

  /// Initialize Firebase Messaging
  Future<void> initialize() async {
    // Set up foreground notification presentation options
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen(_handleTokenRefresh);

    // Request permission for iOS (this is required)
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  }

  /// Request notification permission after sign-in
  /// Should be called when user successfully signs in
  Future<bool> requestPermissionAfterSignIn(UserID userId) async {
    try {
      // Check if we should request permission now
      if (!await _shouldRequestPermission()) {
        _log.i('Skipping permission request due to recent request');
        return false;
      }

      // Show pre-permission dialog to explain benefits
      final shouldRequest = await _showCustomPermissionDialog();
      if (!shouldRequest) {
        // User declined in custom dialog
        await _savePermissionStatus('declined_temp');
        _log.i('User declined custom permission dialog');
        return false;
      }

      // Request actual system permission
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      // Save the status
      final granted =
          settings.authorizationStatus == AuthorizationStatus.authorized;
      await _savePermissionStatus(granted ? 'granted' : 'denied');

      if (granted) {
        // Register device token
        await registerDeviceToken(userId);
        return true;
      } else {
        _log.i('System permission denied');
        return false;
      }
    } catch (e) {
      _log.e('Error requesting notification permission: $e');
      return false;
    }
  }

  /// Should be called when user successfully signs in
  Future<bool> forceRequestPermission(UserID userId) async {
    try {
      // // Skip the _shouldRequestPermission check
      // // Check if we should request permission now
      // if (!await _shouldRequestPermission()) {
      //   _log.i('Skipping permission request due to recent request');
      //   return false;
      // }

      // Show pre-permission dialog to explain benefits
      final shouldRequest = await _showCustomPermissionDialog();
      if (!shouldRequest) {
        // User declined in custom dialog
        await _savePermissionStatus('declined_temp');
        _log.i('User declined custom permission dialog');
        return false;
      }

      // Request actual system permission
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      // Save the status
      final granted =
          settings.authorizationStatus == AuthorizationStatus.authorized;
      await _savePermissionStatus(granted ? 'granted' : 'denied');

      if (granted) {
        // Register device token
        await registerDeviceToken(userId);
        return true;
      } else {
        _log.i('System permission denied');
        return false;
      }
    } catch (e) {
      _log.e('Error requesting notification permission: $e');
      return false;
    }
  }

  /// Register device token for user
  Future<void> registerDeviceToken(UserID userId) async {
    try {
      // Get FCM Token
      final token = await _firebaseMessaging.getToken();
      if (token == null) {
        _log.w('Failed to get FCM token');
        return;
      }

      _log.i('Got FCM token: $token');

      // Get device info
      final deviceInfo = await _getDeviceInfo();

      // Check if token already exists
      final existingTokenQuery = await _deviceTokensCollection
          .where(FirestoreFieldName.token, isEqualTo: token)
          .limit(1)
          .get();

      if (existingTokenQuery.docs.isNotEmpty) {
        // Update existing token
        await _deviceTokensCollection
            .doc(existingTokenQuery.docs.first.id)
            .update({
          FirestoreFieldName.userId: userId,
          FirestoreFieldName.lastActiveAt: FieldValue.serverTimestamp(),
          FirestoreFieldName.notificationsEnabled: true,
          FirestoreFieldName.lastUpdateDate: FieldValue.serverTimestamp(),
        });

        _log.i('Updated existing device token for user: $userId');
      } else {
        // Create new token document
        await _deviceTokensCollection.add({
          FirestoreFieldName.token: token,
          FirestoreFieldName.userId: userId,
          FirestoreFieldName.deviceInfo: deviceInfo,
          FirestoreFieldName.createDate: FieldValue.serverTimestamp(),
          FirestoreFieldName.lastActiveAt: FieldValue.serverTimestamp(),
          FirestoreFieldName.notificationsEnabled: true,
          FirestoreFieldName.notificationCategories:
              NotificationCategory.values.map((c) => c.name).toList(),
        });

        _log.i('Created new device token for user: $userId');
      }

      // Subscribe to default topics
      await _subscribeToDefaultTopics();
    } catch (e) {
      _log.e('Error registering device token: $e');
      throw Exception('Failed to register device for notifications');
    }
  }

  /// Update device token with new user ID
  /// Call this when user logs in or changes accounts
  Future<void> updateDeviceTokenUserId(UserID userId) async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token == null) return;

      final tokenDocs = await _deviceTokensCollection
          .where(FirestoreFieldName.token, isEqualTo: token)
          .limit(1)
          .get();

      if (tokenDocs.docs.isNotEmpty) {
        await _deviceTokensCollection.doc(tokenDocs.docs.first.id).update({
          FirestoreFieldName.userId: userId,
          FirestoreFieldName.lastActiveAt: FieldValue.serverTimestamp(),
        });
      } else {
        // Token doesn't exist, create it
        await registerDeviceToken(userId);
      }
    } catch (e) {
      _log.e('Error updating device token for user ID: $e');
    }
  }

  /// Handle the token refresh event from firebase Messaging
  Future<void> _handleTokenRefresh(String token) async {
    try {
      _log.i('FCM token refreshed');

      // Try to get current user ID
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('current_user_id');

      if (userId == null) {
        _log.i('No user ID available for token refresh');
        return;
      }

      // Get device info
      final deviceInfo = await _getDeviceInfo();

      // Find existing token documents for this device
      final existingTokenQuery = await _deviceTokensCollection
          .where(FirestoreFieldName.userId, isEqualTo: userId)
          .where('deviceInfo.deviceId', isEqualTo: deviceInfo['deviceId'])
          .limit(1)
          .get();

      if (existingTokenQuery.docs.isNotEmpty) {
        // Update existing token
        await _deviceTokensCollection
            .doc(existingTokenQuery.docs.first.id)
            .update({
          FirestoreFieldName.token: token,
          FirestoreFieldName.lastActiveAt: FieldValue.serverTimestamp(),
          FirestoreFieldName.lastUpdateDate: FieldValue.serverTimestamp(),
        });

        _log.i('Updated existing device token during refresh');
      } else {
        // Create new token entry
        await _deviceTokensCollection.add({
          FirestoreFieldName.token: token,
          FirestoreFieldName.userId: userId,
          FirestoreFieldName.deviceInfo: deviceInfo,
          FirestoreFieldName.createDate: FieldValue.serverTimestamp(),
          FirestoreFieldName.lastActiveAt: FieldValue.serverTimestamp(),
          FirestoreFieldName.notificationsEnabled: true,
          FirestoreFieldName.notificationCategories:
              NotificationCategory.values.map((c) => c.name).toList(),
        });

        _log.i('Created new device token during refresh');
      }
    } catch (e) {
      _log.e('Error handling token refresh: $e');
    }
  }

  /// Subscribe to default notification topics
  Future<void> _subscribeToDefaultTopics() async {
    try {
      // Subscribe to general topics that all users should receive
      await _firebaseMessaging.subscribeToTopic('general');

      // Subscribe to all categories by default
      for (final category in NotificationCategory.values) {
        await _firebaseMessaging.subscribeToTopic(category.topicName);
      }

      _log.i('Subscribed to default notification topics');
    } catch (e) {
      _log.w('Error subscribing to default topics');
    }
  }

  /// Update notification category preferences
  Future<void> updateCategoryPreferences(
      UserID userId, Map<NotificationCategory, bool> preferences) async {
    try {
      // Get current device token
      final token = await _firebaseMessaging.getToken();
      if (token == null) return;

      // Find device token document
      final tokenDoc = await _deviceTokensCollection
          .where(FirestoreFieldName.token, isEqualTo: token)
          .limit(1)
          .get();

      if (tokenDoc.docs.isEmpty) {
        _log.w('Device token not found when updating preferences');
        return;
      }

      // Update category preferences in Firestore
      final enabledCategories = preferences.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key.name)
          .toList();

      await _deviceTokensCollection.doc(tokenDoc.docs.first.id).update({
        FirestoreFieldName.notificationCategories: enabledCategories,
        FirestoreFieldName.lastUpdateDate: FieldValue.serverTimestamp(),
      });

      // Update topic subscriptions
      for (final entry in preferences.entries) {
        final topic = entry.key.topicName;
        if (entry.value) {
          await _firebaseMessaging.subscribeToTopic(topic);
        } else {
          await _firebaseMessaging.unsubscribeFromTopic(topic);
        }
      }

      _log.i('Updated notification preferences for user: $userId');
    } catch (e) {
      _log.e('Error updating category preferences: $e');
      throw Exception('Failed to update notification preferences');
    }
  }

  /// Toggle all notification on/off for current device
  Future<void> setNotificationsEnabled(UserID userId, bool enabled) async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token == null) return;

      // Find device token document
      final tokenDocs = await _deviceTokensCollection
          .where(FirestoreFieldName.token, isEqualTo: token)
          .limit(1)
          .get();

      if (tokenDocs.docs.isEmpty) {
        _log.w('Device token not found when toggling notifications');
        return;
      }

      // Update enabled status
      await _deviceTokensCollection.doc(tokenDocs.docs.first.id).update({
        FirestoreFieldName.notificationsEnabled: enabled,
        FirestoreFieldName.lastUpdateDate: FieldValue.serverTimestamp(),
      });

      // Handle topic subscriptions
      if (enabled) {
        // Re-subscribe to default topics
        await _subscribeToDefaultTopics();
      } else {
        // Unsubscribe from all topics
        for (final category in NotificationCategory.values) {
          await _firebaseMessaging.unsubscribeFromTopic(category.topicName);
        }
        await _firebaseMessaging.unsubscribeFromTopic('general');
      }

      _log.i(
          'Set notifications ${enabled ? 'enabled' : 'disabled'} for user: $userId');
    } catch (e) {
      _log.e('Error setting notifications enabled state: $e');
      throw Exception('Failed to update notification settings');
    }
  }

  /// Remove a device from a user's devices
  Future<void> removeDevice(String deviceTokenId) async {
    try {
      final doc = await _deviceTokensCollection.doc(deviceTokenId).get();
      if (!doc.exists) {
        _log.w('Device token not found for removal: $deviceTokenId');
        return;
      }

      // Get the token to unsubscribe
      final token = doc.data()?[FirestoreFieldName.token] as String?;
      if (token != null) {
        // Unsubscribe from all topics first
        for (final category in NotificationCategory.values) {
          await _firebaseMessaging.unsubscribeFromTopic(category.topicName);
        }
        await _firebaseMessaging.unsubscribeFromTopic('general');
      }

      // Delete the document
      await _deviceTokensCollection.doc(deviceTokenId).delete();
      _log.i('Removed device: $deviceTokenId');
    } catch (e) {
      _log.e('Error removing device: $e');
      throw Exception('Failed to remove device');
    }
  }

  /// Get all devices for a user
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getUserDevices(
      UserID userId) async {
    try {
      final devices = await _deviceTokensCollection
          .where(FirestoreFieldName.userId, isEqualTo: userId)
          .orderBy(FirestoreFieldName.lastActiveAt, descending: true)
          .get();

      return devices.docs;
    } catch (e) {
      _log.e('Error getting user devics: $e');
      return [];
    }
  }

  /// Check if notifications are enabled for the current device
  Future<bool> areNotificationsEnabled() async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token == null) return false;

      final tokenDocs = await _deviceTokensCollection
          .where(FirestoreFieldName.token, isEqualTo: token)
          .limit(1)
          .get();

      if (tokenDocs.docs.isEmpty) return false;

      return tokenDocs.docs.first
              .data()[FirestoreFieldName.notificationsEnabled] ??
          false;
    } catch (e) {
      _log.e('Error checking if notificaitons are enabled: $e');
      return false;
    }
  }

  /// Get notification category preferences for current device
  Future<Map<NotificationCategory, bool>> getCategoryPreferences() async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token == null) {
        return {
          for (final category in NotificationCategory.values) category: false
        };
      }

      final tokenDocs = await _deviceTokensCollection
          .where(FirestoreFieldName.token, isEqualTo: token)
          .limit(1)
          .get();

      if (tokenDocs.docs.isEmpty) {
        return {
          for (final category in NotificationCategory.values) category: false
        };
      }

      final enabledCategories = List<String>.from(tokenDocs.docs.first
              .data()[FirestoreFieldName.notificationCategories] ??
          []);

      return {
        for (final category in NotificationCategory.values)
          category: enabledCategories.contains(category.name)
      };
    } catch (e) {
      _log.e('Error getting category preferences: $e');
      return {
        for (final category in NotificationCategory.values)
          category: true // Default to enable on error
      };
    }
  }

  /// Update device last active time
  Future<void> updateDeviceActiveTime() async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token == null) return;

      final tokenDocs = await _deviceTokensCollection
          .where(FirestoreFieldName.token, isEqualTo: token)
          .limit(1)
          .get();

      if (tokenDocs.docs.isEmpty) return;

      await _deviceTokensCollection.doc(tokenDocs.docs.first.id).update({
        FirestoreFieldName.lastActiveAt: FieldValue.serverTimestamp(),
      });

      _log.i('Device last active time updated');
    } catch (e) {
      _log.e('Error updating device active time: $e');
    }
  }

  /// Clean up old devices for a user (older than 60 days)
  Future<int> cleanupOldDevices(UserID userId) async {
    try {
      final cutOfDate = DateTime.now().subtract(const Duration(days: 60));
      final oldDevices = await _deviceTokensCollection
          .where(FirestoreFieldName.userId, isEqualTo: userId)
          .where(FirestoreFieldName.lastActiveAt, isLessThan: cutOfDate)
          .get();

      // Delete old devices
      int count = 0;
      for (final doc in oldDevices.docs) {
        await _deviceTokensCollection.doc(doc.id).delete();
        count++;
      }

      if (count > 0) {
        _log.i('Cleaned up $count old devices for user: $userId');
      }

      return count;
    } catch (e) {
      _log.e('Error cleaning up old devices: $e');
      return 0;
    }
  }

  /// Check if we should request permission now
  Future<bool> _shouldRequestPermission() async {
    final prefs = await SharedPreferences.getInstance();
    final lastRequest = prefs.getInt(_lastPermissionRequestKey);
    final permissionStatus = prefs.getString(_permissionStatusKey);

    _log.i(
        'Permission status check: status=$permissionStatus, lastRequest=${lastRequest != null ? DateTime.fromMillisecondsSinceEpoch(lastRequest) : "never"}');

    if (lastRequest == null) {
      // First time request
      await prefs.setInt(
          _lastPermissionRequestKey, DateTime.now().millisecondsSinceEpoch);
      return true;
    }

    final lastRequestDate = DateTime.fromMillisecondsSinceEpoch(lastRequest);
    final daysSinceLastRequest =
        DateTime.now().difference(lastRequestDate).inDays;

    // If we've requested recently, don't ask again
    if (daysSinceLastRequest < _minRequestInterval.inDays) {
      return false;
    }

    // Check current status
    final status = prefs.getString(_permissionStatusKey);
    if (status == 'granted') {
      // Already granted, no need to request again
      return false;
    } else if (status == 'denied') {
      // Previously denied, only request again after longer interval
      return daysSinceLastRequest > 30;
    } else if (status == 'declined_temp') {
      // User declined our pre-permission dialog, try again after a week
      return daysSinceLastRequest > 7;
    }

    // Status unknown, request permission
    await prefs.setInt(
        _lastPermissionRequestKey, DateTime.now().millisecondsSinceEpoch);
    return true;
  }

  /// Save the permission status
  Future<void> _savePermissionStatus(String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_permissionStatusKey, status);
    await prefs.setInt(
        _lastPermissionRequestKey, DateTime.now().millisecondsSinceEpoch);
  }

  /// Show custom permission dialog
  Future<bool> _showCustomPermissionDialog() async {
    // Check if we have a valid navigator key and context
    // final navigatorKey = ref.watch(rootNavigatorKeyProvider);
    // final rootNavKeyCurrentContext = rootNavigatorKey.currentContext;
    // if (rootNavKeyCurrentContext == null) {
    //   debugPrint(
    //       'No valid context found for permission dialog, defaulting to false');
    //   return false;
    // }

    try {
      // final result =
      //     await Navigator.of(rootNavKeyCurrentContext, rootNavigator: true)
      //         .push<bool>(
      //   MaterialPageRoute(
      //     builder: (context) => const NotificationPermissionDialog(),
      //     fullscreenDialog: true,
      //   ),
      // );
      final result = ref
          .read(dialogServiceProvider.notifier)
          .showNotificationPermissionDialog();

      // return result ?? false;
      return result;
    } catch (e) {
      debugPrint('Error showing permission dialog: $e');
      return false;
    }
  }

  /// Get device information
  Future<Map<String, dynamic>> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceId = await _getDeviceId(deviceInfo);

    final Map<String, dynamic> info = {
      'deviceId': deviceId,
      'appVersion': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
      'platform': Platform.operatingSystem,
    };

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      info.addAll({
        'model': androidInfo.model,
        'manufacturer': androidInfo.manufacturer,
        'osVersion': androidInfo.version.release,
        'sdkVersion': androidInfo.version.sdkInt.toString(),
      });
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      info.addAll({
        'model': iosInfo.model,
        'name': iosInfo.name,
        'systemName': iosInfo.systemName,
        'systemVersion': iosInfo.systemVersion,
      });
    }

    return info;
  }

  /// Get a unique device ID
  Future<String> _getDeviceId(DeviceInfoPlugin deviceInfo) async {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Use Android ID
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown'; // Use vendor identifier
    }

    // Fallback to a generated ID
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');

    if (deviceId == null) {
      deviceId = DateTime.now().millisecondsSinceEpoch.toString();
      await prefs.setString('device_id', deviceId);
    }

    return deviceId;
  }
}

/// Extension for getting PackageInfo with error handling
extension PackageInfoExtension on PackageInfo {
  static Future<PackageInfo> getInstance() async {
    try {
      return await PackageInfo.fromPlatform();
    } catch (e) {
      // Return default values on error
      return PackageInfo(
        appName: 'Unknown',
        packageName: 'Unknown',
        version: '0.0.0',
        buildNumber: '0',
      );
    }
  }
}
