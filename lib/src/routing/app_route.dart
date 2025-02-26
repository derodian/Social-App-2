import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/routing/app_router.dart';

part 'app_route.g.dart';

enum AppRoute {
  // Public routes
  root('/', protection: RouteProtection.none),
  onboarding('/onboarding', protection: RouteProtection.none),
  auth('/auth', protection: RouteProtection.none),
  error('/error', protection: RouteProtection.none),

  // Auth-required routes
  emailVerification('/verify-email', protection: RouteProtection.auth),
  waitingApproval('/waiting-approval', protection: RouteProtection.auth),

  // VERIFIED AND APPROVED ROUTES
  // Main Features

  // Home Routes
  home('/home', protection: RouteProtection.verified),

  // Profile Routes
  profile('/profile', protection: RouteProtection.verified),
  editProfile('/profile/edit', protection: RouteProtection.verified),
  profileSettings('/profile/settings', protection: RouteProtection.verified),

  // Account management
  accountManagement('/account', protection: RouteProtection.verified),
  changePassword('/account/password', protection: RouteProtection.verified),
  privacySettings('/account/privacy', protection: RouteProtection.verified),
  notificationSettings('/account/notifications',
      protection: RouteProtection.verified),

  // Users Routes
  users('/users', protection: RouteProtection.auth),

  // Settings Routes
  settings('/settings', protection: RouteProtection.verified),

  // // User Account Routes
  // account('/account', protection: RouteProtection.verified),
  // editAccount('/account/edit', protection: RouteProtection.auth);

  // News Routes
  news('/news', protection: RouteProtection.verified),
  newsDetail('/news/:id', protection: RouteProtection.verified),
  addNews('/news/add', protection: RouteProtection.admin),
  editNews('/news/:id/edit', protection: RouteProtection.admin),

  // Events Routes
  events('/events', protection: RouteProtection.verified),
  eventDetail('/events/:id', protection: RouteProtection.verified),
  addEvent('/events/add', protection: RouteProtection.admin),
  editEvent('/events/:id/edit', protection: RouteProtection.admin),

  // Committee Routes
  committee('/committee', protection: RouteProtection.verified),
  committeeDetail('/committee/:id', protection: RouteProtection.verified),
  addCommittee('/committee/add', protection: RouteProtection.admin),
  editCommittee('/committee/:id/edit', protection: RouteProtection.admin),

  // Photos Routes
  photos('/photos', protection: RouteProtection.verified),
  photoDetail('/photos/:id', protection: RouteProtection.verified),
  addPhoto('/photos/add', protection: RouteProtection.admin),
  editPhoto('/photos/:id/edit', protection: RouteProtection.admin),

  // Insta Routes
  insta('/insta', protection: RouteProtection.verified),

  // Directory Routes
  directory('/directory', protection: RouteProtection.verified);

  final String path;
  final RouteProtection protection;

  const AppRoute(this.path, {required this.protection});

  bool get isAdminRoute => protection == RouteProtection.admin;
  bool get requiresAuth => protection != RouteProtection.none;
  bool get isProfileRoute => name.startsWith('profile');
  bool get isAccountRoute => name.startsWith('account');
  bool get requiresVerification =>
      protection == RouteProtection.verified ||
      protection == RouteProtection.admin;
  bool get requiresApproval =>
      protection == RouteProtection.verified ||
      protection == RouteProtection.admin;

  // Helper methods
  String withParams(Map<String, String> params) {
    String newPath = path;
    params.forEach((key, value) {
      newPath = newPath.replaceAll(':$key', value);
    });
    return newPath;
  }

  // Helper methods for dynamic routes
  // For Details Screen
  String detail(String id) => switch (this) {
        AppRoute.users => '/users/$id',
        AppRoute.news => '/news/$id',
        AppRoute.events => '/events/$id',
        AppRoute.committee => '/committee/$id',
        // AppRoute.account => '/account/$id',
        AppRoute.photos => '/photos/$id',
        AppRoute.insta => '/insta/$id',
        _ => throw UnimplementedError('Detail route not implemented for $name'),
      };

