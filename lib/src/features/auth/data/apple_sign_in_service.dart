// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:logger/logger.dart';
// import 'package:social_app_1_0/src/features/authentication/domain/app_user.dart';
// import 'package:the_apple_sign_in/the_apple_sign_in.dart';

// class AppleSignInService {
//   final _firebaseAuth = FirebaseAuth.instance;
//   final log = Logger();

//   Future<AppUser> signInWithApple() async {
//     // 1. Perform the sign-in request
//     final result = await TheAppleSignIn.performRequests([
//       const AppleIdRequest(
//         requestedScopes: [
//           Scope.email,
//           Scope.fullName,
//         ],
//       ),
//     ]);
//     // 2. Check the result
//     switch (result.status) {
//       case AuthorizationStatus.authorized:
//         // 3. Create a credential from the result
//         final appleIdCredential = result.credential!;
//         log.i(result.credential);
//         final oAuthProvider = OAuthProvider('apple.com');
//         final credential = oAuthProvider.credential(
//           idToken: String.fromCharCodes(appleIdCredential.identityToken!),
//           accessToken:
//               String.fromCharCodes(appleIdCredential.authorizationCode!),
//         );

//         // 4. get display name from result.credential
//         final fixDisplayNameFromApple =
//             '${result.credential?.fullName?.givenName} ${result.credential?.fullName?.familyName}';

//         // 5. Sign-in the user with the credential
//         final userCredential =
//             await _firebaseAuth.signInWithCredential(credential);
//         final User? firebaseUser = userCredential.user;

//         log.i(firebaseUser);

//         // ... once the authentication is complete
//         // 6. update firebase user's display name

//         if (firebaseUser?.displayName == null) {
//           await firebaseUser?.updateDisplayName(fixDisplayNameFromApple);
//         }
//         await firebaseUser?.reload();
//         final updatedFirebaseUser = _firebaseAuth.currentUser;
//         log.i(updatedFirebaseUser);

//         return AppUser.fromFirebaseUser(updatedFirebaseUser!);
//       case AuthorizationStatus.error:
//         throw PlatformException(
//           code: 'ERROR_AUTHORIZATION_FAILED',
//           message: result.error.toString(),
//         );
//       case AuthorizationStatus.cancelled:
//         throw PlatformException(
//           code: 'ERROR_ABORTED_BY_USER',
//           message: 'Sign in aborted by user',
//         );
//       default:
//         throw UnimplementedError();
//     }
//   }

//   Future<OAuthCredential> getCredentialFromApple() async {
//     // 1. Perform the sign-in request
//     final result = await TheAppleSignIn.performRequests([
//       const AppleIdRequest(
//         requestedScopes: [
//           Scope.email,
//           Scope.fullName,
//         ],
//       ),
//     ]);
//     // 2. Check the result
//     switch (result.status) {
//       case AuthorizationStatus.authorized:
//         // 3. Create a credential from the result
//         final appleIdCredential = result.credential!;
//         log.i(result.credential);
//         final oAuthProvider = OAuthProvider('apple.com');
//         final credential = oAuthProvider.credential(
//           idToken: String.fromCharCodes(appleIdCredential.identityToken!),
//           accessToken:
//               String.fromCharCodes(appleIdCredential.authorizationCode!),
//         );
//         return credential;

//       case AuthorizationStatus.error:
//         throw PlatformException(
//           code: 'ERROR_AUTHORIZATION_FAILED',
//           message: result.error.toString(),
//         );
//       case AuthorizationStatus.cancelled:
//         throw PlatformException(
//           code: 'ERROR_ABORTED_BY_USER',
//           message: 'Sign in aborted by user',
//         );
//       default:
//         throw UnimplementedError();
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:social_app_2/src/utils/crypto_utilities.dart';

part 'apple_sign_in_service.g.dart';

class AppleSignInService {
  Future<AuthCredential> getCredentialsFromApple() async {
    try {
      // To prevent replay attacks with the credential returned from
      // Apple, we include a nonce in the credential request.
      // When signing in with Firebase, the nonce in the id token
      // returned by Apple, is expected to match the sha256 hash
      // of 'rawNonce'
      final rawNonce = CryptoUtilities.generateNonce();
      final nonce = CryptoUtilities.sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // webAuthenticationOptions: WebAuthenticationOptions(
        //   clientId: 'clientId',
        //   redirectUri: Uri.parse('redirect_uri'),
        // ),
        nonce: nonce,
      );

      // Create an 'OAuthCredential' from the credential returned
      // by apple.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // If the nonce generated earlier does not match the nonce
      // in 'appleCredential.identityToken', sign in will fail.

      return oauthCredential;
    } catch (e) {
      rethrow;
    }
  }
}

@riverpod
AppleSignInService appleSignInService(AppleSignInServiceRef ref) {
  return AppleSignInService();
}
