import 'package:flutter/material.dart';

// Define the enum outside the class
enum PasswordStrength {
  weak,
  medium,
  strong,
  veryStrong,
}

class PasswordValidator {
  // Basic Password Validation (minimum 8 characters)
  static final RegExp _basicPasswordRegExp = RegExp(r'^.{8,}$');

  // Medium Password (8+ chars, at least 1 letter and 1 number)
  static final RegExp _mediumPasswordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  // Strong Password (8+ chars, uppercase, lowercase, number)
  static final RegExp _strongPasswordRegExp =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');

  // Very Strong Password (8+ chars, uppercase, lowercase, number, special char)
  static final RegExp _veryStrongPasswordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  static PasswordStrength checkPasswordStrength(String password) {
    if (password.isEmpty) return PasswordStrength.weak;
    if (_veryStrongPasswordRegExp.hasMatch(password))
      return PasswordStrength.veryStrong;
    if (_strongPasswordRegExp.hasMatch(password))
      return PasswordStrength.strong;
    if (_mediumPasswordRegExp.hasMatch(password))
      return PasswordStrength.medium;
    return PasswordStrength.weak;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  // Get color based on password strength
  static Color getPasswordStrengthColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.medium:
        return Colors.orange;
      case PasswordStrength.strong:
        return Colors.yellow;
      case PasswordStrength.veryStrong:
        return Colors.green;
    }
  }

  // Get description based on password strength
  static String getPasswordStrengthDescription(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 'Weak password';
      case PasswordStrength.medium:
        return 'Medium strength password';
      case PasswordStrength.strong:
        return 'Strong password';
      case PasswordStrength.veryStrong:
        return 'Very strong password';
    }
  }
}
