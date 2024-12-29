import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/theme/dark_theme.dart';
import 'package:social_app_2/src/theme/light_theme.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  bool get isDarkMode => state == ThemeMode.dark;

  ThemeData get themeData => state == ThemeMode.dark ? darkMode : lightMode;

  void toggleTheme(bool isOn) {
    state = isOn ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
