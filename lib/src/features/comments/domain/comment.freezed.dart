// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  @JsonKey(name: FirestoreFieldName.id)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.contentId)
  String get contentId => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.contentType)
  String get contentType =>
      throw _privateConstructorUsedError; // "news", "photo", "insta", etc.
  @JsonKey(name: FirestoreFieldName.userId)
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.commentText)
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.commentCreatedAt)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.commentUpdatedAt)
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.commentUserName)
  String get userName => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.commentUserProfileImage)
  String? get userProfileImage => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.commentLikes)
  int get likes => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.commentIsEdited)
  bool get isEdited => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.commentParentId)
  String? get parentId =>
      throw _privateConstructorUsedError; // For reply functionality
  @JsonKey(name: FirestoreFieldName.commentReactions)
  Map<String, int> get reactions => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.commentIsDeleted)
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.id) String id,
      @JsonKey(name: FirestoreFieldName.contentId) String contentId,
      @JsonKey(name: FirestoreFieldName.contentType) String contentType,
      @JsonKey(name: FirestoreFieldName.userId) String userId,
      @JsonKey(name: FirestoreFieldName.commentText) String text,
      @JsonKey(name: FirestoreFieldName.commentCreatedAt) DateTime createdAt,
      @JsonKey(name: FirestoreFieldName.commentUpdatedAt) DateTime updatedAt,
      @JsonKey(name: FirestoreFieldName.commentUserName) String userName,
      @JsonKey(name: FirestoreFieldName.commentUserProfileImage)
      String? userProfileImage,
      @JsonKey(name: FirestoreFieldName.commentLikes) int likes,
      @JsonKey(name: FirestoreFieldName.commentIsEdited) bool isEdited,
      @JsonKey(name: FirestoreFieldName.commentParentId) String? parentId,
      @JsonKey(name: FirestoreFieldName.commentReactions)
      Map<String, int> reactions,
      @JsonKey(name: FirestoreFieldName.commentIsDeleted) bool isDeleted});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contentId = null,
    Object? contentType = null,
    Object? userId = null,
    Object? text = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userName = null,
    Object? userProfileImage = freezed,
    Object? likes = null,
    Object? isEdited = null,
    Object? parentId = freezed,
    Object? reactions = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userProfileImage: freezed == userProfileImage
          ? _value.userProfileImage
          : userProfileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      reactions: null == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.id) String id,
      @JsonKey(name: FirestoreFieldName.contentId) String contentId,
      @JsonKey(name: FirestoreFieldName.contentType) String contentType,
      @JsonKey(name: FirestoreFieldName.userId) String userId,
      @JsonKey(name: FirestoreFieldName.commentText) String text,
      @JsonKey(name: FirestoreFieldName.commentCreatedAt) DateTime createdAt,
      @JsonKey(name: FirestoreFieldName.commentUpdatedAt) DateTime updatedAt,
      @JsonKey(name: FirestoreFieldName.commentUserName) String userName,
      @JsonKey(name: FirestoreFieldName.commentUserProfileImage)
      String? userProfileImage,
      @JsonKey(name: FirestoreFieldName.commentLikes) int likes,
      @JsonKey(name: FirestoreFieldName.commentIsEdited) bool isEdited,
      @JsonKey(name: FirestoreFieldName.commentParentId) String? parentId,
      @JsonKey(name: FirestoreFieldName.commentReactions)
      Map<String, int> reactions,
      @JsonKey(name: FirestoreFieldName.commentIsDeleted) bool isDeleted});
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contentId = null,
    Object? contentType = null,
    Object? userId = null,
    Object? text = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userName = null,
    Object? userProfileImage = freezed,
    Object? likes = null,
    Object? isEdited = null,
    Object? parentId = freezed,
    Object? reactions = null,
    Object? isDeleted = null,
  }) {
    return _then(_$CommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userProfileImage: freezed == userProfileImage
          ? _value.userProfileImage
          : userProfileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      reactions: null == reactions
          ? _value._reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl extends _Comment {
  const _$CommentImpl(
      {@JsonKey(name: FirestoreFieldName.id) required this.id,
      @JsonKey(name: FirestoreFieldName.contentId) required this.contentId,
      @JsonKey(name: FirestoreFieldName.contentType) required this.contentType,
      @JsonKey(name: FirestoreFieldName.userId) required this.userId,
      @JsonKey(name: FirestoreFieldName.commentText) required this.text,
      @JsonKey(name: FirestoreFieldName.commentCreatedAt)
      required this.createdAt,
      @JsonKey(name: FirestoreFieldName.commentUpdatedAt)
      required this.updatedAt,
      @JsonKey(name: FirestoreFieldName.commentUserName) required this.userName,
      @JsonKey(name: FirestoreFieldName.commentUserProfileImage)
      this.userProfileImage,
      @JsonKey(name: FirestoreFieldName.commentLikes) this.likes = 0,
      @JsonKey(name: FirestoreFieldName.commentIsEdited) this.isEdited = false,
      @JsonKey(name: FirestoreFieldName.commentParentId) this.parentId,
      @JsonKey(name: FirestoreFieldName.commentReactions)
      final Map<String, int> reactions = const {},
      @JsonKey(name: FirestoreFieldName.commentIsDeleted)
      this.isDeleted = false})
      : _reactions = reactions,
        super._();

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  @JsonKey(name: FirestoreFieldName.id)
  final String id;
  @override
  @JsonKey(name: FirestoreFieldName.contentId)
  final String contentId;
  @override
  @JsonKey(name: FirestoreFieldName.contentType)
  final String contentType;
// "news", "photo", "insta", etc.
  @override
  @JsonKey(name: FirestoreFieldName.userId)
  final String userId;
  @override
  @JsonKey(name: FirestoreFieldName.commentText)
  final String text;
  @override
  @JsonKey(name: FirestoreFieldName.commentCreatedAt)
  final DateTime createdAt;
  @override
  @JsonKey(name: FirestoreFieldName.commentUpdatedAt)
  final DateTime updatedAt;
  @override
  @JsonKey(name: FirestoreFieldName.commentUserName)
  final String userName;
  @override
  @JsonKey(name: FirestoreFieldName.commentUserProfileImage)
  final String? userProfileImage;
  @override
  @JsonKey(name: FirestoreFieldName.commentLikes)
  final int likes;
  @override
  @JsonKey(name: FirestoreFieldName.commentIsEdited)
  final bool isEdited;
  @override
  @JsonKey(name: FirestoreFieldName.commentParentId)
  final String? parentId;
// For reply functionality
  final Map<String, int> _reactions;
// For reply functionality
  @override
  @JsonKey(name: FirestoreFieldName.commentReactions)
  Map<String, int> get reactions {
    if (_reactions is EqualUnmodifiableMapView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reactions);
  }

  @override
  @JsonKey(name: FirestoreFieldName.commentIsDeleted)
  final bool isDeleted;

  @override
  String toString() {
    return 'Comment(id: $id, contentId: $contentId, contentType: $contentType, userId: $userId, text: $text, createdAt: $createdAt, updatedAt: $updatedAt, userName: $userName, userProfileImage: $userProfileImage, likes: $likes, isEdited: $isEdited, parentId: $parentId, reactions: $reactions, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userProfileImage, userProfileImage) ||
                other.userProfileImage == userProfileImage) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            const DeepCollectionEquality()
                .equals(other._reactions, _reactions) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      contentId,
      contentType,
      userId,
      text,
      createdAt,
      updatedAt,
      userName,
      userProfileImage,
      likes,
      isEdited,
      parentId,
      const DeepCollectionEquality().hash(_reactions),
      isDeleted);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(
      this,
    );
  }
}

