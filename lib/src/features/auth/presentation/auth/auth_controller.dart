import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/data/auth_service.dart';
import 'package:social_app_2/src/features/auth/data/firebase_auth_service.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/services/snackbar_service.dart';

part 'auth_controller.g.dart';

// @Riverpod(keepAlive: true)
// class AuthController extends _$AuthController {
//   AuthService get _auth => ref.watch(authServiceProvider);
//   StreamSubscription<AppUser?>? _userSubscription;
//   StreamSubscription<bool>? _emailVerificationSubscription;
//   bool _disposed = false;
//   bool _isReauthenticating = false;

//   // Add this getter for the router
//   bool get isReauthenticating => _isReauthenticating;

//   @override
//   FutureOr<AppUser?> build() async {
//     debugPrint('AuthController: Building...');

//     ref.onDispose(() {
//       _userSubscription?.cancel();
//       _disposed = true;
//       debugPrint('AuthController disposed');
//     });

//     try {
//       // Get initial user synchronously
//       final initialUser = await _auth.getCurrentUser();
//       debugPrint('AuthController: Got initial user: ${initialUser?.id}');

//       // Update state with initial user
//       if (!_disposed) {
//         state = AsyncData(initialUser);
//         debugPrint(
//             'AuthController: Set initial state with user: ${initialUser?.id}');
//       }

//       // Then set up listener for future changes
//       _setupUserListener();

//       return initialUser;
//     } catch (e, st) {
//       debugPrint('AuthController: Error in build: $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//       return null;
//     }
//   }

//   // Stream<AppUser?> get authStateChanges => _auth.authStateChanges;
//   // Stream<bool> get isEmailVerified => _auth.isEmailVerified;

//   void _setupUserListener() {
//     _userSubscription?.cancel();

//     debugPrint('AuthController: Setting up auth state listener');
//     _userSubscription = _auth.authStateChanges.listen(
//       (user) async {
//         debugPrint('Auth state changed - User: ${user?.id}');

//         if (_disposed) return;

//         try {
//           state = AsyncData(user);
//           debugPrint(
//               'AuthController: Updated state from listener: ${user?.id}');
//         } catch (e) {
//           debugPrint('AuthController: Error in auth state listener: $e');
//           if (!_disposed) {
//             state = AsyncError(e, StackTrace.current);
//           }
//         }
//       },
//       onError: (error) {
//         debugPrint('AuthController: Auth state listener error: $error');
//         // Don't update state on listener errors
//         if (!_disposed) {
//           state = AsyncError(error, StackTrace.current);
//         }
//       },
//     );
//   }

//   Future<void> syncAuthState() async {
//     try {
//       final user = await _auth.getCurrentUser();
//       if (!_disposed) return;

//       state = AsyncData(user);
//     } catch (e, st) {
//       debugPrint('AuthController: Error syncing auth state: $e');
//       state = AsyncError(e, st);
//     }
//   }

//   void clearError() {
//     if (state.hasError) {
//       state = AsyncValue.data(state.valueOrNull);
//     }
//   }

//   void _setupEmailVerificationListener() {
//     _emailVerificationSubscription?.cancel();
//     _emailVerificationSubscription = _auth.isEmailVerified.listen((isVerified) {
//       if (!_disposed && isVerified) {
//         reload();
//       }
//     });
//   }

//   Future<void> signInWithEmail(String email, String password) async {
//     debugPrint('AuthController: Attempting sign in...'); // Debug print
//     if (state.isLoading) return; // Prevent multiple calls while loading

//     try {
//       // state = const AsyncLoading();

//       // // 1. Sign in with Firebase Auth
//       // final userCredential = await _auth.signInWithEmailAndPassword(
//       //   email: email,
//       //   password: password,
//       // );
//       // debugPrint('AuthController: Sign in successful');
//       // // // Sync verification status if needed
//       // // if (userCredential.isEmailVerified && !state.value!.isEmailVerified) {
//       // //   debugPrint('Syncing email verification status during sign in');
//       // //   final updatedUser = userCredential.withEmailVerification(true);
//       // //   // state = AsyncData(updatedUser);
//       // //   if (!_disposed) {
//       // //     state = AsyncData(updatedUser);
//       // //   }
//       // // } else {
//       // //   // state = AsyncData(userCredential);
//       // //   if (!_disposed) {
//       // //     state = AsyncData(userCredential);
//       // //   }
//       // // }
//       // // Instead, just update state with the user
//       // // 2. Get Firebase Auth verification status
//       // final firebaseUser = FirebaseAuth.instance.currentUser;
//       // final isVerifiedInAuth = firebaseUser?.emailVerified ?? false;

//       // // 3. Get current user from Firestore
//       // if (userCredential.id != null) {
//       //   final userStorage = ref.read(appUserStorageServiceProvider);
//       //   final firestoreUser = await userStorage.getUser(userCredential.id);

//       //   // 4. Update Firestore if verification status differs
//       //   if (firestoreUser != null &&
//       //       isVerifiedInAuth &&
//       //       !firestoreUser.isEmailVerified) {
//       //     debugPrint(
//       //         'Updating email verification status in Firestore during sign in');
//       //     final updatedUser = firestoreUser.withEmailVerification(true);
//       //     await userStorage.updateUser(updatedUser);

//       //     if (!_disposed) {
//       //       state = AsyncData(updatedUser);
//       //     }
//       //   } else {
//       //     if (!_disposed) {
//       //       state = AsyncData(userCredential);
//       //     }
//       //   }
//       // }

//       debugPrint('AuthController: Starting email sign in process');
//       state = const AsyncLoading();

