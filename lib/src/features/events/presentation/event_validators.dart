import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

/// A class with some event validation methods
class EventValidator {
  const EventValidator();

  String? titleValidator(dynamic value) {
    if (value == null) {
      return 'Can\'t be empty'.hardcoded;
    }
    if (value.length < 8) {
      return 'Minimum length: 8 characters';
    }
    return null;
  }

  String? eventDetailsValidator(dynamic value) => titleValidator(value);
}

final eventValidatorProvider = Provider<EventValidator>((ref) {
  return const EventValidator();
});
