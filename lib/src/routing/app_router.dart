import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:social_app_2/src/common_widgets/error_screen.dart';
import 'package:social_app_2/src/constants/keys.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/account/edit_profile_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_shell.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/email_verification_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/waiting_for_approval_screen.dart';
import 'package:social_app_2/src/features/components/loading/presentation/loading_screen.dart';
import 'package:social_app_2/src/features/events/presentation/events_list_screen.dart';
import 'package:social_app_2/src/features/insta/presentation/insta_screen.dart';
import 'package:social_app_2/src/features/news/presentation/news_list_screen.dart';
import 'package:social_app_2/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:social_app_2/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:social_app_2/src/features/photos/presentation/photos_screen.dart';
import 'package:social_app_2/src/features/settings/presentation/settings_screen.dart';
import 'package:social_app_2/src/routing/app_route.dart';
import 'package:social_app_2/src/routing/scaffold_with_nested_navigation.dart';
import 'package:social_app_2/src/utils/key_tracker.dart';

part 'app_router.g.dart';

// Define these outside of any class or function to ensure they're only created once
final _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
final _newsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'newsNavigatorKey');
final _eventsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'eventsNavigatorKey');
final _photosNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'photosNavigatorKey');
final _instaNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'instaNavigatorKey');

// Track if keys are already registered
bool _keysAlreadyRegistered = false;

GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // // Register keys with tracker
  // KeyTracker.registerKey(_newsNavigatorKey);
  // KeyTracker.registerKey(_eventsNavigatorKey);
  // KeyTracker.registerKey(_rootNavigatorKey);
  // Only register keys if not already registered
  if (!_keysAlreadyRegistered) {
    KeyTracker.registerKey(_newsNavigatorKey);
    KeyTracker.registerKey(_eventsNavigatorKey);
    KeyTracker.registerKey(_rootNavigatorKey);
    _keysAlreadyRegistered = true;
  }

  return GoRouter(
    // navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: AppRoute.root.path,
    // Redirect Logic
    redirect: (context, state) {
      final currentPath = state.uri.path;

      // Get current route from path
      final currentRoute = _getCurrentRoute(state.uri.path);

      // Log current state
      RouterLogger.logState(
        path: state.uri.path,
        route: currentRoute,
        authState: ref.read(authControllerProvider),
      );

      debugPrint('Router checking redirect:');
      debugPrint('- Current path: $currentPath');

      // 1. Handle reauthentication first
      if (ref.read(authControllerProvider.notifier).isReauthenticating) {
        RouterLogger.logInfo('Skipping redirect during reauthentication');
        return null;
      }

      // 2. Check onboarding completion
      final onboardingComplete = ref.read(onboardingControllerProvider);
      debugPrint('- Onboarding complete: $onboardingComplete');
      if (!onboardingComplete) {
        if (currentRoute == AppRoute.onboarding) return null;
        RouterLogger.logRedirect(currentPath, AppRoute.onboarding.path);
        return AppRoute.onboarding.path;
      }

      // 3. Handle authentication state
      final authState = ref.watch(authControllerProvider);
      debugPrint('- Auth state type: ${authState.runtimeType}');
      debugPrint('- Auth state value: ${authState.value}');

      return switch (authState) {
        // Handle loading state
        AsyncLoading() => _handleLoadingState(currentPath),

        // Handle error state
        AsyncError() => _handleErrorState(currentRoute),

        // Handle data state
        AsyncData(:final value) => _handleAuthData(
            currentPath: currentPath,
            authResult: value,
          ),

        // Handle any other potential states
        _ => AppRoute.auth.path
      };
    },
    // Route definitions
    routes: [
      // Public routes
      GoRoute(
        path: AppRoute.root.path,
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: AppRoute.error.path,
        builder: (context, state) => ErrorScreen(
          error: state.extra?.toString() ?? 'An unknown error occurred',
        ),
      ),
      GoRoute(
        path: AppRoute.onboarding.path,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoute.auth.path,
        builder: (context, state) => const AuthScreen(),
      ),

      // Protected routes
      GoRoute(
        path: AppRoute.emailVerification.path,
        builder: (context, state) => const EmailVerificationScreen(),
      ),
      GoRoute(
        path: AppRoute.waitingApproval.path,
        builder: (context, state) => const WaitingApprovalScreen(),
      ),

      // Routes for all the Features of the App
      // GoRoute(
      //   path: AppRoute.home.path,
      //   builder: (context, state) => const HomeScreen(),
      // ),

      // Routes for user preference settings
      GoRoute(
        path: AppRoute.settings.path,
        builder: (context, state) => const SettingsScreen(),
      ),

      // Add other routes as needed
      _profileRoutes(),
      // _newsRoutes(),
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _newsNavigatorKey,
            routes: [
              GoRoute(
                path: '/news',
                name: AppRoute.news.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: NewsListScreen(),
                ),
                routes: [
                  // GoRoute(
                  //   path: 'add',
                  //   name: AppRoute.addNews.name,
                  //   parentNavigatorKey: _rootNavigatorKey,
                  //   pageBuilder: (context, state) {
                  //     return const MaterialPage(
                  //       fullscreenDialog: true,
                  //       child: AddEditNewsScreen(),
                  //     );
                  //   },
                  // ),
                  // GoRoute(
                  //   path: ':id',
                  //   name: AppRoute.singleNews.name,
                  //   pageBuilder: (context, state) {
                  //     final id = state.pathParameters['id'] as NewsID;
                  //     return MaterialPage(
                  //       child: DetailNewsScreen(newsId: id),
                  //     );
                  //   },
                  //   routes: [
                  //     GoRoute(
                  //       path: 'edit',
                  //       name: AppRoute.editNews.name,
                  //       pageBuilder: (context, state) {
                  //         final newsId = state.pathParameters['id'] as NewsID;
                  //         return MaterialPage(
                  //           child: AddEditNewsScreen(
                  //             newsId: newsId,
                  //           ),
                  //         );
                  //       },
                  //     ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _eventsNavigatorKey,
            routes: [
              GoRoute(
                path: '/events',
                name: AppRoute.events.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: EventsListScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _instaNavigatorKey,
            routes: [
              GoRoute(
                path: '/insta',
                name: AppRoute.insta.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: InstaScreen(),
                ),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _photosNavigatorKey,
            routes: [
              GoRoute(
                path: '/photos',
                name: AppRoute.photos.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PhotosScreen(),
                ),
                routes: [],
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(
      error: state.error.toString(),
    ),
  );
}

// Helper functions for route handling
AppRoute _getCurrentRoute(String path) {
  return AppRoute.values.firstWhere(
    (route) => path.startsWith(route.path),
    orElse: () => AppRoute.root,
  );
}

// Helper functions for redirect logic
String? _handleLoadingState(String currentPath) {
  debugPrint('- Auth state isLoading');
  // Show loading only on initial load
  if (currentPath == AppRoute.root.path) return null;
  // Keep current path during other loading states
  return currentPath;
}

String? _handleErrorState(AppRoute currentRoute) {
  debugPrint('- Auth state has error');
  // On error, redirect to auth unless already there
  if (currentRoute == AppRoute.auth) return null;
  RouterLogger.logRedirect(currentRoute.path, AppRoute.auth.path);
  return AppRoute.auth.path;
}

String? _handleAuthData({
  required AuthResult? authResult,
  required String currentPath,
}) {
  // First handle the null case
  if (authResult == null) {
    RouterLogger.logInfo('User is not authenticated');
    if (currentPath == AppRoute.auth.path) return null;
    return AppRoute.auth.path;
  }

  if (authResult case AuthUser(:final user)) {
    RouterLogger.logInfo('User authenticated: ${user.id}\n'
        'Email verified: ${user.isEmailVerified}\n'
        'Approved: ${user.isApproved}');

    // Handle email verification
    if (!user.isEmailVerified) {
      if (currentPath == AppRoute.emailVerification.path) return null;
      RouterLogger.logRedirect(currentPath, AppRoute.emailVerification.path);
      return AppRoute.emailVerification.path;
    }

    // Handle approval
    if (!user.isApproved) {
      if (currentPath == AppRoute.waitingApproval.path) return null;
      RouterLogger.logRedirect(currentPath, AppRoute.waitingApproval.path);
      return AppRoute.waitingApproval.path;
    }

    // If user is verified and approved, redirect to home from root or auth
    if (currentPath == AppRoute.root.path ||
        currentPath == AppRoute.auth.path ||
        currentPath == AppRoute.emailVerification.path ||
        currentPath == AppRoute.waitingApproval.path) {
      RouterLogger.logRedirect(currentPath, AppRoute.news.path);
      return AppRoute.news.path;
    }
  }

  return null;
}

String? _handleProfileRedirect({
  required AppRoute route,
  required AuthResult? authResult,
  required bool isVerified,
  required bool isApproved,
}) {
  // Check authentication
  if (authResult case AuthUser(:final user)) {
    // Check verification for profile routes
    if (!isVerified) {
      return AppRoute.emailVerification.path;
    }

    // Check approval for certain profile actions
    if (route.requiresApproval && !isApproved) {
      return AppRoute.waitingApproval.path;
    }

    return null;
  }

  // Not authenticated
  return AppRoute.auth.path;
}

String? _handleMergeAccount(AppRoute currentRoute) {
  // Handle merge account info
  if (currentRoute == AppRoute.auth) return null;
  return AppRoute.auth.path;
}

String? _handleUserState({
  required AppUser user,
  required AppRoute currentRoute,
  required bool isAdmin,
  required String currentPath,
}) {
  // 1. check admin routes
  if (currentRoute.isAdminRoute && !isAdmin) {
    // If not an Admin redirect to home screen/route
    RouterLogger.logRedirect(currentPath, AppRoute.news.path);
    return AppRoute.news.path;
  }

  // 2. Check email verification
  if (currentRoute.requiresVerification && !user.isEmailVerified) {
    if (currentRoute == AppRoute.emailVerification) return null;
    RouterLogger.logRedirect(currentPath, AppRoute.emailVerification.path);
    return AppRoute.emailVerification.path;
  }

  // 3. check user approval
  if (currentRoute.requiresApproval &&
      !user.isApproved &&
      user.isEmailVerified) {
    if (currentRoute == AppRoute.waitingApproval) return null;
    RouterLogger.logRedirect(currentPath, AppRoute.waitingApproval.path);
    return AppRoute.waitingApproval.path;
  }

  // 4. Redirect authenticated users from auth/root to home
  if ((currentRoute == AppRoute.auth || currentRoute == AppRoute.root) &&
      user.isEmailVerified &&
      user.isApproved) {
    RouterLogger.logRedirect(currentPath, AppRoute.news.path);
    return AppRoute.news.path;
  }
  // No redirect needed
  return null;
}

RouteBase _profileRoutes() {
  return // Profile routes
      ShellRoute(
    builder: (context, state, child) => ProfileShell(child: child),
    routes: [
      GoRoute(
        path: AppRoute.profile.path,
        builder: (context, state) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) => EditProfileScreen(
              user: state.extra as AppUser,
            ),
          ),
          // GoRoute(
          //   path: 'settings',
          //   builder: (context, state) => const ProfileSettingsScreen(),
          // ),
        ],
      ),
    ],
  );
}

// Optional: Add extension methods for common routing operations
extension GoRouterX on GoRouter {
  void goToAuth() => go('/auth');
  void goToHome() => go('/home');
  void goToOnboarding() => go('/onboarding');
  void goToEmailVerification() => go('/verify-email');
  void goToWaitingApproval() => go('/waiting-approval');
}

// Alternative: Simpler current path provider
@riverpod
String? currentPath(Ref ref) {
  return ref
      .watch(appRouterProvider)
      .routerDelegate
      .currentConfiguration
      .uri
      .path;
}

// Optional: Add a provider for easy access to router methods
@riverpod
class RouterController extends _$RouterController {
  @override
  void build() {}

  void goToAuth() => ref.read(appRouterProvider).goToAuth();
  void goToHome() => ref.read(appRouterProvider).goToHome();
  void goToOnboarding() => ref.read(appRouterProvider).goToOnboarding();
  void goToEmailVerification() =>
      ref.read(appRouterProvider).goToEmailVerification();
  void goToWaitingApproval() =>
      ref.read(appRouterProvider).goToWaitingApproval();
}

// Add a more detailed logging utility
class RouterLogger {
  static void logRedirect(String? from, String? to, {Object? reason}) {
    if (to == null) return;
    debugPrint('🚦 Router Redirect:'
        '\n   From: $from'
        '\n   To: $to'
        '${reason != null ? '\n   Extra: $reason' : ''}');
    debugPrint(' Reason: ${_getRedirectReason(from!, to)}');
  }

  static void logError(String message, Object error) {
    debugPrint('❌ Router Error:'
        '\n   Message: $message'
        '\n   Error: $error');
  }

  static void logInfo(String message) {
    debugPrint('ℹ️ Router Info: $message');
  }

  static void logState({
    required String path,
    required AppRoute route,
    required AsyncValue<AuthResult?> authState,
  }) {
    debugPrint('''
🔍 Router State:
    Path: $path
    Route: ${route.name}
    Protection: ${route.protection}
    Auth State: ${authState.whenOrNull(
      data: (result) => switch (result) {
        AuthUser(:final user) =>
          'Authenticated (${user.isEmailVerified ? 'Verified' : 'Unverified'}, ${user.isApproved ? 'Approved' : 'Pending'})',
        MergeAccountInfo() => 'Merge Required',
        null => 'Unauthenticated',
      },
      loading: () => 'Loading',
      error: (e, _) => 'Error: $e',
    )}
    ''');
  }

  static String _getRedirectReason(String from, String to) {
    if (to == AppRoute.auth.path) return 'Authentication required';
    if (to == AppRoute.emailVerification.path)
      return 'Email verification required';
    if (to == AppRoute.waitingApproval.path) return 'Approval required';
    if (to == AppRoute.news.path) return 'User authenticated and approved';
    return 'General redirect';
  }
}

// // TODO:
      // StatefulShellRoute.indexedStack(
      //   // Try using builder instead of indexedStack
      //   // Use navigatorContainerBuilder instead

      //   builder: (context, state, navigationShell) {
      //     return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      //   },
      //   branches: [
      //     StatefulShellBranch(
      //       navigatorKey: _newsNavigatorKey,
      //       routes: [
      //         GoRoute(
      //           path: '/news',
      //           builder: (context, state) => const NewsListScreen(),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       navigatorKey: _eventsNavigatorKey,
      //       routes: [
      //         GoRoute(
      //           path: '/events',
      //           builder: (context, state) => const EventsListScreen(),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),

      // // Feature route builders
// RouteBase _newsRoutes() {
//   return ShellRoute(
//     builder: (context, state, child) => NewsShell(child: child),
//     routes: [
//       GoRoute(
//         path: AppRoute.news.path,
//         builder: (context, state) => const NewsScreen(),
//         routes: [
//           GoRoute(
//             path: 'add',
//             builder: (context, state) => const AddNewsScreen(),
//           ),
//           GoRoute(
//             path: ':id',
//             builder: (context, state) => NewsDetailScreen(
//               id: state.pathParameters['id']!,
//             ),
//             routes: [
//               GoRoute(
//                 path: 'edit',
//                 builder: (context, state) => EditNewsScreen(
//                   id: state.pathParameters['id']!,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//   );
// }