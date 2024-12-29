import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/custom_card.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/features/committee_member/domain/committee_member.dart';
import 'package:social_app_2/src/features/components/image/custom_circular_avatar.dart';

class CommitteeMemberCard extends ConsumerWidget {
  const CommitteeMemberCard({
    super.key,
    required this.committeeMember,
    this.onPressed,
  });
  final CommitteeMember committeeMember;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const committeeMemberCardKey = Key('committee-member-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final memberSince = Format.date(committeeMember.memberSince);

    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: onPressed,
                title: Text(
                  committeeMember.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  committeeMember.email,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                leading: CustomCircularAvatar(
                  radius: 25.0,
                  imageUrl: committeeMember.photoUrl,
                ),
                // trailing: Text(committee.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
