import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/constants/keys.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/utils/app_theme_data.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('=== Building MyApp ===');
    final goRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      restorationScopeId: 'app',
      scaffoldMessengerKey: scaffoldMessengerKey,
      onGenerateTitle: (BuildContext context) => 'Social App'.hardcoded,
      routerConfig: goRouter,
      theme: AppThemeData.light(),
      darkTheme: AppThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
    );
  }
}
