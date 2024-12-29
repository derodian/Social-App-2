import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/constants/firebase_field_name.dart';
import 'package:social_app_2/src/features/committee_member/typedefs/committee_member_id.dart';

@immutable
class CommitteeMemberPayload extends MapView<String, dynamic> {
  CommitteeMemberPayload({
    required CommitteeMemberID committeeMemberId,
    required String title,
    required String name,
    required String email,
    required String titleId,
    required DateTime memberSince,
    String? userId,
    String? phoneNumber,
    String? photoUrl,
    DateTime? postDate,
    DateTime? updateDate,
    String? postedBy,
    String? photoFileName,
    String? street,
    String? city,
    String? state,
    String? zip,
  }) : super({
          FirebaseFieldName.committeeMemberId: committeeMemberId,
          FirebaseFieldName.committeeMemberUserId: userId,
          FirebaseFieldName.committeeMemberTitle: title,
          FirebaseFieldName.committeeMemberName: name,
          FirebaseFieldName.committeeMemberEmail: email,
          FirebaseFieldName.committeeMemberPhoneNumber: phoneNumber,
          FirebaseFieldName.committeeMemberTitleId: titleId,
          FirebaseFieldName.committeeMemberPhotoUrl: photoUrl,
          FirebaseFieldName.committeeMemberSince:
              memberSince.millisecondsSinceEpoch,
          FirebaseFieldName.committeeMemberPostDate:
              postDate ?? DateTime.now().millisecondsSinceEpoch,
          FirebaseFieldName.committeeMemberUpdateDate:
              DateTime.now().millisecondsSinceEpoch,
          FirebaseFieldName.committeeMemberPostedBy: postedBy,
          FirebaseFieldName.committeeMemberPhotoFileName: photoFileName,
          FirebaseFieldName.street: street,
          FirebaseFieldName.city: city,
          FirebaseFieldName.state: state,
          FirebaseFieldName.zip: zip,
        });
}
