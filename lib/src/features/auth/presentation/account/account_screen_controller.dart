import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/utils/notifier_mounted.dart';

part 'account_screen_controller.g.dart';

@riverpod
class AccountScreenController extends _$AccountScreenController
    with NotifierMounted {
  final log = Logger();

  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // noting to do
  }

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }

  Future<void> deleteAppUser(AppUser appUser) async {
    // final imageUploadService = ref.read(imageUploadServiceProvider);
    // state = const AsyncLoading();
    // final value =
    //     await AsyncValue.guard(() => imageUploadService.deleteAppUser(appUser));
    // final success = value.hasError == false;
    // if (mounted) {
    //   state = value;
    //   if (success) {
    //     // on success, go back to previous screen
    //     ref.read(goRouterProvider).pop();
    //   }
    // }
  }

  // Future<bool> sendEmailVerification(AppUser user) async {
  //   state = const AsyncLoading();
  //   state = await AsyncValue.guard(() => user.sendEmailVerification());
  //   return state.hasError == false;
  // }

  // User Credentials
  Future<void> deleteUser({
    required AuthCredential credential,
    required String userId,
  }) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);

      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        await ref.read(appUserStorageServiceProvider).deleteUserData(userId);
        await authRepository.deleteUser(credential: credential);
      });
    } catch (e, st) {
      if (mounted) {
        state = AsyncError(e, st);
      }
    }
  }

  // Future<void> deleteUserFromApple(
  //     {required OAuthCredential credential}) async {
  //   try {
  //     state = const AsyncLoading();
  //     log.i(credential.providerId);

  //     await authService.deleteUserFromApple(credential);

  //     // authService.deleteUser().then((value) {
  //     //   return authService.signOut();
  //     // });
  //     await authService.signOut();
  //     // state = const AsyncData(null);
  //   } catch (e) {
  //     state = AsyncError(e);
  //     // rethrow;
  //   } finally {
  //     state = const AsyncData(null);
  //   }
  // }

  Future<AuthCredential?> getUserCredentialFromApple() async {
    // if (authService.currentUser != null) {
    //   // get credential from Apple
    //   log.i('getting credential from Apple');
    //   return await appleSignInService.getCredentialFromApple();
    // }
    // get credential from Apple
    try {
      log.i('getting credential from Apple');
      state = const AsyncLoading();
      final authRepository = ref.watch(authRepositoryProvider);
      return await authRepository.getCredentialFromApple();

      // state = const AsyncData(null);
    } catch (e, stacktrace) {
      state = AsyncError(e, stacktrace);
      // rethrow;
    } finally {
      state = const AsyncData(null);
    }
    // on FirebaseAuthException catch (e) {
    //   state = AsyncError(e.message!);
    //   return null;
    // } finally {
    //   state = const AsyncData(null);
    // }

    return null;
  }

  Future<AuthCredential?> getUserCredentialFromGoogle() async {
    try {
      log.i('getting credential from Google');
      state = const AsyncLoading();
      final authRepository = ref.watch(authRepositoryProvider);
      return await authRepository.getCredentialFromGoogle();

      // state = const AsyncData(null);
    } catch (e, stacktrace) {
      state = AsyncError(e, stacktrace);
      // rethrow;
    } finally {
      state = const AsyncData(null);
    }
    // on FirebaseAuthException catch (e) {
    //   state = AsyncError(e.message!);
    //   return null;
    // }
    // finally {
    //   state = const AsyncData(null);
    // }
    return null;
  }

  Future<AuthCredential?> getUserCredentialFromFirebase({
    required String email,
    required String password,
  }) async {
    // get credential from Firebase
    try {
      log.i('getting credential from Firebase');
      state = const AsyncLoading();
      log.i(email);
      final authRepository = ref.watch(authRepositoryProvider);
      return await authRepository.getUserCredential(
        email: email,
        password: password,
      );
      // state = const AsyncData(null);
    } catch (e, stacktrace) {
      state = AsyncError(e, stacktrace);
      // rethrow;
    } finally {
      state = const AsyncData(null);
    }
    return null;
  }
}
