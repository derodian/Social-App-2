// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

News _$NewsFromJson(Map<String, dynamic> json) {
  return _News.fromJson(json);
}

/// @nodoc
mixin _$News {
  @JsonKey(name: FirestoreFieldName.id)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsListTitle)
  String get listTitle => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsPostedBy)
  String get postedBy => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsType)
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsTitle)
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsDetails)
  String get newsDetails => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsImageUrl)
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsImageFileName)
  String? get imageFileName => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsPostDate)
  DateTime get postDate => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsLastUpdateAt)
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsLocation)
  String? get location => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsAddress)
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.city)
  String? get city => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.state)
  String? get state => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.zip)
  String? get zip => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsViews)
  int get views => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsIsPublished)
  bool get isPublished => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsTags)
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsCommentsEnabled)
  bool get commentsEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsReactions)
  Map<String, int> get reactions => throw _privateConstructorUsedError;
  @JsonKey(name: FirestoreFieldName.newsPriority)
  int get priority => throw _privateConstructorUsedError;

  /// Serializes this News to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsCopyWith<News> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsCopyWith<$Res> {
  factory $NewsCopyWith(News value, $Res Function(News) then) =
      _$NewsCopyWithImpl<$Res, News>;
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.id) String id,
      @JsonKey(name: FirestoreFieldName.newsListTitle) String listTitle,
      @JsonKey(name: FirestoreFieldName.newsPostedBy) String postedBy,
      @JsonKey(name: FirestoreFieldName.newsType) String? type,
      @JsonKey(name: FirestoreFieldName.newsTitle) String title,
      @JsonKey(name: FirestoreFieldName.newsDetails) String newsDetails,
      @JsonKey(name: FirestoreFieldName.newsImageUrl) String? imageUrl,
      @JsonKey(name: FirestoreFieldName.newsImageFileName)
      String? imageFileName,
      @JsonKey(name: FirestoreFieldName.newsPostDate) DateTime postDate,
      @JsonKey(name: FirestoreFieldName.newsLastUpdateAt) DateTime lastUpdated,
      @JsonKey(name: FirestoreFieldName.newsLocation) String? location,
      @JsonKey(name: FirestoreFieldName.newsAddress) String? address,
      @JsonKey(name: FirestoreFieldName.city) String? city,
      @JsonKey(name: FirestoreFieldName.state) String? state,
      @JsonKey(name: FirestoreFieldName.zip) String? zip,
      @JsonKey(name: FirestoreFieldName.newsViews) int views,
      @JsonKey(name: FirestoreFieldName.newsIsPublished) bool isPublished,
      @JsonKey(name: FirestoreFieldName.newsTags) List<String> tags,
      @JsonKey(name: FirestoreFieldName.newsCommentsEnabled)
      bool commentsEnabled,
      @JsonKey(name: FirestoreFieldName.newsReactions)
      Map<String, int> reactions,
      @JsonKey(name: FirestoreFieldName.newsPriority) int priority});
}

