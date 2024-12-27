// private navigators
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/presentation/email_not_verified_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/sign_in_screen.dart';
import 'package:social_app_2/src/features/onboarding/data/onboarding_repository.dart';
import 'package:social_app_2/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:social_app_2/src/routing/go_router_refresh_stream.dart';
import 'package:social_app_2/src/routing/not_found_screen.dart';
import 'package:social_app_2/src/routing/scaffold_with_nested_navigation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _newsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'news');
final _photosNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'photos');
final _instaNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'insta');
final _eventsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'events');
final _directoryNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'directory');
final _committeeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'committee');
final _membersNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'members');
final _jobsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'jobs');
final _entriesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'entries');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

enum AppRoute {
  onboarding,
  settings,
  signIn,
  emailPassword,
  emailNotVerified,
  news,
  singleNews,
  addNews,
  editNews,
  events,
  singleEvent,
  addEvent,
  editEvent,
  instaPost,
  photos,
  addPhotosAlbum,
  photoAlbum,
  photoViewer,
  editPhotoAlbum,
  addPictures,
  members,
  committee,
  directory,
  culturalAwareness,
  jobs,
  job,
  addJob,
  editJob,
  entry,
  addEntry,
  editEntry,
  entries,
  profile,
  editAccount,
}

@riverpod
// ignore: unsupported_provider_value
GoRouter goRouter(Ref ref) {
  // final authRepository = ref.watch(authRepositoryProvider);
  final onboardingRepository =
      ref.watch(onboardingRepositoryProvider).requireValue;
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final didCompleteOnboarding = onboardingRepository.isOnboardingComplete();
      final path = state.uri.path;
      if (!didCompleteOnboarding) {
        // Always check state.subloc before returning a non-null route
        // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart#L78
        if (path != '/onboarding') {
          return '/onboarding';
        }
      }
      // final isLoggedIn = true;
      // // final isLoggedIn = authRepository.currentUser != null;
      // // final isEmailVerified = authRepository.isEmailVerified;

      // if (isLoggedIn == true) {
      //   // if (!isEmailVerified) {
      //   //   return '/emailNotVerified';
      //   // } else if (state.matchedLocation.startsWith('/signIn')) {
      //   //   return '/news';
      //   // }
      //   return '/news';
      // } else {
      //   if (path.startsWith('/news') ||
      //       path.startsWith('/events') ||
      //       path.startsWith('/insta') ||
      //       path.startsWith('/photos') ||
      //       path.startsWith('/account')) {
      //     return '/signIn';
      //   }
      // }
      return null;
    },
    // refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: OnBoardingScreen(),
        ),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SignInScreen(),
        ),
        // routes: [
        //   GoRoute(
        //     path: 'emailPassword',
        //     name: AppRoute.emailPassword.name,
        //     pageBuilder: (context, state) => MaterialPage(
        //       key: state.pageKey,
        //       fullscreenDialog: true,
        //       child: const EmailPasswordSignInScreen(
        //         formType: EmailPasswordSignInFormType.signIn,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      GoRoute(
        path: '/emailNotVerified',
        name: AppRoute.emailNotVerified.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: EmailNotVerifiedScreen(),
        ),
      ),
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      // StatefulShellRoute.indexedStack(
      //   builder: (context, state, navigationShell) {
      //     return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      //   },
      //   branches: [
      //     // StatefulShellBranch(
      //     //   navigatorKey: _jobsNavigatorKey,
      //     //   routes: [
      //     //     GoRoute(
      //     //       path: '/jobs',
      //     //       name: AppRoute.jobs.name,
      //     //       pageBuilder: (context, state) => const NoTransitionPage(
      //     //         child: JobsScreen(),
      //     //       ),
      //     //       // routes: [
      //     //       //   GoRoute(
      //     //       //     path: 'add',
      //     //       //     name: AppRoute.addJob.name,
      //     //       //     parentNavigatorKey: _rootNavigatorKey,
      //     //       //     pageBuilder: (context, state) {
      //     //       //       return const MaterialPage(
      //     //       //         fullscreenDialog: true,
      //     //       //         child: EditJobScreen(),
      //     //       //       );
      //     //       //     },
      //     //       //   ),
      //     //       //   GoRoute(
      //     //       //     path: ':id',
      //     //       //     name: AppRoute.job.name,
      //     //       //     pageBuilder: (context, state) {
      //     //       //       final id = state.pathParameters['id']!;
      //     //       //       return const MaterialPage(
      //     //       //         child: JobEntriesScreen(jobId: id),
      //     //       //       );
      //     //       //     },
      //     //       //     routes: [
      //     //       //       GoRoute(
      //     //       //         path: 'entries/add',
      //     //       //         name: AppRoute.addEntry.name,
      //     //       //         parentNavigatorKey: _rootNavigatorKey,
      //     //       //         pageBuilder: (context, state) {
      //     //       //           final jobId = state.pathParameters['id']!;
      //     //       //           return MaterialPage(
      //     //       //             fullscreenDialog: true,
      //     //       //             child: EntryScreen(
      //     //       //               jobId: jobId,
      //     //       //             ),
      //     //       //           );
      //     //       //         },
      //     //       //       ),
      //     //       //       GoRoute(
      //     //       //         path: 'entries/:eid',
      //     //       //         name: AppRoute.entry.name,
      //     //       //         pageBuilder: (context, state) {
      //     //       //           final jobId = state.pathParameters['id']!;
      //     //       //           final entryId = state.pathParameters['eid']!;
      //     //       //           final entry = state.extra as Entry?;
      //     //       //           return MaterialPage(
      //     //       //             fullscreenDialog: true,
      //     //       //             child: EntryScreen(
      //     //       //               jobId: jobId,
      //     //       //               entryId: entryId,
      //     //       //               entry: entry,
      //     //       //             ),
      //     //       //           );
      //     //       //         },
      //     //       //       ),
      //     //       //       GoRoute(
      //     //       //         path: 'edit',
      //     //       //         name: AppRoute.editJob.name,
      //     //       //         pageBuilder: (context, state) {
      //     //       //           final jobId = state.pathParameters['id'];
      //     //       //           final job = state.extra as Job?;
      //     //       //           return MaterialPage(
      //     //       //             fullscreenDialog: true,
      //     //       //             child: EditJobScreen(jobId: jobId, job: job),
      //     //       //           );
      //     //       //         },
      //     //       //       ),
      //     //       //     ],
      //     //       //   ),
      //     //       // ],
      //     //     )
      //     //   ],
      //     // ),
      //     StatefulShellBranch(
      //       navigatorKey: _newsNavigatorKey,
      //       routes: [
      //         GoRoute(
      //           path: '/news',
      //           name: AppRoute.news.name,
      //           pageBuilder: (context, state) => const NoTransitionPage(
      //             child: NewsListScreen(),
      //           ),
      //           routes: [
      //             GoRoute(
      //               path: 'add',
      //               name: AppRoute.addNews.name,
      //               parentNavigatorKey: _rootNavigatorKey,
      //               pageBuilder: (context, state) {
      //                 return const MaterialPage(
      //                   fullscreenDialog: true,
      //                   child: EditNewsScreen(),
      //                 );
      //               },
      //             ),
      //             GoRoute(
      //               path: ':id',
      //               name: AppRoute.singleNews.name,
      //               pageBuilder: (context, state) {
      //                 final id = state.pathParameters['id'] as NewsID;
      //                 return MaterialPage(
      //                   child: DetailNewsScreen(newsId: id),
      //                 );
      //               },
      //               routes: [
      //                 GoRoute(
      //                   path: 'edit',
      //                   name: AppRoute.editNews.name,
      //                   pageBuilder: (context, state) {
      //                     final newsId = state.pathParameters['id'] as NewsID;
      //                     return MaterialPage(
      //                       child: EditNewsScreen(
      //                         newsId: newsId,
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       navigatorKey: _eventsNavigatorKey,
      //       routes: [
      //         GoRoute(
      //           path: '/events',
      //           name: AppRoute.events.name,
      //           pageBuilder: (context, state) => const NoTransitionPage(
      //             child: EventsScreen(),
      //           ),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       navigatorKey: _instaNavigatorKey,
      //       routes: [
      //         GoRoute(
      //           path: '/insta',
      //           name: AppRoute.instaPost.name,
      //           pageBuilder: (context, state) => const NoTransitionPage(
      //             child: InstaPostScreen(),
      //           ),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       navigatorKey: _photosNavigatorKey,
      //       routes: [
      //         GoRoute(
      //           path: '/photos',
      //           name: AppRoute.photos.name,
      //           pageBuilder: (context, state) => const NoTransitionPage(
      //             child: PhotosScreen(),
      //           ),
      //           routes: [
      //             GoRoute(
      //               path: 'add',
      //               name: AppRoute.addPhotosAlbum.name,
      //               parentNavigatorKey: _rootNavigatorKey,
      //               pageBuilder: (context, state) {
      //                 return const MaterialPage(
      //                   fullscreenDialog: true,
      //                   child: AddPhotosAlbumScreen(),
      //                 );
      //               },
      //             ),
      //             GoRoute(
      //               path: ':albumId',
      //               name: AppRoute.photoAlbum.name,
      //               pageBuilder: (context, state) {
      //                 final albumId =
      //                     state.pathParameters['albumId'] as AlbumID;
      //                 return MaterialPage(
      //                   child: AlbumPhotosScreen(photoAlbumID: albumId),
      //                 );
      //               },
      //               routes: [
      //                 GoRoute(
      //                   path: 'albumPhotos/:initialIndex',
      //                   name: AppRoute.photoViewer.name,
      //                   pageBuilder: (context, state) {
      //                     final albumId =
      //                         state.pathParameters['albumId'] as AlbumID;
      //                     final initialIndex =
      //                         int.parse(state.pathParameters['initialIndex']!);
      //                     final List<Photo> initialPhotos =
      //                         state.extra as List<Photo>;
      //                     return MaterialPage(
      //                       child: DetailPhotoScreen(
      //                         initialPhotos: initialPhotos,
      //                         initialIndex: initialIndex,
      //                         albumId: albumId,
      //                       ),
      //                     );
      //                   },
      //                 ),
      //                 GoRoute(
      //                   path: 'edit',
      //                   name: AppRoute.editPhotoAlbum.name,
      //                   pageBuilder: (context, state) {
      //                     final photoAlbumId =
      //                         state.pathParameters['id'] as PhotoAlbumID;
      //                     final photoAlbum = state.extra as PhotoAlbum?;
      //                     return MaterialPage(
      //                       child: EditPhotoAlbumScreen(
      //                         photoAlbumID: photoAlbumId,
      //                         photoAlbum: photoAlbum,
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       navigatorKey: _accountNavigatorKey,
      //       routes: [
      //         GoRoute(
      //           path: '/account',
      //           name: AppRoute.profile.name,
      //           pageBuilder: (context, state) => const NoTransitionPage(
      //             child: AccountScreen(),
      //           ),
      //           routes: [
      //             GoRoute(
      //               path: 'edit/:userId',
      //               name: AppRoute.editAccount.name,
      //               pageBuilder: (context, state) {
      //                 final userId = state.pathParameters['userId']!;
      //                 return MaterialPage(
      //                   fullscreenDialog: false,
      //                   child: EditAccountScreen(userId: userId),
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
