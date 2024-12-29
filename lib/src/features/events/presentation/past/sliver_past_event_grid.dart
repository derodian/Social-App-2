import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/breakpoints.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/features/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:social_app_2/src/features/events/data/event_repository.dart';
import 'package:social_app_2/src/features/events/domain/event.dart';
import 'package:social_app_2/src/features/events/presentation/event_card.dart';
import 'package:social_app_2/src/features/events/presentation/events_list_notifier.dart';
import 'package:social_app_2/src/features/events/presentation/past/past_events_list_notifier.dart';
import 'package:social_app_2/src/features/events/typedefs/event_id.dart';

/// A Widget that displays the list of past events that match the search query
class SliverPastEventGrid extends ConsumerStatefulWidget {
  const SliverPastEventGrid({
    super.key,
    this.onPressed,
  });

  final void Function(BuildContext, EventID)? onPressed;

  @override
  ConsumerState<SliverPastEventGrid> createState() =>
      _SliverPastEventGridState();
}

class _SliverPastEventGridState extends ConsumerState<SliverPastEventGrid> {
  final ScrollController _scrollController = ScrollController();
  final bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      ref.read(pastEventsListNotifierProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AsyncValueWidget<List<Event>>(
      value: ref.watch(pastEventsListStreamProvider),
      data: (events) => _buildEventGrid(events),
      loading: () => const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => SliverToBoxAdapter(
        child: ErrorDisplay(
          message: 'Error loading events: $error',
          onRetry: () => ref.refresh(eventsListNotifierProvider),
        ),
      ),
    );
  }

  Widget _buildEventGrid(List<Event> events) {
    if (events.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentsWithTextAnimationView(
          text: Strings.noEventAvailable,
        ),
      );
    }

    final hasMore = ref.read(pastEventsListNotifierProvider.notifier).hasMore;

    return SliverPadding(
      padding: const EdgeInsets.all(Sizes.p8),
      sliver: SliverToBoxAdapter(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref
                .refresh(pastEventsListNotifierProvider.notifier)
                .refresh();
          },
          child: SliverPastEventAlignedGrid(
            // itemCount: events.length + (hasMore ? 1 : 0),
            itemCount: events.length + (hasMore && events.length > 1 ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == events.length && hasMore) {
                return const EventCardShimmer();
              }
              final event = events[index];
              return EventCard(
                event: event,
                onPressed: () => widget.onPressed?.call(context, event.id),
              );
            },
            controller: _scrollController,
          ),
        ),
      ),
    );
  }
}

class SliverPastEventAlignedGrid extends StatelessWidget {
  const SliverPastEventAlignedGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.controller,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final maxWidth = min(width, Breakpoint.desktop);
        final crossAxisCount = max(1, maxWidth ~/ 250);
        final padding = width > Breakpoint.desktop + Sizes.p32
            ? (width - Breakpoint.desktop) / 2
            : Sizes.p8;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: AlignedGridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: Sizes.p8,
            crossAxisSpacing: Sizes.p8,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            shrinkWrap: true,
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
          ),
        );
      },
    );
  }
}

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorDisplay({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: Theme.of(context).textTheme.titleMedium),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
