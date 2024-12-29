import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/auth/domain/app_user_payload.dart';
import 'package:social_app_2/src/features/services/logger.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/utils/notifier_mounted.dart';

part 'sign_in_screen_controller.g.dart';

@riverpod
class SignInScreenController extends _$SignInScreenController
    with NotifierMounted {
  @override
  FutureOr<void> build() async {
    ref.onDispose(setUnmounted);
    // no-op
  }

  final _log = getLogger('SignInController');

  Future<void> signInAnonymously() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInAnonymously);
  }

  Future<bool> loginWithGoogle() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    final value = await AsyncValue.guard(
      () async {
        await authRepository.signInWithGoogle();

        final user = ref.read(authRepositoryProvider).currentUser;

        if (user != null) {
          // await saveUserInfo(currentUser: user);
          await _handleUserAuthentication();
        }
      },
    );

    final success = state.hasError == false;
    if (mounted) {
      state = value;
      if (success == true) {
        // on success, go back to previous screen
        ref.read(goRouterProvider).pop();
      }
    }
    return success;
  }

  // Future<void> _authenticateWithGoogle() async {
  //   await ref.read(authRepositoryProvider).signInWithGoogle();

  //   final user = ref.read(authRepositoryProvider).currentUser;

  //   if (user != null) {
  //     await saveUserInfo(currentUser: user);
  //   }
  // }

  Future<bool> loginWithApple() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    final value = await AsyncValue.guard(
      () async {
        await authRepository.signInWithApple();

        final user = ref.read(authRepositoryProvider).currentUser;

        if (user != null) {
          // await saveUserInfo(currentUser: user);
          await _handleUserAuthentication();
        }
      },
    );

    final success = state.hasError == false;
    if (mounted) {
      state = value;
      if (success == true) {
        // on success, go back to previous screen
        ref.read(goRouterProvider).pop();
      }
    }
    return success;
  }

  // Future<void> saveUserInfo({required AppUser currentUser}) async {
  //   final appUserStorageService = ref.read(appUserStorageServiceProvider);
  //   await appUserStorageService.createAppUser(
  //     id: currentUser.id,
  //     appUser: currentUser,
  //   );
  // }

  Future<void> _handleUserAuthentication(
      {String? phoneNumber, String? displayName}) async {
    final authRepository = ref.read(authRepositoryProvider);
    final appUserStorageRepository = ref.read(appUserStorageServiceProvider);
    final currentUser = authRepository.currentUser;

    if (currentUser != null) {
      try {
        // Fetch the existing user data
        final existingUser =
            await appUserStorageRepository.fetchAppUser(currentUser.id);

        if (existingUser == null) {
          // Prepare the user data
          final userPayload = AppUserPayload(
            id: currentUser.id,
            email: currentUser.email,
            fullName: currentUser.displayName,
            photoUrl: currentUser.photoURL,
            providerId: currentUser.providerId,
            isEmailVerified: authRepository.isEmailVerified,
            lastLoginDate: DateTime.now().millisecondsSinceEpoch,
            phoneNumber: phoneNumber ?? existingUser?.phoneNumber,
          );
          // This is a new user, so we need to create a new document
          await appUserStorageRepository.createUser(payload: userPayload);
        } else {
          // Prepare the user data
          final userPayload = AppUserPayload(
            id: currentUser.id,
            email: currentUser.email,
            fullName: existingUser.displayName,
            photoUrl: existingUser.photoURL,
            providerId: currentUser.providerId,
            familyId: existingUser.familyId,
            isEmailVerified: authRepository.isEmailVerified,
            lastLoginDate: DateTime.now().millisecondsSinceEpoch,
            phoneNumber: phoneNumber ?? existingUser.phoneNumber,
            isAdmin: existingUser.isAdmin,
            isApproved: existingUser.isApproved,
            isChatEnabled: existingUser.isChatEnabled,
            isInfoShared: existingUser.isInfoShared,
            isPrimaryAccount: existingUser.isPrimaryAccount,
            primaryAccountEmail: existingUser.primaryAccountEmail,
            photoFileName: existingUser.photoFileName,
            profileBannerImageUrl: existingUser.profileBannerImageURL,
            street: existingUser.street,
            city: existingUser.city,
            state: existingUser.state,
            zip: existingUser.zip,
            country: existingUser.country,
            createDate: existingUser.createDate?.millisecondsSinceEpoch,
          );
          // This is an existing user, so we update the document
          await appUserStorageRepository.updateUser(
              id: currentUser.id, payload: userPayload);
        }

        // Initialize push notifications
        // await _initPushNotification(userId: currentUser.id);
      } catch (e) {
        _log.e('Error updating user data on authentication', error: e);
        // Handle the error appropriately
      }
    }
  }
}
