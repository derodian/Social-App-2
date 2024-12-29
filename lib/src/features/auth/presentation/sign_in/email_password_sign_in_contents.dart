import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/custom_text_button.dart';
import 'package:social_app_2/src/common_widgets/custom_text_form_field.dart';
import 'package:social_app_2/src/common_widgets/primary_button.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/extensions/async_value_ui.dart';
import 'package:social_app_2/src/features/auth/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:social_app_2/src/features/auth/presentation/sign_in/email_password_sign_in_validators.dart';
import 'package:social_app_2/src/features/auth/presentation/sign_in/string_validators.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

/// A Widget for email & password authentication, supporting the folling
/// = sign in
/// - register (create an account)
/// - forgot password (reset password)
class EmailPasswordSignInContents extends ConsumerStatefulWidget {
  const EmailPasswordSignInContents({
    super.key,
    required this.formType,
  });

  /// The default form type to use
  final EmailPasswordSignInFormType formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmailPasswordSignInContentsState();
}

class _EmailPasswordSignInContentsState
    extends ConsumerState<EmailPasswordSignInContents>
    with EmailAndPasswordValidators {
  final _formKey = GlobalKey<FormState>();

  // * Keys for testing using find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');
  static const fullNameKey = Key('fullName');

  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;
  String get fullName => _fullNameController.text;

  /// local variable used to apply AutovalidateMode.onUserInteraction and show
  /// error hints only when the form has been submitted
  /// For more details on how this is implemented, see:
  /// https://cpdewithandrea.com/articles/flutter-text-field-form-validation/
  var _submitted = false;

  /// track the formType as a local state variable
  late var _formType = widget.formType;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
    });
    // only submit the form if validation passes
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(emailPasswordSignInControllerProvider.notifier);
      await controller.submit(
        email: email,
        password: password,
        fullName: fullName,
        formType: _formType,
      );
    }
  }

  void _fullNameEditingComplete() {
    if (canSubmitFullName(fullName)) {
      _node.nextFocus();
    }
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  void _updateFormType() {
    // * Toggle between register and sign in form
    setState(() => _formType = _formType.secondaryActionFormType);
    // * Clear the password field when doing so
    _passwordController.clear();
  }

  void _loadPasswordResetForm() {
    // * load forgot password form
    setState(() {
      _formType = EmailPasswordSignInFormType.forgotPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(emailPasswordSignInControllerProvider);
    return SingleChildScrollView(
      child: FocusScope(
        node: _node,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              gapH8,
              // Full Name field
              if (_formType == EmailPasswordSignInFormType.register)
                CustomTextFormField(
                  key: fullNameKey,
                  controller: _fullNameController,
                  labelText: 'Fullname'.hardcoded,
                  helperText: 'Firstname Lastname'.hardcoded,
                  textInputType: TextInputType.text,
                  isEnabled: !state.isLoading,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (fullName) =>
                      !_submitted ? null : fullNameErrorText(fullName ?? ''),
                  textInputAction: TextInputAction.next,
                  keyboardAppearance: Brightness.light,
                  onEditingComplete: () => _fullNameEditingComplete(),
                  formatters: <TextInputFormatter>[
                    ValidatorInputFormatter(
                      editingValidator: MinLengthStringValidator(6),
                    )
                  ],
                ),
              gapH8,
              // Email field
              CustomTextFormField(
                key: emailKey,
                controller: _emailController,
                labelText: 'Email'.hardcoded,
                helperText: 'email@email.com'.hardcoded,
                textInputType: TextInputType.emailAddress,
                isEnabled: !state.isLoading,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    !_submitted ? null : emailErrorText(email ?? ''),
                textInputAction: TextInputAction.next,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _emailEditingComplete(),
                formatters: <TextInputFormatter>[
                  ValidatorInputFormatter(
                    editingValidator: EmailEditingRegexValidator(),
                  )
                ],
              ),
              gapH8,
              // Password field
              if (_formType != EmailPasswordSignInFormType.forgotPassword)
                CustomTextFormField(
                  key: passwordKey,
                  controller: _passwordController,
                  labelText: _formType.passwordLabelText,
                  isEnabled: !state.isLoading,
                  textInputType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) => !_submitted
                      ? null
                      : passwordErrorText(password ?? '', _formType),
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  keyboardAppearance: Brightness.light,
                  onEditingComplete: () => _passwordEditingComplete(),
                ),
              gapH8,
              PrimaryButton(
                text: _formType.primaryButtonText,
                isLoading: state.isLoading,
                onPressed: state.isLoading ? null : () => _submit(),
              ),
              gapH8,
              CustomTextButton(
                text: _formType.secondaryButtonText,
                onPressed: state.isLoading ? null : _updateFormType,
              ),
              if (_formType == EmailPasswordSignInFormType.signIn)
                CustomTextButton(
                  text: _formType.tertiaryButtonText,
                  onPressed: state.isLoading ? null : _loadPasswordResetForm,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
