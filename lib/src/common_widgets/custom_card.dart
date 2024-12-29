import 'package:flutter/material.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.child,
    this.height,
    this.onTap,
  });
  final Widget? child;
  final double? height;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.p8),
        ),
        elevation: 2.0,
        margin: const EdgeInsets.all(Sizes.p8),
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
