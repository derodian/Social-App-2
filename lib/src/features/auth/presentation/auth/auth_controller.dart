import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/data/auth_service.dart';
import 'package:social_app_2/src/features/auth/data/firebase_auth_service.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/push_notification/data/notification_permission_manager.dart';
import 'package:social_app_2/src/features/services/snackbar_service.dart';

part 'auth_controller.g.dart';

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
      await _saveCurrentUserIdToPrefs(user.id); // Save user ID to prefs
      _updateState(AsyncData(AuthUser(user)));
      // TODO: comment bottom line after testing
      // await resetNotificationPermissionTimestamp();
      // await forceRequestNotificationPermission();
      // Request notifications after sign-in
      await requestNotificationPermission();
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
      await _saveCurrentUserIdToPrefs(user.id); // Save user ID to prefs
      _updateState(AsyncData(AuthUser(user)));
      // Request notifications after sign-up
      await requestNotificationPermission();
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

      await _saveCurrentUserIdToPrefs(appUser.id); // Save user ID to prefs

      _updateState(AsyncData(AuthUser(appUser)));
      // Request notifications after social sign-in
      await requestNotificationPermission();
    } catch (e, st) {
      _updateState(AsyncError(e, st));
    }
  }

  Future<void> signOut() async {
    _updateState(const AsyncLoading());
    try {
      await _auth.signOut();
      // Clear user ID from preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('current_user_id');
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

  // Push Notification
  Future<void> requestNotificationPermission() async {
    if (currentUser == null) return;

    try {
      final permissionManager = ref.read(notificationPermissionManagerProvider);
      final granted =
          await permissionManager.requestPermissionAfterSignIn(currentUser!.id);

      if (granted) {
        debugPrint(
            'Notification permission granted for user: ${currentUser!.id}');
      } else {
        debugPrint('Notification permission denied by user');
      }
    } catch (e) {
      debugPrint('Error requesting notification permission: $e');
    }
  }

  Future<void> forceRequestNotificationPermission() async {
    if (currentUser == null) return;

    try {
      final permissionManager = ref.read(notificationPermissionManagerProvider);
      final granted =
          await permissionManager.forceRequestPermission(currentUser!.id);

      if (granted) {
        debugPrint(
            'Notification permission granted for user: ${currentUser!.id}');
      } else {
        debugPrint('Notification permission denied by user');
      }
    } catch (e) {
      debugPrint('Error requesting notification permission: $e');
    }
  }

  // Add this to your AuthController after successful sign-in
  Future<void> resetNotificationPermissionTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_notification_permission_request');
    debugPrint('Reset notification permission timestamp');
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

  // Store user info in SharedPreferences
  Future<void> _saveCurrentUserIdToPrefs(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user_id', userId);
      debugPrint('Saved current user ID to SharedPreferences: $userId');
    } catch (e) {
      debugPrint('Error saving user ID to preferences: $e');
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