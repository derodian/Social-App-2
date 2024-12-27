import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/app_bootstrap.dart';
import 'package:social_app_2/src/exceptions/async_error_logger.dart';

/// Extension methods specific for the Firebase project configuration
extension AppBootstrapFirebase on AppBootstrap {
  /// Creates the top-level [ProviderContainer] by overriding providers with
  /// repositories.
  ///
  /// Note: all repositories needed by the app can be accessed via providers.
  /// Some of these providers throw an [UnimplementedError] by default.
  ///
  /// Example:
  /// ```dart
  /// @Riverpod(keepAlive: true)
  /// LocalCartRepository localCartRepository(LocalCartRepositoryRef ref) {
  ///   throw UnimplementedError();
  /// }
  /// ```
  ///
  /// As a result, this method does two things:
  /// - create and configure the repositories as desired
  /// - override the default implementations with a list of "overrides"
  Future<ProviderContainer> createFirebaseProviderContainer(
      {bool addDelay = false}) async {
    // TODO: Replace with Firebase repositories
    // final localNewsRepository = await SembastCartRepository.makeDefault();
    return ProviderContainer(
      overrides: [
        // repositories
        // newsRepositoryProvider.overrideWithValue(localNewsRepository);
      ],
      observers: [AsyncErrorLogger()],
    );
  }

  /// setup Firebase Emulators
  // Future<void> setupEmulators() async {
  //   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //   await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  //   // * When running on the emulator, disable persistence to avoid discrepancies
  //   // * between the emulated database and local caches. More info here:
  //   // * https://firebase.google.com/docs/emulator-suite/connect_firestore#instrument_your_app_to_talk_to_the_emulators
  //   FirebaseFirestore.instance.settings =
  //       const Settings(persistenceEnabled: false);
  // }
}
