import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/auth/presentation/account/app_user_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';

final isLoadingProvider = Provider.autoDispose<bool>((ref) {
  final authController = ref.watch(authControllerProvider);
  // final emailVerificationController =
  //     ref.watch(emailVerificationControllerProvider);
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
  final appUserController = ref.watch(appUserControllerProvider);
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
  return authController.isLoading ||
      // detailNewsScreenController.isLoading ||
      // addEditNewsScreenController.isLoading ||
      // detailEventsScreenController.isLoading ||
      // addEditEventsScreenController.isLoading ||
      // addEditCommitteeScreenController.isLoading ||
      // appUsersListScreenController.isLoading ||
      // detailAppUserScreenController.isLoading ||
      appUserController.isLoading;
});
