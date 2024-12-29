import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/theme/app_colors.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.facebook,
            color: AppColors.kcFacebookColor,
          ),
          const SizedBox(width: 10.0),
          const Text(Strings.facebook),
        ],
      ),
    );
  }
}
