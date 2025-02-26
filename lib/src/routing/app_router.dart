// // private navigators
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:social_app_2/src/common_widgets/error_screen.dart';
// import 'package:social_app_2/src/features/auth/domain/app_user.dart';
// import 'package:social_app_2/src/features/auth/presentation/account/edit_profile_screen.dart';
// import 'package:social_app_2/src/features/auth/presentation/account/profile_screen.dart';
// import 'package:social_app_2/src/features/auth/presentation/auth/auth_screen.dart';
// import 'package:social_app_2/src/features/auth/presentation/auth/email_verification_screen.dart';
// import 'package:social_app_2/src/features/auth/presentation/auth/waiting_for_approval_screen.dart';
// import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
// import 'package:social_app_2/src/features/components/loading/presentation/loading_screen.dart';
// import 'package:social_app_2/src/features/events/presentation/events_list_screen.dart';
// import 'package:social_app_2/src/features/news/presentation/add_edit_news_screen.dart';
// import 'package:social_app_2/src/features/news/presentation/detail_news_screen.dart';
// import 'package:social_app_2/src/features/news/presentation/news_list_screen.dart';
// import 'package:social_app_2/src/features/news/typedefs/news_id.dart';
// import 'package:social_app_2/src/features/onboarding/presentation/onboarding_controller.dart';
// import 'package:social_app_2/src/features/onboarding/presentation/onboarding_screen.dart';
// import 'package:social_app_2/src/routing/app_routes.dart';
// import 'package:social_app_2/src/routing/go_router_refresh_stream.dart';
// import 'package:social_app_2/src/routing/not_found_screen.dart';
// import 'package:social_app_2/src/routing/scaffold_with_nested_navigation.dart';

// part 'app_router.g.dart';

// final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _newsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'news');
// final _photosNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'photos');
// final _instaNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'insta');
// final _eventsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'events');
// final _directoryNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'directory');
// final _committeeNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'committee');
// final _membersNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'members');
// final _jobsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'jobs');
// final _entriesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'entries');
// final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

// enum AppRoute {
//   loading,
//   onboarding,
//   settings,
//   auth,
//   emailPassword,
//   emailNotVerified,
//   waitingApproval,
//   home,
//   news,
//   singleNews,
//   addNews,
//   editNews,
//   events,
//   singleEvent,
//   addEvent,
//   editEvent,
//   instaPost,
//   photos,
//   addPhotosAlbum,
//   photoAlbum,
//   photoViewer,
//   editPhotoAlbum,
//   addPictures,
//   members,
//   committeeMembers,
//   directory,
//   culturalAwareness,
//   jobs,
//   job,
//   addJob,
//   editJob,
//   entry,
//   addEntry,
//   editEntry,
//   entries,
//   profile,
//   editProfile,
//   account,
//   admin,
//   appUsers,
//   singleCommitteeMember,
//   addCommitteeMember,
//   editCommitteeMember,
// }

// @Riverpod(keepAlive: true)
// // ignore: unsupported_provider_value
// GoRouter appRouter(Ref ref) {
//   // bool isProtectedRoute(String path) {
//   //   return path.startsWith('/news') ||
//   //       path.startsWith('/events') ||
//   //       path.startsWith('/insta') ||
//   //       path.startsWith('/photos') ||
//   //       path.startsWith('/account') ||
//   //       path == '/emailNotVerified' ||
//   //       path == '/waitingForApproval';
//   // }

//   return GoRouter(
//     initialLocation: '/',
//     navigatorKey: _rootNavigatorKey,
//     debugLogDiagnostics: true,
//     redirect: (context, state) {
//       // Create local variables for the states we need to check
//       final authState =
//           ref.read(authControllerProvider); // Use read instead of watch
//       final authController = ref.read(authControllerProvider.notifier);
//       final onboardingComplete =
//           ref.read(onboardingControllerProvider); // Use read here too

//       // Skip redirection if reathenticating
//       if (authController.isReauthenticating) {
//         return null;
//       }

