class NameValidator {
  static final RegExp _basicNameRegExp = RegExp(r'^[a-zA-Z\s-]+$');
  static final RegExp _twoWordsRegExp = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)+$');
  static final RegExp _comprehensiveNameRegExp =
      RegExp(r"^[a-zA-ZÀ-ÿ]+(([',. -][a-zA-ZÀ-ÿ ])?[a-zA-ZÀ-ÿ]*)*$");

  // Validates if the string contains only letters and spaces
  static bool isValidBasicName(String name) {
    return _basicNameRegExp.hasMatch(name);
  }

  // Validates if the string has at least two words
  static bool hasFirstAndLastName(String name) {
    return _twoWordsRegExp.hasMatch(name);
  }

  // Comprehensive validation including special characters
  static bool isValidFullName(String name) {
    if (name.isEmpty) return false;
    if (name.length < 3) return false; // Minimum length
    if (name.length > 70) return false; // Maximum length

    // Check if contains at least two words
    final words = name.trim().split(' ');
    if (words.length < 2) return false;

    // Check if each word is at least 2 characters long
    for (final word in words) {
      if (word.length < 2) return false;
    }

    return _comprehensiveNameRegExp.hasMatch(name);
  }

  // Validation with specific error messages
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }

    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }

    if (value.length > 70) {
      return 'Name must be less than 70 characters long';
    }

    final words = value.trim().split(' ');
    if (words.length < 2) {
      return 'Please enter both first and last name';
    }

    for (final word in words) {
      if (word.length < 2) {
        return 'Each name part should be at least 2 characters long';
      }
    }

    if (!_comprehensiveNameRegExp.hasMatch(value)) {
      return 'Please enter a valid name using only letters, hyphens, and spaces';
    }

    return null;
  }
}
