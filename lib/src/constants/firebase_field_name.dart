import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  // Auth
  static const userId = 'uid';
  static const displayName = 'display_name';
  static const email = 'email';
  static const providerId = 'provider_id';
  static const phoneNumber = 'phone_number';
  static const profileImageURL = 'profile_image_url';
  static const profileImageName = 'profile_image_name';
  static const isEmailVerified = 'is_email_verified';
  static const isApproved = 'is_user_approved';
  static const isAdmin = 'is_user_admin';
  static const isInfoShared = 'is_info_shared';
  static const lastLogin = 'last_login';
  static const createdAt = 'created_at';

  // Insta_Post
  static const postId = 'post_id';
  static const comment = 'comment';

  // Common
  static const postedBy = 'postedBy';
  static const imageURL = 'image_url';
  static const imageFileName = 'image_file_name';
  static const date = 'date';
  static const postDate = 'post_date';
  static const lastUpdated = 'last_updated';
  static const createDate = 'create_date';
  static const updateDate = 'update_date';
  static const location = 'location';
  static const address = 'address';
  static const street = 'street';
  static const city = 'city';
  static const state = 'state';
  static const zip = 'zip';
  static const country = 'country';

  // News
  static const newsId = 'news_id';
  static const newsTitle = 'title';
  static const newsShortDescription = 'short_description';
  static const newsDetails = 'news_details';
  static const newsType = 'news_type';

  // Event
  static const eventId = 'event_id';

  const FirebaseFieldName._();
}
