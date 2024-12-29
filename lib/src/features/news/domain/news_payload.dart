import 'dart:collection' show MapView;
import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/constants/firebase_field_name.dart';
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
          FirebaseFieldName.newsId: id,
          FirebaseFieldName.newsTitle: title,
          FirebaseFieldName.newsListTitle: listTitle,
          FirebaseFieldName.newsType: type,
          FirebaseFieldName.newsDetails: newsDetails,
          FirebaseFieldName.newsPostedBy: postedBy,
          FirebaseFieldName.newsImageUrl: imageUrl,
          FirebaseFieldName.newsImageFileName: imageFileName,
          FirebaseFieldName.newsPostDate: postDate.millisecondsSinceEpoch,
          FirebaseFieldName.newsLastUpdated: lastUpdated.millisecondsSinceEpoch,
          FirebaseFieldName.newsLocation: location,
          FirebaseFieldName.newsAddress: address,
          FirebaseFieldName.city: city,
          FirebaseFieldName.state: state,
          FirebaseFieldName.zip: zip,
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
      id: map[FirebaseFieldName.newsId] as String,
      listTitle: map[FirebaseFieldName.newsListTitle] as String,
      postedBy: map[FirebaseFieldName.newsPostedBy] as String,
      postDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.newsPostDate] as int),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.newsLastUpdated] as int),
      title: map[FirebaseFieldName.newsTitle] as String,
      type: map[FirebaseFieldName.newsType] as String?,
      newsDetails: map[FirebaseFieldName.newsDetails] as String,
      imageUrl: map[FirebaseFieldName.newsImageUrl] as String?,
      imageFileName: map[FirebaseFieldName.newsImageFileName] as String?,
      location: map[FirebaseFieldName.newsLocation] as String?,
      address: map[FirebaseFieldName.newsAddress] as String?,
      city: map[FirebaseFieldName.city] as String?,
      state: map[FirebaseFieldName.state] as String?,
      zip: map[FirebaseFieldName.zip] as String?,
      views: (map[FirebaseFieldName.newsViews] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toMap() => Map.unmodifiable(this);
}
