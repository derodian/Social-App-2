import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/constants/firebase_field_name.dart';
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
          FirebaseFieldName.eventId: id,
          FirebaseFieldName.eventListTitle: listTitle,
          FirebaseFieldName.eventPostedBy: postedBy,
          FirebaseFieldName.eventPostDate: postDate.millisecondsSinceEpoch,
          FirebaseFieldName.eventLastUpdated:
              lastUpdated.millisecondsSinceEpoch,
          FirebaseFieldName.eventType: type,
          FirebaseFieldName.eventTitle: title,
          FirebaseFieldName.eventStatus: status,
          FirebaseFieldName.eventDetails: eventDetails,
          FirebaseFieldName.eventImageUrl: imageUrl,
          FirebaseFieldName.eventImageFileName: imageFileName,
          FirebaseFieldName.eventStartDate: startDate.millisecondsSinceEpoch,
          FirebaseFieldName.eventEndDate: endDate.millisecondsSinceEpoch,
          FirebaseFieldName.eventLocation: location,
          FirebaseFieldName.eventAddress: address,
          FirebaseFieldName.eventCity: city,
          FirebaseFieldName.eventState: state,
          FirebaseFieldName.eventZip: zip,
          FirebaseFieldName.eventViews: views,
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
      id: map[FirebaseFieldName.eventId] as String,
      listTitle: map[FirebaseFieldName.eventListTitle] as String,
      postedBy: map[FirebaseFieldName.eventPostedBy] as String,
      postDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.eventPostDate] as int),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.eventLastUpdated] as int),
      title: map[FirebaseFieldName.eventTitle] as String,
      type: map[FirebaseFieldName.eventType] as String?,
      status: map[FirebaseFieldName.eventStatus] as String,
      eventDetails: map[FirebaseFieldName.eventDetails] as String,
      imageUrl: map[FirebaseFieldName.eventImageUrl] as String?,
      imageFileName: map[FirebaseFieldName.eventImageFileName] as String?,
      startDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.eventStartDate] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.eventEndDate] as int),
      location: map[FirebaseFieldName.eventLocation] as String?,
      address: map[FirebaseFieldName.eventAddress] as String?,
      city: map[FirebaseFieldName.eventCity] as String?,
      state: map[FirebaseFieldName.eventState] as String?,
      zip: map[FirebaseFieldName.eventZip] as String?,
      views: (map[FirebaseFieldName.eventViews] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toMap() => Map.unmodifiable(this);
}
