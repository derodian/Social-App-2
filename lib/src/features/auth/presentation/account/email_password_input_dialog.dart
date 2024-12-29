import 'package:flutter/material.dart';
import 'package:social_app_2/src/theme/app_colors.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/theme/text_styles.dart';

const kInputDialogDefaultKey = Key('input-dialog-default-key');
const kEmailFormKey = Key('email-form-key');
const kPasswordFormKey = Key('password-form-key');

/// Generic function to show a platform-aware Material or Cupertino dialog
Future<bool?> emailPasswordInputDialog({
  required BuildContext context,
  required String title,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  Widget? content,
  String? cancelActionText,
  bool canSubmitPassword = true,
  String defaultActionText = 'Submit',
}) async {
  final formKey = GlobalKey<FormState>();

  Widget buildContent() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // gapH8,
          // Text(
          //   Strings.reauthenticateAccount,
          //   style: bodyStyle,
          // ),
          gapH24,
          // Email field
          TextFormField(
            decoration: const InputDecoration(
              labelText: Strings.email,
              hintText: Strings.testEmail,
              // errorText: Strings.invalidEmailErrorText,
            ),
            controller: emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            keyboardAppearance: Brightness.dark,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email cannot be empty';
              }

              return null;
            },
            onEditingComplete: () {},
          ),

          gapH8,
          // Password field
          TextFormField(
            decoration: const InputDecoration(
              labelText: Strings.password,
            ),
            controller: passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            keyboardAppearance: Brightness.dark,
          ),
          // CustomTextFormField(
          //   key: const Key('email'),
          //   controller: emailController,
          //   labelText: Strings.email,
          //   errorText: Strings.invalidEmailErrorText,
          //   isEnabled: true,
          //   isPassword: false,
          //   autocorrect: false,
          //   textInputAction: TextInputAction.next,
          //   keyboardAppearance: Brightness.light,
          //   validationMessage: Strings.invalidEmailErrorText,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Email cannot be empty';
          //     }

          //     return null;
          //   },
          // ),
          // CustomTextFormField(
          //   key: const Key('password'),
          //   controller: passwordController,
          //   labelText: Strings.password,
          //   errorText: Strings.invalidPasswordTooShort,
          //   isEnabled: true,
          //   isPassword: true,
          //   autocorrect: false,
          //   textInputAction: TextInputAction.done,
          //   keyboardAppearance: Brightness.light,
          //   validationMessage: Strings.invalidPasswordTooShort,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Password cannot be empty';
          //     }

          //     return null;
          //   },
          // ),
        ],
      ),
    );
  }

  // if (kIsWeb || !Platform.isIOS) {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: cancelActionText != null,
  //     builder: (context) => AlertDialog(
  //       title: Text(title),
  //       content: buildContent(),
  //       actions: <Widget>[
  //         if (cancelActionText != null)
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(false),
  //             child: Text(
  //               cancelActionText,
  //               style: bodyStyle.copyWith(
  //                 color: AppColors.kcLightTextColor,
  //               ),
  //             ),
  //           ),
  //         TextButton(
  //           key: kInputDialogDefaultKey,
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: Text(
  //             defaultActionText,
  //             style: bodyStyle.copyWith(
  //               fontWeight: FontWeight.bold,
  //               color: AppColors.kcLightTextColor,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // return showCupertinoDialog(
  //   context: context,
  //   barrierDismissible: cancelActionText != null,
  //   builder: (context) => Scaffold(
  //     backgroundColor: Colors.transparent,
  //     body: CupertinoAlertDialog(
  //       title: Text(title),
  //       content: buildContent(),
  //       actions: <Widget>[
  //         if (cancelActionText != null)
  //           CupertinoDialogAction(
  //             onPressed: () => Navigator.of(context).pop(false),
  //             child: Text(
  //               cancelActionText,
  //               style: bodyStyle.copyWith(
  //                 color: AppColors.kcLightTextColor,
  //               ),
  //             ),
  //           ),
  //         CupertinoDialogAction(
  //           key: kInputDialogDefaultKey,
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: Text(
  //             defaultActionText,
  //             style: bodyStyle.copyWith(
  //               fontWeight: FontWeight.bold,
  //               color: AppColors.kcLightTextColor,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );

  return showDialog(
    context: context,
    barrierDismissible: cancelActionText != null,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: buildContent(),
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancelActionText,
              style: bodyStyle.copyWith(
                color: AppColors.kcPrimaryColor,
              ),
            ),
          ),
        TextButton(
          key: kInputDialogDefaultKey,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            defaultActionText,
            style: bodyStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.kcPrimaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}

// /// Generic function to show a platform-aware Material or Cupertino error dialog
// Future<void> showExceptionAlertDialog({
//   required BuildContext context,
//   required String title,
//   required dynamic exception,
// }) =>
//     showAlertDialogWithInput(
//       context: context,
//       title: title,
//       content: Text(exception.toString()),
//       defaultActionText: 'OK'.hardcoded,
//     );

// Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
//     showAlertDialogWithInput(
//       context: context,
//       title: 'Not implemented'.hardcoded,
//     );
