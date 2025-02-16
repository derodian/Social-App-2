import 'package:social_app_2/src/features/auth/domain/app_user.dart';

abstract class UserDefaults {
  static const String defaultLanguage = 'en';
  static const AppAuthProvider defaultProvider = AppAuthProvider.email;
  static const AccountStatus defaultAccountStatus = AccountStatus.active;
  static const Duration sessionTimeout = Duration(hours: 24);
  static const int maxLoginAttempts = 5;
}
