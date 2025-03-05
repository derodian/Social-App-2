import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirestoreFieldName {
  // Auth
  static const String id = 'id';
  static const String email = 'email';
  static const String displayName = 'display_name';
  static const String profileImageUrl = 'profile_image_url';
  static const String profileBannerImageUrl = 'profile_banner_image_url';
  static const String familyId = 'family_id';
  static const String primaryAccountEmail = 'primary_account_email';
  static const String phoneNumber = 'phone_number';
  static const String street = 'street';
  static const String city = 'city';
  static const String addressState = 'address_state';
  static const String zip = 'zip';
  static const String country = 'country';
  static const String createDate = 'create_date';
  static const String lastUpdateDate = 'last_update_date';
  static const String lastLoginDate = 'last_login_date';
  static const String lastPasswordChangeDate = 'last_password_change_date';
  static const String isAdmin = 'is_admin';
  static const String isEmailVerified = 'is_email_verified';
  static const String isApproved = 'is_approved';
  static const String isInfoShared = 'is_info_shared';
  static const String isChatEnabled = 'is_chat_enabled';
  static const String isPrimaryAccount = 'is_primary_account';
  static const String provider = 'provider';
  static const String linkedProviders = 'linked_providers';
  static const String accountStatus = 'account_status';
  static const String providerData = 'provider_data';
  static const String preferences = 'preferences';
  static const String notificationSettings = 'notification_settings';
  static const String privacySettings = 'privacy_settings';

  // Preferences fields
  static const String systemMode = 'system_mode';
  static const String darkMode = 'dark_mode';
  static const String lightMode = 'light_mode';
  static const String themeMode = 'theme_mode';
  static const String language = 'language';

  // Notification settings fields
  static const String emailNotifications = 'email_notifications';
  static const String pushNotifications = 'push_notifications';
  static const String inAppNotifications = 'in_app_notifications';
  static const String notificationsEnabled = 'notification_enabled';
  static const String notificationCategories = 'notification_categories';

  // Privacy settings fields
  static const String profileVisibleToPublic = 'profile_visible_to_public';
  static const String hideOnlineStatus = 'hide_online_status';
  static const String hideLastSeen = 'hide_last_seen';
  static const String userId = 'user_id';
  static const String deviceToken = 'fcm_device_token';
  static const String apnsToken = 'apns_token';
  static const String platform = 'platform';
  static const String photoURL = 'photo_url';
  static const String state = 'state';
  static const String userSettings = 'user_settings';
  static const String userPreferences = 'user_preferences';

  // Device & Token
  static const String token = 'token';
  static const String deviceInfo = 'device_info';

  // ID

  // Dates
  static const String date = 'date';
  static const String lastActiveAt = 'last_active_at';
  static const String updatedDate = 'update_date';
  static const String postDate = 'post_date';
  static const String lastUpdateAt = 'last_update_at';
  static const String newsPostDate = "post_date";
  static const String newsLastUpdateAt = "last_update_at";
  static const String eventPostDate = "post_date";
  static const String eventLastUpdateAt = "last_update_at";
  static const String eventStartDate = "start_date";
  static const String eventEndDate = "end_date";
  static const String committeeMemberSince = "member_since";
  static const String committeeMemberPostDate = "post_date";
  static const String committeeMemberUpdateDate = "update_date";
  static const String membershipStartDate = "membership_start_date";
  static const String membershipEndDate = "membership_end_date";
  static const String paymentEntryDate = "payment_entry_date";
  static const String paymentDate = "payment_date";
  static const String dueDate = "due_date";

  // Insta_Post
  static const String postId = 'post_id';
  static const String comment = 'comment';

  // Common
  static const String postedBy = 'posted_by';
  static const String imageURL = 'image_url';
  static const String imageFileName = 'image_filename';

  static const String location = 'location';
  static const String address = 'address';

  // News
  static const String newsId = 'news_id';
  static const String newsTitle = 'title';
  static const String newsShortDescription = 'short_description';
  static const String newsDetails = 'news_details';
  static const String newsType = 'news_type';
  static const String newsListTitle = "list_title";
  static const String newsPostedBy = "posted_by";
  static const String newsImageUrl = "image_url";
  static const String newsImageFileName = "image_filename";
  static const String newsLocation = "location";
  static const String newsAddress = "address";
  static const String newsViews = "news_views";
  static const String newsIsPublished = 'is_published';
  static const String newsTags = 'tags';
  static const String newsCommentsEnabled = 'comments_enabled';
  static const String newsReactions = 'reactions';
  static const String newsPriority = 'priority';

  // Event
  static const String eventId = "event_id";
  static const String eventListTitle = "list_title";
  static const String eventPostedBy = "posted_by";
  static const String eventType = "type";
  static const String eventTitle = "title";
  static const String eventStatus = "status";
  static const String eventDetails = "event_details";
  static const String eventImageUrl = "image_url";
  static const String eventImageFileName = "image_filename";
  static const String eventLocation = "location";
  static const String eventAddress = "address";
  static const String eventCity = "city";
  static const String eventState = "state";
  static const String eventZip = "zip";
  static const String eventViews = "event_views";

  // Committee Member
  static const String committeeMemberId = "id";
  static const String committeeMemberUserId = "user_id";
  static const String committeeMemberTitle = "title";
  static const String committeeMemberName = "name";
  static const String committeeMemberEmail = "email";
  static const String committeeMemberPhoneNumber = "phone_number";
  static const String committeeMemberTitleId = "title_id";
  static const String committeeMemberPhotoUrl = "photo_url";
  static const String committeeMemberPostedBy = "posted_by";
  static const String committeeMemberPhotoFileName = "photo_filename";
  static const String committeeMemberStreet = "street";
  static const String committeeMemberCity = "city";
  static const String committeeMemberState = "state";
  static const String committeeMemberZip = "zip";

  // Comments
  static const String contentId = 'content_id';
  static const String commentText = 'text';
  static const String commentCreatedAt = 'created_at';
  static const String commentUpdatedAt = 'updated_at';
  static const String commentUserName = 'user_name';
  static const String commentUserProfileImage = 'user_profile_image';
  static const String commentLikes = 'likes';
  static const String commentIsEdited = 'is_edited';
  static const String commentParentId = 'parent_id';
  static const String commentReactions = 'reactions';
  static const String commentIsDeleted = 'is_deleted';
  static const String contentType =
      'content_type'; // new field to distinguish content types

  // Family
  static const String primaryAccountId = "primary_account_id";
  static const String memberAccountIds = "member_account_ids";

  // Membership payment
  static const String paymentId = "payment_id";
  static const String amountPaid = "amount_paid";
  static const String amountBalance = "amount_balance";
  static const String paymentMethod = "payment_method";
  static const String paymentDescription = "payment_description";

  const FirestoreFieldName._();
}
