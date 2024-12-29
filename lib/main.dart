import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:social_app_2/global_firebase_options.dart';
import 'package:social_app_2/src/app_bootstrap.dart';
import 'package:social_app_2/src/app_bootstrap_firebase.dart';
import 'package:social_app_2/src/features/onboarding/data/onboarding_repository.dart';
// Future<void> setupEmulators() async {
//   await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
//   FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
//   await FirebaseStorage.instance.useStorageEmulator('127.0.0.1', 9199);
// }

Future<void> runMainApp({required FirebaseOptions firebaseOptions}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // * Initialize Firebase
  await Firebase.initializeApp(options: firebaseOptions);
  // Optional: Store the firebaseOptions in a globally accessible location
  GlobalFirebaseOptions.instance.options = firebaseOptions;
  // setup emulators : MAKE SURE TO COMMENT IT OUT DURING PRODUCTION
  // await setupEmulators();
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  // create an app bootstrap instance
  final appBootstrap = AppBootstrap();
  // create a container configured with all the "fake" repositories
  final container = await appBootstrap.createFirebaseProviderContainer();

  // Onboarding
  await container.read(onboardingRepositoryProvider.future);
  // use the container above to create the root widget
  final root = appBootstrap.createRootWidget(container: container);
  // start the app
  runApp(root);
}
