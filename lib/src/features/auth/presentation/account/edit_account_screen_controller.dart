import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/constants/firebase_collection_name.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/domain/app_user_payload.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/utils/notifier_mounted.dart';

part 'edit_account_screen_controller.g.dart';

@riverpod
class EditAccountScreenController extends _$EditAccountScreenController
    with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // noting to do
  }

  // Future<bool> updateAppUser({
  //   required AppUser appUser,
  //   required String displayName,
  //   String? userPhoneNumber,
  //   String? userStreet,
  //   String? userCity,
  //   String? userState,
  //   String? userZip,
  //   String? userCountry,
  //   bool? isInfoShared,
  // }) async {
  //   final appUserStorageService = ref.read(appUserStorageServiceProvider);
  //   // Parse the input values (already pre-validated) if any
  //   // for example
  //   // final priceValue = double.parse(price).

  //   // Update appUser metadata (keep the pre-existing values)
  //   final updatedAppUser = appUser.copyWith(
  //     fullName: displayName,
  //     phoneNumber: userPhoneNumber,
  //     street: userStreet,
  //     city: userCity,
  //     state: userState,
  //     zip: userZip,
  //     country: userCountry,
  //     isInfoShared: isInfoShared,
  //   );
  //   state = const AsyncLoading();
  //   final value = await AsyncValue.guard(
  //       () => appUserStorageService.updateAppUser(appUser: updatedAppUser));
  //   final success = value.hasError == false;
  //   if (mounted) {
  //     state = value;
  //     if (success) {
  //       // on success, go back to previous screen
  //       ref.read(goRouterProvider).pop();
  //     }
  //   }
  //   return success;
  // }

  // Future<void> deleteAppUser(AppUser appUser) async {
  //   final imageUploadService = ref.read(imageUploadServiceProvider);
  //   state = const AsyncLoading();
  //   final value =
  //       await AsyncValue.guard(() => imageUploadService.deleteAppUser(appUser));
  //   final success = value.hasError == false;
  //   if (mounted) {
  //     state = value;
  //     if (success) {
  //       // on success, go back to previous screen
  //       ref.read(goRouterProvider).pop();
  //     }
  //   }
  // }

  final log = Logger();

  Future<void> saveUser({
    required AppUser user,
    String? profileImageURL,
    String? profileBannerImageURL,
  }) async {
    try {
      log.i("BANNER_IMAGE_URL: $profileBannerImageURL");
      final appUserStorageRepository = ref.read(appUserStorageServiceProvider);

      final payload = AppUserPayload(
        id: user.id,
        email: user.email,
        fullName: user.displayName,
        phoneNumber: user.phoneNumber,
        providerId: user.providerId,
        isEmailVerified: user.isEmailVerified,
        lastLoginDate: user.lastLoginDate?.millisecondsSinceEpoch,
        createDate: user.createDate?.millisecondsSinceEpoch,
        updateDate: DateTime.now().millisecondsSinceEpoch,
        photoUrl: profileImageURL ?? user.photoURL,
        photoFileName: '${user.id}_profile_image',
        profileBannerImageUrl:
            profileBannerImageURL ?? user.profileBannerImageURL,
        isApproved: user.isApproved,
        isAdmin: user.isAdmin,
        isInfoShared: user.isInfoShared,
        isChatEnabled: user.isChatEnabled,
        isPrimaryAccount: user.isPrimaryAccount,
        primaryAccountEmail: user.isPrimaryAccount == true ? user.email : '',
        street: user.street,
        city: user.city,
        state: user.state,
        zip: user.zip,
        country: user.country,
      );

      await appUserStorageRepository.createOrUpdateAppUser(
          id: user.id, payload: payload);
    } catch (e) {
      log.e(e);
    }
  }

  Future<bool> uploadImageAndSaveUserInfo({
    required AppUser user,
    File? profileImageFile,
    File? profileBannerImageFile,
  }) async {
    try {
      state = const AsyncLoading();

      String? profileImageUrl =
          await uploadImage(profileImageFile, '${user.id}_profile_image');
      String? profileBannerImageUrl = await uploadImage(
          profileBannerImageFile, '${user.id}_profile_banner_image');

      //3. Save user data to firestore
      final value = await AsyncValue.guard(() => saveUser(
            user: user,
            profileImageURL: profileImageUrl,
            profileBannerImageURL: profileBannerImageUrl,
          ));
      final success = value.hasError == false;
      if (mounted) {
        // * only set the state if the controller hasn't been disposed
        state = value;
        if (success) {
          //3. delete local file as no longer needed
          if (profileImageFile != null) {
            await profileImageFile.delete();
          }
          if (profileBannerImageFile != null) {
            await profileBannerImageFile.delete();
          }
        }
      }

      return success;
    } catch (e, stacktrace) {
      state = AsyncError(e.toString(), stacktrace);
      // _profileImageFile = null;
      rethrow;
    } finally {
      state = const AsyncData(null);
    }
  }

  Future<String?> uploadImage(File? file, String path) async {
    if (file == null) return null;
    var ref = FirebaseStorage.instance
        .ref()
        .child(FirebaseCollectionName.users)
        .child(path);
    await ref.putFile(file);
    return ref.getDownloadURL();
  }
}
