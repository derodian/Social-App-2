// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:social_app_2/src/constants/firebase_field_name.dart';
import 'package:social_app_2/src/features/committee_member/typedefs/committee_member_id.dart';

class CommitteeMember extends Equatable {
  final CommitteeMemberID committeeMemberId;
  final String title;
  final String titleId;
  final String name;
  final String email;
  final DateTime memberSince;
  final String? phoneNumber;
  final String? userId;
  final String? photoUrl;
  final DateTime? postDate;
  final DateTime? updateDate;
  final String? postedBy;
  final String? photoFileName;
  final String? street;
  final String? city;
  final String? state;
  final String? zip;

  const CommitteeMember({
    required this.title,
    required this.name,
    required this.email,
    required this.titleId,
    required this.memberSince,
    required this.committeeMemberId,
    this.phoneNumber,
    this.userId,
    this.photoUrl,
    this.postDate,
    this.updateDate,
    this.postedBy,
    this.photoFileName,
    this.street,
    this.city,
    this.state,
    this.zip,
  });

  factory CommitteeMember.fromMap(Map<String, dynamic> map) {
    return CommitteeMember(
      committeeMemberId: map[FirebaseFieldName.committeeMemberId],
      userId: map[FirebaseFieldName.committeeMemberUserId],
      title: map[FirebaseFieldName.committeeMemberTitle],
      name: map[FirebaseFieldName.committeeMemberName],
      email: map[FirebaseFieldName.committeeMemberEmail],
      phoneNumber: map[FirebaseFieldName.committeeMemberPhoneNumber],
      titleId: map[FirebaseFieldName.committeeMemberTitleId],
      photoUrl: map[FirebaseFieldName.committeeMemberPhotoUrl],
      memberSince: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.committeeMemberSince]),
      postDate: map[FirebaseFieldName.committeeMemberPostDate] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map[FirebaseFieldName.committeeMemberPostDate])
          : null,
      updateDate: map[FirebaseFieldName.committeeMemberUpdateDate] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map[FirebaseFieldName.committeeMemberUpdateDate])
          : null,
      postedBy: map[FirebaseFieldName.committeeMemberPostedBy],
      photoFileName: map[FirebaseFieldName.committeeMemberPhotoFileName],
      street: map[FirebaseFieldName.committeeMemberStreet],
      city: map[FirebaseFieldName.committeeMemberCity],
      state: map[FirebaseFieldName.committeeMemberState],
      zip: map[FirebaseFieldName.committeeMemberZip],
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
          postDate?.millisecondsSinceEpoch,
      FirebaseFieldName.committeeMemberUpdateDate:
          updateDate?.millisecondsSinceEpoch,
      FirebaseFieldName.committeeMemberPostedBy: postedBy,
      FirebaseFieldName.committeeMemberPhotoFileName: photoFileName,
      FirebaseFieldName.committeeMemberStreet: street,
      FirebaseFieldName.committeeMemberCity: city,
      FirebaseFieldName.committeeMemberState: state,
      FirebaseFieldName.committeeMemberZip: zip,
    };
  }

  @override
  int get hashCode {
    return committeeMemberId.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        titleId.hashCode ^
        photoUrl.hashCode ^
        memberSince.hashCode ^
        postDate.hashCode ^
        updateDate.hashCode ^
        postedBy.hashCode ^
        photoFileName.hashCode ^
        street.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zip.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommitteeMember &&
        other.committeeMemberId == committeeMemberId &&
        other.userId == userId &&
        other.title == title &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.titleId == titleId &&
        other.photoUrl == photoUrl &&
        other.memberSince == memberSince &&
        other.postDate == postDate &&
        other.updateDate == updateDate &&
        other.postedBy == postedBy &&
        other.photoFileName == photoFileName &&
        other.street == street &&
        other.city == city &&
        other.state == state &&
        other.zip == zip;
  }

  CommitteeMember copyWith({
    String? committeeMemberId,
    String? userId,
    String? title,
    String? name,
    String? email,
    String? phoneNumber,
    String? titleId,
    String? photoUrl,
    DateTime? memberSince,
    DateTime? postDate,
    DateTime? updateDate,
    String? postedBy,
    String? photoFileName,
    String? street,
    String? city,
    String? state,
    String? zip,
  }) {
    return CommitteeMember(
      committeeMemberId: committeeMemberId ?? this.committeeMemberId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      titleId: titleId ?? this.titleId,
      photoUrl: photoUrl ?? this.photoUrl,
      memberSince: memberSince ?? this.memberSince,
      postDate: postDate ?? this.postDate,
      updateDate: updateDate ?? this.updateDate,
      postedBy: postedBy ?? this.postedBy,
      photoFileName: photoFileName ?? this.photoFileName,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
    );
  }

  @override
  String toString() {
    return "committeeMemberId: $committeeMemberId, userId: $userId, title: $title, email: $email, name: $name, phoneNumber: $phoneNumber, titleId: $titleId, photoUrl: $photoUrl, photoFileName: $photoFileName, memberSince: $memberSince, postDate: $postDate, updateDate: $updateDate, postedBy: $postedBy, street: $street, city: $city, state: $state, zip: $zip";
  }

  @override
  List<Object?> get props => [
        committeeMemberId,
        userId,
        title,
        name,
        email,
        phoneNumber,
        titleId,
        photoUrl,
        memberSince,
        postDate,
        updateDate,
        photoFileName,
        street,
        city,
        state,
        zip,
      ];

  @override
  bool? get stringify => true;
}