/// @nodoc
class _$NewsCopyWithImpl<$Res, $Val extends News>
    implements $NewsCopyWith<$Res> {
  _$NewsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listTitle = null,
    Object? postedBy = null,
    Object? type = freezed,
    Object? title = null,
    Object? newsDetails = null,
    Object? imageUrl = freezed,
    Object? imageFileName = freezed,
    Object? postDate = null,
    Object? lastUpdated = null,
    Object? location = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? zip = freezed,
    Object? views = null,
    Object? isPublished = null,
    Object? tags = null,
    Object? commentsEnabled = null,
    Object? reactions = null,
    Object? priority = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      listTitle: null == listTitle
          ? _value.listTitle
          : listTitle // ignore: cast_nullable_to_non_nullable
              as String,
      postedBy: null == postedBy
          ? _value.postedBy
          : postedBy // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      newsDetails: null == newsDetails
          ? _value.newsDetails
          : newsDetails // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageFileName: freezed == imageFileName
          ? _value.imageFileName
          : imageFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      postDate: null == postDate
          ? _value.postDate
          : postDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      zip: freezed == zip
          ? _value.zip
          : zip // ignore: cast_nullable_to_non_nullable
              as String?,
      views: null == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: null == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commentsEnabled: null == commentsEnabled
          ? _value.commentsEnabled
          : commentsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      reactions: null == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsImplCopyWith<$Res> implements $NewsCopyWith<$Res> {
  factory _$$NewsImplCopyWith(
          _$NewsImpl value, $Res Function(_$NewsImpl) then) =
      __$$NewsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: FirestoreFieldName.id) String id,
      @JsonKey(name: FirestoreFieldName.newsListTitle) String listTitle,
      @JsonKey(name: FirestoreFieldName.newsPostedBy) String postedBy,
      @JsonKey(name: FirestoreFieldName.newsType) String? type,
      @JsonKey(name: FirestoreFieldName.newsTitle) String title,
      @JsonKey(name: FirestoreFieldName.newsDetails) String newsDetails,
      @JsonKey(name: FirestoreFieldName.newsImageUrl) String? imageUrl,
      @JsonKey(name: FirestoreFieldName.newsImageFileName)
      String? imageFileName,
      @JsonKey(name: FirestoreFieldName.newsPostDate) DateTime postDate,
      @JsonKey(name: FirestoreFieldName.newsLastUpdateAt) DateTime lastUpdated,
      @JsonKey(name: FirestoreFieldName.newsLocation) String? location,
      @JsonKey(name: FirestoreFieldName.newsAddress) String? address,
      @JsonKey(name: FirestoreFieldName.city) String? city,
      @JsonKey(name: FirestoreFieldName.state) String? state,
      @JsonKey(name: FirestoreFieldName.zip) String? zip,
      @JsonKey(name: FirestoreFieldName.newsViews) int views,
      @JsonKey(name: FirestoreFieldName.newsIsPublished) bool isPublished,
      @JsonKey(name: FirestoreFieldName.newsTags) List<String> tags,
      @JsonKey(name: FirestoreFieldName.newsCommentsEnabled)
      bool commentsEnabled,
      @JsonKey(name: FirestoreFieldName.newsReactions)
      Map<String, int> reactions,
      @JsonKey(name: FirestoreFieldName.newsPriority) int priority});
}

