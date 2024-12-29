import 'package:flutter/material.dart';
import 'package:social_app_2/src/features/committee_member/domain/committee_member.dart';

class GroupedListHeaderSeparatorView extends StatelessWidget {
  const GroupedListHeaderSeparatorView({
    super.key,
    required this.titleId,
    required this.committee,
  });
  final String titleId;
  final List<CommitteeMember> committee;

  @override
  Widget build(BuildContext context) {
    final CommitteeMember committeeMember =
        committee.firstWhere((cm) => cm.title == titleId);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 8,
        ),
        child: Text(
          committeeMember.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
