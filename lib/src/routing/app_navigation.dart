import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/routing/app_route.dart';
import 'package:social_app_2/src/routing/app_router.dart';

part 'app_navigation.g.dart';

@riverpod
class AppNavigation extends _$AppNavigation {
  @override
  void build() {}

  // Navigation methods
  void push(AppRoute route, {Map<String, String>? params, Object? extra}) {
    final path = params != null ? route.withParams(params) : route.path;
    ref.read(appRouterProvider).push(path, extra: extra);
  }

  void go(AppRoute route, {Map<String, String>? params, Object? extra}) {
    final path = params != null ? route.withParams(params) : route.path;
    ref.read(appRouterProvider).go(path, extra: extra);
  }

  void pop<T>([T? result]) {
    ref.read(appRouterProvider).pop(result);
  }

  // Feature-specific navigation methods
  // Home
  void goToHome() => go(AppRoute.home);

  // News
  void goToNews() => go(AppRoute.news);
  void goToNewsDetail(String id) =>
      push(AppRoute.newsDetail, params: {'id': id});
  void goToAddNews() => push(AppRoute.addNews);
  void goToEditNews(String id) => push(AppRoute.editNews, params: {'id': id});

  // Profile
  void goToProfile() => go(AppRoute.profile);
  void goToEditProfile() => push(AppRoute.editProfile);
  // void goToSettings() => push(AppRoute.settings);
}
