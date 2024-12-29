import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/features/committee_member/presentation/sliver_committee_member_grid.dart';
import 'package:social_app_2/src/features/components/app_bar/home_app_bar.dart';
import 'package:social_app_2/src/routing/app_router.dart';

class CommitteeMemberListScreen extends ConsumerStatefulWidget {
  const CommitteeMemberListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommitteeMemberListScreenState();
}

class _CommitteeMemberListScreenState
    extends ConsumerState<CommitteeMemberListScreen> {
  // * USe a [ScrollController] to register a listener that dismisses the
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
    return Scaffold(
      appBar: HomeAppBar(
        title: Strings.committee,
        showButtonBackground: true,
        showAddButton: true,
        onPressed: () => context.pushNamed(AppRoute.addCommitteeMember.name),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          /// Search Field
          // const ResponsiveSliverCenter(
          //   padding: EdgeInsets.all(Sizes.p16),
          //   child: NewsSearchTextField(),
          // ),
          SliverCommitteeMemberGrid(
            onPressed: (context, id) => context.pushNamed(
              AppRoute.singleCommitteeMember.name,
              pathParameters: {'id': id},
            ),
          ),
        ],
      ),
    );
  }
}
