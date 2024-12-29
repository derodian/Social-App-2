import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/breakpoints.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/features/committee_member/data/committee_member_repository.dart';
import 'package:social_app_2/src/features/committee_member/domain/committee_member.dart';
import 'package:social_app_2/src/features/committee_member/presentation/committee_member_card.dart';
import 'package:social_app_2/src/features/committee_member/presentation/grouped_list_header_separator_view.dart';
import 'package:social_app_2/src/features/committee_member/typedefs/committee_member_id.dart';
import 'package:social_app_2/src/features/components/animations/empty_contents_with_text_animation_view.dart';

/// A Widget that displays the list of news that match the search query
class SliverCommitteeMemberGrid extends ConsumerWidget {
  const SliverCommitteeMemberGrid({
    super.key,
    this.onPressed,
  });
  final void Function(BuildContext, CommitteeMemberID)? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final committeeMemberListValue =
        ref.watch(committeeMemberListStreamProvider);

    return AsyncValueSliverWidget<List<CommitteeMember>>(
        value: committeeMemberListValue,
        data: (committeeMember) {
          if (committeeMember.isEmpty) {
            return const SliverToBoxAdapter(
              child: EmptyContentsWithTextAnimationView(
                text: Strings.noCommitteeMembersAvailable,
              ),
            );
          } else {
            return SliverToBoxAdapter(
              child: GroupedListView<dynamic, String>(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                elements: committeeMember,
                groupBy: (cm) {
                  return cm.title;
                },
                groupSeparatorBuilder: (String titleId) =>
                    GroupedListHeaderSeparatorView(
                  titleId: titleId,
                  committee: committeeMember,
                ),
                order: GroupedListOrder.ASC,
                itemBuilder: (context, dynamic cm) {
                  return CommitteeMemberCard(
                    committeeMember: cm as CommitteeMember,
                    onPressed: () =>
                        onPressed?.call(context, cm.committeeMemberId),
                  );
                },
              ),
            );
          }
        });
  }
}

class SliverCommitteeMemberAlignedGrid extends StatelessWidget {
  const SliverCommitteeMemberAlignedGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display
  final int itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            Strings.noCommitteeMembersAvailable,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      );
    }
    // use a LayoutBuilder to determine the crossAxisCount
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        // width of the screen
        final width = constraints.crossAxisExtent;
        // max width allowed for the sliver
        final maxWidth = min(width, Breakpoint.desktop);
        // use 1 column for width < 500px
        // then add one more column for each 250px
        final crossAxisCount = max(1, maxWidth ~/ 250);
        // calculate a "responsive" padding that increases
        // when the width is greater than the desktop breakpoint
        // this is used to center the contents horizontally on large screen
        final padding = width > Breakpoint.desktop + Sizes.p32
            ? (width - Breakpoint.desktop) / 2
            : Sizes.p8;
        return SliverPadding(
          padding:
              EdgeInsets.symmetric(horizontal: padding, vertical: Sizes.p8),
          sliver: SliverAlignedGrid.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: Sizes.p8,
            crossAxisSpacing: Sizes.p8,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
          ),
        );
      },
    );
  }
}
