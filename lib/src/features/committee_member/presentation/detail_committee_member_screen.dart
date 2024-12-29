// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
// import 'package:social_app_2/src/common_widgets/delete_button.dart';
// import 'package:social_app_2/src/common_widgets/empty_placeholder_widget.dart';
// import 'package:social_app_2/src/constants/app_sizes.dart';
// import 'package:social_app_2/src/constants/strings.dart';
// import 'package:social_app_2/src/extensions/async_value_ui.dart';
// import 'package:social_app_2/src/features/committee_member/data/committee_member_repository.dart';
// import 'package:social_app_2/src/features/committee_member/domain/committee_member.dart';
// import 'package:social_app_2/src/features/committee_member/presentation/committee_member_info_view.dart';
// import 'package:social_app_2/src/features/committee_member/typedefs/committee_member_id.dart';
// import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';
// import 'package:social_app_2/src/routing/app_router.dart';
// import 'package:social_app_2/src/theme/app_colors.dart';

// class DetailCommitteeMemberScreen extends ConsumerWidget {
//   const DetailCommitteeMemberScreen({
//     super.key,
//     required this.committeeMemberID,
//   });
//   final CommitteeMemberID committeeMemberID;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // ref.listen<AsyncValue>(
//     //   detailAppUserScreenControllerProvider,
//     //   (_, state) => state.showAlertDialogOnError(context),
//     // );
//     // final state = ref.watch(detailAppUserScreenControllerProvider);

//     final committeeMember =
//         ref.watch(committeeMemberStreamProvider(committeeMemberID));
//     return AsyncValueWidget(
//       value: committeeMember,
//       data: (cm) => cm == null
//           ? const EmptyPlaceholderWidget(
//               message: Strings.noCommitteeMembersAvailable,
//             )
//           : _buildUserAccountScreen(
//               context: context,
//               committeeMember: cm,
//               state: state,
//               ref: ref,
//             ),
//     );
//   }

//   Widget _buildUserAccountScreen({
//     required BuildContext context,
//     required CommitteeMember committeeMember,
//     required AsyncValue<void> state,
//     required WidgetRef ref,
//   }) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: _buildAppBar(state: state, context: context, ref: ref),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minHeight: constraints.maxHeight),
//               child: IntrinsicHeight(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: CommitteeMemberInfoView(
//                           committeeMemberId: committeeMember.committeeMemberId),
//                     ),
//                     AdminOnlyWidget(
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: Sizes.p24),
//                         child: DeleteButton(
//                           onPressed: state.isLoading ? null : () {},
//                           text: Strings.delete,
//                         ),
//                       ),
//                     ),
//                     gapH16,
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   PreferredSize _buildAppBar({
//     required AsyncValue<void> state,
//     required BuildContext context,
//     required WidgetRef ref,
//   }) {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(kToolbarHeight),
//       child: AppBar(
//         backgroundColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//         leading: _buildAppBarIcon(
//           icon: Icons.close,
//           onPressed: state.isLoading ? null : () => context.pop(),
//         ),
//         actions: [
//           AdminOnlyWidget(
//             child: _buildAppBarIcon(
//               icon: Icons.edit,
//               onPressed: state.isLoading
//                   ? null
//                   : () => context.pushNamed(
//                         AppRoute.editCommitteeMember.name,
//                         pathParameters: {'id': committeeMemberID},
//                       ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppBarIcon({
//     required IconData icon,
//     required VoidCallback? onPressed,
//   }) {
//     return Container(
//       margin: const EdgeInsets.all(8.0),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: AppColors.kcBlackColor.withOpacity(0.6),
//       ),
//       child: IconButton(
//         icon: Icon(icon),
//         color: AppColors.kcWhiteColor,
//         onPressed: onPressed,
//       ),
//     );
//   }
// }
