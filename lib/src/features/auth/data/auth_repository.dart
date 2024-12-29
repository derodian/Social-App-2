import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/data/firebase_auth_service.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';

part 'auth_repository.g.dart';

// abstract class AuthRepository {
//   AuthRepository({required FirebaseAuthService authService})
//       : _authService = authService;
//   final FirebaseAuthService _authService;

//   Future<void> signInAnonymously() {
//     return _authService.signInAnonymously();
//   }

//   Future<void> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) {
//     return _authService.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }

//   Future<void> createUserWithEmailAndPassword({
//     required String email,
//     required String password,
//     required String fullName,
//   }) async {
//     return _authService.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//       fullName: fullName,
//     );
//   }

//   Future<void> deleteUser({required AuthCredential credential}) {
//     return _authService.deleteUser(credential: credential);
//   }

//   Future<AuthCredential> getUserCredential({
//     required String email,
//     required String password,
//   }) async {
//     return _authService.getUserCredential(
//       email: email,
//       password: password,
//     );
//   }

//   Future<void> sendEmailVerification() {
//     return _authService.sendEmailVerification();
//   }

//   Future<void> sendPasswordResetEmail({required String toEmail}) {
//     return _authService.sendPasswordResetEmail(toEmail: toEmail);
//   }

//   Future<void> signInWithGoogle() {
//     return _authService.signInWithGoogle();
//   }

//   Future<AuthCredential> getCredentialFromGoogle() {
//     return _authService.getCredentialFromGoogle();
//   }

//   Future<void> signInWithApple() {
//     return _authService.signInWithApple();
//   }

//   Future<AuthCredential> getCredentialFromApple() async {
//     return _authService.getCredentialFromApple();
//   }

//   Future<void> signOut() {
//     return _authService.signOut();
//   }

//   /// Notifies about changes to the user's sign-in state (such as sign-in or sign-out)
//   Stream<AppUser?> authStateChanges() {
//     return _authService.authStateChanges();
//   }

//   /// Notifies about changes to the user's sign-in state (such as sign-in or sign-out) and also token refresh events.
//   Stream<AppUser?> idTokenChanges() {
//     return _authService.idTokenChanges();
//   }

//   AppUser? get currentUser => _authService.currentUser;

//   /// Notifies about changes to the email/user verification
//   bool get isEmailVerified => _authService.isEmailVerified;

//   // /// Helper method to convert a [User] to an [AppUser]
//   // AppUser? _convertUser(User? user) =>
//   //     user != null ? AppUser.fromFirebaseUser(user) : null;
// }

// @Riverpod(keepAlive: true)
// AuthRepository authRepository(Ref ref) {
//   return ref.read(firebaseAuthServiceProvider);
// }

// // * Using keepAlive since other providers need it to be an
// // * [AlwaysAliveProviderListenable]
// @Riverpod(keepAlive: true)
// Stream<AppUser?> authStateChanges(Ref ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return authRepository.authStateChanges();
// }

// @Riverpod(keepAlive: true)
// Stream<AppUser?> idTokenChanges(Ref ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return authRepository.idTokenChanges();
// }

// // @riverpod
// // FutureOr<bool> isCurrentUserAdmin(IsCurrentUserAdminRef ref) {
// //   final user = ref.watch(idTokenChangesProvider).value;
// //   if (user != null) {
// //     return user.isAdmin();
// //   } else {
// //     return false;
// //   }
// // }

abstract class AuthRepository {
  Future<void> signInAnonymously();
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  });
  Future<void> deleteUser({required AuthCredential credential});
  Future<AuthCredential> getUserCredential({
    required String email,
    required String password,
  });
  Future<void> sendEmailVerification();
  Future<void> sendPasswordResetEmail({required String toEmail});
  Future<void> signInWithGoogle();
  Future<AuthCredential> getCredentialFromGoogle();
  Future<void> signInWithApple();
  Future<AuthCredential> getCredentialFromApple();
  Future<void> signOut();
  Stream<AppUser?> authStateChanges();
  Stream<AppUser?> idTokenChanges();
  Stream<bool> isUserEmailVerified();
  AppUser? get currentUser;
  bool get isEmailVerified;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return ref.read(firebaseAuthServiceProvider);
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}

@Riverpod(keepAlive: true)
Stream<AppUser?> idTokenChanges(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.idTokenChanges();
}

@Riverpod(keepAlive: true)
Stream<bool> isUserEmailVerified(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.isUserEmailVerified();
}
