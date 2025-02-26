import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/utils/image_utils.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<AppUser?> build() {
    // Watch the auth state to keep profile in sync
    return ref.watch(currentUserProvider);
  }

  Future<void> updateProfile({
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
      // Get current user
      final currentUser = state.valueOrNull;
      if (currentUser == null) {
        throw Exception('Please sign in to update profile');
      }

      // Validate and potentially compress images
      File? processedProfileImage;
      File? processedBackgroundImage;

      if (profileImage != null) {
        final validation = await ImageUtils.validateImage(profileImage);
        if (!validation.isValid) {
          throw Exception(validation.error);
        }
        processedProfileImage = await ImageUtils.compressImage(profileImage);
        if (processedProfileImage == null) {
          throw Exception('Failed to process profile image');
        }
      }

      if (backgroundImage != null) {
        final validation = await ImageUtils.validateImage(backgroundImage);
        if (!validation.isValid) {
          throw Exception(validation.error);
        }
        processedBackgroundImage =
            await ImageUtils.compressImage(backgroundImage);
        if (processedBackgroundImage == null) {
          throw Exception('Failed to process background image');
        }
      }

      final storage = ref.read(appUserStorageServiceProvider.notifier);

      // Upload processed images
      String? profileImageURL;
      String? profileBannerImageURL;

      if (processedProfileImage != null) {
        profileImageURL = await storage.uploadProfileImage(
          currentUser.id,
          processedProfileImage,
        );
      }

      if (processedBackgroundImage != null) {
        profileBannerImageURL = await storage.uploadProfileBackground(
          currentUser.id,
          processedBackgroundImage,
        );
      }

      // Update user data
      final updatedUser = currentUser.copyWith(
        displayName: displayName,
        email: email,
        phoneNumber: phone,
        street: street,
        city: city,
        addressState: addressState,
        zip: zip,
        country: country,
        profileImageURL: profileImageURL ?? currentUser.profileImageURL,
        profileBannerImageURL:
            profileBannerImageURL ?? currentUser.profileBannerImageURL,
        privacySettings: privacySettings,
        notificationSettings: notificationSettings,
        isInfoShared: isInfoShared,
        isChatEnabled: isChatEnabled,
        lastUpdateDate: DateTime.now(),
      );

      await storage.updateUser(updatedUser);

      // Update the state with new user data
      state = AsyncValue.data(updatedUser);

      // Cleanup temp files
      await ImageUtils.cleanupTempFiles();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Add method to refresh user data
  Future<void> refreshProfile() async {
    state = const AsyncValue.loading();
    try {
      final currentUser = state.valueOrNull;
      if (currentUser == null) {
        throw Exception('No user found');
      }

      final storage = ref.read(appUserStorageServiceProvider.notifier);
      final updatedUser = await storage.getUser(currentUser.id);

      if (updatedUser == null) {
        throw Exception('Failed to fetch user data');
      }

      state = AsyncValue.data(updatedUser);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Add method to delete profile image
  Future<void> deleteProfileImage() async {
    state = const AsyncValue.loading();
    try {
      final currentUser = state.valueOrNull;
      if (currentUser == null) {
        throw Exception('No user found');
      }

      final storage = ref.read(appUserStorageServiceProvider.notifier);
      await storage.deleteProfileImage(currentUser.id);

      // Refresh user data
      await refreshProfile();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Add method to delete background image
  Future<void> deleteProfileBackground() async {
    state = const AsyncValue.loading();
    try {
      final currentUser = state.valueOrNull;
      if (currentUser == null) {
        throw Exception('No user found');
      }

      final storage = ref.read(appUserStorageServiceProvider.notifier);
      await storage.deleteProfileBackground(currentUser.id);

      // Refresh user data
      await refreshProfile();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
