// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      contentId: json['content_id'] as String,
      contentType: json['content_type'] as String,
      userId: json['user_id'] as String,
      text: json['text'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      userName: json['user_name'] as String,
      userProfileImage: json['user_profile_image'] as String?,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      isEdited: json['is_edited'] as bool? ?? false,
      parentId: json['parent_id'] as String?,
      reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      isDeleted: json['is_deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content_id': instance.contentId,
      'content_type': instance.contentType,
      'user_id': instance.userId,
      'text': instance.text,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'user_name': instance.userName,
      'user_profile_image': instance.userProfileImage,
      'likes': instance.likes,
      'is_edited': instance.isEdited,
      'parent_id': instance.parentId,
      'reactions': instance.reactions,
      'is_deleted': instance.isDeleted,
    };
