import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
import 'package:social_app_2/src/features/services/snackbar_service.dart';
import 'package:social_app_2/src/features/settings/domain/user_preferences.dart';
import 'package:social_app_2/src/features/settings/presentation/settings_controller.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _updateTheme(WidgetRef ref, AppThemeMode mode) async {
    try {
      await ref.read(settingsControllerProvider.notifier).updateThemeMode(mode);
    } catch (e) {
      ref
          .read(snackBarControllerProvider.notifier)
          .showError('Failed to update theme: $e');
    }
  }

  Future<void> _updateLanguage(WidgetRef ref, String languageCode) async {
    try {
      await ref
          .read(settingsControllerProvider.notifier)
          .updateLanguage(languageCode);
    } catch (e) {
      ref
          .read(snackBarControllerProvider.notifier)
          .showError('Failed to update language: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.hardcoded),
      ),
      body: AsyncValueWidget(
          value: settingsState,
          data: (preferences) => ListView(
                children: [
                  _buildThemeSection(context, ref, preferences),
                ],
              )),
    );
  }

  Widget _buildThemeSection(
    BuildContext context,
    WidgetRef ref,
    UserPreferences preferences,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: Icon(Icons.palette_outlined),
          title: Text('Theme'),
        ),
        RadioListTile<AppThemeMode>(
          title: const Text('System'),
          subtitle: const Text('Follow system theme'),
          value: AppThemeMode.system,
          groupValue: preferences.themeMode,
          onChanged: (value) => _updateTheme(ref, value!),
        ),
        RadioListTile<AppThemeMode>(
          title: const Text('Light'),
          subtitle: const Text('Always use light theme'),
          value: AppThemeMode.light,
          groupValue: preferences.themeMode,
          onChanged: (value) => _updateTheme(ref, value!),
        ),
        RadioListTile<AppThemeMode>(
          title: const Text('Dark'),
          subtitle: const Text('Always use dark theme'),
          value: AppThemeMode.dark,
          groupValue: preferences.themeMode,
          onChanged: (value) => _updateTheme(ref, value!),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildLanguageSection(
    BuildContext context,
    WidgetRef ref,
    UserPreferences preferences,
  ) {
    final availableLanguages = {
      'en': 'English',
      'es': 'Espanol',
      'fr': 'Francais',
      // Add more languages as needed
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: Icon(Icons.language),
          title: Text('Language'),
        ),
        ...availableLanguages.entries.map(
          (entry) => RadioListTile(
            title: Text(entry.value),
            value: entry.key,
            groupValue: preferences.languageCode,
            onChanged: (value) => _updateLanguage(ref, value!),
          ),
        ),
      ],
    );
  }
}

// // Example usage
// class ThemedWidget extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isDark = ref.watch(currentThemeModeProvider) == AppThemeMode.dark;
//     return Icon(isDark ? Icons.dark_mode : Icons.light_mode);
//   }
// }
