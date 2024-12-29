// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/constants/firebase_field_name.dart';

@immutable
class Family {
  final String familyId;
  final String primaryAccountId; // Account that paid the membership fee
  final List<String>
      memberAccountIds; // List of user IDs for all family members
  final DateTime membershipStartDate;
  final DateTime membershipEndDate;

  const Family({
    required this.familyId,
    required this.primaryAccountId,
    required this.memberAccountIds,
    required this.membershipStartDate,
    required this.membershipEndDate,
  });

  factory Family.fromMap(Map<String, dynamic> map) {
    return Family(
      familyId: map[FirebaseFieldName.familyId],
      primaryAccountId: map[FirebaseFieldName.primaryAccountId],
      memberAccountIds:
          List<String>.from(map[FirebaseFieldName.memberAccountIds]),
      membershipStartDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.membershipStartDate]),
      membershipEndDate: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldName.membershipEndDate]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FirebaseFieldName.familyId: familyId,
      FirebaseFieldName.primaryAccountId: primaryAccountId,
      FirebaseFieldName.memberAccountIds: memberAccountIds,
      FirebaseFieldName.membershipStartDate:
          membershipStartDate.millisecondsSinceEpoch,
      FirebaseFieldName.membershipEndDate:
          membershipEndDate.millisecondsSinceEpoch,
    };
  }

  bool get isMembershipActive {
    return DateTime.now().isAfter(membershipStartDate) &&
        DateTime.now().isBefore(membershipEndDate);
  }

  Family copyWith({
    String? familyId,
    String? primaryAccountId,
    List<String>? memberAccountIds,
    DateTime? membershipStartDate,
    DateTime? membershipEndDate,
  }) {
    return Family(
      familyId: familyId ?? this.familyId,
      primaryAccountId: primaryAccountId ?? this.primaryAccountId,
      // Important: Create a new List from the original or provided one to avoid reference issues
      memberAccountIds: memberAccountIds != null
          ? List<String>.from(memberAccountIds)
          : List<String>.from(this.memberAccountIds),
      membershipStartDate: membershipStartDate ?? this.membershipStartDate,
      membershipEndDate: membershipEndDate ?? this.membershipEndDate,
    );
  }

  @override
  String toString() {
    return 'Family(familyId: $familyId, primaryAccountId: $primaryAccountId, memberAccountIds: $memberAccountIds, membershipStartDate: $membershipStartDate, membershipEndDate: $membershipEndDate)';
  }

  @override
  bool operator ==(covariant Family other) {
    if (identical(this, other)) return true;

    return other.familyId == familyId &&
        other.primaryAccountId == primaryAccountId &&
        other.memberAccountIds == memberAccountIds &&
        other.membershipStartDate == membershipStartDate &&
        other.membershipEndDate == membershipEndDate;
  }

  @override
  int get hashCode {
    return familyId.hashCode ^
        primaryAccountId.hashCode ^
        memberAccountIds.hashCode ^
        membershipStartDate.hashCode ^
        membershipEndDate.hashCode;
  }
}
