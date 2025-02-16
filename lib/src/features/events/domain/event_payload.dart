import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/features/events/domain/event.dart';
import 'package:social_app_2/src/features/events/typedefs/event_id.dart';

@immutable
class EventPayload extends MapView<String, dynamic> {
  EventPayload({
    required EventID id,
    required String listTitle,
    required String postedBy,
    required DateTime postDate,
    required DateTime lastUpdated,
    required String title,
    String? type,
    String? status,
    required String eventDetails,
    String? imageUrl,
    String? imageFileName,
    required DateTime startDate,
    required DateTime endDate,
    String? location,
    String? address,
    String? city,
    String? state,
    String? zip,
    int views = 0,
  }) : super({
          FirestoreFieldName.eventId: id,
          FirestoreFieldName.eventListTitle: listTitle,
          FirestoreFieldName.eventPostedBy: postedBy,
          FirestoreFieldName.eventPostDate: postDate.millisecondsSinceEpoch,
          FirestoreFieldName.eventLastUpdateAt:
              lastUpdated.millisecondsSinceEpoch,
          FirestoreFieldName.eventType: type,
          FirestoreFieldName.eventTitle: title,
          FirestoreFieldName.eventStatus: status,
          FirestoreFieldName.eventDetails: eventDetails,
          FirestoreFieldName.eventImageUrl: imageUrl,
          FirestoreFieldName.eventImageFileName: imageFileName,
          FirestoreFieldName.eventStartDate: startDate.millisecondsSinceEpoch,
          FirestoreFieldName.eventEndDate: endDate.millisecondsSinceEpoch,
          FirestoreFieldName.eventLocation: location,
          FirestoreFieldName.eventAddress: address,
          FirestoreFieldName.eventCity: city,
          FirestoreFieldName.eventState: state,
          FirestoreFieldName.eventZip: zip,
          FirestoreFieldName.eventViews: views,
        });

  EventPayload.fromEvent(Event event)
      : this(
          id: event.id,
          listTitle: event.listTitle,
          postedBy: event.postedBy,
          postDate: event.postDate,
          lastUpdated: event.lastUpdated,
          title: event.title,
          type: event.type,
          status: event.status,
          eventDetails: event.eventDetails,
          imageUrl: event.imageUrl,
          imageFileName: event.imageFileName,
          startDate: event.startDate,
          endDate: event.endDate,
          location: event.location,
          address: event.address,
          city: event.city,
          state: event.state,
          zip: event.zip,
          views: event.views,
        );

  factory EventPayload.fromMap(Map<String, dynamic> map) {
    return EventPayload(
      id: map[FirestoreFieldName.eventId] as String,
      listTitle: map[FirestoreFieldName.eventListTitle] as String,
      postedBy: map[FirestoreFieldName.eventPostedBy] as String,
      postDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirestoreFieldName.eventPostDate] as int),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(
          map[FirestoreFieldName.eventLastUpdateAt] as int),
      title: map[FirestoreFieldName.eventTitle] as String,
      type: map[FirestoreFieldName.eventType] as String?,
      status: map[FirestoreFieldName.eventStatus] as String,
      eventDetails: map[FirestoreFieldName.eventDetails] as String,
      imageUrl: map[FirestoreFieldName.eventImageUrl] as String?,
      imageFileName: map[FirestoreFieldName.eventImageFileName] as String?,
      startDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirestoreFieldName.eventStartDate] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirestoreFieldName.eventEndDate] as int),
      location: map[FirestoreFieldName.eventLocation] as String?,
      address: map[FirestoreFieldName.eventAddress] as String?,
      city: map[FirestoreFieldName.eventCity] as String?,
      state: map[FirestoreFieldName.eventState] as String?,
      zip: map[FirestoreFieldName.eventZip] as String?,
      views: (map[FirestoreFieldName.eventViews] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toMap() => Map.unmodifiable(this);
}
