// device_manager.dart
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/device_management_system/domain/device_info.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'device_manager.g.dart';

@Riverpod(keepAlive: true)
class DeviceManager extends _$DeviceManager {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  PackageInfo? _packageInfo;

  @override
  Future<DeviceInfo?> build() async {
    _packageInfo = await PackageInfo.fromPlatform();
    return _getCurrentDevice();
  }

  Future<DeviceInfo> _getCurrentDevice() async {
    final deviceId = await _getDeviceId();
    final deviceData = await _getDeviceData();
    final now = DateTime.now();

    return DeviceInfo(
      id: deviceId,
      name: deviceData['name'] as String,
      platform: Platform.operatingSystem,
      model: deviceData['model'] as String,
      osVersion: deviceData['osVersion'] as String,
      appVersion: _packageInfo?.version ?? '1.0.0',
      lastLoginAt: now,
      lastSeenAt: now,
      isCurrentDevice: true,
      metadata: deviceData,
    );
  }

  Future<String> _getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    var deviceId = prefs.getString('device_id');

    if (deviceId == null) {
      deviceId = const Uuid().v4();
      await prefs.setString('device_id', deviceId);
    }

    return deviceId;
  }

  Future<Map<String, dynamic>> _getDeviceData() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return {
        'name': '${info.brand} ${info.model}',
        'model': info.model,
        'osVersion': info.version.release,
        'sdkInt': info.version.sdkInt,
        'manufacturer': info.manufacturer,
        'androidId': info.id,
      };
    } else if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return {
        'name': info.name,
        'model': info.model,
        'osVersion': info.systemVersion,
        'systemName': info.systemName,
        'localizedModel': info.localizedModel,
        'identifierForVendor': info.identifierForVendor,
      };
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  Future<void> registerDevice({String? fcmToken, String? apnsToken}) async {
    // Get the current state
    final currentDevice = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };

    if (currentDevice == null) return;

    // Add tokens if provided
    final updatedDevice = currentDevice.copyWith(
      fcmToken: fcmToken,
      apnsToken: apnsToken,
      lastSeenAt: DateTime.now(),
    );

    // Save to Firestore
    await _saveDevice(updatedDevice);
    state = AsyncValue.data(updatedDevice);
  }

  Future<void> updateDeviceActivity() async {
    final currentDevice = await future;
    if (currentDevice == null) return;

    final updatedDevice = currentDevice.copyWith(
      lastSeenAt: DateTime.now(),
    );

    await _saveDevice(updatedDevice);
    state = AsyncValue.data(updatedDevice);
  }

  Future<void> _saveDevice(DeviceInfo device) async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('devices')
        .doc(device.id)
        .set(device.toJson(), SetOptions(merge: true));
  }

  Future<List<DeviceInfo>> getUserDevices() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('devices')
        .get();

    return snapshot.docs.map((doc) => DeviceInfo.fromJson(doc.data())).toList();
  }

  Future<void> revokeDevice(String deviceId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Delete from Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('devices')
        .doc(deviceId)
        .delete();

    // If it's the current device, sign out
    final currentDevice = await future;
    if (currentDevice?.id == deviceId) {
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<void> revokeAllDevices() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Delete all devices
    final batch = FirebaseFirestore.instance.batch();
    final devices = await getUserDevices();

    for (final device in devices) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('devices')
          .doc(device.id);
      batch.delete(docRef);
    }

    await batch.commit();
    await FirebaseAuth.instance.signOut();
  }
}
