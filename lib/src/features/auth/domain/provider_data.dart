import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_data.freezed.dart';
part 'provider_data.g.dart';

@freezed
class ProviderData with _$ProviderData {
  const factory ProviderData({
    required String providerId,
    required String uid,
    String? displayName,
    String? photoURL,
    String? email,
    String? phoneNumber,
  }) = _ProviderData;

  factory ProviderData.fromJson(Map<String, dynamic> json) =>
      _$ProviderDataFromJson(json);
}
