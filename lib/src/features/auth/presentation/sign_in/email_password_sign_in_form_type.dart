import 'package:social_app_2/src/utils/string_hardcoded.dart';

/// Form type for email & password authentication
enum EmailPasswordSignInFormType {
  signIn,
  register,
  forgotPassword,
}

extension EmailPasswordSignInFormTypeX on EmailPasswordSignInFormType {
  String get passwordLabelText {
    if (this == EmailPasswordSignInFormType.register) {
      return 'Password (8+ characters)'.hardcoded;
    } else {
      return 'Password'.hardcoded;
    }
  }

  // Getters
  String get primaryButtonText {
    if (this == EmailPasswordSignInFormType.register) {
      return 'Create an account'.hardcoded;
    } else if (this == EmailPasswordSignInFormType.signIn) {
      return 'Sign in'.hardcoded;
    } else {
      return 'Reset password'.hardcoded;
    }
  }

  String get secondaryButtonText {
    if (this == EmailPasswordSignInFormType.register) {
      return 'Have an account? Sign in'.hardcoded;
    } else if (this == EmailPasswordSignInFormType.signIn) {
      return 'Need an account? Register'.hardcoded;
    } else {
      return 'Sign in'.hardcoded;
    }
  }

  String get tertiaryButtonText {
    if (this == EmailPasswordSignInFormType.signIn) {
      return 'Forgot Password? Reset'.hardcoded;
    } else {
      return '';
    }
  }

  EmailPasswordSignInFormType get secondaryActionFormType {
    if (this == EmailPasswordSignInFormType.register) {
      return EmailPasswordSignInFormType.signIn;
    } else if (this == EmailPasswordSignInFormType.signIn) {
      return EmailPasswordSignInFormType.register;
    } else {
      return EmailPasswordSignInFormType.signIn;
    }
  }

  String get errorAlertTitle {
    if (this == EmailPasswordSignInFormType.register) {
      return 'Registration failed'.hardcoded;
    } else if (this == EmailPasswordSignInFormType.signIn) {
      return 'Sign in failed'.hardcoded;
    } else {
      return 'Password reset failed'.hardcoded;
    }
  }

  String get title {
    if (this == EmailPasswordSignInFormType.register) {
      return 'Register'.hardcoded;
    } else if (this == EmailPasswordSignInFormType.signIn) {
      return 'Sign in'.hardcoded;
    } else {
      return 'Forgot your password?'.hardcoded;
    }
  }
}