//       // Get the current path
//       final path = state.uri.path;
//       final currentPath = state.matchedLocation;

//       RouterLogger.logInfo('Checking redirect for path: $currentPath');
//       RouterLogger.logInfo('Auth state: ${authState.toString()}');
//       RouterLogger.logInfo('Onboarding complete: $onboardingComplete');

//       // Handle loading state
//       if (authState.isLoading) {
//         RouterLogger.logRedirect(currentPath, null);
//         return '/';
//         // return null;
//       }

//       // Handle error state
//       if (authState.hasError) {
//         debugPrint('Auth state error: ${authState.error}');
//         return '/auth';
//       }

//       // Check if user is on specific routes
//       final isAuthRoute = currentPath == '/auth';
//       final isVerificationRoute = currentPath == '/verify-email';
//       final isApprovalRoute = currentPath == '/waiting-approval';

//       // 1. Check onboarding
//       // Check onboarding first
//       if (!onboardingComplete) {
//         // If not on onboarding screen, redirect to onboarding
//         if (currentPath != '/onboarding') {
//           RouterLogger.logRedirect(currentPath, '/onboarding');
//           return '/onboarding';
//         }
//         return null;
//       }

//       // Only handle authentication states, ignore error states
//       if (authState.hasValue && !authState.hasError) {
//         final user = authState.value;

//         // If no user, redirect to auth unless already there
//         if (user == null && !isAuthRoute) {
//           RouterLogger.logRedirect(currentPath, '/auth');
//           return '/auth';
//         }

//         // If we have a user
//         if (user != null) {
//           // Don't redirect if already on the correct screen
//           if (!user.isEmailVerified && !isVerificationRoute) {
//             RouterLogger.logRedirect(currentPath, '/verify-email');
//             return '/verify-email';
//           }

//           if (user.isEmailVerified && !user.isApproved && !isApprovalRoute) {
//             RouterLogger.logRedirect(currentPath, '/waiting-approval');
//             return '/waiting-approval';
//           }

//           // If user is fully verified and approved, send to home
//           if (user.isEmailVerified && user.isApproved) {
//             RouterLogger.logRedirect(currentPath, '/home');
//             // 5. Handle authenticated and approved user redirects
//             if (path == AppRoutes.auth ||
//                 path == AppRoutes.emailNotVerified ||
//                 path == AppRoutes.waitingForApproval ||
//                 path == AppRoutes.onboarding) {
//               return AppRoutes.news;
//             }
//             return '/news';
//           }
//         }
//       }

//       // // If we're at root and not authenticated, go to auth
//       // if (currentPath == '/' && !authState.isLoading) {
//       //   RouterLogger.logRedirect(currentPath, '/auth');
//       //   return '/auth';
//       // }

//       // // 5. Handle authenticated and approved user redirects
//       // if (path == AppRoutes.auth ||
//       //     path == AppRoutes.emailNotVerified ||
//       //     path == AppRoutes.waitingForApproval ||
//       //     path == AppRoutes.onboarding) {
//       //   return AppRoutes.news;
//       // }

//       // No redirect needed
//       RouterLogger.logRedirect(currentPath, null);
//       return null;
//     },
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) => const LoadingScreen(),
//       ),
//       GoRoute(
//         path: '/error',
//         builder: (context, state) => ErrorScreen(
//           error: state.extra?.toString() ?? 'An unknown error occurred',
//         ),
//       ),
//       GoRoute(
//         path: '/onboarding',
//         name: AppRoute.onboarding.name,
//         // pageBuilder: (context, state) => const NoTransitionPage(
//         //   child: OnBoardingScreen(),
//         // ),
//         builder: (context, state) => const OnBoardingScreen(),
//       ),
//       GoRoute(
//         path: '/auth',
//         name: AppRoute.auth.name,
//         pageBuilder: (context, state) => const NoTransitionPage(
//           child: AuthScreen(),
//         ),
//       ),

