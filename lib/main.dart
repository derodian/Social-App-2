import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/app_startup.dart';
import 'package:social_app_2/src/features/onboarding/onboarding_screen.dart';
import 'package:social_app_2/src/features/settings/settings_screen.dart';
import 'package:social_app_2/src/routing/app_routes.dart';
import 'package:social_app_2/src/utils/app_theme_data.dart';
import 'package:social_app_2/src/utils/app_theme_mode.dart';
import 'package:social_app_2/src/utils/shared_preferences_provider.dart';

Future<void> runMainApp({required FirebaseOptions firebaseOptions}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // * Initialize Firebase
  await Firebase.initializeApp(options: firebaseOptions);
  final container = ProviderContainer();
  // * Preload SharedPreferences before calling runApp, as the AppStartupWidget
  // * depends on it in order to load the themeMode
  await container.read(sharedPreferencesProvider.future);
  // run the app
  runApp(UncontrolledProviderScope(
    container: container,
    child: AppStartupWidget(
      onLoaded: (context) => const MainApp(),
    ),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.light(),
      darkTheme: AppThemeData.dark(),
      themeMode: themeMode,
      onGenerateRoute: (settings) {
        // * This app uses named routes. For more info, read:
        // * https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments
        return switch (settings.name) {
          AppRoutes.onboarding => MaterialPageRoute(
              settings: settings,
              builder: (_) => const OnBoardingScreen(),
            ),
          AppRoutes.settings => MaterialPageRoute(
              settings: settings,
              fullscreenDialog: true,
              builder: (_) => const SettingsScreen(),
            ),
          _ =>
            throw UnimplementedError('Route named ${settings.name} not found'),
        };
      },
      initialRoute: AppRoutes.onboarding,
    );
  }
}

// ignore_for_file:avoid-undisposed-instances,avoid-nullable-interpolation
