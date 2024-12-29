// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:social_app_2/src/constants/firebase_field_name.dart';
import 'package:social_app_2/src/features/news/typedefs/news_id.dart';

class News extends Equatable {
  final NewsID id;
  final String listTitle;
  final String postedBy;
  final String? type;
  final String title;
  final String newsDetails;
  final String? imageUrl;
  final String? imageFileName;
  final DateTime postDate;
  final DateTime lastUpdated;
  final String? location;
  final String? address;
  final String? city;
  final String? state;
  final String? zip;
  final int views;

  const News({
    required this.id,
    required this.listTitle,
    required this.postedBy,
    this.type,
    required this.title,
    required this.newsDetails,
    this.imageUrl,
    this.imageFileName,
    required this.postDate,
    required this.lastUpdated,
    this.location,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.views = 0,
  });

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map[FirebaseFieldName.newsId] as String,
      listTitle: map[FirebaseFieldName.newsListTitle] as String,
      postedBy: map[FirebaseFieldName.newsPostedBy] as String,
      type: map[FirebaseFieldName.newsType] as String?,
      title: map[FirebaseFieldName.newsTitle] as String,
      newsDetails: map[FirebaseFieldName.newsDetails] as String,
      imageUrl: map[FirebaseFieldName.newsImageUrl] as String?,
      imageFileName: map[FirebaseFieldName.newsImageFileName] as String?,
      postDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.newsPostDate]),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.newsLastUpdated]),
      location: map[FirebaseFieldName.newsLocation] as String?,
      address: map[FirebaseFieldName.newsAddress] as String?,
      city: map[FirebaseFieldName.city] as String?,
      state: map[FirebaseFieldName.state] as String?,
      zip: map[FirebaseFieldName.zip] as String?,
      views: (map[FirebaseFieldName.newsViews] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        FirebaseFieldName.newsId: id,
        FirebaseFieldName.newsListTitle: listTitle,
        FirebaseFieldName.newsPostedBy: postedBy,
        FirebaseFieldName.newsType: type,
        FirebaseFieldName.newsTitle: title,
        FirebaseFieldName.newsDetails: newsDetails,
        FirebaseFieldName.newsImageUrl: imageUrl,
        FirebaseFieldName.newsImageFileName: imageFileName,
        FirebaseFieldName.newsPostDate: postDate.millisecondsSinceEpoch,
        FirebaseFieldName.newsLastUpdated: lastUpdated.millisecondsSinceEpoch,
        FirebaseFieldName.newsLocation: location,
        FirebaseFieldName.newsAddress: address,
        FirebaseFieldName.city: city,
        FirebaseFieldName.state: state,
        FirebaseFieldName.zip: zip,
        FirebaseFieldName.newsViews: views,
      };

  News copyWith({
    NewsID? id,
    String? listTitle,
    String? postedBy,
    String? type,
    String? title,
    String? newsDetails,
    String? imageUrl,
    String? imageFileName,
    DateTime? postDate,
    DateTime? lastUpdated,
    String? location,
    String? address,
    String? city,
    String? state,
    String? zip,
    int? views,
  }) {
    return News(
      id: id ?? this.id,
      listTitle: listTitle ?? this.listTitle,
      postedBy: postedBy ?? this.postedBy,
      type: type ?? this.type,
      title: title ?? this.title,
      newsDetails: newsDetails ?? this.newsDetails,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFileName: imageFileName ?? this.imageFileName,
      postDate: postDate ?? this.postDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [
        id,
        listTitle,
        postedBy,
        title,
        type,
        newsDetails,
        imageUrl,
        imageFileName,
        postDate,
        lastUpdated,
        location,
        address,
        city,
        state,
        zip,
        views,
      ];

  @override
  bool? get stringify => true;
}