  // For Edit Screen
  String edit(String id) => switch (this) {
        AppRoute.users => '/users/$id/edit',
        AppRoute.news => '/news/$id/edit',
        AppRoute.events => '/events/$id/edit',
        AppRoute.committee => '/committee/$id/edit',
        // AppRoute.account => '/account/$id/edit',
        AppRoute.photos => '/photos/$id/edit',
        AppRoute.insta => '/insta/$id/edit',
        _ => throw UnimplementedError('Edit route not implemented for $name'),
      };
}

enum RouteProtection {
  none, // Public routes
  auth, // Requires authentication
  admin, // Requires admin access
  verified // Requires email verification and approval
}

// Helper extension for route parameters, protection and validation
extension AppRouteX on AppRoute {
  String withParams(Map<String, String> params) {
    String newPath = path;
    params.forEach((key, value) {
      newPath = newPath.replaceAll(':$key', value);
    });
    return newPath;
  }

  // Helper for dynamic routes
  String detail(String id) => switch (this) {
        AppRoute.news => AppRoute.newsDetail.withParams({'id': id}),
        AppRoute.events => AppRoute.eventDetail.withParams({'id': id}),
        AppRoute.committee => AppRoute.committeeDetail.withParams({'id': id}),
        AppRoute.photos => AppRoute.photoDetail.withParams({'id': id}),
        _ => throw UnsupportedError('Detail route not available for $name'),
      };

  String edit(String id) => switch (this) {
        AppRoute.news => AppRoute.editNews.withParams({'id': id}),
        AppRoute.events => AppRoute.editEvent.withParams({'id': id}),
        AppRoute.committee => AppRoute.editCommittee.withParams({'id': id}),
        AppRoute.photos => AppRoute.editPhoto.withParams({'id': id}),
        _ => throw UnsupportedError('Edit route not available for $name'),
      };
}

// Provider for current route
// If you need more complex route matching:
@riverpod
class CurrentRoute extends _$CurrentRoute {
  @override
  AppRoute build() {
    final routerConfig =
        ref.watch(appRouterProvider).routerDelegate.currentConfiguration;
    if (routerConfig == null) return AppRoute.onboarding;

    final path = routerConfig.uri.path;
    final params = routerConfig.pathParameters;

    // Handle nested routes
    if (path.startsWith('/news/')) {
      if (path.endsWith('/add')) return AppRoute.addNews;
      if (path.contains('/edit')) return AppRoute.editNews;
      if (params.containsKey('id')) return AppRoute.newsDetail;
      return AppRoute.news;
    }

    // TODO: do same setup as above for all other features of the app

    return AppRoute.values.firstWhere(
      (route) => path.startsWith(route.path),
      orElse: () => AppRoute.onboarding,
    );
  }

  bool get requiresAuth => state.requiresAuth;
  bool get requiresVerification => state.requiresVerification;
  bool get requiresApproval => state.requiresApproval;
  bool get isAdminRoute => state.isAdminRoute;
}


// TODO: Usage examples
// Usage examples:
// void example() {
//   // Get news detail route
//   final newsDetailPath = AppRoute.news.detail('123'); // '/news/123'
  
//   // Get edit route
//   final editNewsPath = AppRoute.news.edit('123');     // '/news/123/edit'
  
//   // Check protection
//   final isProtected = AppRoute.addNews.isAdminRoute;  // true
  
//   // Use with parameters
//   final editPath = AppRoute.editNews.withParams({'id': '123'}); // '/news/123/edit'
// }

// // Navigation service example
// @riverpod
// class NavigationService extends _$NavigationService {
//   @override
//   void build() {}

//   void goToNewsDetail(String id) {
//     final path = AppRoute.news.detail(id);
//     ref.read(appRouterProvider).push(path);
//   }

//   void goToEditNews(String id) {
//     if (!ref.read(isAdminProvider)) {
//       throw UnauthorizedException('Admin access required');
//     }
//     final path = AppRoute.news.edit(id);
//     ref.read(appRouterProvider).push(path);
//   }

//   void goToAddNews() {
//     if (!ref.read(isAdminProvider)) {
//       throw UnauthorizedException('Admin access required');
//     }
//     ref.read(appRouterProvider).push(AppRoute.addNews.path);
//   }
// }