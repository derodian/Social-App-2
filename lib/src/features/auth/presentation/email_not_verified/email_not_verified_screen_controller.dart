import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';

part 'email_not_verified_screen_controller.g.dart';

@riverpod
class EmailNotVerifiedScreenController
    extends _$EmailNotVerifiedScreenController {
  @override
  FutureOr<void> build() {
    // noting to do
  }

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }

  Future<bool> sendEmailVerification() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => authRepository.sendEmailVerification());
    return state.hasError == false;
  }
}
