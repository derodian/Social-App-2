// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsImpl _$$NewsImplFromJson(Map<String, dynamic> json) => _$NewsImpl(
      id: json['id'] as String,
      listTitle: json['list_title'] as String,
      postedBy: json['posted_by'] as String,
      type: json['news_type'] as String?,
      title: json['title'] as String,
      newsDetails: json['news_details'] as String,
      imageUrl: json['image_url'] as String?,
      imageFileName: json['image_filename'] as String?,
      postDate: DateTime.parse(json['post_date'] as String),
      lastUpdated: DateTime.parse(json['last_update_at'] as String),
      location: json['location'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
      views: (json['news_views'] as num?)?.toInt() ?? 0,
      isPublished: json['is_published'] as bool? ?? true,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      commentsEnabled: json['comments_enabled'] as bool? ?? true,
      reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      priority: (json['priority'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$NewsImplToJson(_$NewsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'list_title': instance.listTitle,
      'posted_by': instance.postedBy,
      'news_type': instance.type,
      'title': instance.title,
      'news_details': instance.newsDetails,
      'image_url': instance.imageUrl,
      'image_filename': instance.imageFileName,
      'post_date': instance.postDate.toIso8601String(),
      'last_update_at': instance.lastUpdated.toIso8601String(),
      'location': instance.location,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zip': instance.zip,
      'news_views': instance.views,
      'is_published': instance.isPublished,
      'tags': instance.tags,
      'comments_enabled': instance.commentsEnabled,
      'reactions': instance.reactions,
      'priority': instance.priority,
    };
