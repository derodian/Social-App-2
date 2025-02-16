// app_routes.dart
class AppRoutes {
  const AppRoutes._();

  // Authentication & Onboarding
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String emailPassword = 'emailPassword';
  static const String emailNotVerified = '/emailNotVerified';
  static const String waitingForApproval = '/waitingForApproval';

  // Main Features
  static const String news = '/news';
  static const String events = '/events';
  static const String committee = '/committee';
  static const String account = '/account';
  static const String photos = '/photos';
  static const String insta = '/insta';
  static const String directory = '/directory';
  static const String jobs = '/jobs';
  static const String entries = '/entries';

  // Helper methods
  static String newsDetail(String id) => '$news/$id';
  static String newsEdit(String id) => '$news/$id/edit';
  static String committeeDetail(String id) => '$committee/$id';
  static String committeeEdit(String id) => '$committee/$id/edit';
  static String accountEdit(String id) => '$account/$id/editAccount';

  static bool isProtectedRoute(String path) {
    return path.startsWith(news) ||
        path.startsWith(events) ||
        path.startsWith(insta) ||
        path.startsWith(photos) ||
        path.startsWith(account) ||
        path.startsWith(committee) ||
        path == emailNotVerified ||
        path == waitingForApproval;
  }
}
