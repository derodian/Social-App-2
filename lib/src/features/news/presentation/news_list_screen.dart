import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/circular_profile_image.dart';
import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';
import 'package:social_app_2/src/features/components/app_bar/home_app_bar.dart';
import 'package:social_app_2/src/features/news/presentation/sliver_news_grid.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

class NewsListScreen extends ConsumerStatefulWidget {
  const NewsListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends ConsumerState<NewsListScreen> {
// * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls,
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileControllerProvider).valueOrNull;

    return Scaffold(
      appBar: HomeAppBar(
        title: 'Home',
        customLeading: IconButton(
          onPressed: () async {
            await ref.read(authControllerProvider.notifier).signOut();
            if (context.mounted) {
              ref.read(routerControllerProvider.notifier).goToAuth();
            }
          },
          icon: Icon(Icons.logout_rounded),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircularProfileImage(
              imageUrl: user?.profileImageURL,
              radius: 18,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // drawer: currentUser != null ? const AppDrawerView() : null,
      // body: CustomScrollView(
      //   controller: _scrollController,
      //   slivers: [
      //     /// Search Field
      //     // const ResponsiveSliverCenter(
      //     //   padding: EdgeInsets.all(Sizes.p16),
      //     //   child: NewsSearchTextField(),
      //     // ),
      //     SliverNewsGrid(
      //       onPressed: (context, newsId) {
      //         // TODO uncomment onPressed
      //       },
      //       // onPressed: (context, newsId) => context.goNamed(
      //       //   AppRoute.singleNews.name,
      //       //   pathParameters: {'id': newsId},
      //       // ),
      //     ),
      //   ],
      // ),
      body: Center(
        child: Text('News'.hardcoded),
      ),
    );
  }
}
