import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/events/data/event_repository.dart';
import 'package:social_app_2/src/features/events/domain/event.dart';

part 'events_list_notifier.g.dart';

@riverpod
class EventsListNotifier extends _$EventsListNotifier {
  static const int _pageSize = 20;
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  @override
  Stream<List<Event>> build() {
    return _watchEvents();
  }

  Stream<List<Event>> _watchEvents() {
    final eventRepository = ref.watch(eventRepositoryProvider);
    return eventRepository.watchEventsList(limit: _pageSize);
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;

    final currentEvents = state.value ?? [];
    if (currentEvents.isEmpty) return;

    final lastEvent = currentEvents.last;
    final eventRepository = ref.read(eventRepositoryProvider);

    final newEvents = await eventRepository.fetchEventsList(
      limit: _pageSize,
      startAfter: lastEvent,
    );

    _hasMore = newEvents.length == _pageSize;
    state = AsyncValue.data([...currentEvents, ...newEvents]);
  }

  Future<void> refresh() async {
    _hasMore = true;
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _watchEvents().first);
  }
}
