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
  static const userId = 'id';
  static const deviceToken = 'fcm_device_token';
  static const apnsToken = 'apns_token';
  static const platform = 'platform';
  static const photoURL = 'photo_url';
  static const state = 'state';
  static const userSettings = 'user_settings';
  static const userPreferences = 'user_preferences';

  // Device & Token
  static const String token = 'token';
  static const String deviceInfo = 'device_info';

  // ID

  // Dates
  static const date = 'date';
  static const String lastActiveAt = 'last_active_at';
  static const updatedDate = 'update_date';
  static const postDate = 'post_date';
  static const lastUpdateAt = 'last_update_at';
  static const newsPostDate = "post_date";
  static const newsLastUpdateAt = "last_update_at";
  static const eventPostDate = "post_date";
  static const eventLastUpdateAt = "last_update_at";
  static const eventStartDate = "start_date";
  static const eventEndDate = "end_date";
  static const committeeMemberSince = "member_since";
  static const committeeMemberPostDate = "post_date";
  static const committeeMemberUpdateDate = "update_date";
  static const membershipStartDate = "membership_start_date";
  static const membershipEndDate = "membership_end_date";
  static const paymentEntryDate = "payment_entry_date";
  static const paymentDate = "payment_date";
  static const dueDate = "due_date";

  // Insta_Post
  static const postId = 'post_id';
  static const comment = 'comment';

  // Common
  static const postedBy = 'posted_by';
  static const imageURL = 'image_url';
  static const imageFileName = 'image_filename';

  static const location = 'location';
  static const address = 'address';

  // News
  static const newsId = 'news_id';
  static const newsTitle = 'title';
  static const newsShortDescription = 'short_description';
  static const newsDetails = 'news_details';
  static const newsType = 'news_type';
  static const newsListTitle = "list_title";
  static const newsPostedBy = "posted_by";
  static const newsImageUrl = "image_url";
  static const newsImageFileName = "image_filename";
  static const newsLocation = "location";
  static const newsAddress = "address";
  static const newsViews = "news_views";

  // Event
  static const eventId = "event_id";
  static const eventListTitle = "list_title";
  static const eventPostedBy = "posted_by";
  static const eventType = "type";
  static const eventTitle = "title";
  static const eventStatus = "status";
  static const eventDetails = "event_details";
  static const eventImageUrl = "image_url";
  static const eventImageFileName = "image_filename";
  static const eventLocation = "location";
  static const eventAddress = "address";
  static const eventCity = "city";
  static const eventState = "state";
  static const eventZip = "zip";
  static const eventViews = "event_views";

  // Committee Member
  static const committeeMemberId = "id";
  static const committeeMemberUserId = "user_id";
  static const committeeMemberTitle = "title";
  static const committeeMemberName = "name";
  static const committeeMemberEmail = "email";
  static const committeeMemberPhoneNumber = "phone_number";
  static const committeeMemberTitleId = "title_id";
  static const committeeMemberPhotoUrl = "photo_url";
  static const committeeMemberPostedBy = "posted_by";
  static const committeeMemberPhotoFileName = "photo_filename";
  static const committeeMemberStreet = "street";
  static const committeeMemberCity = "city";
  static const committeeMemberState = "state";
  static const committeeMemberZip = "zip";

  // Family
  static const primaryAccountId = "primary_account_id";
  static const memberAccountIds = "member_account_ids";

  // Membership payment
  static const paymentId = "payment_id";
  static const amountPaid = "amount_paid";
  static const amountBalance = "amount_balance";
  static const paymentMethod = "payment_method";
  static const paymentDescription = "payment_description";

  const FirestoreFieldName._();
}
