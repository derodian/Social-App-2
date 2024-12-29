import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/constants/firebase_collection_name.dart';
import 'package:social_app_2/src/constants/firebase_field_name.dart';
import 'package:social_app_2/src/features/events/domain/event.dart';
import 'package:social_app_2/src/features/events/domain/event_payload.dart';
import 'package:social_app_2/src/features/events/typedefs/event_id.dart';
import 'package:social_app_2/src/features/services/logger.dart';

part 'event_repository.g.dart';

class EventRepository {
  EventRepository(this._firestore, this._storage);
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  final _log = getLogger("EventRepository");

  static String eventPath() => 'events';
  static String singleEventPath(EventID id) => 'events/$id';

  Future<List<Event>> fetchEventsList(
      {int limit = 20, Event? startAfter}) async {
    try {
      var query = _eventsRef().limit(limit);
      if (startAfter != null) {
        query = query.startAfterDocument(
            await _firestore.doc(singleEventPath(startAfter.id)).get());
      }
      final snapshot = await query.get();
      return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
    } catch (e) {
      _log.e('Error fetching events list: $e');
      rethrow;
    }
  }

  Future<List<Event>> fetchPastEventsList(
      {int limit = 20, Event? startAfter}) async {
    try {
      var query = _pastEventsRef().limit(limit);
      if (startAfter != null) {
        query = query.startAfterDocument(
            await _firestore.doc(singleEventPath(startAfter.id)).get());
      }
      final snapshot = await query.get();
      return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
    } catch (e) {
      _log.e('Error fetching events list: $e');
      rethrow;
    }
  }

