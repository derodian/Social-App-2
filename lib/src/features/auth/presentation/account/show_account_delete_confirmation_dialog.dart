// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:social_app_2/src/common_widgets/custom_text_form_field.dart';
// import 'package:social_app_2/src/constants/app_sizes.dart';
// import 'package:social_app_2/src/constants/strings.dart';

// const kInputDialogDefaultKey = Key('input-dialog-default-key');
// const kEmailFormKey = Key('email-form-key');
// const kPasswordFormKey = Key('password-form-key');

// Future<bool?> showAccountDeletionConfirmationDialog({
//   required BuildContext context,
//   required String title,
//   required Function(String email, String password) onConfirm,
//   String cancelActionText = 'Cancel',
//   String confirmActionText = 'Delete Account',
// }) async {
//   final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final emailFocusNode = FocusNode();
//   final passwordFocusNode = FocusNode();

//   // Function to dispose of controllers and focus nodes
//   void disposeResources() {
//     emailController.dispose();
//     passwordController.dispose();
//     emailFocusNode.dispose();
//     passwordFocusNode.dispose();
//   }

//   Widget buildEmailField() => CustomTextFormField(
//         key: kEmailFormKey,
//         controller: emailController,
//         fieldFocusNode: emailFocusNode,
//         nextFocusNode: passwordFocusNode,
//         labelText: Strings.email,
//         hintText: Strings.defaultEmail,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textInputAction: TextInputAction.next,
//         textInputType: TextInputType.emailAddress,
//         keyboardAppearance: Brightness.dark,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Email cannot be empty';
//           }
//           if (!EmailValidator.validate(value)) {
//             return 'Enter a valid email address';
//           }
//           return null;
//         },
//         onEditingComplete: () =>
//             FocusScope.of(context).requestFocus(passwordFocusNode),
//       );

//   Widget buildPasswordField() => CustomTextFormField(
//         key: kPasswordFormKey,
//         controller: passwordController,
//         fieldFocusNode: passwordFocusNode,
//         labelText: Strings.password,
//         validator: (password) {
//           if (password == null || password.isEmpty) {
//             return 'Password cannot be empty';
//           }
//           if (password.length < 8) {
//             return 'Password must be at least 8 characters long';
//           }
//           return null;
//         },
//         isPassword: true,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textInputAction: TextInputAction.done,
//         keyboardAppearance: Brightness.dark,
//         onEditingComplete: () {
//           if (formKey.currentState!.validate()) {
//             Navigator.of(context).pop(true);
//             onConfirm(emailController.text, passwordController.text);
//           }
//         },
//       );

//   Widget buildContent() {
//     return Form(
//       key: formKey,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           gapH24,
//           buildEmailField(),
//           gapH8,
//           buildPasswordField(),
//         ],
//       ),
//     );
//   }

//   return showDialog<bool>(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => AlertDialog(
//       title: Text(title),
//       content: buildContent(),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(false),
//           child: Text(
//             cancelActionText,
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//         ),
//         TextButton(
//           key: kInputDialogDefaultKey,
//           onPressed: () {
//             if (formKey.currentState!.validate()) {
//               Navigator.of(context).pop(true);
//               onConfirm(emailController.text, passwordController.text);
//             }
//           },
//           //TODO: change text button color
//           child: Text(
//             confirmActionText,
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//         ),
//       ],
//     ),
//   ).then((value) {
//     // Ensure resources are disposed even if dialog is dismissed unexpectedly
//     if (value == null) {
//       disposeResources();
//     }
//     return value;
//   });
// }
