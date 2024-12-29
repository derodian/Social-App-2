import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/constants/firebase_field_name.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, dynamic> {
  UserInfoPayload({
    required UserID userId,
    String? displayName,
    String? email,
    bool? isEmailVerified = false,
    DateTime? createDate,
    DateTime? lastLogin,
    String? providerId,
    String? profileImageURL,
    String? profileImageName,
    bool? isApproved = false,
    bool? isAdmin = false,
    bool? isInfoShared = false,
    DateTime? updateDate,
    String? street,
    String? city,
    String? state,
    String? zip,
    String? country = 'US',
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName ?? '',
            FirebaseFieldName.email: email ?? '',
            FirebaseFieldName.isEmailVerified: isEmailVerified,
            FirebaseFieldName.createDate: createDate,
            FirebaseFieldName.lastLogin: lastLogin,
            FirebaseFieldName.providerId: providerId ?? '',
            FirebaseFieldName.profileImageURL: profileImageURL ?? '',
            FirebaseFieldName.profileImageName: profileImageName ?? '',
            FirebaseFieldName.isApproved: isApproved,
            FirebaseFieldName.isAdmin: isAdmin,
            FirebaseFieldName.isInfoShared: isInfoShared,
            FirebaseFieldName.updateDate: updateDate,
            FirebaseFieldName.street: street ?? '',
            FirebaseFieldName.city: city ?? '',
            FirebaseFieldName.state: state ?? '',
            FirebaseFieldName.zip: zip ?? '',
            FirebaseFieldName.country: country ?? '',
          },
        );
}
