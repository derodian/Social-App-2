import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/events/data/event_repository.dart';
import 'package:social_app_2/src/features/events/domain/event.dart';
import 'package:social_app_2/src/features/events/typedefs/event_id.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/utils/notifier_mounted.dart';

part 'add_edit_event_screen_controller.g.dart';

@riverpod
class AddEditEventScreenController extends _$AddEditEventScreenController
    with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // no-op
  }

  Future<bool> addOrUpdateEvent({
    EventID? eventId,
    required Event event,
    File? eventImageFile,
  }) async {
    final eventRepository = ref.watch(eventRepositoryProvider);
    try {
      state = const AsyncLoading();

      final value = await AsyncValue.guard(() => eventRepository.createEvent(
            id: event.id,
            event: event,
            imageFile: eventImageFile,
          ));

      final success = value.hasError == false;
      if (mounted) {
        state = value;
        if (success) {
          ref.read(goRouterProvider).pop();
        }
      }
      return success;
    } catch (e, st) {
      if (mounted) {
        state = AsyncError(e, st);
      }
      return false;
    }
  }

  Future<void> deleteEvent(EventID id) async {
    final eventRepository = ref.read(eventRepositoryProvider);
    state = const AsyncLoading();
    final value = await AsyncValue.guard(() => eventRepository.deleteEvent(id));
    if (mounted) {
      state = value;
      if (!value.hasError) {
        ref.read(goRouterProvider).pop();
      }
    }
  }
}
