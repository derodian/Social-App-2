import 'package:flutter/material.dart';

class UserStatInfoItem extends StatelessWidget {
  const UserStatInfoItem({
    super.key,
    required this.count,
    required this.label,
  });
  final String count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
