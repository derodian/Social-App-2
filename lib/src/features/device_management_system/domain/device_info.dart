// device_info.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';

@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String id,
    required String name,
    required String platform,
    required String model,
    required String osVersion,
    required String appVersion,
    required DateTime lastLoginAt,
    required bool isCurrentDevice,
    DateTime? lastSeenAt,
    String? fcmToken,
    String? apnsToken,
    String? ipAddress,
    Map<String, dynamic>? metadata,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}
