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
  static const familyId = 'family_id';
  static const deviceToken = 'fcm_device_token';
  static const apnsToken = 'apns_token';
  static const platform = 'platform';
  static const photoURL = 'photo_url';
  static const profileBannerImageURL = 'profile_banner_image_url';
  static const photoFileName = 'photo_filename';
  static const isChatEnabled = 'is_chat_enabled';
  static const isPrimaryAccount = 'is_primary_account';
  static const primaryAccountEmail = 'primary_account_email';
  static const updatedDate = 'updated_date';
  static const updateDate = 'update_date';
  static const lastLoginDate = 'last_login';
  static const street = 'street';
  static const city = 'city';
  static const state = 'state';
  static const zip = 'zip';
  static const country = 'country';
  static const userSettings = 'user_settings';

  static const id = 'id';
  static const createdAt = 'created_at';
  static const createdDate = 'created_date';
  static const createDate = 'create_date';
  static const date = 'date';

  // Insta_Post
  static const postId = 'post_id';
  static const comment = 'comment';

  // Common
  static const postedBy = 'posted_by';
  static const imageURL = 'image_url';
  static const imageFileName = 'image_filename';
  static const postDate = 'post_date';
  static const lastUpdated = 'last_updated';
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
  static const newsPostDate = "post_date";
  static const newsLastUpdated = "last_updated";
  static const newsLocation = "location";
  static const newsAddress = "address";
  static const newsViews = "news_views";

  // Event
  static const eventId = "event_id";
  static const eventListTitle = "list_title";
  static const eventPostedBy = "posted_by";
  static const eventPostDate = "post_date";
  static const eventLastUpdated = "last_updated";
  static const eventType = "type";
  static const eventTitle = "title";
  static const eventStatus = "status";
  static const eventDetails = "event_details";
  static const eventImageUrl = "image_url";
  static const eventImageFileName = "image_filename";
  static const eventStartDate = "start_date";
  static const eventEndDate = "end_date";
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
  static const committeeMemberSince = "member_since";
  static const committeeMemberPostDate = "post_date";
  static const committeeMemberUpdateDate = "update_date";
  static const committeeMemberPostedBy = "posted_by";
  static const committeeMemberPhotoFileName = "photo_filename";
  static const committeeMemberStreet = "street";
  static const committeeMemberCity = "city";
  static const committeeMemberState = "state";
  static const committeeMemberZip = "zip";

  // Family
  static const primaryAccountId = "primary_account_id";
  static const memberAccountIds = "member_account_ids";
  static const membershipStartDate = "membership_start_date";
  static const membershipEndDate = "membership_end_date";

  // Membership payment
  static const paymentId = "payment_id";
  static const amountPaid = "amount_paid";
  static const amountBalance = "amount_balance";
  static const paymentEntryDate = "payment_entry_date";
  static const paymentDate = "payment_date";
  static const dueDate = "due_date";
  static const paymentMethod = "payment_method";
  static const paymentDescription = "payment_description";

  const FirebaseFieldName._();
}
