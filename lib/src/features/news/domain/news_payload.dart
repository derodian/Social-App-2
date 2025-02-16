import 'dart:collection' show MapView;
import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/features/news/domain/news.dart';
import 'package:social_app_2/src/features/news/typedefs/news_id.dart';

@immutable
class NewsPayload extends MapView<String, dynamic> {
  NewsPayload({
    required NewsID id,
    required String title,
    required String listTitle,
    required String postedBy,
    String? type,
    required DateTime lastUpdated,
    required DateTime postDate,
    required String newsDetails,
    String? imageUrl,
    String? imageFileName,
    String? location,
    String? address,
    String? city,
    String? state,
    String? zip,
    int views = 0,
  }) : super({
          FirestoreFieldName.newsId: id,
          FirestoreFieldName.newsTitle: title,
          FirestoreFieldName.newsListTitle: listTitle,
          FirestoreFieldName.newsType: type,
          FirestoreFieldName.newsDetails: newsDetails,
          FirestoreFieldName.newsPostedBy: postedBy,
          FirestoreFieldName.newsImageUrl: imageUrl,
          FirestoreFieldName.newsImageFileName: imageFileName,
          FirestoreFieldName.newsPostDate: postDate.millisecondsSinceEpoch,
          FirestoreFieldName.newsLastUpdateAt:
              lastUpdated.millisecondsSinceEpoch,
          FirestoreFieldName.newsLocation: location,
          FirestoreFieldName.newsAddress: address,
          FirestoreFieldName.city: city,
          FirestoreFieldName.state: state,
          FirestoreFieldName.zip: zip,
        });

  NewsPayload.fromNews(News news)
      : this(
          id: news.id,
          listTitle: news.listTitle,
          postedBy: news.postedBy,
          postDate: news.postDate,
          lastUpdated: news.lastUpdated,
          title: news.title,
          type: news.type,
          newsDetails: news.newsDetails,
          imageUrl: news.imageUrl,
          imageFileName: news.imageFileName,
          location: news.location,
          address: news.address,
          city: news.city,
          state: news.state,
          zip: news.zip,
          views: news.views,
        );

  factory NewsPayload.fromMap(Map<String, dynamic> map) {
    return NewsPayload(
      id: map[FirestoreFieldName.newsId] as String,
      listTitle: map[FirestoreFieldName.newsListTitle] as String,
      postedBy: map[FirestoreFieldName.newsPostedBy] as String,
      postDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirestoreFieldName.newsPostDate] as int),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(
          map[FirestoreFieldName.newsLastUpdateAt] as int),
      title: map[FirestoreFieldName.newsTitle] as String,
      type: map[FirestoreFieldName.newsType] as String?,
      newsDetails: map[FirestoreFieldName.newsDetails] as String,
      imageUrl: map[FirestoreFieldName.newsImageUrl] as String?,
      imageFileName: map[FirestoreFieldName.newsImageFileName] as String?,
      location: map[FirestoreFieldName.newsLocation] as String?,
      address: map[FirestoreFieldName.newsAddress] as String?,
      city: map[FirestoreFieldName.city] as String?,
      state: map[FirestoreFieldName.state] as String?,
      zip: map[FirestoreFieldName.zip] as String?,
      views: (map[FirestoreFieldName.newsViews] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toMap() => Map.unmodifiable(this);
}
