import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

/// A class with some news validation methods
class NewsValidator {
  const NewsValidator();

  String? titleValidator(dynamic value) {
    if (value == null) {
      return 'Can\'t be empty'.hardcoded;
    }
    if (value.length < 8) {
      return 'Minimum length: 8 characters';
    }
    return null;
  }

  String? newsDetailsValidator(dynamic value) => titleValidator(value);
}

final newsValidatorProvider = Provider<NewsValidator>((ref) {
  return const NewsValidator();
});
