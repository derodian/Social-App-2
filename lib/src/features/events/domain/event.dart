// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/features/events/typedefs/event_id.dart';

class Event extends Equatable {
  final EventID id;
  final String title;
  final String listTitle;
  final String postedBy;
  final DateTime postDate;
  final DateTime lastUpdated;
  final String? type;
  final String? status;
  final String eventDetails;
  final String? imageUrl;
  final String? imageFileName;
  final DateTime startDate;
  final DateTime endDate;
  final String? location;
  final String? address;
  final String? city;
  final String? state;
  final String? zip;
  final int views;

  const Event({
    required this.id,
    required this.title,
    required this.listTitle,
    required this.postedBy,
    required this.postDate,
    required this.lastUpdated,
    this.type,
    this.status,
    required this.eventDetails,
    this.imageUrl,
    this.imageFileName,
    required this.startDate,
    required this.endDate,
    this.location,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.views = 0,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey(FirestoreFieldName.eventId)) {
      throw const FormatException('Missing required field: eventId');
    }
    // Add similar checks for other required fields
    return Event(
      id: map[FirestoreFieldName.eventId] as String,
      listTitle: map[FirestoreFieldName.eventListTitle] as String,
      postedBy: map[FirestoreFieldName.eventPostedBy] as String,
      // postDate: DateTime.fromMillisecondsSinceEpoch(
      //     map[FirebaseFieldName.eventPostDate]),
      // lastUpdated: DateTime.fromMillisecondsSinceEpoch(
      //     map[FirebaseFieldName.eventLastUpdated]),
      postDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirestoreFieldName.eventPostDate] as int),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(
          map[FirestoreFieldName.eventLastUpdateAt] as int),
      type: map[FirestoreFieldName.eventType] as String?,
      title: map[FirestoreFieldName.eventTitle] as String,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirestoreFieldName.eventId: id,
      FirestoreFieldName.eventListTitle: listTitle,
      FirestoreFieldName.eventPostedBy: postedBy,
      FirestoreFieldName.eventPostDate: postDate.millisecondsSinceEpoch,
      FirestoreFieldName.eventLastUpdateAt: lastUpdated.millisecondsSinceEpoch,
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
    };
  }

  Event copyWith({
    EventID? id,
    String? listTitle,
    String? postedBy,
    DateTime? postDate,
    DateTime? lastUpdated,
    String? title,
    String? type,
    String? status,
    String? eventDetails,
    String? imageUrl,
    String? imageFileName,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
    String? address,
    String? city,
    String? state,
    String? zip,
    int? views,
  }) {
    return Event(
      id: id ?? this.id,
      listTitle: listTitle ?? this.listTitle,
      postedBy: postedBy ?? this.postedBy,
      postDate: postDate ?? this.postDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      title: title ?? this.title,
      type: type ?? this.type,
      status: status ?? this.status,
      eventDetails: eventDetails ?? this.eventDetails,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFileName: imageFileName ?? this.imageFileName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      views: views ?? this.views,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        listTitle.hashCode ^
        postedBy.hashCode ^
        postDate.hashCode ^
        lastUpdated.hashCode ^
        title.hashCode ^
        type.hashCode ^
        status.hashCode ^
        eventDetails.hashCode ^
        imageUrl.hashCode ^
        imageFileName.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        location.hashCode ^
        address.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zip.hashCode ^
        views.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.id == id &&
        other.listTitle == listTitle &&
        other.postedBy == postedBy &&
        other.postDate == postDate &&
        other.lastUpdated == lastUpdated &&
        other.title == title &&
        other.type == type &&
        other.status == status &&
        other.eventDetails == eventDetails &&
        other.imageUrl == imageUrl &&
        other.imageFileName == imageFileName &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.location == location &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.zip == zip &&
        other.views == views;
  }

  @override
  String toString() =>
      'id: $id, listTitle: $listTitle, postedBy: $postedBy, postDate: $postDate, lastUpdated: $lastUpdated, type: $type, title: $title, status: $status, eventDetails: $eventDetails, imageUrl: $imageUrl, imageFileName: $imageFileName, startDate: $startDate, endDate: $endDate, location: $location, address: $address, city: $city, state: $state, zip: $zip, views: $views';

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        listTitle,
        postedBy,
        postDate,
        lastUpdated,
        title,
        type,
        status,
        eventDetails,
        imageUrl,
        imageFileName,
        startDate,
        endDate,
        location,
        address,
        city,
        state,
        zip,
        views,
      ];
}
