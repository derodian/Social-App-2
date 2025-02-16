import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/constants/firestore_field_name.dart';
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
          FirestoreFieldName.committeeMemberId: committeeMemberId,
          FirestoreFieldName.committeeMemberUserId: userId,
          FirestoreFieldName.committeeMemberTitle: title,
          FirestoreFieldName.committeeMemberName: name,
          FirestoreFieldName.committeeMemberEmail: email,
          FirestoreFieldName.committeeMemberPhoneNumber: phoneNumber,
          FirestoreFieldName.committeeMemberTitleId: titleId,
          FirestoreFieldName.committeeMemberPhotoUrl: photoUrl,
          FirestoreFieldName.committeeMemberSince:
              memberSince.millisecondsSinceEpoch,
          FirestoreFieldName.committeeMemberPostDate:
              postDate ?? DateTime.now().millisecondsSinceEpoch,
          FirestoreFieldName.committeeMemberUpdateDate:
              DateTime.now().millisecondsSinceEpoch,
          FirestoreFieldName.committeeMemberPostedBy: postedBy,
          FirestoreFieldName.committeeMemberPhotoFileName: photoFileName,
          FirestoreFieldName.street: street,
          FirestoreFieldName.city: city,
          FirestoreFieldName.state: state,
          FirestoreFieldName.zip: zip,
        });
}