//       final user = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       if (!_disposed) {
//         debugPrint('AuthController: Sign in successful, updating state');
//         state = AsyncData(user);
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Sign in error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   Future<void> signUp({
//     required String email,
//     required String password,
//     required String displayName,
//     required String phoneNumber,
//   }) async {
//     try {
//       // Check providers before attempting sign up
//       final providers = await checkEmailProviders(email);
//       if (providers.isNotEmpty) {
//         throw Exception('Email already registered with other providers');
//       }

//       state = const AsyncValue.loading();
//       final user = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//         displayName: displayName,
//         phoneNumber: phoneNumber,
//       );

//       if (!_disposed) {
//         state = AsyncData(user);
//       }
//     } catch (e, st) {
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   // Update signOut to handle all providers
//   Future<void> signOut() async {
//     state = const AsyncValue.loading();
//     try {
//       await _auth.signOut();
//       if (!_disposed) {
//         state = const AsyncData(null);
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Sign out error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   Future<void> resetPassword(String email) async {
//     state = const AsyncValue.loading();

//     state = await AsyncValue.guard(() async {
//       await _auth.sendPasswordResetEmail(email);
//       // Add success message after successful operation
//       ref.read(snackBarControllerProvider.notifier).showSuccess(
//             'Password reset link sent to $email. Please check your email.',
//           );
//       return null;
//     });
//   }

//   Future<void> confirmPasswordReset({
//     required String code,
//     required String newPassword,
//   }) async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       await _auth.confirmPasswordReset(
//         code: code,
//         newPassword: newPassword,
//       );
//       return null;
//     });
//   }

//   Future<void> sendEmailVerification() async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       await _auth.sendEmailVerification();
//       return state.valueOrNull;
//     });
//   }

//   Future<void> reload() async {
//     if (_disposed) return;
//     // try {
//     //   state = const AsyncLoading();

//     //   // Reload Firebase Auth user
//     //   await _auth.reload();

//     //   // Get fresh user data
//     //   final user = await _auth.getCurrentUser();
//     //   if (user == null) {
//     //     state = const AsyncData(null);
//     //     return;
//     //   }

//     //   // Check if verification status needs to be synced
//     //   if (user.isEmailVerified && !state.value!.isEmailVerified) {
//     //     debugPrint('Syncing email verification status during reload');
//     //     final updatedUser = user.withEmailVerification(true);
//     //     state = AsyncData(updatedUser);
//     //   } else {
//     //     state = AsyncData(user);
//     //   }
//     // } catch (e, st) {
//     //   debugPrint('Error reloading user: $e');
//     //   state = AsyncError(e, st);
//     //   rethrow;
//     // }
//     // if (!_disposed) {
//     //   state = const AsyncLoading();
//     // }
//     state = const AsyncLoading();
//     try {
//       await _auth.reload();

//       if (!_disposed) {
//         // Get fresh user data after reload
//         final user = await _auth.getCurrentUser();
//         state = AsyncData(user);
//         // if (user != null) {
//         //   state = AsyncData(user);
//         // } else {
//         //   // Don't update state if user is null after reload
//         //   // This prevents unwanted redirects
//         //   debugPrint('User not found after reload, keeping current state');
//         // }
//       }
//     } catch (e) {
//       debugPrint('AuthController: Error reloading user: $e');
//       // if (!_disposed) {
//       //   state = AsyncError(e, StackTrace.current);
//       // }
//     }
//   }

//   Future<void> updateProfile({
//     String? displayName,
//     String? photoURL,
//   }) async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       await _auth.updateProfile(
//         displayName: displayName,
//         photoURL: photoURL,
//       );
//       return await _auth.getCurrentUser();
//     });
//   }

//   Future<void> updateEmail(String newEmail) async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       await _auth.updateEmail(newEmail);
//       return await _auth.getCurrentUser();
//     });
//   }

//   Future<void> updatePassword(String newPassword) async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       await _auth.updatePassword(newPassword);
//       return state.valueOrNull;
//     });
//   }

//   // Add method to handle verification status sync
//   Future<void> syncVerificationStatus() async {
//     try {
//       if (state.value == null) return;

//       // final currentUser = state.value!;
//       // Get latest status from Firebase Auth
//       await ref.read(authServiceProvider).reload();
//       final firebaseUser = FirebaseAuth.instance.currentUser;
//       if (firebaseUser == null) return;
//       final firebaseVerified = firebaseUser.emailVerified;
//       final currentUser = state.value!;

//       // Update state only if changed
//       if (firebaseVerified != currentUser.isEmailVerified) {
//         debugPrint(
//             'AuthController: Syncing verification status from Firebase Auth');
//         final updatedUser = currentUser.withEmailVerification(firebaseVerified);
//         state = AsyncData(updatedUser);
//       }
//     } catch (e, st) {
//       debugPrint(
//           'AuthController: Error syncing verification status: $e, StackTrace: $st');
//       // Don't update state for sync errors
//     }
//   }

//   // Future<void> signInWithSocialProvider(AppAuthProvider provider) async {
//   //   if (state.isLoading) return;
//   //   state = const AsyncValue.loading();
//   //   try {
//   //     AppUser user;
//   //     switch (provider) {
//   //       case AppAuthProvider.google:
//   //         user = await _auth.signInWithGoogle();
//   //         break;
//   //       case AppAuthProvider.apple:
//   //         user = await _auth.signInWithApple();
//   //         break;
//   //       default:
//   //         throw UnimplementedError('Provider not supported');
//   //     }
//   //     state = AsyncData(user);
//   //   } on FirebaseAuthException catch (e) {
//   //     state = AsyncError(_handleFirebaseError(e), StackTrace.current);
//   //   } catch (e, st) {
//   //     state = AsyncError(e, st);
//   //   }
//   // }
//   Future<void> signInWithSocialProvider(AppAuthProvider provider) async {
//     if (state.isLoading) return;
//     state = const AsyncValue.loading();

//     try {
//       debugPrint('Starting social sign in with: ${provider.name}');

//       // Get user info
//       final credential = await _getCredentialForProvider(provider);
//       final userInfo = await _auth.getUserInfoFromCredential(credential);

//       // Check for existing accounts
//       final existingProviders = await _auth.checkEmailProviders(userInfo.email);
//       if (existingProviders.isNotEmpty &&
//           !existingProviders.contains(provider)) {
//         // Set state to require merge confirmation
//         state = AsyncValue.data(MergeAccountRequest(
//           email: userInfo.email,
//           newProvider: provider,
//           existingProviders: existingProviders,
//         ));
//         return;
//       }

//       // Proceed with normal sign in
//       final user = await _signInWithProvider(provider);
//       state = AsyncData(user);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }

//   // Called after user confirms merge
//   Future<void> confirmAccountMerge(MergeAccountRequest request) async {
//     state = const AsyncLoading();
//     try {
//       final user = await _signInWithProvider(request.newProvider);
//       state = AsyncData(user);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }

//   // Add social sign-in methods
//   Future<void> signInWithGoogle() async {
//     if (state.isLoading) return;
//     state = const AsyncValue.loading();
//     try {
//       final user = await _auth.signInWithGoogle();
//       if (!_disposed) {
//         state = AsyncData(user);
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Google sign in error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   // Add social sign-in methods
//   Future<void> signInWithApple() async {
//     if (state.isLoading) return;
//     state = const AsyncValue.loading();

//     try {
//       final user = await _auth.signInWithApple();
//       if (!_disposed) {
//         state = AsyncData(user);
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Apple sign in error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   // Add provider linking methods
//   Future<void> linkProvider(AppAuthProvider provider) async {
//     if (state.isLoading) return;
//     state = const AsyncValue.loading();
//     try {
//       final user = await _auth.linkProvider(provider);
//       if (!_disposed) {
//         state = AsyncData(user);
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Provider linking error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   Future<void> unlinkProvider(AppAuthProvider provider) async {
//     if (state.isLoading) return;
//     state = const AsyncValue.loading();
//     try {
//       final currentUser = state.valueOrNull;
//       if (currentUser == null) {
//         throw Exception('No user is signed in');
//       }

//       // Prevent unlinking if it's the only provider
//       if (currentUser.linkedProviders.length <= 1) {
//         throw Exception('Cannot unlink the only authentication method');
//       }

//       final user = await _auth.unlinkProvider(provider);
//       if (!_disposed) {
//         state = AsyncData(user);
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Provider unlinking error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   Future<void> deleteAccount() async {
//     debugPrint('AuthController: Starting account deletion');
//     try {
//       state = const AsyncLoading();
//       await _auth.deleteAccount();
//       debugPrint('AuthController: Account deleted successfully');
//       state = const AsyncData(null);
//     } catch (e, st) {
//       debugPrint('AuthController: Error deleting account: $e');
//       state = AsyncError(e, st);
//       rethrow;
//     }
//   }

//   // Update other reauthentication methods similarly
//   Future<void> reauthenticateWithProvider(AppAuthProvider provider) async {
//     debugPrint('AuthController: Starting provider reauthentication');
//     try {
//       _isReauthenticating = true; // Set flag before authentication
//       await _reauthenticateWithProvider(provider);
//       debugPrint('AuthController: Reauthentication successful');
//     } catch (e) {
//       debugPrint('AuthController: Reauthentication failed: $e');
//       rethrow;
//     } finally {
//       _isReauthenticating = false; // Clear flag after authentication
//     }
//   }

//   // Future<void> reauthenticateWithPassword({
//   //   required String email,
//   //   required String password,
//   // }) async {

//   //   try {
//   //     state = const AsyncLoading();
//   //     await _auth.reauthenticateWithPassword(
//   //       email: email,
//   //       password: password,
//   //     );
//   //     // Don't update state on success to maintain current user
//   //   } catch (e) {
//   //     // Don't update error state, just rethrow for handling in UI
//   //     rethrow;
//   //   }
//   // }
//   Future<bool> reauthenticateWithPassword({
//     required String email,
//     required String password,
//   }) async {
//     debugPrint('Starting password reauthentication');
//     _isReauthenticating = true; // Set flag to prevent redirects

//     try {
//       await _auth.reauthenticateWithPassword(
//         email: email,
//         password: password,
//       );
//       debugPrint('Password reauthentication successful');
//       return true;
//     } catch (e) {
//       debugPrint('Password reauthentication failed: $e');
//       rethrow;
//     } finally {
//       _isReauthenticating = false; // Reset flag
//     }
//   }

//   Future<void> _reauthenticateWithProvider(AppAuthProvider provider) async {
//     switch (provider) {
//       case AppAuthProvider.google:
//         await _auth.reauthenticateWithGoogle();
//         break;
//       case AppAuthProvider.apple:
//         await _auth.reauthenticateWithApple();
//         break;
//       case AppAuthProvider.facebook:
//         // await _auth.reauthenticateWithFacebook();
//         break;
//       case AppAuthProvider.github:
//         // await _auth.reauthenticateWithGithub();
//         break;
//       case AppAuthProvider.email:
//         throw Exception('Email authentication requires email and password');
//     }
//   }

//   Future<List<AppAuthProvider>> checkEmailProviders(String email) async {
//     try {
//       debugPrint('Checking providers for email: $email');
//       final providers = await _auth.checkEmailProviders(email);
//       debugPrint('Found providers: $providers');
//       return providers;
//     } catch (e, st) {
//       debugPrint('Error checking providers: $e, $st');
//       // Don't update error state for validation checks
//       // state = AsyncError(e, st);
//       rethrow;
//     }
//   }

//   String _handleFirebaseError(FirebaseAuthException e) {
//     return switch (e.code) {
//       'account-exists-with-different-credential' =>
//         'An account already exists with this email. Try signing in with a different method.',
//       'popup-blocked' =>
//         'Sign in popup was blocked. Please allow popups and try again.',
//       'popup-closed-by-user' => 'Sign in was cancelled.',
//       'network-request-failed' =>
//         'Network error. Please check your connection.',
//       _ => e.message ?? 'An error occurred during sign in'
//     };
//   }
// }

// TODO: this is second attempt (remove if anything better or go back to previous one)

// @Riverpod(keepAlive: true)
// class AuthController extends _$AuthController {
//   AuthService get _auth => ref.watch(authServiceProvider);
//   AppUserStorageService get _storage =>
//       ref.watch(appUserStorageServiceProvider);
//   StreamSubscription<AppUser?>? _userSubscription;
//   StreamSubscription<bool>? _emailVerificationSubscription;
//   bool _disposed = false;
//   bool _isReauthenticating = false;

//   // Add this getter for the router
//   bool get isReauthenticating => _isReauthenticating;

//   @override
//   FutureOr<AuthResult?> build() async {
//     debugPrint('AuthController: Building...');

//     ref.onDispose(() {
//       _userSubscription?.cancel();
//       _disposed = true;
//       debugPrint('AuthController disposed');
//     });

//     try {
//       // Get initial user synchronously
//       final initialUser = await _auth.getCurrentUser();
//       debugPrint('AuthController: Got initial user: ${initialUser?.id}');

//       // Update state with initial user
//       if (!_disposed) {
//         if (initialUser != null) {
//           // return AuthUser(initialUser);
//           state = AsyncData(AuthUser(initialUser));
//         }
//         debugPrint(
//             'AuthController: Set initial state with user: ${initialUser?.id}');
//       }

//       // Then set up listener for future changes
//       _setupUserListener();
//       return initialUser != null ? AuthUser(initialUser) : null;
//     } catch (e, st) {
//       debugPrint('AuthController: Error in build: $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//       return null;
//     }
//   }

//   // Stream<AppUser?> get authStateChanges => _auth.authStateChanges;
//   // Stream<bool> get isEmailVerified => _auth.isEmailVerified;

//   void _setupUserListener() {
//     _userSubscription?.cancel();

//     debugPrint('AuthController: Setting up auth state listener');
//     _userSubscription = _auth.authStateChanges.listen(
//       (user) async {
//         debugPrint('Auth state changed - User: ${user?.id}');

//         if (_disposed) return;

//         try {
//           state = AsyncData(user != null ? AuthUser(user) : null);
//           debugPrint(
//               'AuthController: Updated state from listener: ${user?.id}');
//         } catch (e) {
//           debugPrint('AuthController: Error in auth state listener: $e');
//           if (!_disposed) {
//             state = AsyncError(e, StackTrace.current);
//           }
//         }
//       },
//       onError: (error) {
//         debugPrint('AuthController: Auth state listener error: $error');
//         // Don't update state on listener errors
//         if (!_disposed) {
//           state = AsyncError(error, StackTrace.current);
//         }
//       },
//     );
//   }

//   Future<void> syncAuthState() async {
//     try {
//       final user = await _auth.getCurrentUser();
//       if (!_disposed) return;

//       state = AsyncData(user != null ? AuthUser(user) : null);
//     } catch (e, st) {
//       debugPrint('AuthController: Error syncing auth state: $e');
//       state = AsyncError(e, st);
//     }
//   }

//   void clearError() {
//     if (state.hasError) {
//       state = AsyncValue.data(state.valueOrNull);
//     }
//   }

//   void _setupEmailVerificationListener() {
//     _emailVerificationSubscription?.cancel();
//     _emailVerificationSubscription = _auth.isEmailVerified.listen((isVerified) {
//       if (!_disposed && isVerified) {
//         reload();
//       }
//     });
//   }

//   Future<void> signInWithEmail(String email, String password) async {
//     debugPrint('AuthController: Attempting sign in...'); // Debug print
//     if (state.isLoading) return; // Prevent multiple calls while loading

//     try {
//       debugPrint('AuthController: Starting email sign in process');
//       state = const AsyncLoading();

//       final user = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       if (!_disposed) {
//         debugPrint('AuthController: Sign in successful, updating state');
//         state = AsyncData(AuthUser(user));
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Sign in error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   Future<void> signUp({
//     required String email,
//     required String password,
//     required String displayName,
//     required String phoneNumber,
//   }) async {
//     try {
//       // Check providers before attempting sign up
//       final providers = await checkEmailProviders(email);
//       if (providers.isNotEmpty) {
//         throw Exception('Email already registered with other providers');
//       }

//       state = const AsyncValue.loading();
//       final user = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//         displayName: displayName,
//         phoneNumber: phoneNumber,
//       );

//       if (!_disposed) {
//         state = AsyncData(AuthUser(user));
//       }
//     } catch (e, st) {
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   // Update signOut to handle all providers
//   Future<void> signOut() async {
//     state = const AsyncValue.loading();
//     try {
//       await _auth.signOut();
//       if (!_disposed) {
//         state = const AsyncData(null);
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Sign out error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   Future<void> resetPassword(String email) async {
//     state = const AsyncValue.loading();

//     state = await AsyncValue.guard(() async {
//       await _auth.sendPasswordResetEmail(email);
//       // Add success message after successful operation
//       ref.read(snackBarControllerProvider.notifier).showSuccess(
//             'Password reset link sent to $email. Please check your email.',
//           );
//       return null;
//     });
//   }

//   Future<void> confirmPasswordReset({
//     required String code,
//     required String newPassword,
//   }) async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       await _auth.confirmPasswordReset(
//         code: code,
//         newPassword: newPassword,
//       );
//       return null;
//     });
//   }

//   Future<void> sendEmailVerification() async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       await _auth.sendEmailVerification();
//       return state.valueOrNull;
//     });
//   }

//   Future<void> reload() async {
//     if (_disposed) return;

//     state = const AsyncLoading();
//     try {
//       await _auth.reload();

//       if (!_disposed) {
//         // Get fresh user data after reload
//         final user = await _auth.getCurrentUser();
//         state = AsyncData(user != null ? AuthUser(user) : null);
//       }
//     } catch (e) {
//       debugPrint('AuthController: Error reloading user: $e');
//     }
//   }

//   Future<void> updateProfile({
//     String? displayName,
//     String? photoURL,
//   }) async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       await _auth.updateProfile(
//         displayName: displayName,
//         photoURL: photoURL,
//       );
//       final user = await _auth.getCurrentUser();
//       return user != null ? AuthUser(user) : null;
//     });
//   }

//   Future<void> updateEmail(String newEmail) async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       await _auth.updateEmail(newEmail);
//       final user = await _auth.getCurrentUser();
//       return user != null ? AuthUser(user) : null;
//     });
//   }

//   Future<void> updatePassword(String newPassword) async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       await _auth.updatePassword(newPassword);
//       return state.valueOrNull;
//     });
//   }

//   // Add method to handle verification status sync
//   Future<void> syncVerificationStatus() async {
//     try {
//       if (state.value == null) return;

//       // Get latest status from Firebase Auth
//       await ref.read(authServiceProvider).reload();
//       final firebaseUser = FirebaseAuth.instance.currentUser;
//       if (firebaseUser == null) return;
//       final firebaseVerified = firebaseUser.emailVerified;
//       final currentUser = state.value! as AuthUser;

//       // Update state only if changed
//       if (firebaseVerified != currentUser.user.isEmailVerified) {
//         debugPrint(
//             'AuthController: Syncing verification status from Firebase Auth');
//         final updatedUser =
//             currentUser.user.withEmailVerification(firebaseVerified);
//         state = AsyncData(AuthUser(updatedUser));
//       }
//     } catch (e, st) {
//       debugPrint(
//           'AuthController: Error syncing verification status: $e, StackTrace: $st');
//       // Don't update state for sync errors
//     }
//   }

//   // Future<void> signInWithSocialProvider(AppAuthProvider provider) async {
//   //   if (state.isLoading) return;
//   //   state = const AsyncValue.loading();
//   //   try {
//   //     AppUser user;
//   //     switch (provider) {
//   //       case AppAuthProvider.google:
//   //         user = await _auth.signInWithGoogle();
//   //         break;
//   //       case AppAuthProvider.apple:
//   //         user = await _auth.signInWithApple();
//   //         break;
//   //       default:
//   //         throw UnimplementedError('Provider not supported');
//   //     }
//   //     state = AsyncData(user);
//   //   } on FirebaseAuthException catch (e) {
//   //     state = AsyncError(_handleFirebaseError(e), StackTrace.current);
//   //   } catch (e, st) {
//   //     state = AsyncError(e, st);
//   //   }
//   // }
//   Future<void> signInWithSocialProvider(AppAuthProvider provider) async {
//     if (state.isLoading) {
//       throw Exception(
//           'Authentication in progress'); // Or handle this case differently
//     }

//     state = const AsyncValue.loading();

//     try {
//       debugPrint('Starting social sign in with: ${provider.name}');

//       // Get credential first without signing in
//       final credential = await _auth.getProviderCredential(provider);
//       final firebaseUser = await _auth.signInWithCredential(credential);

//       if (firebaseUser == null) {
//         throw Exception('No user found after sign in');
//       }

//       final email = firebaseUser.email;
//       if (email == null) {
//         throw Exception('No email found for user');
//       }

//       // Check if email exists
//       final exists = await _storage.checkEmailExists(email);
//       if (exists) {
//         // Get linked providers for this email
//         final providers = await _auth.checkEmailProviders(email);

//         if (providers.isNotEmpty && !providers.contains(provider)) {
//           // Create MergeAccountInfo as AuthResult
//           final mergeInfo = MergeAccountInfo(
//             email: firebaseUser.email!,
//             newProvider: provider,
//             existingProviders: providers,
//           );

//           // Notify UI about merge need
//           // Cast is safe because MergeAccountInfo is a subtype of AuthResult
//           state = AsyncData<AuthResult?>(mergeInfo);
//           return;
//         }
//       }

//       final newUser = await _storage.getAppUser(firebaseUser.uid);

//       // No existing account or same provider, proceed with sign in
//       final appUser = await _storage.createOrUpdateSocialUser(
//         newUser!,
//         provider,
//       );

//       state = AsyncData(AuthUser(appUser));
//     } catch (e, st) {
//       state = AsyncError(e, st);
//       rethrow;
//     }
//   }

//   Future<void> confirmMerge(MergeAccountInfo mergeInfo) async {
//     state = const AsyncLoading();
//     try {
//       // Get credential again
//       final credential =
//           await _auth.getProviderCredential(mergeInfo.newProvider);
//       final firebaseUser = await _auth.signInWithCredential(credential);

//       if (firebaseUser == null) {
//         throw Exception('No user found during merge');
//       }

//       final newUser = await _storage.getAppUser(firebaseUser.uid);

//       // Merge accounts in storage
//       final mergedUser = await _storage.mergeAccounts(
//         newUser!,
//         mergeInfo.newProvider,
//       );

//       state = AsyncData(AuthUser(mergedUser));
//     } catch (e, st) {
//       state = AsyncError(e, st);
//       rethrow;
//     }
//   }

//   Future<AppUser> _signInWithProvider(AppAuthProvider provider) async {
//     switch (provider) {
//       case AppAuthProvider.google:
//         return await _auth.signInWithGoogle();
//       case AppAuthProvider.apple:
//         return await _auth.signInWithApple();
//       default:
//         throw UnimplementedError('Provider not supported');
//     }
//   }

//   // Future<OAuthCredential> _getCredentialForProvider(
//   //     AppAuthProvider provider) async {
//   //   try {
//   //     switch (provider) {
//   //       case AppAuthProvider.google:
//   //         return await _auth.getGoogleCredential();
//   //       case AppAuthProvider.apple:
//   //         return await _auth.getAppleCredential();
//   //       default:
//   //         throw UnimplementedError('Provider not supported');
//   //     }
//   //   } catch (e) {
//   //     debugPrint('Error getting credential: $e');
//   //     rethrow;
//   //   }
//   // }

//   // Future<String?> _getEmailFromCredential(
//   //   OAuthCredential credential,
//   //   AppAuthProvider provider,
//   // ) async {
//   //   try {
//   //     switch (provider) {
//   //       case AppAuthProvider.google:
//   //         final googleSignInInfo = await _auth.signInWithGoogle(credential);
//   //         return googleSignInInfo.email;
//   //       case AppAuthProvider.apple:
//   //         final appleSignInInfo = await _auth.getAppleSignInInfo(credential);
//   //         return appleSignInInfo.email;
//   //       default:
//   //         throw UnimplementedError('Provider not supported');
//   //     }
//   //   } catch (e) {
//   //     debugPrint('Error getting email: $e');
//   //     return null;
//   //   }
//   // }

//   // Add method to complete sign in after merge decision
//   Future<void> completeSocialSignIn(AppAuthProvider provider) async {
//     state = const AsyncValue.loading();
//     try {
//       final user = await _signInWithProvider(provider);
//       state = AsyncData(AuthUser(user));
//     } catch (e, st) {
//       state = AsyncError(e, st);
//       rethrow;
//     }
//   }

//   // Add social sign-in methods
//   Future<void> signInWithGoogle() async {
//     if (state.isLoading) return;
//     state = const AsyncValue.loading();
//     try {
//       final user = await _auth.signInWithGoogle();
//       if (!_disposed) {
//         state = AsyncData(AuthUser(user));
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Google sign in error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   // Add social sign-in methods
//   Future<void> signInWithApple() async {
//     if (state.isLoading) return;
//     state = const AsyncValue.loading();

//     try {
//       final user = await _auth.signInWithApple();
//       if (!_disposed) {
//         state = AsyncData(AuthUser(user));
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Apple sign in error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   // Add provider linking methods
//   Future<void> linkProvider(AppAuthProvider provider) async {
//     if (state.isLoading) return;
//     state = const AsyncValue.loading();
//     try {
//       final user = await _auth.linkProvider(provider);
//       if (!_disposed) {
//         state = AsyncData(AuthUser(user));
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Provider linking error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   Future<void> unlinkProvider(AppAuthProvider provider) async {
//     if (state.isLoading) return;
//     state = const AsyncValue.loading();
//     try {
//       final authUser = state.valueOrNull as AuthUser;
//       final currentUser = authUser.user;
//       if (currentUser == null) {
//         throw Exception('No user is signed in');
//       }

//       // Prevent unlinking if it's the only provider
//       if (currentUser.linkedProviders.length <= 1) {
//         throw Exception('Cannot unlink the only authentication method');
//       }

//       final user = await _auth.unlinkProvider(provider);
//       if (!_disposed) {
//         state = AsyncData(AuthUser(user));
//       }
//     } catch (e, st) {
//       debugPrint('AuthController: Provider unlinking error - $e');
//       if (!_disposed) {
//         state = AsyncError(e, st);
//       }
//     }
//   }

//   Future<void> deleteAccount() async {
//     debugPrint('AuthController: Starting account deletion');
//     try {
//       state = const AsyncLoading();
//       await _auth.deleteAccount();
//       debugPrint('AuthController: Account deleted successfully');
//       state = const AsyncData(null);
//     } catch (e, st) {
//       debugPrint('AuthController: Error deleting account: $e');
//       state = AsyncError(e, st);
//       rethrow;
//     }
//   }

//   // Update other reauthentication methods similarly
//   Future<void> reauthenticateWithProvider(AppAuthProvider provider) async {
//     debugPrint('AuthController: Starting provider reauthentication');
//     try {
//       _isReauthenticating = true; // Set flag before authentication
//       await _reauthenticateWithProvider(provider);
//       debugPrint('AuthController: Reauthentication successful');
//     } catch (e) {
//       debugPrint('AuthController: Reauthentication failed: $e');
//       rethrow;
//     } finally {
//       _isReauthenticating = false; // Clear flag after authentication
//     }
//   }

//   Future<bool> reauthenticateWithPassword({
//     required String email,
//     required String password,
//   }) async {
//     debugPrint('Starting password reauthentication');
//     _isReauthenticating = true; // Set flag to prevent redirects

//     try {
//       await _auth.reauthenticateWithPassword(
//         email: email,
//         password: password,
//       );
//       debugPrint('Password reauthentication successful');
//       return true;
//     } catch (e) {
//       debugPrint('Password reauthentication failed: $e');
//       rethrow;
//     } finally {
//       _isReauthenticating = false; // Reset flag
//     }
//   }

//   Future<void> _reauthenticateWithProvider(AppAuthProvider provider) async {
//     switch (provider) {
//       case AppAuthProvider.google:
//         await _auth.reauthenticateWithGoogle();
//         break;
//       case AppAuthProvider.apple:
//         await _auth.reauthenticateWithApple();
//         break;
//       case AppAuthProvider.facebook:
//         // await _auth.reauthenticateWithFacebook();
//         break;
//       case AppAuthProvider.github:
//         // await _auth.reauthenticateWithGithub();
//         break;
//       case AppAuthProvider.email:
//         throw Exception('Email authentication requires email and password');
//     }
//   }

//   Future<List<AppAuthProvider>> checkEmailProviders(String email) async {
//     try {
//       debugPrint('Checking providers for email: $email');
//       final providers = await _auth.checkEmailProviders(email);
//       debugPrint('Found providers: $providers');
//       return providers;
//     } catch (e, st) {
//       debugPrint('Error checking providers: $e, $st');
//       // Don't update error state for validation checks
//       // state = AsyncError(e, st);
//       rethrow;
//     }
//   }

//   String _handleFirebaseError(FirebaseAuthException e) {
//     return switch (e.code) {
//       'account-exists-with-different-credential' =>
//         'An account already exists with this email. Try signing in with a different method.',
//       'popup-blocked' =>
//         'Sign in popup was blocked. Please allow popups and try again.',
//       'popup-closed-by-user' => 'Sign in was cancelled.',
//       'network-request-failed' =>
//         'Network error. Please check your connection.',
//       _ => e.message ?? 'An error occurred during sign in'
//     };
//   }
// }

// @riverpod
// class DeletionState extends _$DeletionState {
//   @override
//   bool build() => false;

//   void setDeleting(bool isDeleting) => state = isDeleting;
// }

// // Optional: Add some extension methods for easier state handling
// extension AuthStateX on AsyncValue<AppUser?> {
//   bool get isAuthenticated => hasValue && value != null;
//   bool get isUnauthenticated => hasValue && value == null;
//   bool get isVerified => isAuthenticated && value!.isEmailVerified;
//   bool get isApproved => isAuthenticated && value!.isApproved;

//   // Add helper for providers
//   List<String> get linkedProviders =>
//       isAuthenticated ? value!.linkedProviders : const [];
//   AppAuthProvider get mainProvider =>
//       isAuthenticated ? value!.provider : AppAuthProvider.email;
// }

// // First, create a sealed class for auth states
// sealed class AuthResult {
//   const AuthResult();
// }

// class AuthUser extends AuthResult {
//   final AppUser user;
//   const AuthUser(this.user);
// }

// // Helper class for merge info
// class MergeAccountInfo extends AuthResult {
//   final String email;
//   final AppAuthProvider newProvider;
//   final List<AppAuthProvider> existingProviders;

//   MergeAccountInfo({
//     required this.email,
//     required this.newProvider,
//     required this.existingProviders,
//   });
// }

/// NOTE: 3rd Attempt

// First, create a sealed class for auth states
sealed class AuthResult {
  const AuthResult();
}

class AuthUser extends AuthResult {
  final AppUser user;
  const AuthUser(this.user);
}

// Helper class for merge info
class MergeAccountInfo extends AuthResult {
  final String email;
  final AppAuthProvider newProvider;
  final List<AppAuthProvider> existingProviders;

  MergeAccountInfo({
    required this.email,
    required this.newProvider,
    required this.existingProviders,
  });
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  // Service getters
  AuthService get _auth => ref.watch(authServiceProvider);
  AppUserStorageService get _storage =>
      ref.watch(appUserStorageServiceProvider);

  // Private fields
  StreamSubscription<AppUser?>? _userSubscription;
  StreamSubscription<bool>? _emailVerificationSubscription;
  bool _disposed = false;
  bool _isReauthenticating = false;

  // Public getters
  bool get isReauthenticating => _isReauthenticating;

  // Safe access to current user
  AppUser? get currentUser {
    final value = state.value;
    return value is AuthUser ? value.user : null;
  }

  // Helper method to safely update state
  void _updateState(AsyncValue<AuthResult?> newState) {
    if (!_disposed) {
      state = newState;
    }
  }

  @override
  FutureOr<AuthResult?> build() async {
    debugPrint('AuthController: Building...');

    // Setup cleanup
    ref.onDispose(() {
      _userSubscription?.cancel();
      _emailVerificationSubscription?.cancel();
      _disposed = true;
      debugPrint('AuthController disposed');
    });

    try {
      final initialUser = await _auth.getCurrentUser();
      debugPrint('AuthController: Got initial user: ${initialUser?.id}');

      _updateState(
          AsyncData(initialUser != null ? AuthUser(initialUser) : null));

      // Setup listeners
      _setupUserListener();
      _setupEmailVerificationListener();

      return initialUser != null ? AuthUser(initialUser) : null;
    } catch (e, st) {
      debugPrint('AuthController: Error in build: $e');
      _updateState(AsyncError(e, st));
      return null;
    }
  }

  // Listener setup methods
  void _setupUserListener() {
    // Cancel any previous stream
    _userSubscription?.cancel();

    debugPrint('AuthController: Setting up auth state listener');
    _userSubscription = _auth.authStateChanges.listen(
      (user) {
        debugPrint('AuthController: Auth state changed - User: ${user?.id}');
        _updateState(AsyncData(user != null ? AuthUser(user) : null));
      },
      onError: (error) {
        debugPrint('AuthController: Auth state listener error: $error');
        _updateState(AsyncError(error, StackTrace.current));
      },
    );
  }

  void _setupEmailVerificationListener() {
    // Cancel any previous stream
    _emailVerificationSubscription?.cancel();

    debugPrint('AuthController: Setting up email verification listener');
    _emailVerificationSubscription = _auth.isEmailVerified.listen((isVerified) {
      if (!_disposed && isVerified) {
        reload();
      }
    });
  }

  // State Synchronization
  Future<void> syncAuthState() async {
    try {
      final user = await _auth.getCurrentUser();
      if (_disposed) return;

      _updateState(AsyncData(user != null ? AuthUser(user) : null));
    } catch (e, st) {
      debugPrint('AuthController: Error syncing auth state: $e');
      _updateState(AsyncError(e, st));
    }
  }

  Future<void> syncVerificationStatus() async {
    try {
      if (currentUser == null) return;

      await _auth.reload();
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) return;

      final firebaseVerified = firebaseUser.emailVerified;
      final currentAuthState = state.value;

      if (currentAuthState is AuthUser) {
        final currentUser = currentAuthState.user;
        if (firebaseVerified != currentUser.isEmailVerified) {
          debugPrint('AuthController: Syncing verification status');
          final updatedUser =
              currentUser.withEmailVerification(firebaseVerified);
          _updateState(AsyncData(AuthUser(updatedUser)));
        }
      }
    } catch (e) {
      debugPrint('AuthController: Error syncing verification status: $e');
      // Don't update state for sync errors
    }
  }

  // Verification Methods
  Future<void> sendEmailVerification() async {
    _updateState(const AsyncLoading());
    try {
      await _auth.sendEmailVerification();
      _updateState(AsyncData(state.valueOrNull));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  Future<void> reload() async {
    if (_disposed) return;

    _updateState(const AsyncLoading());
    try {
      await _auth.reload();
      final user = await _auth.getCurrentUser();
      _updateState(AsyncData(user != null ? AuthUser(user) : null));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  // Authentication Methods
  Future<void> signInWithEmail(String email, String password) async {
    if (state.isLoading) return;

    _updateState(const AsyncLoading());
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _updateState(AsyncData(AuthUser(user)));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
  }) async {
    if (state.isLoading) return;

    _updateState(const AsyncLoading());
    try {
      // Check existing providers
      final providers = await checkEmailProviders(email);
      if (providers.isNotEmpty) {
        throw Exception('Email already registered with other providers');
      }

      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
        phoneNumber: phoneNumber,
      );
      _updateState(AsyncData(AuthUser(user)));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  // Social Authentication Methods
  Future<void> signInWithSocialProvider(AppAuthProvider provider) async {
    if (state.isLoading) {
      throw Exception('Authentication in progress');
    }

    _updateState(const AsyncLoading());
    try {
      final credential = await _auth.getProviderCredential(provider);
      final firebaseUser = await _auth.signInWithCredential(credential);

      if (firebaseUser == null) {
        throw Exception('No user found after sign in');
      }

      final email = firebaseUser.email;
      if (email == null) {
        throw Exception('No email found for user');
      }

      // Handle existing accounts
      final exists = await _storage.checkEmailExists(email);
      if (exists) {
        final providers = await _auth.checkEmailProviders(email);
        if (providers.isNotEmpty && !providers.contains(provider)) {
          _updateState(AsyncData(MergeAccountInfo(
            email: email,
            newProvider: provider,
            existingProviders: providers,
          )));
          return;
        }
      }

      final newUser = await _storage.getAppUser(firebaseUser.uid);
      final appUser =
          await _storage.createOrUpdateSocialUser(newUser!, provider);

      _updateState(AsyncData(AuthUser(appUser)));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  Future<void> signOut() async {
    _updateState(const AsyncLoading());
    try {
      await _auth.signOut();
      _updateState(const AsyncData(null));
    } catch (e, st) {
      debugPrint('AuthController: Sign out error - $e');
      _updateState(AsyncError(e, st));
    }
  }

  // Account Management Methods
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    _updateState(const AsyncLoading());
    try {
      await _auth.updateProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
      final user = await _auth.getCurrentUser();
      _updateState(AsyncData(user != null ? AuthUser(user) : null));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  Future<void> updateEmail(String newEmail) async {
    _updateState(const AsyncLoading());
    try {
      await _auth.updateEmail(newEmail);
      final user = await _auth.getCurrentUser();
      _updateState(AsyncData(user != null ? AuthUser(user) : null));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  Future<void> updatePassword(String newPassword) async {
    _updateState(const AsyncLoading());
    try {
      await _auth.updatePassword(newPassword);
      final user = await _auth.getCurrentUser();
      _updateState(AsyncData(user != null ? AuthUser(user) : null));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  // Password Reset Methods
  Future<void> resetPassword(String email) async {
    _updateState(const AsyncLoading());
    try {
      await _auth.sendPasswordResetEmail(email);
      ref.read(snackBarControllerProvider.notifier).showSuccess(
            'Password reset link sent to $email',
          );
      _updateState(const AsyncData(null));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    _updateState(const AsyncLoading());
    try {
      await _auth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      _updateState(const AsyncData(null));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  // Reauthentication Methods
  Future<bool> reauthenticateWithPassword({
    required String email,
    required String password,
  }) async {
    _isReauthenticating = true;
    try {
      await _auth.reauthenticateWithPassword(
        email: email,
        password: password,
      );
      return true;
    } finally {
      _isReauthenticating = false;
    }
  }

  Future<void> reauthenticateWithProvider(AppAuthProvider provider) async {
    _isReauthenticating = true;
    try {
      switch (provider) {
        case AppAuthProvider.google:
          await _auth.reauthenticateWithGoogle();
          break;
        case AppAuthProvider.apple:
          await _auth.reauthenticateWithApple();
          break;
        case AppAuthProvider.facebook:
          // await _auth.reauthenticateWithFacebook();
          break;
        case AppAuthProvider.github:
          // await _auth.reauthenticateWithGithub();
          break;
        case AppAuthProvider.email:
          throw Exception('Email authentication requires email and password');
      }
    } finally {
      _isReauthenticating = false;
    }
  }

  // Account Merging
  Future<void> confirmMerge(MergeAccountInfo mergeInfo) async {
    _updateState(const AsyncLoading());
    try {
      // Get new credential
      final credential =
          await _auth.getProviderCredential(mergeInfo.newProvider);
      final firebaseUser = await _auth.signInWithCredential(credential);

      if (firebaseUser == null) {
        throw Exception('No user found during merge');
      }

      final newUser = await _storage.getAppUser(firebaseUser.uid);
      if (newUser == null) {
        throw Exception('User data not found');
      }

      // Merge accounts in storage
      final mergedUser = await _storage.mergeAccounts(
        newUser,
        mergeInfo.newProvider,
      );

      _updateState(AsyncData(AuthUser(mergedUser)));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
      rethrow;
    }
  }

  //Social Sign in Completion
  Future<void> completeSocialSignIn(AppAuthProvider provider) async {
    _updateState(const AsyncLoading());
    try {
      final user = await _signInWithProvider(provider);
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  // Helper method for provider-specific sign in
  Future<AppUser> _signInWithProvider(AppAuthProvider provider) async {
    switch (provider) {
      case AppAuthProvider.google:
        return await _auth.signInWithGoogle();
      case AppAuthProvider.apple:
        return await _auth.signInWithApple();
      case AppAuthProvider.facebook:
        // TODO: Handle this case.
        throw UnimplementedError('Provider not supported');
      case AppAuthProvider.github:
        // TODO: Handle this case.
        throw UnimplementedError('Provider not supported');
      default:
        throw UnimplementedError('Provider not supported');
    }
  }

  // Provider Linking
  Future<void> linkProvider(AppAuthProvider provider) async {
    if (state.isLoading) return;

    _updateState(const AsyncLoading());
    try {
      final user = await _auth.linkProvider(provider);
      _updateState(AsyncData(AuthUser(user)));
    } catch (e, st) {
      debugPrint('AuthController: Provider linking error - $e');
      _updateState(AsyncError(e, st));
    }
  }

  Future<void> unlinkProvider(AppAuthProvider provider) async {
    if (state.isLoading) return;

    _updateState(const AsyncLoading());
    try {
      final authUser = currentUser;
      if (authUser == null) {
        throw Exception('No user is signed in');
      }

      // Prevent unlinking if it's the only provider
      if (authUser.linkedProviders.length <= 1) {
        throw Exception('Cannot unlink the only authentication method');
      }

      final user = await _auth.unlinkProvider(provider);
      _updateState(AsyncData(AuthUser(user)));
    } catch (e, st) {
      debugPrint('AuthController: Provider unlinking error - $e');
      _updateState(AsyncError(e, st));
    }
  }

  // Account Deletion
  Future<void> deleteAccount() async {
    _updateState(const AsyncLoading());
    try {
      await _auth.deleteAccount();
      _updateState(const AsyncData(null));
    } catch (e, st) {
      _updateState(AsyncError(e, st));
      rethrow;
    }
  }

  // Utility Methods
  Future<List<AppAuthProvider>> checkEmailProviders(String email) async {
    try {
      return await _auth.checkEmailProviders(email);
    } catch (e) {
      debugPrint('AuthController: Error checking providers: $e');
      rethrow;
    }
  }

  void clearError() {
    if (state.hasError) {
      _updateState(AsyncData(state.valueOrNull));
    }
  }

  // Error Handling Helper
  String _handleFirebaseError(FirebaseAuthException e) {
    return switch (e.code) {
      'account-exists-with-different-credential' =>
        'An account already exists with this email. Try signing in with a different method.',
      'popup-blocked' =>
        'Sign in popup was blocked. Please allow popups and try again.',
      'popup-closed-by-user' => 'Sign in was cancelled.',
      'network-request-failed' =>
        'Network error. Please check your connection.',
      _ => e.message ?? 'An error occurred during sign in'
    };
  }
}

// Helper to get currentUser
// Create a separate provider for currentUser
@riverpod
AppUser? currentUser(Ref ref) {
  final authState = ref.watch(authControllerProvider);
  return authState
      .whenData((result) => switch (result) {
            AuthUser(:final user) => user,
            _ => null,
          })
      .value;
}

@riverpod
bool isAuthenticated(Ref ref) {
  return ref.watch(currentUserProvider) != null;
}

@riverpod
bool isEmailVerified(Ref ref) {
  return ref.watch(currentUserProvider)?.isEmailVerified ?? false;
}

@riverpod
bool isApproved(Ref ref) {
  return ref.watch(currentUserProvider)?.isApproved ?? false;
}

@riverpod
bool isAdmin(Ref ref) {
  return ref.watch(currentUserProvider)?.isAdmin ?? false;
}

// Helper Classes and Extensions
@riverpod
class DeletionState extends _$DeletionState {
  @override
  bool build() => false;

  void setDeleting(bool isDeleting) => state = isDeleting;
}

extension AuthStateX on AsyncValue<AuthResult?> {
  bool get isAuthenticated => hasValue && value != null;
  bool get isUnauthenticated => hasValue && value == null;
  bool get isVerified =>
      isAuthenticated && (value as AuthUser).user.isEmailVerified;
  bool get isApproved => isAuthenticated && (value as AuthUser).user.isApproved;
  List<String> get linkedProviders =>
      isAuthenticated ? (value as AuthUser).user.linkedProviders : const [];
  AppAuthProvider get mainProvider => isAuthenticated
      ? (value as AuthUser).user.provider
      : AppAuthProvider.email;
}

// auth_providers.dart

// // 1. Core Authentication State
// @riverpod
// AppUser? currentUser(CurrentUserRef ref) {
//   return ref.watch(authControllerProvider).whenData((result) => 
//     switch (result) {
//       AuthUser(:final user) => user,
//       _ => null,
//     }
//   ).value;
// }

// // 2. Account Status Providers
// @riverpod
// bool isAuthenticated(IsAuthenticatedRef ref) {
//   return ref.watch(currentUserProvider) != null;
// }

// @riverpod
// bool isEmailVerified(IsEmailVerifiedRef ref) {
//   return ref.watch(currentUserProvider)?.isEmailVerified ?? false;
// }

// @riverpod
// bool isApproved(IsApprovedRef ref) {
//   return ref.watch(currentUserProvider)?.isApproved ?? false;
// }

// @riverpod
// bool isAdmin(IsAdminRef ref) {
//   return ref.watch(currentUserProvider)?.isAdmin ?? false;
// }

// @riverpod
// AccountStatus accountStatus(AccountStatusRef ref) {
//   return ref.watch(currentUserProvider)?.accountStatus ?? AccountStatus.inactive;
// }

// // 3. Account Type Providers
// @riverpod
// bool isPrimaryAccount(IsPrimaryAccountRef ref) {
//   return ref.watch(currentUserProvider)?.isPrimaryAccount ?? false;
// }

// @riverpod
// String? familyId(FamilyIdRef ref) {
//   return ref.watch(currentUserProvider)?.familyId;
// }

// // 4. Feature Access Providers
// @riverpod
// class UserFeatures extends _$UserFeatures {
//   @override
//   UserFeaturesState build() {
//     final user = ref.watch(currentUserProvider);
//     return UserFeaturesState(
//       isChatEnabled: user?.isChatEnabled ?? false,
//       isInfoShared: user?.isInfoShared ?? false,
//     );
//   }
// }

// // 5. Authentication Providers
// @riverpod
// class AuthenticationInfo extends _$AuthenticationInfo {
//   @override
//   AuthInfoState build() {
//     final user = ref.watch(currentUserProvider);
//     return AuthInfoState(
//       provider: user?.provider ?? AppAuthProvider.email,
//       linkedProviders: user?.linkedProviders ?? [],
//     );
//   }
// }

// // 6. User Settings Providers
// @riverpod
// class UserSettings extends _$UserSettings {
//   @override
//   UserSettingsState build() {
//     final user = ref.watch(currentUserProvider);
//     return UserSettingsState(
//       preferences: user?.preferences ?? const UserPreferences(),
//       notificationSettings: user?.notificationSettings ?? 
//           const NotificationSettings(),
//       privacySettings: user?.privacySettings ?? const PrivacySettings(),
//     );
//   }
// }

// // 7. User Profile Info
// @riverpod
// class UserProfile extends _$UserProfile {
//   @override
//   UserProfileState build() {
//     final user = ref.watch(currentUserProvider);
//     return UserProfileState(
//       displayName: user?.displayName ?? '',
//       email: user?.email ?? '',
//       phoneNumber: user?.phoneNumber,
//       profileImageURL: user?.profileImageURL,
//       profileBannerImageURL: user?.profileBannerImageURL,
//     );
//   }
// }

// // 8. User Address
// @riverpod
// class UserAddress extends _$UserAddress {
//   @override
//   UserAddressState build() {
//     final user = ref.watch(currentUserProvider);
//     return UserAddressState(
//       street: user?.street,
//       city: user?.city,
//       state: user?.addressState,
//       zip: user?.zip,
//       country: user?.country,
//     );
//   }
// }

// // State classes
// class UserFeaturesState {
//   final bool isChatEnabled;
//   final bool isInfoShared;
//   // ... other feature flags
  
//   const UserFeaturesState({
//     required this.isChatEnabled,
//     required this.isInfoShared,
//   });
// }

// class AuthInfoState {
//   final AppAuthProvider provider;
//   final List<String> linkedProviders;
  
//   const AuthInfoState({
//     required this.provider,
//     required this.linkedProviders,
//   });
// }

// class UserSettingsState {
//   final UserPreferences preferences;
//   final NotificationSettings notificationSettings;
//   final PrivacySettings privacySettings;
  
//   const UserSettingsState({
//     required this.preferences,
//     required this.notificationSettings,
//     required this.privacySettings,
//   });
// }

// // Usage example
// class UserProfileWidget extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final profile = ref.watch(userProfileProvider);
//     final features = ref.watch(userFeaturesProvider);
//     final settings = ref.watch(userSettingsProvider);
    
//     return Column(
//       children: [
//         if (features.isChatEnabled)
//           ChatWidget(),
//         UserSettingsSection(settings: settings),
//         // ... other UI elements
//       ],
//     );
//   }
// }