  Stream<List<Event>> watchEventsList({int limit = 20, Event? startAfter}) {
    Query<Event> query = _eventsRef().limit(limit);

    if (startAfter != null) {
      query = query.startAfter([startAfter.endDate]);
    }

    return query
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Event>> watchPastEventsList({int limit = 20, Event? startAfter}) {
    Query<Event> query = _pastEventsRef().limit(limit);

    if (startAfter != null) {
      query = query.startAfter([startAfter.endDate]);
    }

    return query
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<Event?> fetchEvent(EventID id) async {
    try {
      final ref = _singleEventRef(id);
      final snapshot = await ref.get();
      return snapshot.data();
    } catch (e) {
      _log.e('Error fetching event $id: $e');
      rethrow;
    }
  }

  Stream<Event?> watchEvent(EventID id) {
    return _singleEventRef(id).snapshots().map((snapshot) => snapshot.data());
  }

  Future<void> createEvent({
    required EventID id,
    required Event event,
    File? imageFile,
  }) async {
    try {
      String? imageUrl;
      String? imageFileName;

      if (imageFile != null) {
        final uploadResult = await _uploadImage(id, imageFile);
        imageUrl = uploadResult.imageUrl;
        imageFileName = uploadResult.fileName;
      }

      final updatedEvent = event.copyWith(
        imageUrl: imageUrl ?? event.imageUrl,
        imageFileName: imageFileName ?? event.imageFileName,
      );

      final payload = EventPayload.fromEvent(updatedEvent);

      await _firestore.doc(singleEventPath(id)).set(
            payload,
            SetOptions(merge: true),
          );
    } catch (e) {
      _log.e('Error creating/updating event $id: $e');
      rethrow;
    }
  }

  Future<void> updateEvent(Event event) async {
    try {
      final ref = _singleEventRef(event.id);
      await ref.set(event);
    } catch (e) {
      _log.e('Error updating event ${event.id}: $e');
      rethrow;
    }
  }

  Future<void> deleteEvent(EventID id) async {
    try {
      final eventImageRef = FirebaseStorage.instance
          .ref()
          .child(FirebaseCollectionName.events)
          .child(id);

      await _firestore.runTransaction((transaction) async {
        final eventRef = _firestore.doc(singleEventPath(id));
        transaction.delete(eventRef);
      });

      try {
        await eventImageRef.delete();
      } catch (e) {
        _log.w('Error deleting event image for $id: $e');
        // Continue execution even if image deletion fails
      }
    } catch (e) {
      _log.e('Error deleting event $id: $e');
      rethrow;
    }
  }

  Future<void> deleteMultipleEvents(List<EventID> ids) async {
    final batch = _firestore.batch();
    for (final id in ids) {
      batch.delete(_firestore.doc(singleEventPath(id)));
    }
    try {
      await batch.commit();
    } catch (e) {
      _log.e('Error deleting multiple events: $e');
      rethrow;
    }
  }

  Future<void> incrementEventViews(EventID id) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final eventRef = _firestore.doc(singleEventPath(id));
        final snapshot = await transaction.get(eventRef);
        final currentViews =
            (snapshot.data()?[FirebaseFieldName.eventViews] as int?) ?? 0;
        transaction
            .update(eventRef, {FirebaseFieldName.eventViews: currentViews + 1});
      });
    } catch (e) {
      _log.e('Error incrementing views for event $id: $e');
      rethrow;
    }
  }

  Future<({String imageUrl, String fileName})> _uploadImage(
      EventID eventId, File imageFile) async {
    final fileName = '${eventId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = _storage
        .ref()
        .child(FirebaseCollectionName.events)
        .child(eventId)
        .child(fileName);

    final uploadTask = await ref.putFile(imageFile);
    final imageUrl = await uploadTask.ref.getDownloadURL();

    return (imageUrl: imageUrl, fileName: fileName);
  }

  Future<void> _deleteImage(EventID eventId, String fileName) async {
    final ref = _storage
        .ref()
        .child(FirebaseCollectionName.events)
        .child(eventId)
        .child(fileName);
    await ref.delete();
  }

  DocumentReference<Event> _singleEventRef(EventID id) =>
      _firestore.doc(singleEventPath(id)).withConverter(
            fromFirestore: (doc, _) => Event.fromMap(doc.data()!),
            toFirestore: (Event event, options) => event.toMap(),
          );

  Query<Event> _eventsRef() => _firestore
      .collection(eventPath())
      .where(FirebaseFieldName.eventEndDate,
          isGreaterThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
      .withConverter(
        fromFirestore: (doc, _) => Event.fromMap(doc.data()!),
        toFirestore: (Event event, options) => event.toMap(),
      )
      .orderBy(FirebaseFieldName.eventEndDate)
      .orderBy(FirebaseFieldName.eventStartDate, descending: false);

  Query<Event> _pastEventsRef() => _firestore
      .collection(eventPath())
      .where(FirebaseFieldName.eventEndDate,
          isLessThan: DateTime.now().millisecondsSinceEpoch)
      .withConverter(
        fromFirestore: (doc, _) => Event.fromMap(doc.data()!),
        toFirestore: (Event event, options) => event.toMap(),
      )
      .orderBy(FirebaseFieldName.eventEndDate, descending: true);

  // * Temporary search implementation
  // * Note: this is quite inefficient as it pulls the
  // * entire news list and then filters the data on
  // * the client
  Future<List<Event>> search(String query) async {
    // 1. Get all news from firebase
    final eventsList = await fetchEventsList(limit: 100);
    // 2. Perform client-side filtering
    return eventsList
        .where(
            (event) => event.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

@Riverpod(keepAlive: true)
EventRepository eventRepository(EventRepositoryRef ref) {
  return EventRepository(
    FirebaseFirestore.instance,
    FirebaseStorage.instance,
  );
}

@Riverpod(keepAlive: true)
class CachedEventsList extends _$CachedEventsList {
  @override
  Future<List<Event>> build() async {
    return ref.watch(eventRepositoryProvider).fetchEventsList();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(eventRepositoryProvider).fetchEventsList());
  }
}

@riverpod
Stream<List<Event>> eventsListStream(EventsListStreamRef ref) {
  final eventRepository = ref.watch(eventRepositoryProvider);
  return eventRepository.watchEventsList();
}

@riverpod
Stream<List<Event>> pastEventsListStream(PastEventsListStreamRef ref) {
  final eventRepository = ref.watch(eventRepositoryProvider);
  return eventRepository.watchPastEventsList();
}

@riverpod
Future<List<Event>> eventsListFuture(EventsListFutureRef ref) {
  final eventRepository = ref.watch(eventRepositoryProvider);
  return eventRepository.fetchEventsList();
}

@riverpod
Stream<Event?> eventStream(EventStreamRef ref, EventID id) {
  final eventRepository = ref.watch(eventRepositoryProvider);
  return eventRepository.watchEvent(id);
}

@riverpod
Future<Event?> eventFuture(EventFutureRef ref, EventID id) {
  final newsRepository = ref.watch(eventRepositoryProvider);
  return newsRepository.fetchEvent(id);
}
