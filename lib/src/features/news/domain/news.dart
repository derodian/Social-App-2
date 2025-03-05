import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/features/news/typedefs/news_id.dart';

part 'news.freezed.dart';
part 'news.g.dart';

@freezed
class News with _$News {
  const News._();

  const factory News({
    @JsonKey(name: FirestoreFieldName.id) required NewsID id,
    @JsonKey(name: FirestoreFieldName.newsListTitle) required String listTitle,
    @JsonKey(name: FirestoreFieldName.newsPostedBy) required String postedBy,
    @JsonKey(name: FirestoreFieldName.newsType) String? type,
    @JsonKey(name: FirestoreFieldName.newsTitle) required String title,
    @JsonKey(name: FirestoreFieldName.newsDetails) required String newsDetails,
    @JsonKey(name: FirestoreFieldName.newsImageUrl) String? imageUrl,
    @JsonKey(name: FirestoreFieldName.newsImageFileName) String? imageFileName,
    @JsonKey(name: FirestoreFieldName.newsPostDate) required DateTime postDate,
    @JsonKey(name: FirestoreFieldName.newsLastUpdateAt)
    required DateTime lastUpdated,
    @JsonKey(name: FirestoreFieldName.newsLocation) String? location,
    @JsonKey(name: FirestoreFieldName.newsAddress) String? address,
    @JsonKey(name: FirestoreFieldName.city) String? city,
    @JsonKey(name: FirestoreFieldName.state) String? state,
    @JsonKey(name: FirestoreFieldName.zip) String? zip,
    @JsonKey(name: FirestoreFieldName.newsViews) @Default(0) int views,
    @JsonKey(name: FirestoreFieldName.newsIsPublished)
    @Default(true)
    bool isPublished,
    @JsonKey(name: FirestoreFieldName.newsTags) @Default([]) List<String> tags,
    @JsonKey(name: FirestoreFieldName.newsCommentsEnabled)
    @Default(true)
    bool commentsEnabled,
    @JsonKey(name: FirestoreFieldName.newsReactions)
    @Default({})
    Map<String, int> reactions,
    @JsonKey(name: FirestoreFieldName.newsPriority) @Default(0) int priority,
  }) = _News;

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  // Custom factory constructor from Firestore
  factory News.fromFirestore(Map<String, dynamic> data, String id) {
    // Convert Firestore Timestamp to DateTime
    final postDateTimestamp = data[FirestoreFieldName.newsPostDate];
    final lastUpdatedTimestamp = data[FirestoreFieldName.newsLastUpdateAt];

    // Create a modified map with converted dates
    final Map<String, dynamic> jsonData = {
      FirestoreFieldName.id: id,
      ...data,
      FirestoreFieldName.newsPostDate: postDateTimestamp != null
          ? (postDateTimestamp is DateTime
              ? postDateTimestamp
              : postDateTimestamp.toDate())
          : DateTime.now(),
      FirestoreFieldName.newsLastUpdateAt: lastUpdatedTimestamp != null
          ? (lastUpdatedTimestamp is DateTime
              ? lastUpdatedTimestamp
              : lastUpdatedTimestamp.toDate())
          : DateTime.now(),
    };

    return News.fromJson(jsonData);
  }

  // Convert to Firestore map
  Map<String, dynamic> toFirestore() {
    final json = toJson();

    // Convert DateTime to Timestamp
    // Note: This depends on how your Firestore serializer handles DateTime
    // If you need explicit Timestamp conversion, do it here

    return json;
  }
}
