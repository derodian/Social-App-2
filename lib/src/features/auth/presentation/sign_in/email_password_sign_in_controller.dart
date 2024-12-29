import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/domain/app_user_payload.dart';
import 'package:social_app_2/src/features/auth/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:social_app_2/src/features/services/logger.dart';

part 'email_password_sign_in_controller.g.dart';

@riverpod
class EmailPasswordSignInController extends _$EmailPasswordSignInController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  final _log = getLogger('SignInController');

  Future<bool> submit({
    required String email,
    required String password,
    String? fullName,
    required EmailPasswordSignInFormType formType,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authenticate(
          email: email,
          password: password,
          fullName: fullName,
          formType: formType,
        ));
    return state.hasError == false;
  }

  Future<void> _authenticate({
    required String email,
    required String password,
    String? fullName,
    required EmailPasswordSignInFormType formType,
  }) {
    final authRepository = ref.read(authRepositoryProvider);
    switch (formType) {
      case EmailPasswordSignInFormType.signIn:
        return signInAndSaveUserInfo(email: email, password: password);

      case EmailPasswordSignInFormType.register:
        return registerAndSaveUserInfo(
          email: email,
          password: password,
          fullName: fullName!,
        );
      case EmailPasswordSignInFormType.forgotPassword:
        return authRepository.sendPasswordResetEmail(toEmail: email);
    }
  }

  Future<void> registerAndSaveUserInfo({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.createUserWithEmailAndPassword(
      email: email,
      password: password,
      fullName: fullName,
    );
    final currentUser = authRepository.currentUser;
    if (currentUser != null) {
      await _handleUserAuthentication();
    }
  }

  Future<void> signInAndSaveUserInfo({
    required String email,
    required String password,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final currentUser = authRepository.currentUser;
    // final currentUser = ref.watch(appUserFutureProvider(userId!)).value;
    if (currentUser != null) {
      await _handleUserAuthentication();
    }
  }

  // Future<void> saveUserInfo({required AppUser currentUser}) async {
  //   final appUserStorageService = ref.read(appUserStorageServiceProvider);
  //   await appUserStorageService.createOrUpdateAppUser(
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

  // Future<void> _initPushNotification({required String userId}) async {
  //   final userData =
  //       await ref.read(appUserStorageServiceProvider).fetchAppUser(userId);
  //   final pushNotificationService = ref.watch(pushNotificationServiceProvider);
  //   await pushNotificationService.initPushNotification(
  //     userId: userId,
  //     isUserAdmin: userData?.isAdmin ?? false,
  //   );
  // }

  Future<void> _saveOrUpdateUserInfo(
      {required AppUser user, String? phoneNumber}) async {
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
