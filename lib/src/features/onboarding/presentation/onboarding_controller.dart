import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/onboarding/data/onboarding_repository.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // no op
  }

  Future<void> completeOnboarding() async {
    final onboardingRepository =
        ref.watch(onboardingRepositoryProvider).requireValue;
    state = const AsyncLoading();
    state = await AsyncValue.guard(onboardingRepository.setOnboardingComplete);
  }
}
