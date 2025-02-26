import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_controller.dart';

part 'edit_profile_form.g.dart';

@riverpod
class EditProfileForm extends _$EditProfileForm {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> submit({
    required String displayName,
    required String email,
    required String phone,
    String? street,
    String? city,
    String? addressState,
    String? zip,
    String? country,
    File? profileImage,
    File? backgroundImage,
    required PrivacySettings privacySettings,
    required NotificationSettings notificationSettings,
    required bool isInfoShared,
    required bool isChatEnabled,
  }) async {
    state = const AsyncValue.loading();

    try {
      await ref.read(profileControllerProvider.notifier).updateProfile(
            displayName: displayName,
            email: email,
            phone: phone,
            street: street,
            city: city,
            addressState: addressState,
            zip: zip,
            country: country,
            profileImage: profileImage,
            backgroundImage: backgroundImage,
            privacySettings: privacySettings,
            notificationSettings: notificationSettings,
            isInfoShared: isInfoShared,
            isChatEnabled: isChatEnabled,
          );

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
