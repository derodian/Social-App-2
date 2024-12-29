import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

/// A class with some committee validation methods
class CommitteeMemberValidator {
  const CommitteeMemberValidator();

  String? minimumCharactersValidator(dynamic value) {
    if (value == null) {
      return 'Can\'t be empty'.hardcoded;
    }
    if (value.length < 8) {
      return 'Minimum length: 8 characters';
    }
    return null;
  }

  String? nameValidator(dynamic value) => minimumCharactersValidator(value);
}

final committeeMemberValidatorProvider =
    Provider<CommitteeMemberValidator>((ref) {
  return const CommitteeMemberValidator();
});
