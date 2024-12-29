import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/constants/firebase_field_name.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';

@immutable
class AppUserPayload extends MapView<String, dynamic> {
  AppUserPayload({
    required UserID id,
    required String email,
    required String? fullName,
    String? photoUrl,
    String? profileBannerImageUrl,
    String? photoFileName,
    String? providerId,
    String? familyId,
    int? createDate,
    int? updateDate,
    int? lastLoginDate,
    bool isAdmin = false,
    bool isEmailVerified = false,
    bool isApproved = false,
    bool isInfoShared = false,
    bool isChatEnabled = false,
    bool isPrimaryAccount = false,
    String? primaryAccountEmail,
    String? phoneNumber,
    String? street,
    String? city,
    String? state,
    String? zip,
    String? country,
  }) : super(
          {
            FirebaseFieldName.id: id,
            FirebaseFieldName.displayName: fullName ?? '',
            FirebaseFieldName.email: email,
            FirebaseFieldName.providerId: providerId ?? '',
            FirebaseFieldName.familyId: familyId ?? '',
            FirebaseFieldName.phoneNumber: phoneNumber ?? '',
            FirebaseFieldName.photoURL: photoUrl ?? '',
            FirebaseFieldName.photoFileName: photoFileName ?? '',
            FirebaseFieldName.profileBannerImageURL:
                profileBannerImageUrl ?? '',
            FirebaseFieldName.isEmailVerified: isEmailVerified,
            FirebaseFieldName.isApproved: isApproved,
            FirebaseFieldName.isAdmin: isAdmin,
            FirebaseFieldName.isInfoShared: isInfoShared,
            FirebaseFieldName.isChatEnabled: isChatEnabled,
            FirebaseFieldName.isPrimaryAccount: isPrimaryAccount,
            FirebaseFieldName.primaryAccountEmail: primaryAccountEmail ?? '',
            FirebaseFieldName.createDate:
                createDate ?? DateTime.now().millisecondsSinceEpoch,
            FirebaseFieldName.updateDate: DateTime.now().millisecondsSinceEpoch,
            FirebaseFieldName.lastLoginDate: lastLoginDate,
            FirebaseFieldName.street: street ?? '',
            FirebaseFieldName.city: city ?? '',
            FirebaseFieldName.state: state ?? '',
            FirebaseFieldName.zip: zip ?? '',
            FirebaseFieldName.country: country ?? '',
          },
        );
}
