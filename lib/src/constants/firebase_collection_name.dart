import 'package:flutter/foundation.dart';

@immutable
class FirebaseCollectionName {
  // for user information
  static const users = 'app_users';
  // for device token
  static const deviceToken = "device_tokens";
  // for member information
  static const members = 'members';
  // for committee information
  static const committee = 'committee';
  // for news
  static const news = 'news';
  // for events
  static const events = 'events';
  // for posts
  static const posts = 'posts';
  // for comments
  static const comments = 'comments';
  // for likes
  static const likes = 'likes';
  // for thumbnails
  static const thumbnails = 'thumbnails';
  // for user profile image
  static const profileImage = 'profile_image';
  // for user profile banner image
  static const profileBannerImage = 'profile_banner_image';

  const FirebaseCollectionName._();
}
