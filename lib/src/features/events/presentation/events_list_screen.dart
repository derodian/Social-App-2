import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/components/app_bar/home_app_bar.dart';
import 'package:social_app_2/src/features/components/drawer/app_drawer_view.dart';
import 'package:social_app_2/src/features/events/presentation/sliver_event_grid.dart';
import 'package:social_app_2/src/routing/app_router.dart';

class EventsListScreen extends ConsumerStatefulWidget {
  const EventsListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EventsListScreenState();
}

class _EventsListScreenState extends ConsumerState<EventsListScreen> {
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
    final currentUser = ref.watch(authStateChangesProvider).value;

    return Scaffold(
      appBar: HomeAppBar(
        title: Strings.events,
        showAddButton: true,
        onPressed: () => context.goNamed(AppRoute.addEvent.name),
      ),
      drawer: currentUser != null ? const AppDrawerView() : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          /// Search Field
          // const ResponsiveSliverCenter(
          //   padding: EdgeInsets.all(Sizes.p16),
          //   child: EventSearchTextField(),
          // ),
          SliverEventGrid(
            onPressed: (context, eventId) => context.goNamed(
              AppRoute.singleEvent.name,
              pathParameters: {'id': eventId},
            ),
          ),
        ],
      ),
    );
  }
}
