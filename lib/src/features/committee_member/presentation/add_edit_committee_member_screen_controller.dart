import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/constants/firebase_collection_name.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/committee_member/data/committee_member_repository.dart';
import 'package:social_app_2/src/features/committee_member/domain/committee_member.dart';
import 'package:social_app_2/src/features/committee_member/typedefs/committee_member_id.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/utils/notifier_mounted.dart';

part 'add_edit_committee_member_screen_controller.g.dart';

@riverpod
class AddEditCommitteeMemberScreenController
    extends _$AddEditCommitteeMemberScreenController with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // no-op
  }

  final log = Logger();

  Future<bool> addCommitteeMember({
    CommitteeMemberID? committeeMemberId,
    required String title,
    required String titleId,
    required String name,
    required String email,
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
    String? locationState,
    String? zip,
    File? committeeMemberImageFile,
  }) async {
    final committeeMemberRepository =
        ref.watch(committeeMemberRepositoryProvider);
    final userId = ref.watch(authRepositoryProvider).currentUser?.id;
    try {
      state = const AsyncLoading();
      String documentIdFromCurrentDate() => DateTime.now().toIso8601String();
      committeeMemberId ??= documentIdFromCurrentDate();

      //1. Upload images to firebase cloud if provided
      String? committeeMemberPhotoUrl;
      if (committeeMemberImageFile != null) {
        final originalFileRef = FirebaseStorage.instance
            .ref()
            .child(FirebaseCollectionName.committee)
            .child(committeeMemberId);

        // upload the original image file
        final uploadTask =
            await originalFileRef.putFile(committeeMemberImageFile);

        TaskSnapshot taskSnapshot = uploadTask;

        await taskSnapshot.ref.getDownloadURL();

        committeeMemberPhotoUrl = await originalFileRef.getDownloadURL();
      }

      // create copy of committee to add/update
      final committeeMember = CommitteeMember(
        // id: id,
        committeeMemberId: committeeMemberId,
        title: title,
        titleId: titleId,
        name: name,
        email: email,
        memberSince: memberSince,
        photoUrl: committeeMemberPhotoUrl ?? photoUrl,
        postDate: postDate,
        postedBy: userId,
        phoneNumber: phoneNumber,
        street: street,
        city: city,
        state: locationState,
        zip: zip,
      );
      // delegate add member to the service call
      final value = await AsyncValue.guard(
        () => committeeMemberRepository.createCommitteeMember(
          committeeMemberId: committeeMember.committeeMemberId,
          committeeMember: committeeMember,
        ),
      );
      final success = value.hasError == false;
      if (mounted) {
        state = value;
        if (success) {
          // on success, go back to previous screen
          ref.read(goRouterProvider).pop();
        }
      }
      return success;
    } catch (e, st) {
      if (mounted) {
        state = AsyncError(e, st);
      }
      return false;
    }
  }

  Future<void> deleteCommitteeMember(
      {required CommitteeMember committeeMember}) async {
    final committeeMemberRepository =
        ref.read(committeeMemberRepositoryProvider);
    state = const AsyncLoading();
    final value = await AsyncValue.guard(() => committeeMemberRepository
        .deleteCommitteeMember(committeeMember.committeeMemberId));
    final success = value.hasError == false;
    if (mounted) {
      state = value;
      if (success) {
        // on success, go back to committee list screen
        ref.read(goRouterProvider).goNamed(AppRoute.committeeMembers.name);
      }
    }
  }
}