//       GoRoute(
//         path: '/verify-email',
//         name: AppRoute.emailNotVerified.name,
//         pageBuilder: (context, state) => const NoTransitionPage(
//           child: EmailVerificationScreen(),
//         ),
//       ),
//       GoRoute(
//         path: '/waiting-approval',
//         name: AppRoute.waitingApproval.name,
//         pageBuilder: (context, state) => const NoTransitionPage(
//           child: WaitingApprovalScreen(),
//         ),
//       ),
//       // Stateful navigation based on:
//       // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
//       StatefulShellRoute.indexedStack(
//         builder: (context, state, navigationShell) {
//           return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
//         },
//         branches: [
//           StatefulShellBranch(
//             navigatorKey: _newsNavigatorKey,
//             routes: [
//               GoRoute(
//                 path: '/news',
//                 name: AppRoute.news.name,
//                 pageBuilder: (context, state) => const NoTransitionPage(
//                   child: NewsListScreen(),
//                 ),
//                 routes: [
//                   GoRoute(
//                     path: 'add',
//                     name: AppRoute.addNews.name,
//                     parentNavigatorKey: _rootNavigatorKey,
//                     pageBuilder: (context, state) {
//                       return const MaterialPage(
//                         fullscreenDialog: true,
//                         child: AddEditNewsScreen(),
//                       );
//                     },
//                   ),
//                   GoRoute(
//                     path: ':id',
//                     name: AppRoute.singleNews.name,
//                     pageBuilder: (context, state) {
//                       final id = state.pathParameters['id'] as NewsID;
//                       return MaterialPage(
//                         child: DetailNewsScreen(newsId: id),
//                       );
//                     },
//                     routes: [
//                       GoRoute(
//                         path: 'edit',
//                         name: AppRoute.editNews.name,
//                         pageBuilder: (context, state) {
//                           final newsId = state.pathParameters['id'] as NewsID;
//                           return MaterialPage(
//                             child: AddEditNewsScreen(
//                               newsId: newsId,
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             navigatorKey: _eventsNavigatorKey,
//             routes: [
//               GoRoute(
//                 path: '/events',
//                 name: AppRoute.events.name,
//                 pageBuilder: (context, state) => const NoTransitionPage(
//                   child: EventsListScreen(),
//                 ),
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             navigatorKey: _committeeNavigatorKey,
//             routes: [
//               GoRoute(
//                 path: '/committee',
//                 name: AppRoute.committeeMembers.name,
//                 pageBuilder: (context, state) => const NoTransitionPage(
//                   child: EventsListScreen(),
//                 ),
//                 routes: [],
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             navigatorKey: _accountNavigatorKey,
//             routes: [
//               GoRoute(
//                 path: '/account',
//                 name: AppRoute.profile.name,
//                 pageBuilder: (context, state) => const NoTransitionPage(
//                   child: ProfileScreen(),
//                 ),
//                 routes: [
//                   GoRoute(
//                     path: 'edit/:user',
//                     name: AppRoute.editProfile.name,
//                     pageBuilder: (context, state) {
//                       final user = state.extra as AppUser;
//                       return MaterialPage(
//                         fullscreenDialog: false,
//                         child: EditProfileScreen(
//                           user: user,
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//     errorBuilder: (context, state) => const NotFoundScreen(),
//   );
// }

// // Optional: Add extension methods for common routing operations
// extension GoRouterX on GoRouter {
//   void goToAuth() => go('/auth');
//   void goToHome() => go('/home');
//   void goToOnboarding() => go('/onboarding');
//   void goToEmailVerification() => go('/verify-email');
//   void goToWaitingApproval() => go('/waiting-approval');
// }

// // Optional: Add a provider for easy access to router methods
// @riverpod
// class RouterController extends _$RouterController {
//   @override
//   void build() {}

//   void goToAuth() => ref.read(appRouterProvider).goToAuth();
//   void goToHome() => ref.read(appRouterProvider).goToHome();
//   void goToOnboarding() => ref.read(appRouterProvider).goToOnboarding();
//   void goToEmailVerification() =>
//       ref.read(appRouterProvider).goToEmailVerification();
//   void goToWaitingApproval() =>
//       ref.read(appRouterProvider).goToWaitingApproval();
// }