/// @nodoc
class __$$NewsImplCopyWithImpl<$Res>
    extends _$NewsCopyWithImpl<$Res, _$NewsImpl>
    implements _$$NewsImplCopyWith<$Res> {
  __$$NewsImplCopyWithImpl(_$NewsImpl _value, $Res Function(_$NewsImpl) _then)
      : super(_value, _then);

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listTitle = null,
    Object? postedBy = null,
    Object? type = freezed,
    Object? title = null,
    Object? newsDetails = null,
    Object? imageUrl = freezed,
    Object? imageFileName = freezed,
    Object? postDate = null,
    Object? lastUpdated = null,
    Object? location = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? zip = freezed,
    Object? views = null,
    Object? isPublished = null,
    Object? tags = null,
    Object? commentsEnabled = null,
    Object? reactions = null,
    Object? priority = null,
  }) {
    return _then(_$NewsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      listTitle: null == listTitle
          ? _value.listTitle
          : listTitle // ignore: cast_nullable_to_non_nullable
              as String,
      postedBy: null == postedBy
          ? _value.postedBy
          : postedBy // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      newsDetails: null == newsDetails
          ? _value.newsDetails
          : newsDetails // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageFileName: freezed == imageFileName
          ? _value.imageFileName
          : imageFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      postDate: null == postDate
          ? _value.postDate
          : postDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      zip: freezed == zip
          ? _value.zip
          : zip // ignore: cast_nullable_to_non_nullable
              as String?,
      views: null == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: null == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commentsEnabled: null == commentsEnabled
          ? _value.commentsEnabled
          : commentsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      reactions: null == reactions
          ? _value._reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsImpl extends _News {
  const _$NewsImpl(
      {@JsonKey(name: FirestoreFieldName.id) required this.id,
      @JsonKey(name: FirestoreFieldName.newsListTitle) required this.listTitle,
      @JsonKey(name: FirestoreFieldName.newsPostedBy) required this.postedBy,
      @JsonKey(name: FirestoreFieldName.newsType) this.type,
      @JsonKey(name: FirestoreFieldName.newsTitle) required this.title,
      @JsonKey(name: FirestoreFieldName.newsDetails) required this.newsDetails,
      @JsonKey(name: FirestoreFieldName.newsImageUrl) this.imageUrl,
      @JsonKey(name: FirestoreFieldName.newsImageFileName) this.imageFileName,
      @JsonKey(name: FirestoreFieldName.newsPostDate) required this.postDate,
      @JsonKey(name: FirestoreFieldName.newsLastUpdateAt)
      required this.lastUpdated,
      @JsonKey(name: FirestoreFieldName.newsLocation) this.location,
      @JsonKey(name: FirestoreFieldName.newsAddress) this.address,
      @JsonKey(name: FirestoreFieldName.city) this.city,
      @JsonKey(name: FirestoreFieldName.state) this.state,
      @JsonKey(name: FirestoreFieldName.zip) this.zip,
      @JsonKey(name: FirestoreFieldName.newsViews) this.views = 0,
      @JsonKey(name: FirestoreFieldName.newsIsPublished)
      this.isPublished = true,
      @JsonKey(name: FirestoreFieldName.newsTags)
      final List<String> tags = const [],
      @JsonKey(name: FirestoreFieldName.newsCommentsEnabled)
      this.commentsEnabled = true,
      @JsonKey(name: FirestoreFieldName.newsReactions)
      final Map<String, int> reactions = const {},
      @JsonKey(name: FirestoreFieldName.newsPriority) this.priority = 0})
      : _tags = tags,
        _reactions = reactions,
        super._();

  factory _$NewsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsImplFromJson(json);

  @override
  @JsonKey(name: FirestoreFieldName.id)
  final String id;
  @override
  @JsonKey(name: FirestoreFieldName.newsListTitle)
  final String listTitle;
  @override
  @JsonKey(name: FirestoreFieldName.newsPostedBy)
  final String postedBy;
  @override
  @JsonKey(name: FirestoreFieldName.newsType)
  final String? type;
  @override
  @JsonKey(name: FirestoreFieldName.newsTitle)
  final String title;
  @override
  @JsonKey(name: FirestoreFieldName.newsDetails)
  final String newsDetails;
  @override
  @JsonKey(name: FirestoreFieldName.newsImageUrl)
  final String? imageUrl;
  @override
  @JsonKey(name: FirestoreFieldName.newsImageFileName)
  final String? imageFileName;
  @override
  @JsonKey(name: FirestoreFieldName.newsPostDate)
  final DateTime postDate;
  @override
  @JsonKey(name: FirestoreFieldName.newsLastUpdateAt)
  final DateTime lastUpdated;
  @override
  @JsonKey(name: FirestoreFieldName.newsLocation)
  final String? location;
  @override
  @JsonKey(name: FirestoreFieldName.newsAddress)
  final String? address;
  @override
  @JsonKey(name: FirestoreFieldName.city)
  final String? city;
  @override
  @JsonKey(name: FirestoreFieldName.state)
  final String? state;
  @override
  @JsonKey(name: FirestoreFieldName.zip)
  final String? zip;
  @override
  @JsonKey(name: FirestoreFieldName.newsViews)
  final int views;
  @override
  @JsonKey(name: FirestoreFieldName.newsIsPublished)
  final bool isPublished;
  final List<String> _tags;
  @override
  @JsonKey(name: FirestoreFieldName.newsTags)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: FirestoreFieldName.newsCommentsEnabled)
  final bool commentsEnabled;
  final Map<String, int> _reactions;
  @override
  @JsonKey(name: FirestoreFieldName.newsReactions)
  Map<String, int> get reactions {
    if (_reactions is EqualUnmodifiableMapView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reactions);
  }

  @override
  @JsonKey(name: FirestoreFieldName.newsPriority)
  final int priority;

  @override
  String toString() {
    return 'News(id: $id, listTitle: $listTitle, postedBy: $postedBy, type: $type, title: $title, newsDetails: $newsDetails, imageUrl: $imageUrl, imageFileName: $imageFileName, postDate: $postDate, lastUpdated: $lastUpdated, location: $location, address: $address, city: $city, state: $state, zip: $zip, views: $views, isPublished: $isPublished, tags: $tags, commentsEnabled: $commentsEnabled, reactions: $reactions, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listTitle, listTitle) ||
                other.listTitle == listTitle) &&
            (identical(other.postedBy, postedBy) ||
                other.postedBy == postedBy) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.newsDetails, newsDetails) ||
                other.newsDetails == newsDetails) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.imageFileName, imageFileName) ||
                other.imageFileName == imageFileName) &&
            (identical(other.postDate, postDate) ||
                other.postDate == postDate) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zip, zip) || other.zip == zip) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.commentsEnabled, commentsEnabled) ||
                other.commentsEnabled == commentsEnabled) &&
            const DeepCollectionEquality()
                .equals(other._reactions, _reactions) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        listTitle,
        postedBy,
        type,
        title,
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
        isPublished,
        const DeepCollectionEquality().hash(_tags),
        commentsEnabled,
        const DeepCollectionEquality().hash(_reactions),
        priority
      ]);

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsImplCopyWith<_$NewsImpl> get copyWith =>
      __$$NewsImplCopyWithImpl<_$NewsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsImplToJson(
      this,
    );
  }
}

