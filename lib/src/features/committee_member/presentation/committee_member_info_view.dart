import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
import 'package:social_app_2/src/common_widgets/divider_with_margins.dart';
import 'package:social_app_2/src/common_widgets/empty_placeholder_widget.dart';
import 'package:social_app_2/src/common_widgets/url_launcher_widgets.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/features/committee_member/data/committee_member_repository.dart';
import 'package:social_app_2/src/features/committee_member/domain/committee_member.dart';
import 'package:social_app_2/src/features/committee_member/typedefs/committee_member_id.dart';
import 'package:social_app_2/src/features/components/image/custom_cover_image.dart';
import 'package:social_app_2/src/theme/app_colors.dart';
import 'package:social_app_2/src/utils/format.dart';

class CommitteeMemberInfoView extends ConsumerWidget {
  const CommitteeMemberInfoView({
    super.key,
    required this.committeeMemberId,
  });
  final CommitteeMemberID committeeMemberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final committeeMemberValue =
        ref.watch(committeeMemberStreamProvider(committeeMemberId));

    return AsyncValueWidget<CommitteeMember?>(
      value: committeeMemberValue,
      data: (committeeMember) => committeeMember == null
          ? const EmptyPlaceholderWidget(
              message: Strings.noCommitteeMembersAvailable,
            )
          : CommitteeMemberDetailView(committeeMember: committeeMember),
    );
  }
}

class CommitteeMemberDetailView extends ConsumerWidget {
  const CommitteeMemberDetailView({
    super.key,
    required this.committeeMember,
  });
  final CommitteeMember committeeMember;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    final bool isImageUrlAvailable = committeeMember.photoUrl != null &&
        committeeMember.photoUrl!.isNotEmpty;
    final name = committeeMember.name;
    final email = committeeMember.email;
    final phone = committeeMember.phoneNumber ?? '';
    final street = committeeMember.street ?? '';
    final city = committeeMember.city ?? '';
    final state = committeeMember.state ?? '';
    final zip = committeeMember.zip ?? '';
    final address = '$street\n$city $state $zip';
    final memberSince = committeeMember.memberSince;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isImageUrlAvailable
            ? CustomCoverImage(
                imageUrl: committeeMember.photoUrl,
                height: screenSize.height / 2,
              )
            : SizedBox(
                height: screenSize.height / 4,
              ),
        gapH24,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Center(
                child: Text(
                  committeeMember.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              gapH12,
              const DividerWithMargins(),
              email.trim().length > 1
                  ? EmailAddress(emailAddress: email)
                  : Container(),
              gapH16,
              phone.trim().length > 1
                  ? PhoneNumber(phoneNumber: phone)
                  : Container(),
              // gapH8,
              address.trim().length > 1
                  ? ShowAddress(address: address)
                  : Container(),
              gapH12,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Member Since: ${Format.date(memberSince)}',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: AppColors.kcMediumGreyColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
