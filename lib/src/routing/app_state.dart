import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state.g.dart';

@riverpod
class AppState extends _$AppState {
  @override
  AppStateModel build() {
    return const AppStateModel();
  }

  void updateTheme(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
  }

  // Add other app-wide state management methods
}

@immutable
class AppStateModel {
  final ThemeMode themeMode;
  // Add other app-wide state properties

  const AppStateModel({
    this.themeMode = ThemeMode.system,
  });

  AppStateModel copyWith({
    ThemeMode? themeMode,
  }) {
    return AppStateModel(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
