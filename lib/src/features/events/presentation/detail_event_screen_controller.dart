import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/events/data/event_repository.dart';
import 'package:social_app_2/src/features/events/domain/event.dart';
import 'package:social_app_2/src/features/events/typedefs/event_id.dart';
import 'package:social_app_2/src/utils/notifier_mounted.dart';

part 'detail_event_screen_controller.g.dart';

@riverpod
class DetailEventScreenController extends _$DetailEventScreenController
    with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
  }

  Future<void> incrementViewCount(EventID eventId) async {
    final eventRepository = ref.read(eventRepositoryProvider);
    await eventRepository.incrementEventViews(eventId);
  }
}

@riverpod
Stream<Event?> eventWithUpdatedViews(Ref ref, EventID eventId) {
  final controller = ref.watch(detailEventScreenControllerProvider.notifier);

  // Increment view count when the stream is first listened to
  ref.onDispose(() {
    controller.incrementViewCount(eventId);
  });

  final eventRepository = ref.watch(eventRepositoryProvider);
  return eventRepository.watchEvent(eventId);
}
