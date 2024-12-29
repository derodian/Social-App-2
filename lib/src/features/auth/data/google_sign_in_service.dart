// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:social_app_1_0/src/features/authentication/domain/app_user.dart';

// class GoogleSignInService {
//   Future<void> signOut() async {
//     await GoogleSignIn().signOut();
//   }

//   Future<AppUser> signInWithGoogle() async {
//     final googleSignIn = GoogleSignIn(
//       clientId: DefaultFirebaseOptions.currentPlatform.iosClientId,
//       scopes: [
//         'email',
//         'https://www.googleapis.com/auth/contacts.readonly',
//       ],
//     );
//     // try {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser != null) {
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;
//       if (googleAuth.idToken != null) {
//         final userCredential = await FirebaseAuth.instance
//             .signInWithCredential(GoogleAuthProvider.credential(
//           idToken: googleAuth.idToken,
//           // Note: Access token is null when running on web, so we don't check for it above
//           accessToken: googleAuth.accessToken,
//         ));
//         return AppUser.fromFirebaseUser(userCredential.user!);
//       } else {
//         throw FirebaseException(
//           plugin: runtimeType.toString(),
//           code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
//           message: 'Missing Google ID Token',
//         );
//       }
//     } else {
//       throw FirebaseException(
//         plugin: runtimeType.toString(),
//         code: 'ERROR_ABORTED_BY_USER',
//         message: 'Sign in aborted by user',
//       );
//     }
//     // } catch (e) {
//     //   rethrow;
//     // }
//   }

//   Future<AuthCredential> getCredentialFromGoogle() async {
//     final googleSignIn = GoogleSignIn(
//       clientId: DefaultFirebaseOptions.currentPlatform.iosClientId,
//       scopes: [
//         'email',
//         'https://www.googleapis.com/auth/contacts.readonly',
//       ],
//     );
//     // try {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser != null) {
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;
//       if (googleAuth.idToken != null) {
//         await FirebaseAuth.instance
//             .signInWithCredential(GoogleAuthProvider.credential(
//           idToken: googleAuth.idToken,
//           // Note: Access token is null when running on web, so we don't check for it above
//           accessToken: googleAuth.accessToken,
//         ));
//         return GoogleAuthProvider.credential(
//           idToken: googleAuth.idToken,
//           accessToken: googleAuth.accessToken,
//         );
//       } else {
//         throw FirebaseException(
//           plugin: runtimeType.toString(),
//           code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
//           message: 'Missing Google ID Token',
//         );
//       }
//     } else {
//       throw FirebaseException(
//         plugin: runtimeType.toString(),
//         code: 'ERROR_ABORTED_BY_USER',
//         message: 'Sign in aborted by user',
//       );
//     }
//   }
// }

// final googleSignInServiceProvider = Provider<GoogleSignInService>((ref) {
//   return GoogleSignInService();
// });