abstract class _News extends News {
  const factory _News(
      {@JsonKey(name: FirestoreFieldName.id) required final String id,
      @JsonKey(name: FirestoreFieldName.newsListTitle)
      required final String listTitle,
      @JsonKey(name: FirestoreFieldName.newsPostedBy)
      required final String postedBy,
      @JsonKey(name: FirestoreFieldName.newsType) final String? type,
      @JsonKey(name: FirestoreFieldName.newsTitle) required final String title,
      @JsonKey(name: FirestoreFieldName.newsDetails)
      required final String newsDetails,
      @JsonKey(name: FirestoreFieldName.newsImageUrl) final String? imageUrl,
      @JsonKey(name: FirestoreFieldName.newsImageFileName)
      final String? imageFileName,
      @JsonKey(name: FirestoreFieldName.newsPostDate)
      required final DateTime postDate,
      @JsonKey(name: FirestoreFieldName.newsLastUpdateAt)
      required final DateTime lastUpdated,
      @JsonKey(name: FirestoreFieldName.newsLocation) final String? location,
      @JsonKey(name: FirestoreFieldName.newsAddress) final String? address,
      @JsonKey(name: FirestoreFieldName.city) final String? city,
      @JsonKey(name: FirestoreFieldName.state) final String? state,
      @JsonKey(name: FirestoreFieldName.zip) final String? zip,
      @JsonKey(name: FirestoreFieldName.newsViews) final int views,
      @JsonKey(name: FirestoreFieldName.newsIsPublished) final bool isPublished,
      @JsonKey(name: FirestoreFieldName.newsTags) final List<String> tags,
      @JsonKey(name: FirestoreFieldName.newsCommentsEnabled)
      final bool commentsEnabled,
      @JsonKey(name: FirestoreFieldName.newsReactions)
      final Map<String, int> reactions,
      @JsonKey(name: FirestoreFieldName.newsPriority)
      final int priority}) = _$NewsImpl;
  const _News._() : super._();

  factory _News.fromJson(Map<String, dynamic> json) = _$NewsImpl.fromJson;

  @override
  @JsonKey(name: FirestoreFieldName.id)
  String get id;
  @override
  @JsonKey(name: FirestoreFieldName.newsListTitle)
  String get listTitle;
  @override
  @JsonKey(name: FirestoreFieldName.newsPostedBy)
  String get postedBy;
  @override
  @JsonKey(name: FirestoreFieldName.newsType)
  String? get type;
  @override
  @JsonKey(name: FirestoreFieldName.newsTitle)
  String get title;
  @override
  @JsonKey(name: FirestoreFieldName.newsDetails)
  String get newsDetails;
  @override
  @JsonKey(name: FirestoreFieldName.newsImageUrl)
  String? get imageUrl;
  @override
  @JsonKey(name: FirestoreFieldName.newsImageFileName)
  String? get imageFileName;
  @override
  @JsonKey(name: FirestoreFieldName.newsPostDate)
  DateTime get postDate;
  @override
  @JsonKey(name: FirestoreFieldName.newsLastUpdateAt)
  DateTime get lastUpdated;
  @override
  @JsonKey(name: FirestoreFieldName.newsLocation)
  String? get location;
  @override
  @JsonKey(name: FirestoreFieldName.newsAddress)
  String? get address;
  @override
  @JsonKey(name: FirestoreFieldName.city)
  String? get city;
  @override
  @JsonKey(name: FirestoreFieldName.state)
  String? get state;
  @override
  @JsonKey(name: FirestoreFieldName.zip)
  String? get zip;
  @override
  @JsonKey(name: FirestoreFieldName.newsViews)
  int get views;
  @override
  @JsonKey(name: FirestoreFieldName.newsIsPublished)
  bool get isPublished;
  @override
  @JsonKey(name: FirestoreFieldName.newsTags)
  List<String> get tags;
  @override
  @JsonKey(name: FirestoreFieldName.newsCommentsEnabled)
  bool get commentsEnabled;
  @override
  @JsonKey(name: FirestoreFieldName.newsReactions)
  Map<String, int> get reactions;
  @override
  @JsonKey(name: FirestoreFieldName.newsPriority)
  int get priority;

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsImplCopyWith<_$NewsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
