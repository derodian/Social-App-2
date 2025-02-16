class PhoneNumberValidator {
  // Basic validation for international phone numbers
  static bool isValidPhone(String phone) {
    // Remove any whitespace, dashes, or parentheses
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Regular expression for phone number validation
    // Allows for optional '+' prefix and requires 10-15 digits
    final phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegExp.hasMatch(cleanPhone);
  }

  // US phone number validation
  static bool isValidUSPhone(String phone) {
    // Remove any whitespace, dashes, or parentheses
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Pattern for US phone numbers: exactly 10 digits
    final phoneRegExp = RegExp(r'^[0-9]{10}$');
    return phoneRegExp.hasMatch(cleanPhone);
  }

  // Validation with error messages
  static String? validatePhone(String? value, {bool requireUSFormat = false}) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    if (requireUSFormat) {
      if (!isValidUSPhone(value)) {
        return 'Please enter a valid US phone number';
      }
    } else {
      if (!isValidPhone(value)) {
        return 'Please enter a valid phone number';
      }
    }
    return null;
  }
}
