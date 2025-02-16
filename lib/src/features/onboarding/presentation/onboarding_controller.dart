import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/onboarding/data/onboarding_repository.dart';
import 'package:social_app_2/src/utils/shared_preferences_provider.dart';

part 'onboarding_controller.g.dart';

@Riverpod(keepAlive: true)
// class OnboardingController extends _$OnboardingController {
//   @override
//   bool build() {
//     // Get synchronously from repository
//     final repository = ref.watch(onboardingRepositoryProvider).valueOrNull;
//     return repository?.isOnboardingComplete() ?? false;
//   }

//   Future<void> completeOnboarding() async {
//     final repository = await ref.read(onboardingRepositoryProvider.future);
//     await repository.setOnboardingComplete();
//     state = true;
//   }
// }

class OnboardingController extends _$OnboardingController {
  static const _key = 'onboarding_complete';

  @override
  bool build() {
    // Initialize with false
    return false;
  }

  // Initialize state from SharedPreferences
  Future<void> initializeState() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    state = prefs.getBool(_key) ?? false;
    debugPrint('Onboarding state initialized: $state');
  }

  Future<void> completeOnboarding() async {
    try {
      // Get SharedPreferences instance
      final prefs = await ref.read(sharedPreferencesProvider.future);

      // Save to persistent storage
      await prefs.setBool(_key, true);

      // Update state
      state = true;

      debugPrint('Onboarding completed and saved to preferences');
    } catch (e) {
      debugPrint('Error saving onboarding state: $e');
      // Still update state even if save fails
      state = true;
    }
  }

  Future<void> resetOnboarding() async {
    try {
      final prefs = await ref.read(sharedPreferencesProvider.future);
      await prefs.remove(_key);
      state = false;
      debugPrint('Onboarding state reset');
    } catch (e) {
      debugPrint('Error resetting onboarding state: $e');
    }
  }
}