// // Add a more detailed logging utility
// class RouterLogger {
//   static void logRedirect(String? from, String? to, {Object? extra}) {
//     if (to == null) return;
//     debugPrint('🚦 Router Redirect:'
//         '\n   From: $from'
//         '\n   To: $to'
//         '${extra != null ? '\n   Extra: $extra' : ''}');
//   }

//   static void logError(String message, Object error) {
//     debugPrint('❌ Router Error:'
//         '\n   Message: $message'
//         '\n   Error: $error');
//   }

//   static void logInfo(String message) {
//     debugPrint('ℹ️ Router Info: $message');
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:social_app_2/src/common_widgets/error_screen.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/account/edit_profile_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_shell.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/email_verification_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/waiting_for_approval_screen.dart';
import 'package:social_app_2/src/features/components/loading/presentation/loading_screen.dart';
import 'package:social_app_2/src/features/home_screen.dart';
import 'package:social_app_2/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:social_app_2/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:social_app_2/src/features/settings/presentation/settings_screen.dart';
import 'package:social_app_2/src/routing/app_route.dart';

part 'app_router.g.dart';

// @Riverpod(keepAlive: true)
// GoRouter appRouter(Ref ref) {
//   final rootNavigatorKey = GlobalKey<NavigatorState>();

//   return GoRouter(
//     navigatorKey: rootNavigatorKey,
//     debugLogDiagnostics: true,
//     initialLocation: '/',
//     redirect: (context, state) {
//       final onboardingComplete = ref.read(onboardingControllerProvider);
//       final authState = ref.watch(authControllerProvider);
//       final authController = ref.read(authControllerProvider.notifier);
//       final currentPath = state.matchedLocation;

//       debugPrint('Router checking redirect:');
//       debugPrint('- Current path: $currentPath');
//       debugPrint('- Auth state type: ${authState.runtimeType}');
//       debugPrint('- Auth state value: ${authState.value}');
//       debugPrint('- Auth state isLoading: ${authState.isLoading}');
//       debugPrint('- Onboarding complete: $onboardingComplete');

//       // 1. Skip redirection if reauthenticating
//       if (authController.isReauthenticating) {
//         debugPrint('Router: Skipping redirect during reauthentication');
//         return null;
//       }

//       // 2. Check onboarding completion before any auth checks
//       if (!onboardingComplete) {
//         debugPrint('Onboarding not complete, redirecting to onboarding');
//         if (currentPath == '/onboarding') return null;
//         return '/onboarding';
//       }

//       // 3. Show loading only on initial app load
//       // if (authState.isLoading && currentPath == '/') {
//       //   debugPrint('Staying on loading screen - auth state loading');
//       //   return null;
//       // }
//       // Handle loading state
//       if (authState.isLoading) {
//         debugPrint('Router: Auth state is loading');
//         // Only show loading screen on initial app load
//         if (currentPath == '/') {
//           return null;
//         }
//         // Keep current path during other loading states
//         return currentPath;
//       }

//       // 4. Handle loaded auth state after onboarding is complete
//       if (authState.hasValue && !authState.hasError) {
//         debugPrint('Auth has value: ${authState.value}');

//         // Check if user is on specific routes
//         final isAuthRoute = currentPath == '/auth';
//         final isVerificationRoute = currentPath == '/verify-email';
//         final isApprovalRoute = currentPath == '/waiting-approval';

//         final user = ref.watch(authControllerProvider.notifier).currentUser;
//         // If no user, redirect to auth unless already there
//         if (user == null && !isAuthRoute) {
//           debugPrint('No user found, redirecting to auth');
//           RouterLogger.logRedirect(currentPath, '/auth');
//           return '/auth';
//         }

//         // User exists but email not verified
//         if (user != null) {
//           // Don't redirect if already on the correct screen
//           // Check if user's email is verified
//           if (!user.isEmailVerified && !isVerificationRoute) {
//             RouterLogger.logRedirect(currentPath, '/verify-email');
//             return '/verify-email';
//           }

