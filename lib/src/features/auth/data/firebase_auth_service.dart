import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/constants/firebase_collection_name.dart';
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/data/apple_auth_service.dart';
import 'package:social_app_2/src/features/auth/data/auth_service.dart';
import 'package:social_app_2/src/features/auth/data/google_auth_service.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/domain/provider_data.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';

part 'firebase_auth_service.g.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuthService(this._auth, this._userStorage);

  final FirebaseAuth _auth;
  final AppUserStorageService _userStorage;

  // Add social auth service fields
  final GoogleAuthService _googleAuth = GoogleAuthService();
  final AppleAuthService _appleAuth = AppleAuthService();
  // final FacebookAuthService _facebookAuth = FacebookAuthService();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return _userStorage.getUser(user.uid);
  }

  @override
  Stream<AppUser?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      try {
        return await _userStorage.getUser(user.uid);
      } catch (e) {
        debugPrint('Error getting user data: $e');
        return null;
      }
    });
  }

  @override
  Stream<bool> get isEmailVerified {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return false;

      // Force refresh the token to get latest email verification status
      await firebaseUser.reload();
      final currentUser = _auth.currentUser!;

      // Get latest Firebase Auth status
      final isVerifiedInAuth = currentUser.emailVerified;

      // Update Firestore ONLY if there's mismatch
      final appUser = await _userStorage.getUser(currentUser.uid);
      if (appUser != null && appUser.isEmailVerified != isVerifiedInAuth) {
        final updatedUser = appUser.withEmailVerification(isVerifiedInAuth);
        await _userStorage.updateUser(updatedUser);
      }

      return isVerifiedInAuth;
    }).distinct();
  }

  @override
  Future<AppUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // final userCredential = await _auth.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // // final user = userCredential.user!;

      // // // Force sync verification status after sign-in
      // // await user.reload();
      // // final isVerifiedInAuth = user.emailVerified;

      // if (userCredential.user == null) {
      //   throw Exception('No user found after sign in');
      // }

      // // // Update last login
      // // // Get Firestore user
      // // final appUser = await _userStorage.getUser(user.uid);
      // // if (appUser == null) throw Exception('User data not found');

      // // // Update Firestore if needed
      // // if (appUser.isEmailVerified != isVerifiedInAuth) {
      // //   final updatedUser = appUser.withEmailVerification(isVerifiedInAuth);
      // //   await _userStorage.updateUser(updatedUser);
      // //   await _userStorage.updateLastLogin(appUser.id);
      // //   return updatedUser;
      // // }

      // // return appUser;

      // // Get user from Firestore with retry
      // AppUser? user;
      // int retryCount = 0;
      // while (user == null && retryCount < 3) {
      //   try {
      //     user = await _userStorage.getUser(userCredential.user!.uid);
      //     if (user == null) {
      //       retryCount++;
      //       await Future.delayed(Duration(milliseconds: 500 * retryCount));
      //     }
      //   } catch (e) {
      //     debugPrint('Error getting user data (attempt ${retryCount + 1}): $e');
      //     retryCount++;
      //     if (retryCount >= 3) rethrow;
      //     await Future.delayed(Duration(milliseconds: 500 * retryCount));
      //   }
      // }

      // if (user == null) {
      //   throw Exception('User data not found after multiple attempts');
      // }

      // // Update Firestore if needed
      // if (userCredential.user!.emailVerified && !user.isEmailVerified) {
      //   debugPrint('Updating email verification status in Firestore');
      //   user = user.withEmailVerification(true);
      //   await _userStorage.updateUser(user);
      // }

      // await _userStorage.updateLastLogin(user.id);
      // return user;
      debugPrint('Attempting sign in for email: $email');

      // 1. Sign in with Firebase Auth
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('No user found after sign in');
      }

      debugPrint(
          'Firebase Auth sign in successful for uid: ${userCredential.user!.uid}');

      // 2. Get Firestore user with retries
      AppUser? firestoreUser;
      int retries = 0;
      const maxRetries = 3;

      while (firestoreUser == null && retries < maxRetries) {
        try {
          firestoreUser = await _userStorage.getUser(userCredential.user!.uid);
          if (firestoreUser == null) {
            retries++;
            debugPrint(
                'User not found in Firestore, retry $retries of $maxRetries');
            await Future.delayed(Duration(milliseconds: 500 * retries));
          }
        } catch (e) {
          debugPrint('Error getting Firestore user (attempt $retries): $e');
          retries++;
          if (retries >= maxRetries) rethrow;
          await Future.delayed(Duration(milliseconds: 500 * retries));
        }
      }

      if (firestoreUser == null) {
        throw Exception('Failed to get user data after $maxRetries attempts');
      }

      // 3. Check and update email verification status
      if (userCredential.user!.emailVerified &&
          !firestoreUser.isEmailVerified) {
        debugPrint('Updating email verification status in Firestore');
        firestoreUser = firestoreUser.withEmailVerification(true);
        await _userStorage.updateUser(firestoreUser);
      }

      // 4. Update last login
      await _userStorage.updateLastLogin(firestoreUser.id);

      debugPrint('Sign in process completed successfully');
      return firestoreUser;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    String? phoneNumber,
  }) async {
    debugPrint('Starting sign up process');

    // First, check if email exists
    final exists = await _userStorage.checkEmailExists(email);
    if (exists) {
      throw Exception('An account with this email already exists');
    }

    UserCredential? userCredential;
    try {
      // Create Firebase Auth user
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Failed to create user');
      }

      debugPrint('Created auth user with ID: ${userCredential.user!.uid}');

      // Create AppUser
      final newUser = AppUser.create(
        id: userCredential.user!.uid,
        email: email,
        displayName: displayName,
        phoneNumber: phoneNumber,
      );

      debugPrint('Created AppUser object, saving to Firestore');

      // Save to Firestore
      await _userStorage.createUser(newUser);
      debugPrint('Successfully saved user to Firestore');

      // Send email verification
      await sendEmailVerification();

      return newUser;
    } catch (e) {
      debugPrint('Error in createUserWithEmailAndPassword: $e');

      // Clean up if user was created but Firestore failed
      if (userCredential?.user != null) {
        try {
          await userCredential!.user!.delete();
          debugPrint('Cleaned up Firebase Auth user after error');
        } catch (deleteError) {
          debugPrint('Error cleaning up Firebase Auth user: $deleteError');
        }
      }

      if (e is FirebaseAuthException) {
        throw _handleAuthException(e);
      }
      throw Exception('Failed to create account: ${e.toString()}');
    }
  }
  // Future<AppUser> createUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  //   required String displayName,
  //   String? phoneNumber,
  // }) async {
  //   try {
  //     debugPrint('Starting sign up process');
  //     final userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     if (userCredential.user == null) {
  //       throw Exception('Failed to create user');
  //     }

  //     debugPrint('Created auth user with ID: ${userCredential.user!.uid}');

  //     // Create AppUser
  //     final newUser = AppUser.create(
  //       id: userCredential.user!.uid,
  //       email: email,
  //       displayName: displayName,
  //       phoneNumber: phoneNumber,
  //     );

  //     // Save to storage
  //     // await _userStorage.createUser(newUser);
  //     debugPrint('Created AppUser object, attempting to save to Firestore');

  //     // Save to Firestore
  //     try {
  //       await _userStorage.createUser(newUser);
  //       debugPrint('Successfully saved user to Firestore');
  //     } catch (e) {
  //       debugPrint('Error saving user to Firestore: $e');
  //       // Clean up by deleting the auth user if Firestore save fails
  //       await userCredential.user!.delete();
  //       throw Exception('Failed to create user profile: $e');
  //     }

  //     // Send email verification
  //     await sendEmailVerification();

  //     return newUser;
  //   } on FirebaseAuthException catch (e) {
  //     throw _handleAuthException(e);
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  @override
  Future<List<AppAuthProvider>> checkEmailProviders(String email) async {
    try {
      debugPrint('Checking Firebase providers for: $email');
      // First check if email exists in Firestore
      final exists = await _userStorage.checkEmailExists(email);
      if (exists) {
        final methods = await _auth.fetchSignInMethodsForEmail(email);
        debugPrint('Firebase returned methods: $methods');

        final providers = methods
            .map((method) {
              switch (method) {
                case 'google.com':
                  return AppAuthProvider.google;
                case 'apple.com':
                  return AppAuthProvider.apple;
                case 'facebook.com':
                  return AppAuthProvider.facebook;
                case 'github.com':
                  return AppAuthProvider.github;
                case 'password':
                  return AppAuthProvider.email;
                default:
                  return null;
              }
            })
            .whereType<AppAuthProvider>()
            .toList();

        debugPrint('Converted to providers: $providers');
        return providers;
      }
      return [];
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('Unexpected error: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleAuth.signOut(),
      // _facebookAuth.signOut(),
      // Apple doesn't need sign out
    ]);
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user found');
    await user.sendEmailVerification();
  }

  // Add social sign-in methods
  @override
  Future<AuthCredential> getProviderCredential(AppAuthProvider provider) async {
    switch (provider) {
      case AppAuthProvider.google:
        return await _googleAuth.getCredential();
      case AppAuthProvider.apple:
        return await _appleAuth.getCredential();
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

  @override
  Future<User?> signInWithCredential(AuthCredential credential) async {
    try {
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw Exception('Failed to sign in with credential: $e');
    }
  }

  @override
  Future<AppUser> signInWithProvider(
      AppAuthProvider provider, AuthCredential credential) async {
    try {
      final userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user == null) {
        throw Exception('No user found after ${provider.name} sign in');
      }

      return _handleSocialSignIn(
        userCredential: userCredential,
        provider: provider,
        credential: credential,
      );
    } catch (e) {
      throw Exception('Failed to sign in with ${provider.name}: $e');
    }
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    try {
      final credential = await _googleAuth.getCredential();
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw Exception('No user found after Google sign in');
      }

      return await _handleSocialSignIn(
        userCredential: userCredential,
        provider: AppAuthProvider.google,
        credential: credential,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Failed to sign in with Google: ${e.toString()}');
    }
  }

  // Add social sign-in methods
  @override
  Future<AppUser> signInWithApple() async {
    try {
      final credential = await _appleAuth.getCredential();
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw Exception('No user found after Sing in with Apple');
      }

      return await _handleSocialSignIn(
        userCredential: userCredential,
        provider: AppAuthProvider.apple,
        credential: credential,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Failed to sign in with Apple: ${e.toString()}');
    }
  }

  // Convert Firebase user data to ProviderData
  ProviderData _createProviderData({
    required User firebaseUser,
    required AuthCredential credential,
    Map<String, dynamic>? additionalData,
  }) {
    return ProviderData(
      providerId: credential.providerId,
      uid: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      photoURL: firebaseUser.photoURL,
      email: firebaseUser.email,
      phoneNumber: firebaseUser.phoneNumber,
    );
  }

  // Helper method to handle social sign-in
  Future<AppUser> _handleSocialSignIn({
    required UserCredential userCredential,
    required AppAuthProvider provider,
    required AuthCredential credential,
  }) async {
    final firebaseUser = userCredential.user!;
    final userData = userCredential.additionalUserInfo?.profile;

    // Create ProviderData
    final providerData = _createProviderData(
      firebaseUser: firebaseUser,
      credential: credential,
      additionalData: userData,
    );

    // Check if user exists
    final existingUser = await _userStorage.getUser(firebaseUser.uid);

    if (existingUser != null) {
      // Update last login and return existing user
      final updatedUser = existingUser.mergeWithProviderData(providerData);
      await _userStorage.updateUser(updatedUser);
      await _userStorage.updateLastLogin(existingUser.id);
      // return existingUser;
      return updatedUser;
    }

    // Check if email exists with different account
    final emailExists =
        await _userStorage.checkEmailExists(firebaseUser.email!);
    if (emailExists) {
      // Show merge confirmation dialog through UI
      // This should be handled at the UI level through a callback
      // For now, proceed with merge
      final newUser = AppUser.fromSocialAuth(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        displayName:
            firebaseUser.displayName ?? firebaseUser.email!.split('@')[0],
        provider: provider,
        phoneNumber: firebaseUser.phoneNumber,
        profileImageURL: firebaseUser.photoURL,
        providerData: [providerData],
      );

      await _userStorage.createOrUpdateSocialUser(newUser, provider);
      return newUser;
    }

    // Create new user
    final newUser = AppUser.fromSocialAuth(
      id: firebaseUser.uid,
      email: firebaseUser.email!,
      displayName:
          firebaseUser.displayName ?? firebaseUser.email!.split('@')[0],
      provider: provider,
      phoneNumber: firebaseUser.phoneNumber,
      profileImageURL: firebaseUser.photoURL,
      providerData: [providerData],
    );

    // Save to storage
    await _userStorage.createUser(newUser);
    return newUser;
  }

  AppAuthProvider _getProviderFromCredential(AuthCredential credential) {
    return switch (credential.providerId) {
      'google.com' => AppAuthProvider.google,
      'apple.com' => AppAuthProvider.apple,
      'facebook.com' => AppAuthProvider.facebook,
      'github.com' => AppAuthProvider.github,
      _ => AppAuthProvider.email,
    };
  }

  // @override
  // Future<AppUser> getUserInfoFromCredential(OAuthCredential credential) async {
  //   try {
  //     final userCred = await _auth.signInWithCredential(credential);
  //     if (userCred.user == null) throw Exception('No user data found');

  //     // Create ProviderData
  //     final providerData = _createProviderData(
  //       firebaseUser: userCred.user!,
  //       credential: credential,
  //       additionalData: userCred.additionalUserInfo?.profile,
  //     );

  //     return AppUser.fromSocialAuth(
  //       id: userCred.user!.uid,
  //       email: userCred.user!.email ?? '',
  //       displayName: userCred.user!.displayName ??
  //           userCred.user!.email?.split('@')[0] ??
  //           '',
  //       provider: _getProviderFromCredential(credential),
  //       phoneNumber: userCred.user!.phoneNumber,
  //       profileImageURL: userCred.user!.photoURL,
  //       providerData: [providerData],
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     throw _handleAuthException(e);
  //   } catch (e) {
  //     throw Exception('Failed to sign in with Apple: ${e.toString()}');
  //   }
  // }

  @override
  Future<AppUser> linkProvider(AppAuthProvider provider) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user found');

      AuthCredential? credential;
      switch (provider) {
        case AppAuthProvider.google:
          credential = await _googleAuth.getCredential();
          break;
        case AppAuthProvider.apple:
          credential = await _appleAuth.getCredential();
          break;
        // case AppAuthProvider.facebook:
        //   credential = await _facebookAuth.getFacebookCredential();
        //   break;
        // case AppAuthProvider.github:
        //   credential = await _githubAuth.getGithubCredential();
        // break;
        default:
          throw Exception('Unsupported provider for linking');
      }

      final result = await user.linkWithCredential(credential);
      if (result.user == null) throw Exception('Failed to link provider');

      // Create ProviderData
      final providerData = _createProviderData(
        firebaseUser: result.user!,
        credential: credential,
        additionalData: result.additionalUserInfo?.profile,
      );

      // Get current user
      final currentUser = await _userStorage.getUser(result.user!.uid);
      if (currentUser == null) throw Exception('User not found in database');

      // Merge with new provider data
      final updatedUser = currentUser.mergeWithProviderData(providerData);

      // Update in storage
      await _userStorage.updateUser(updatedUser);

      return updatedUser;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<AppUser> unlinkProvider(AppAuthProvider provider) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user found');

      await user.unlink(provider.providerId);

      // Update user in Firestore
      final updatedUser = await _userStorage.unlinkProvider(
        user.uid,
        provider,
      );

      return updatedUser;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> reload() async {
    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser == null) throw Exception('No user found');

      debugPrint('Reloading user data for: ${firebaseUser.uid}');

      // Reload Firebase Auth user
      await firebaseUser.reload();

      // Get fresh Firebase Auth user after reload
      final freshUser = _auth.currentUser;
      if (freshUser == null) throw Exception('User not found after reload');
      // final isVerifiedInAuth = freshUser.emailVerified;

      // // Get current user from Firestore
      // final appUser = await _userStorage.getUser(freshUser.uid);

      // if (appUser == null) throw Exception('User not found in database');

      // debugPrint('Firebase Auth verified: ${freshUser.emailVerified}');
      // debugPrint('Firestore verified: ${appUser.isEmailVerified}');

      // // If verified in Firebase Auth but not in Firestore, update Firestore
      // if (appUser.isEmailVerified != isVerifiedInAuth) {
      //   debugPrint('Updating email verification status in Firestore');

      //   final updatedUser = appUser.withEmailVerification(isVerifiedInAuth);
      //   await _userStorage.updateUser(updatedUser);

      //   // Wait for Firestore write completion
      //   await FirebaseFirestore.instance
      //       .collection(FirebaseCollectionName.users)
      //       .doc(freshUser.uid)
      //       .snapshots()
      //       .firstWhere((doc) =>
      //           doc[FirestoreFieldName.isEmailVerified] == isVerifiedInAuth);

      //   debugPrint('Successfully updated email verification status');
      // }
      // Get user from Firestore with retries
      AppUser? firestoreUser;
      int retries = 0;
      const maxRetries = 3;

      while (firestoreUser == null && retries < maxRetries) {
        try {
          firestoreUser = await _userStorage.getUser(freshUser.uid);
          if (firestoreUser == null) {
            retries++;
            debugPrint('Retrying Firestore fetch (attempt $retries)');
            await Future.delayed(Duration(milliseconds: 500 * retries));
          }
        } catch (e) {
          debugPrint('Error fetching from Firestore (attempt $retries): $e');
          retries++;
          if (retries >= maxRetries) rethrow;
          await Future.delayed(Duration(milliseconds: 500 * retries));
        }
      }

      if (firestoreUser == null) {
        throw Exception('User data not found after multiple attempts');
      }

      // Check and update verification status
      if (freshUser.emailVerified && !firestoreUser.isEmailVerified) {
        debugPrint('Updating email verification status in Firestore');
        final updatedUser = firestoreUser.withEmailVerification(true);
        await _userStorage.updateUser(updatedUser);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth error during reload: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('Error during reload: $e');
      throw Exception('Failed to reload user: $e');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    try {
      await _auth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user found');
      await user.verifyBeforeUpdateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user found');
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user found');
      await user.updateDisplayName(displayName);
      await user.updatePhotoURL(photoURL);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user found');

      // Delete storage files first
      await _userStorage.deleteAllUserImages(user.uid);

      // First delete from Firestore
      await _userStorage.deleteUser(user.uid);

      // Then delete the Firebase Auth account
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  // Add to existing reauthenticate method
  @override
  Future<void> reauthenticateWithCredential(AuthCredential credential) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user found');
      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> reauthenticateWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user found');

      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> reauthenticateWithGoogle() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user found');

      final credential = await _googleAuth.getCredential();
      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Failed to reauthenticate with Google: $e');
    }
  }

  @override
  Future<void> reauthenticateWithApple() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user found');

      final credential = await _appleAuth.getCredential();
      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Failed to reauthenticate with Apple: $e');
    }
  }

  // @override
  // Future<void> reauthenticateWithFacebook() async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user == null) throw Exception('No user found');

  //     final credential = await _facebookAuth.getFacebookCredential();
  //     await user.reauthenticateWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     throw _handleAuthException(e);
  //   } catch (e) {
  //     throw Exception('Failed to reauthenticate with Facebook: $e');
  //   }
  // }

  // @override
  // Future<void> reauthenticateWithGithub() async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user == null) throw Exception('No user found');

  //     final credential = await _githubAuth.getGithubCredential();
  //     await user.reauthenticateWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     throw _handleAuthException(e);
  //   } catch (e) {
  //     throw Exception('Failed to reauthenticate with Github: $e');
  //   }
  // }

  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found with this email');
      case 'wrong-password':
        return Exception('Incorrect password');
      case 'invalid-email':
        return Exception('Invalid email format');
      case 'user-disabled':
        return Exception('This account has been disabled');
      case 'too-many-requests':
        return Exception('Too many attempts. Please try again later');
      case 'email-already-in-use':
        return Exception('An account already exists with this email');
      case 'weak-password':
        return Exception('Password is too weak');
      case 'invalid-credential':
        return Exception('Invalid email or password');
      case 'network-request-failed':
        return Exception('Network error. Please check your connection');
      case 'invalid-verification-code':
        return Exception('Invalid verification code');
      case 'invalid-verification-id':
        return Exception('Invalid verification ID');
      case 'requires-recent-login':
        return Exception('Please sign in again to complete this action');
      case 'account-exists-with-different-credential':
        return Exception(
            'An account already exists with the same email address but different sign-in credentials');
      case 'operation-not-allowed':
        return Exception('This sign-in provider is not enabled');
      case 'popup-blocked':
        return Exception('The popup was blocked by the browser');
      case 'popup-closed-by-user':
        return Exception(
            'The popup was closed by the user before finalizing the sign-in');
      case 'provider-already-linked':
        return Exception('This provider is already linked to your account');
      case 'no-such-provider':
        return Exception('This provider is not linked to your account');
      case 'credential-already-in-use':
        return Exception('This account is already linked to another user');
      default:
        return Exception(e.message ?? 'An unknown error occurred');
    }
  }

  @override
  Stream<AppUser?> idTokenChanges() {
    // TODO: implement idTokenChanges
    throw UnimplementedError();
  }

  @override
  Future<AppUser> signInAnonymously() {
    // TODO: implement signInAnonymously
    throw UnimplementedError();
  }
}

// Add provider ID extension
extension AppAuthProviderX on AppAuthProvider {
  String get providerId {
    switch (this) {
      case AppAuthProvider.google:
        return 'google.com';
      case AppAuthProvider.apple:
        return 'apple.com';
      case AppAuthProvider.facebook:
        return 'facebook.com';
      case AppAuthProvider.github:
        return 'github.com';
      case AppAuthProvider.email:
        return 'password';
    }
  }
}

@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@riverpod
AuthService authService(Ref ref) {
  return FirebaseAuthService(
    ref.watch(firebaseAuthProvider),
    ref.watch(appUserStorageServiceProvider),
  );
}
