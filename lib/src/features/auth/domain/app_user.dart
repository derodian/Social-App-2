// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/constants/firebase_field_name.dart';
import 'package:social_app_2/src/features/auth/domain/app_user_payload.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';

@immutable
class AppUser {
  final UserID id;
  final String email;
  final String? displayName;
  final String? photoURL;
  final String? profileBannerImageURL;
  final String? photoFileName;
  final String? providerId;
  final String? familyId;
  final DateTime? createDate;
  final DateTime? updateDate;
  final DateTime? lastLoginDate;
  final bool isAdmin;
  final bool isEmailVerified;
  final bool isApproved;
  final bool isInfoShared;
  final bool isChatEnabled;
  final bool isPrimaryAccount;
  final String? primaryAccountEmail;
  final String? phoneNumber;
  final String? street;
  final String? city;
  final String? state;
  final String? zip;
  final String? country;

  const AppUser({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    this.photoFileName,
    this.profileBannerImageURL,
    this.providerId,
    this.familyId,
    this.isAdmin = false,
    this.isEmailVerified = false,
    this.isApproved = false,
    this.isInfoShared = false,
    this.isChatEnabled = false,
    this.isPrimaryAccount = false,
    this.primaryAccountEmail,
    this.createDate,
    this.updateDate,
    this.lastLoginDate,
    this.phoneNumber,
    this.street,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  factory AppUser.fromPayload(AppUserPayload payload) {
    return AppUser(
      id: payload[FirebaseFieldName.id],
      email: payload[FirebaseFieldName.email],
      displayName: payload[FirebaseFieldName.displayName],
      photoURL: payload[FirebaseFieldName.photoURL],
      photoFileName: payload[FirebaseFieldName.photoFileName],
      profileBannerImageURL: payload[FirebaseFieldName.profileBannerImageURL],
      providerId: payload[FirebaseFieldName.providerId],
      familyId: payload[FirebaseFieldName.familyId],
      isAdmin: payload[FirebaseFieldName.isAdmin] ?? false,
      isEmailVerified: payload[FirebaseFieldName.isEmailVerified] ?? false,
      isApproved: payload[FirebaseFieldName.isApproved] ?? false,
      isChatEnabled: payload[FirebaseFieldName.isChatEnabled] ?? false,
      isInfoShared: payload[FirebaseFieldName.isInfoShared] ?? false,
      isPrimaryAccount: payload[FirebaseFieldName.isPrimaryAccount] ?? false,
      primaryAccountEmail: payload[FirebaseFieldName.primaryAccountEmail],
      createDate: payload[FirebaseFieldName.createDate] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              payload[FirebaseFieldName.createDate])
          : null,
      updateDate: payload[FirebaseFieldName.updateDate] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              payload[FirebaseFieldName.updateDate])
          : null,
      lastLoginDate: payload[FirebaseFieldName.lastLoginDate] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              payload[FirebaseFieldName.lastLoginDate])
          : null,
      phoneNumber: payload[FirebaseFieldName.phoneNumber],
      street: payload[FirebaseFieldName.street],
      city: payload[FirebaseFieldName.city],
      state: payload[FirebaseFieldName.state],
      zip: payload[FirebaseFieldName.zip],
      country: payload[FirebaseFieldName.country],
    );
  }

  factory AppUser.fromFirebaseUser(User user) {
    String authProviderId =
        user.providerData.isNotEmpty ? user.providerData.first.providerId : '';
    return AppUser(
      id: user.uid,
      email: user.email!,
      displayName: user.displayName,
      isEmailVerified: user.emailVerified,
      createDate: user.metadata.creationTime,
      lastLoginDate: user.metadata.lastSignInTime,
      providerId: authProviderId,
      photoURL: user.photoURL,
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
        id: map[FirebaseFieldName.id],
        email: map[FirebaseFieldName.email],
        displayName: map[FirebaseFieldName.displayName],
        photoURL: map[FirebaseFieldName.photoURL],
        photoFileName: map[FirebaseFieldName.photoFileName],
        profileBannerImageURL: map[FirebaseFieldName.profileBannerImageURL],
        providerId: map[FirebaseFieldName.providerId],
        familyId: map[FirebaseFieldName.familyId],
        isAdmin: map[FirebaseFieldName.isAdmin] ?? false,
        isEmailVerified: map[FirebaseFieldName.isEmailVerified] ?? false,
        isApproved: map[FirebaseFieldName.isApproved] ?? false,
        isChatEnabled: map[FirebaseFieldName.isChatEnabled] ?? false,
        isInfoShared: map[FirebaseFieldName.isInfoShared] ?? false,
        isPrimaryAccount: map[FirebaseFieldName.isPrimaryAccount] ?? false,
        primaryAccountEmail: map[FirebaseFieldName.primaryAccountEmail],
        createDate: map[FirebaseFieldName.createDate] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                map[FirebaseFieldName.createDate])
            : null,

        // updatedDate: (map[FirebaseFieldName.updatedAt] as Timestamp).toDate(),
        updateDate: map[FirebaseFieldName.updateDate] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                map[FirebaseFieldName.updateDate])
            : null,
        lastLoginDate: map[FirebaseFieldName.lastLoginDate] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                map[FirebaseFieldName.lastLoginDate])
            : null,
        phoneNumber: map[FirebaseFieldName.phoneNumber],
        street: map[FirebaseFieldName.street],
        city: map[FirebaseFieldName.city],
        state: map[FirebaseFieldName.state],
        zip: map[FirebaseFieldName.zip],
        country: map[FirebaseFieldName.country]);
  }

  Map<String, dynamic> toMap() {
    return {
      FirebaseFieldName.id: id,
      FirebaseFieldName.email: email,
      FirebaseFieldName.displayName: displayName,
      FirebaseFieldName.photoURL: photoURL,
      FirebaseFieldName.photoFileName: photoFileName,
      FirebaseFieldName.profileBannerImageURL: profileBannerImageURL,
      FirebaseFieldName.providerId: providerId,
      FirebaseFieldName.familyId: familyId,
      FirebaseFieldName.isAdmin: isAdmin,
      FirebaseFieldName.isApproved: isApproved,
      FirebaseFieldName.isEmailVerified: isEmailVerified,
      FirebaseFieldName.isChatEnabled: isChatEnabled,
      FirebaseFieldName.isInfoShared: isInfoShared,
      FirebaseFieldName.isPrimaryAccount: isPrimaryAccount,
      FirebaseFieldName.primaryAccountEmail: primaryAccountEmail,
      FirebaseFieldName.createDate: createDate?.millisecondsSinceEpoch,
      FirebaseFieldName.updateDate: updateDate?.millisecondsSinceEpoch,
      FirebaseFieldName.lastLoginDate: lastLoginDate?.millisecondsSinceEpoch,
      FirebaseFieldName.phoneNumber: phoneNumber,
      FirebaseFieldName.street: street,
      FirebaseFieldName.city: city,
      FirebaseFieldName.state: state,
      FirebaseFieldName.zip: zip,
      FirebaseFieldName.country: country,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.id == id &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoURL == photoURL &&
        other.profileBannerImageURL == profileBannerImageURL &&
        other.photoFileName == photoFileName &&
        other.providerId == providerId &&
        other.familyId == familyId &&
        other.createDate == createDate &&
        other.updateDate == updateDate &&
        other.lastLoginDate == lastLoginDate &&
        other.isAdmin == isAdmin &&
        other.isEmailVerified == isEmailVerified &&
        other.isApproved == isApproved &&
        other.isInfoShared == isInfoShared &&
        other.isChatEnabled == isChatEnabled &&
        other.isPrimaryAccount == isPrimaryAccount &&
        other.primaryAccountEmail == primaryAccountEmail &&
        other.phoneNumber == phoneNumber &&
        other.street == street &&
        other.city == city &&
        other.state == state &&
        other.zip == zip &&
        other.country == country;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoURL.hashCode ^
        profileBannerImageURL.hashCode ^
        photoFileName.hashCode ^
        providerId.hashCode ^
        familyId.hashCode ^
        createDate.hashCode ^
        updateDate.hashCode ^
        lastLoginDate.hashCode ^
        isAdmin.hashCode ^
        isEmailVerified.hashCode ^
        isApproved.hashCode ^
        isInfoShared.hashCode ^
        isChatEnabled.hashCode ^
        isPrimaryAccount.hashCode ^
        primaryAccountEmail.hashCode ^
        phoneNumber.hashCode ^
        street.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zip.hashCode ^
        country.hashCode;
  }

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, fullName: $displayName, photoURL: $photoURL, profileBannerImageURL: $profileBannerImageURL, photoFileName: $photoFileName, providerId: $providerId, familyId: $familyId, createDate: $createDate, updateDate: $updateDate, lastLoginDate: $lastLoginDate, isAdmin: $isAdmin, isEmailVerified: $isEmailVerified, isApproved: $isApproved, isInfoShared: $isInfoShared, isChatEnabled: $isChatEnabled, isPrimaryAccount: $isPrimaryAccount, primaryAccountEmail: $primaryAccountEmail, phoneNumber: $phoneNumber, street: $street, city: $city, state: $state, zip: $zip, country: $country)';
  }

  AppUser copyWith({
    UserID? id,
    String? email,
    String? fullName,
    String? photoURL,
    String? profileBannerImageURL,
    String? photoFileName,
    String? providerId,
    String? familyId,
    DateTime? createDate,
    DateTime? updateDate,
    DateTime? lastLoginDate,
    bool? isAdmin,
    bool? isEmailVerified,
    bool? isApproved,
    bool? isInfoShared,
    bool? isChatEnabled,
    bool? isPrimaryAccount,
    String? primaryAccountEmail,
    String? phoneNumber,
    String? street,
    String? city,
    String? state,
    String? zip,
    String? country,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      profileBannerImageURL:
          profileBannerImageURL ?? this.profileBannerImageURL,
      photoFileName: photoFileName ?? this.photoFileName,
      providerId: providerId ?? this.providerId,
      familyId: familyId ?? this.familyId,
      createDate: createDate ?? this.createDate,
      updateDate: updateDate ?? this.updateDate,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      isAdmin: isAdmin ?? this.isAdmin,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isApproved: isApproved ?? this.isApproved,
      isInfoShared: isInfoShared ?? this.isInfoShared,
      isChatEnabled: isChatEnabled ?? this.isChatEnabled,
      isPrimaryAccount: isPrimaryAccount ?? this.isPrimaryAccount,
      primaryAccountEmail: primaryAccountEmail ?? this.primaryAccountEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      country: country ?? this.country,
    );
  }
}