//           // Email verified but not approved
//           if (user.isEmailVerified && !user.isApproved && !isApprovalRoute) {
//             RouterLogger.logRedirect(currentPath, '/waiting-approval');
//             return '/waiting-approval';
//           }

//           // If user is fully verified and approved, send to home
//           if (user.isEmailVerified && user.isApproved && currentPath == '/') {
//             RouterLogger.logRedirect(currentPath, '/home');
//             return '/home';
//           }
//         }
//       } else {
//         // 4. Any other state (loading/error) -> auth
//         debugPrint('Auth error in router: ${authState.error}');
//         return '/auth';
//       }

//       // If we're at root and not authenticated, go to auth
//       if (currentPath == '/' && !authState.isLoading) {
//         RouterLogger.logRedirect(currentPath, '/auth');
//         return '/auth';
//       }

//       // // 2. Handle auth states
//       // if (authState.hasValue) {
//       //   final user = authState.value;

//       //   if (user == null) {
//       //     debugPrint('Router: No user, redirecting to auth');
//       //     if (currentPath == '/auth') return null;
//       //     return '/auth';
//       //   }

//       //   debugPrint('Router: User found, checking verification');
//       //   if (!user.isEmailVerified) {
//       //     if (currentPath == '/verify-email') return null;
//       //     return '/verify-email';
//       //   }

//       //   if (user.isEmailVerified && !user.isApproved) {
//       //     if (currentPath == '/waiting-approval') return null;
//       //     return '/waiting-approval';
//       //   }

//       //   if (user.isEmailVerified && user.isApproved && currentPath == '/') {
//       //     return '/home';
//       //   }
//       // } else if (authState.isLoading) {
//       //   debugPrint('Router: Auth loading, keeping current path');
//       //   if (currentPath == '/') return null;
//       //   return currentPath;
//       // } else {
//       //   debugPrint('Router: No valid auth state, redirecting to auth');
//       //   if (currentPath == '/auth') return null;
//       //   return '/auth';
//       // }

//       debugPrint('No redirect needed');
//       return null;
//     },
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) => const LoadingScreen(),
//       ),
//       GoRoute(
//         path: '/error',
//         builder: (context, state) => ErrorScreen(
//           error: state.extra?.toString() ?? 'An unknown error occurred',
//         ),
//       ),
//       GoRoute(
//         path: '/onboarding',
//         builder: (context, state) => const OnboardingScreen(),
//       ),
//       GoRoute(
//         path: '/auth',
//         builder: (context, state) => const AuthScreen(),
//       ),
//       GoRoute(
//         path: '/verify-email',
//         builder: (context, state) => const EmailVerificationScreen(),
//       ),
//       GoRoute(
//         path: '/waiting-approval',
//         builder: (context, state) => const WaitingApprovalScreen(),
//       ),
//       GoRoute(
//         path: '/home',
//         builder: (context, state) => const HomeScreen(),
//       ),
//       // Add other routes as needed
//     ],
//     errorBuilder: (context, state) => ErrorScreen(
//       error: state.error.toString(),
//     ),
//   );
// }
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
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
      GoRoute(
        path: AppRoute.home.path,
        builder: (context, state) => const HomeScreen(),
      ),

      // Routes for user preference settings
      GoRoute(
        path: AppRoute.settings.path,
        builder: (context, state) => const SettingsScreen(),
      ),

      // Add other routes as needed
      _profileRoutes(),
      // _newsRoutes(),
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
      RouterLogger.logRedirect(currentPath, AppRoute.home.path);
      return AppRoute.home.path;
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
    RouterLogger.logRedirect(currentPath, AppRoute.home.path);
    return AppRoute.home.path;
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
    RouterLogger.logRedirect(currentPath, AppRoute.home.path);
    return AppRoute.home.path;
  }
  // No redirect needed
  return null;
}

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
    if (to == AppRoute.home.path) return 'User authenticated and approved';
    return 'General redirect';
  }
}
