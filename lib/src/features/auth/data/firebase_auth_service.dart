import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/global_firebase_options.dart';
import 'package:social_app_2/src/features/auth/constants/auth_constants.dart';
import 'package:social_app_2/src/features/auth/data/apple_sign_in_service.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';

part 'firebase_auth_service.g.dart';

class FirebaseAuthService implements AuthRepository {
  const FirebaseAuthService(this._firebaseAuth, this.ref);
  final FirebaseAuth _firebaseAuth;
  final Ref ref;

  // getters
  bool get isAlreadyLoggedIn => userId != null;
  UserID? get userId => FirebaseAuth.instance.currentUser?.uid;
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  /// Notifies about changes to the user's sign-in state (such as sign-in or
  /// sign-out).
  @override
  Stream<AppUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map(_convertUser);
  }

  /// Notifies about changes to the user's sign-in state (such as sign-in or
  /// sign-out) and also token refresh events.
  @override
  Stream<AppUser?> idTokenChanges() {
    return _firebaseAuth.idTokenChanges().map(_convertUser);
  }

  @override
  AppUser? get currentUser => _convertUser(_firebaseAuth.currentUser);

  @override
  Stream<bool> isUserEmailVerified() {
    return _firebaseAuth.userChanges().map((user) {
      // If the user is not null, return the emailVerified status
      // Otherwise, return false
      return user?.emailVerified ?? false;
    });
  }

  @override
  bool get isEmailVerified => _firebaseAuth.currentUser?.emailVerified ?? false;

  /// Helper method to convert a [User] to an [AppUser]
  AppUser? _convertUser(User? user) =>
      user != null ? AppUser.fromFirebaseUser(user) : null;

  // Stream<AppUser?> get authStateChanges {
  //   return _firebaseAuth.authStateChanges().map(_convertUser);
  // }

  @override
  Future<AppUser> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();

    return AppUser.fromFirebaseUser(userCredential.user!);
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _firebaseAuth.currentUser?.sendEmailVerification();
    await _firebaseAuth.currentUser?.updateDisplayName(fullName);
  }

  @override
  Future<AuthCredential> getUserCredential({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );

    // if (userCredential.user != null) {
    //   return EmailAuthProvider.credential(email: email, password: password);
    // } else {
    //   // throw UserNotLoggedInAuthException();
    // }
    return EmailAuthProvider.credential(email: email, password: password);
  }

  // Future<AuthResult> signInWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     final user = currentUser;
  //     if (user != null) {
  //       return AuthResult.success;
  //     } else {
  //       throw UserNotLoggedInAuthException();
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     log.i(e);
  //     AuthResult.failure;
  //   } catch (e) {
  //     AuthResult.failure;
  //   }
  //   return AuthResult.failure;
  // }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    // If using google sing In
    await GoogleSignIn().signOut();
    // If using facebook login in
    // await FacebookAuth.instance.logOut();
    // if using apple sign in
  }

  @override
  Future<void> deleteUser({required AuthCredential credential}) async {
    final result = await _firebaseAuth.currentUser!
        .reauthenticateWithCredential(credential);

    await result.user!.delete();
  }

  Future<void> deleteUserFromApple(OAuthCredential credential) async {
    final result = await _firebaseAuth.currentUser!
        .reauthenticateWithCredential(credential);

    await result.user!.delete();
  }

  @override
  Future<void> sendEmailVerification() async {
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   await user.sendEmailVerification();
    // } else {
    //   throw UserNotLoggedInAuthException();
    // }
    await _firebaseAuth.currentUser?.sendEmailVerification();
  }

  @override
  Future<void> sendPasswordResetEmail({
    required String toEmail,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: toEmail);
    } catch (e) {
      rethrow;
    }
  }

  // Future<AuthResult> loginWithFacebook() async {
  //   final loginResult = await FacebookAuth.instance.login();
  //   final token = loginResult.accessToken?.token;
  //   if (token == null) {
  //     return AuthResult.aborted;
  //   }
  //   final oauthCredentials = FacebookAuthProvider.credential(token);

  //   try {
  //     await FirebaseAuth.instance.signInWithCredential(
  //       oauthCredentials,
  //     );
  //     return AuthResult.success;
  //   } on FirebaseAuthException catch (e) {
  //     final email = e.email;
  //     final credential = e.credential;
  //     if (e.code == AuthConstants.accountExistsWithDifferentCredentialsError &&
  //         email != null &&
  //         credential != null) {
  //       final providers =
  //           await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  //       if (providers.contains(AuthConstants.googleCom)) {
  //         await loginWithGoogle();
  //         FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
  //       }
  //       return AuthResult.success;
  //     }
  //     return AuthResult.failure;
  //   }
  // }

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      // The OAuth client id of app. this is required
      clientId:
          '23265461996-7c7eqcsb5pt04sij0puk2m1hubh6v3r2.apps.googleusercontent.com',
      // If you need to authenticate to a backend server, specify its OAuth client. this is optional
      serverClientId: '',
      scopes: [
        AuthConstants.emailScope,
      ],
    );
    final GoogleSignInAccount? signInAccount;

    try {
      signInAccount = await googleSignIn.signIn();

      if (signInAccount == null) {
        throw FirebaseAuthException(
          code: 'user-cancelled',
          message: 'User cancelled sign-in',
        );
      }

      final googleAuth = await signInAccount.authentication;

      // get OAuthCredentials from Firebase using token received from Google
      final oauthCredentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      try {
        await _firebaseAuth.signInWithCredential(oauthCredentials);
      } on FirebaseAuthException {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthCredential> getCredentialFromGoogle() async {
    final firebaseOptions = GlobalFirebaseOptions.instance.options;
    if (firebaseOptions == null) {
      throw Exception('FirebaseOptions not initialized');
    }
    final googleSignIn = GoogleSignIn(
      clientId: firebaseOptions.iosClientId,
      scopes: [
        AuthConstants.emailScope,
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    // try {
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.idToken != null) {
        // await FirebaseAuth.instance
        //     .signInWithCredential(GoogleAuthProvider.credential(
        //   idToken: googleAuth.idToken,
        //   // Note: Access token is null when running on web, so we don't check for it above
        //   accessToken: googleAuth.accessToken,
        // ));
        return GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
      } else {
        throw FirebaseException(
          plugin: runtimeType.toString(),
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    } else {
      throw FirebaseException(
        plugin: runtimeType.toString(),
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  // Apple Auth
  @override
  Future<void> signInWithApple() async {
    try {
      final oauthCredential = await getCredentialFromApple();

      // If the nonce generated to get credential from apple does not
      // match the nonce in 'appleCredential.identityToken', sign in
      // will fail
      try {
        final userCredential =
            await _firebaseAuth.signInWithCredential(oauthCredential);
        // if (userCredential.user != null) {
        // ignore: avoid_print
        print(userCredential.user);
        // } else {

        // }
      } catch (e) {
        // ignore: avoid_print
        print(e);
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthCredential> getCredentialFromApple() async {
    final appleSignInService = ref.read(appleSignInServiceProvider);
    return appleSignInService.getCredentialsFromApple();
  }
}

@riverpod
FirebaseAuthService firebaseAuthService(FirebaseAuthServiceRef ref) {
  return FirebaseAuthService(FirebaseAuth.instance, ref);
}
