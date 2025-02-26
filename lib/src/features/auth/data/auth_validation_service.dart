// features/auth/services/auth_validation_service.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';

part 'auth_validation_service.g.dart';

// features/auth/services/auth_validation_service.dart
@riverpod
class AuthValidationService extends _$AuthValidationService {
  @override
  void build() {
    // Initialize if needed
  }

  Future<AuthValidationResult> validateEmailForSignUp(String email) async {
    try {
      final providers = await ref
          .read(authControllerProvider.notifier)
          .checkEmailProviders(email);

      if (providers.isEmpty) {
        return ValidEmail(); // Remove const
      }
      return ExistingProviders(providers);
    } catch (e) {
      return ValidationError(e.toString());
    }
  }
}

// Remove factory constructors and use separate classes
sealed class AuthValidationResult {
  const AuthValidationResult();
}

class ValidEmail extends AuthValidationResult {
  const ValidEmail();
}

class ExistingProviders extends AuthValidationResult {
  final List<AppAuthProvider> providers;
  const ExistingProviders(this.providers);
}

class ValidationError extends AuthValidationResult {
  final String message;
  const ValidationError(this.message);
}
