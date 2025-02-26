import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';

abstract class AuthService {
  // Current user getters
  User? get currentUser;
  Future<AppUser?> getCurrentUser();
  Stream<AppUser?> get authStateChanges;
  Stream<bool> get isEmailVerified;

  // Authentication methods
  Future<AppUser> signInAnonymously();
  Future<AppUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<AppUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
  });
  Future<void> signOut();

  // Email verification
  Future<void> sendEmailVerification();
  Future<void> reload();

  // Password reset
  Future<void> sendPasswordResetEmail(String email);
  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  });

  // Update profile
  Future<void> updateEmail(String newEmail);
  Future<void> updatePassword(String newPassword);
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  });

  // Social authentication
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithApple();
  // Future<AppUser> signInWithFacebook();
  // Future<AppUser> signInWithGithub();
  Future<AuthCredential> getProviderCredential(AppAuthProvider provider);
  Future<User?> signInWithCredential(AuthCredential credential);
  Future<AppUser> signInWithProvider(
      AppAuthProvider provider, AuthCredential credential);

  Future<List<AppAuthProvider>> checkEmailProviders(String email);
  // Future<AppUser> getUserInfoFromCredential(OAuthCredential credential);

  // Delete account
  Future<void> deleteAccount();

  // Reauthentication methods
  Future<void> reauthenticateWithPassword({
    required String email,
    required String password,
  });
  Future<void> reauthenticateWithGoogle();
  Future<void> reauthenticateWithApple();
  // Future<void> reauthenticateWithFacebook();
  // Future<void> reauthenticateWithGithub();

  // Generic credential reauthentication
  Future<void> reauthenticateWithCredential(AuthCredential credential);

  // Provider linking methods
  Future<AppUser> linkProvider(AppAuthProvider provider);
  Future<AppUser> unlinkProvider(AppAuthProvider provider);

  Stream<AppUser?> idTokenChanges();
}
