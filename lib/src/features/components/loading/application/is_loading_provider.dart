import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/auth/presentation/account/account_screen_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/email_not_verified/email_not_verified_screen_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/sign_in/sign_in_screen_controller.dart';

final isLoadingProvider = Provider.autoDispose<bool>((ref) {
  final signInController = ref.watch(signInScreenControllerProvider);
  final emailMailNotVerifiedScreenController =
      ref.watch(emailNotVerifiedScreenControllerProvider);
  // final detailNewsScreenController =
  //     ref.watch(detailNewsScreenControllerProvider);
  // final addEditNewsScreenController =
  //     ref.watch(addEditNewsScreenControllerProvider);
  // final eventsScreenController = ref.watch(eventsListScreenControllerProvider);
  // final detailEventsScreenController =
  //     ref.watch(detailEventScreenControllerProvider);
  // final addEditEventsScreenController =
  //     ref.watch(addEditEventScreenControllerProvider);
  // final committeeScreenController = ref.watch(committeeMemberListScreenControllerProvider);
  // final detailCommitteeScreenController = ref.watch(detailCommitteeMemberScreenControllerProvider);
  // final addEditCommitteeScreenController =
  //     ref.watch(addEditCommitteeMemberScreenControllerProvider);
  // final appUsersListScreenController =
  //     ref.watch(appUsersListScreenControllerProvider);
  // final detailAppUserScreenController =
  //     ref.watch(detailAppUserScreenControllerProvider);
  final accountScreenController = ref.watch(accountScreenControllerProvider);
  // final editAccountScreenController =
  //     ref.watch(editAccountScreenControllerProvider);
  // final isUploadingImage = ref.watch(imageUploaderProvider);
  // final isSendingComment = ref.watch(sendCommentProvider);
  // final isDeletingComment = ref.watch(deleteCommentProvider);
  // final isDeletingPost = ref.watch(deletePostProvider);

  // return authState.isLoading ||
  //     isUploadingImage ||
  //     isSendingComment ||
  //     isDeletingComment ||
  //     isDeletingPost;
  return signInController.isLoading ||
      emailMailNotVerifiedScreenController.isLoading ||
      // detailNewsScreenController.isLoading ||
      // addEditNewsScreenController.isLoading ||
      // detailEventsScreenController.isLoading ||
      // addEditEventsScreenController.isLoading ||
      // addEditCommitteeScreenController.isLoading ||
      // appUsersListScreenController.isLoading ||
      // detailAppUserScreenController.isLoading ||
      accountScreenController.isLoading;
});
