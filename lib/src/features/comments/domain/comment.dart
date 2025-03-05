import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';
import 'package:social_app_2/src/features/comments/typedefs/comment_id.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const Comment._();

  const factory Comment({
    @JsonKey(name: FirestoreFieldName.id) required CommentID id,
    @JsonKey(name: FirestoreFieldName.contentId) required String contentId,
    @JsonKey(name: FirestoreFieldName.contentType)
    required String contentType, // "news", "photo", "insta", etc.
    @JsonKey(name: FirestoreFieldName.userId) required UserID userId,
    @JsonKey(name: FirestoreFieldName.commentText) required String text,
    @JsonKey(name: FirestoreFieldName.commentCreatedAt)
    required DateTime createdAt,
    @JsonKey(name: FirestoreFieldName.commentUpdatedAt)
    required DateTime updatedAt,
    @JsonKey(name: FirestoreFieldName.commentUserName) required String userName,
    @JsonKey(name: FirestoreFieldName.commentUserProfileImage)
    String? userProfileImage,
    @JsonKey(name: FirestoreFieldName.commentLikes) @Default(0) int likes,
    @JsonKey(name: FirestoreFieldName.commentIsEdited)
    @Default(false)
    bool isEdited,
    @JsonKey(name: FirestoreFieldName.commentParentId)
    CommentID? parentId, // For reply functionality
    @JsonKey(name: FirestoreFieldName.commentReactions)
    @Default({})
    Map<String, int> reactions,
    @JsonKey(name: FirestoreFieldName.commentIsDeleted)
    @Default(false)
    bool isDeleted, // Soft delete
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  // Create a comment
  factory Comment.create({
    required CommentID id,
    required String contentId,
    required String contentType,
    required UserID userId,
    required String text,
    required String userName,
    String? userProfileImage,
    CommentID? parentId,
  }) {
    final now = DateTime.now();
    return Comment(
      id: id,
      contentId: contentId,
      contentType: contentType,
      userId: userId,
      text: text,
      createdAt: now,
      updatedAt: now,
      userName: userName,
      userProfileImage: userProfileImage,
      parentId: parentId,
    );
  }

  // Convert to Firestore
  Map<String, dynamic> toFirestore() {
    return toJson();
  }

  // Custom factory from Firestore
  factory Comment.fromFirestore(Map<String, dynamic> data, String id) {
    final createdAtTimestamp = data[FirestoreFieldName.commentCreatedAt];
    final updatedAtTimestamp = data[FirestoreFieldName.commentUpdatedAt];

    final Map<String, dynamic> jsonData = {
      FirestoreFieldName.id: id,
      ...data,
      FirestoreFieldName.commentCreatedAt: createdAtTimestamp != null
          ? (createdAtTimestamp is DateTime
              ? createdAtTimestamp
              : createdAtTimestamp.toDate())
          : DateTime.now(),
      FirestoreFieldName.commentUpdatedAt: updatedAtTimestamp != null
          ? (updatedAtTimestamp is DateTime
              ? updatedAtTimestamp
              : updatedAtTimestamp.toDate())
          : DateTime.now(),
    };

    return Comment.fromJson(jsonData);
  }
}
