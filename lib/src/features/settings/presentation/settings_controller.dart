import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/settings/domain/user_preferences.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  FutureOr<UserPreferences> build() async {
    // Get current user's preferences
    final user = ref.watch(currentUserProvider);
    return user?.preferences ?? const UserPreferences();
  }

  Future<void> updateThemeMode(AppThemeMode themeMode) async {
    state = const AsyncLoading();

    try {
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) throw Exception('No user found');

      final updatedPreferences = currentUser.preferences.copyWith(
        themeMode: themeMode,
      );

      final updateUser = currentUser.copyWith(
        preferences: updatedPreferences,
        lastUpdateDate: DateTime.now(),
      );

      await ref.read(appUserStorageServiceProvider).updateUser(updateUser);

      state = AsyncData(updatedPreferences);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateLanguage(String languageCode) async {
    state = const AsyncLoading();

    try {
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) throw Exception('No user found');

      final updatedPreferences = currentUser.preferences.copyWith(
        languageCode: languageCode,
      );

      final updatedUser = currentUser.copyWith(
        preferences: updatedPreferences,
        lastUpdateDate: DateTime.now(),
      );

      await ref.read(appUserStorageServiceProvider).updateUser(updatedUser);

      state = AsyncData(updatedPreferences);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// Convenience providers for theme and language
@riverpod
AppThemeMode currentThemeMode(Ref ref) {
  return ref
          .watch(settingsControllerProvider)
          .whenData(
            (preferences) => preferences.themeMode,
          )
          .value ??
      AppThemeMode.system;
}

@riverpod
String currentLanguage(Ref ref) {
  return ref
          .watch(settingsControllerProvider)
          .whenData(
            (preferences) => preferences.languageCode,
          )
          .value ??
      'en';
}