abstract class _Comment extends Comment {
  const factory _Comment(
      {@JsonKey(name: FirestoreFieldName.id) required final String id,
      @JsonKey(name: FirestoreFieldName.contentId)
      required final String contentId,
      @JsonKey(name: FirestoreFieldName.contentType)
      required final String contentType,
      @JsonKey(name: FirestoreFieldName.userId) required final String userId,
      @JsonKey(name: FirestoreFieldName.commentText) required final String text,
      @JsonKey(name: FirestoreFieldName.commentCreatedAt)
      required final DateTime createdAt,
      @JsonKey(name: FirestoreFieldName.commentUpdatedAt)
      required final DateTime updatedAt,
      @JsonKey(name: FirestoreFieldName.commentUserName)
      required final String userName,
      @JsonKey(name: FirestoreFieldName.commentUserProfileImage)
      final String? userProfileImage,
      @JsonKey(name: FirestoreFieldName.commentLikes) final int likes,
      @JsonKey(name: FirestoreFieldName.commentIsEdited) final bool isEdited,
      @JsonKey(name: FirestoreFieldName.commentParentId) final String? parentId,
      @JsonKey(name: FirestoreFieldName.commentReactions)
      final Map<String, int> reactions,
      @JsonKey(name: FirestoreFieldName.commentIsDeleted)
      final bool isDeleted}) = _$CommentImpl;
  const _Comment._() : super._();

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  @JsonKey(name: FirestoreFieldName.id)
  String get id;
  @override
  @JsonKey(name: FirestoreFieldName.contentId)
  String get contentId;
  @override
  @JsonKey(name: FirestoreFieldName.contentType)
  String get contentType; // "news", "photo", "insta", etc.
  @override
  @JsonKey(name: FirestoreFieldName.userId)
  String get userId;
  @override
  @JsonKey(name: FirestoreFieldName.commentText)
  String get text;
  @override
  @JsonKey(name: FirestoreFieldName.commentCreatedAt)
  DateTime get createdAt;
  @override
  @JsonKey(name: FirestoreFieldName.commentUpdatedAt)
  DateTime get updatedAt;
  @override
  @JsonKey(name: FirestoreFieldName.commentUserName)
  String get userName;
  @override
  @JsonKey(name: FirestoreFieldName.commentUserProfileImage)
  String? get userProfileImage;
  @override
  @JsonKey(name: FirestoreFieldName.commentLikes)
  int get likes;
  @override
  @JsonKey(name: FirestoreFieldName.commentIsEdited)
  bool get isEdited;
  @override
  @JsonKey(name: FirestoreFieldName.commentParentId)
  String? get parentId; // For reply functionality
  @override
  @JsonKey(name: FirestoreFieldName.commentReactions)
  Map<String, int> get reactions;
  @override
  @JsonKey(name: FirestoreFieldName.commentIsDeleted)
  bool get isDeleted;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
