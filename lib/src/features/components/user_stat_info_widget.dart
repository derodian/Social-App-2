import 'package:flutter/material.dart';
import 'package:social_app_2/src/features/components/user_stat_info_item.dart';

class UserStatInfoWidget extends StatelessWidget {
  const UserStatInfoWidget({
    super.key,
    required this.followerCount,
    required this.postCount,
    required this.score,
  });
  final String followerCount;
  final String postCount;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.only(top: 8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          UserStatInfoItem(count: followerCount, label: 'Followers'),
          UserStatInfoItem(count: postCount, label: 'Posts'),
          UserStatInfoItem(count: score, label: 'Score'),
        ],
      ),
    );
  }
}
