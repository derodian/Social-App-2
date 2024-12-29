import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app_2/src/common_widgets/alert_dialogs.dart';
import 'package:social_app_2/src/common_widgets/custom_date_picker.dart';
import 'package:social_app_2/src/common_widgets/custom_text_form_field.dart';
import 'package:social_app_2/src/common_widgets/delete_button.dart';
import 'package:social_app_2/src/common_widgets/divider_with_margins.dart';
import 'package:social_app_2/src/common_widgets/error_message_widget.dart';
import 'package:social_app_2/src/common_widgets/responsive_center.dart';
import 'package:social_app_2/src/common_widgets/responsive_two_colum_layout.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/extensions/async_value_ui.dart';
import 'package:social_app_2/src/features/committee_member/data/committee_member_repository.dart';
import 'package:social_app_2/src/features/committee_member/domain/committee_member.dart';
import 'package:social_app_2/src/features/committee_member/presentation/add_edit_committee_member_screen_controller.dart';
import 'package:social_app_2/src/features/committee_member/presentation/committee_member_validator.dart';
import 'package:social_app_2/src/features/committee_member/typedefs/committee_member_id.dart';
import 'package:social_app_2/src/features/components/app_bar/home_app_bar.dart';
import 'package:social_app_2/src/features/components/image/custom_circular_avatar.dart';
import 'package:social_app_2/src/features/components/loading/application/is_loading_provider.dart';
import 'package:social_app_2/src/features/components/loading/presentation/loading_screen.dart';
import 'package:social_app_2/src/features/services/image_picker_service.dart';
import 'package:social_app_2/src/theme/app_colors.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

class AddEditCommitteeMemberScreen extends ConsumerWidget {
  const AddEditCommitteeMemberScreen({
    super.key,
    this.committeeMemberId,
  });
  final CommitteeMemberID? committeeMemberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (committeeMemberId != null) {
      // * By watching a [FutureProvider], the data is
      // * only loaded once. This prevents unintended
      // * rebuilds while the user is entering form data
      final committeeMemberValue =
          ref.watch(committeeMemberFutureProvider(committeeMemberId!));
      // * using .when rather than [AsyncValueWidget]
      // * to provide custom error and loading screen
      return committeeMemberValue.when(
        data: (committeeMember) => committeeMember != null
            ? AddEditCommitteeMemberScreenContents(
                committeeMember: committeeMember)
            : Scaffold(
                appBar: AppBar(
                  title: const Text(Strings.editNews),
                ),
                body: const Center(
                  child: ErrorMessageWidget(Strings.newsNotFound),
                ),
              ),
        // * to prevent a blank screen, return a
        // * [Scaffold] from the error and loading screen
        error: (e, st) => Scaffold(
          body: Center(
            child: ErrorMessageWidget(
              e.toString(),
            ),
          ),
        ),
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return const AddEditCommitteeMemberScreenContents();
    }
  }
}

/// Widget containing UI for Adding/Editing Committee Member
class AddEditCommitteeMemberScreenContents extends ConsumerStatefulWidget {
  const AddEditCommitteeMemberScreenContents({
    super.key,
    this.committeeMember,
  });
  final CommitteeMember? committeeMember;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddEditCommitteeMemberScreenContentsState();
}

class _AddEditCommitteeMemberScreenContentsState
    extends ConsumerState<AddEditCommitteeMemberScreenContents> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _titleController = TextEditingController();
  final _titleIdController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _locationStateController = TextEditingController();
  final _zipController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  final _titleIdFocusNode = FocusNode();
  final _streetFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _locationStateFocusNode = FocusNode();
  final _zipFocusNode = FocusNode();

  String? _committeeMemberPhotoURL;

  File? _committeeMemberPhotoFile;

  late DateTime _memberSinceDate;

  @override
  void initState() {
    super.initState();

    final memberSince = widget.committeeMember?.memberSince ?? DateTime.now();
    _memberSinceDate =
        DateTime(memberSince.year, memberSince.month, memberSince.day);

    if (widget.committeeMember != null) {
      _committeeMemberPhotoURL = widget.committeeMember!.photoUrl;
      _nameController.text = widget.committeeMember!.name;
      _emailController.text = widget.committeeMember!.email;
      _phoneNumberController.text = widget.committeeMember!.phoneNumber ?? '';
      _titleController.text = widget.committeeMember!.title;
      _titleIdController.text = widget.committeeMember!.titleId;
      _streetController.text = widget.committeeMember!.street ?? '';
      _cityController.text = widget.committeeMember!.city ?? '';
      _locationStateController.text = widget.committeeMember!.state ?? '';
      _zipController.text = widget.committeeMember!.zip ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _titleController.dispose();
    _titleIdController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _locationStateController.dispose();
    _zipController.dispose();

    _nameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    _titleFocusNode.dispose();
    _titleIdFocusNode.dispose();
    _streetFocusNode.dispose();
    _cityFocusNode.dispose();
    _locationStateFocusNode.dispose();
    _zipFocusNode.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      final success = await ref
          .read(addEditCommitteeMemberScreenControllerProvider.notifier)
          .addCommitteeMember(
              committeeMemberId: widget.committeeMember?.committeeMemberId,
              title: _titleController.text,
              titleId: _titleIdController.text,
              name: _nameController.text,
              email: _emailController.text,
              phoneNumber: _phoneNumberController.text,
              photoFileName: widget.committeeMember?.photoFileName,
              memberSince: _memberSinceDate,
              photoUrl: _committeeMemberPhotoURL,
              street: _streetController.text,
              city: _cityController.text,
              locationState: _locationStateController.text,
              zip: _zipController.text,
              committeeMemberImageFile: _committeeMemberPhotoFile);

      if (success) {
        // Display snackbar with success message
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(widget.committeeMember != null
                ? Strings.committeeUpdated
                : Strings.committeeAdded),
          ),
        );
      }
    }
  }

  Future<void> _delete() async {
    final delete = await showAlertDialog(
      context: context,
      title: Strings.areYouSureYouWantToDeleteThis,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.delete,
    );
    if (delete == true) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      ref
          .read(addEditCommitteeMemberScreenControllerProvider.notifier)
          .deleteCommitteeMember(committeeMember: widget.committeeMember!);
      // Display snackbar with success message
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text(Strings.newsDeleted),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // install the loading screen
    ref.listen<bool>(
      isLoadingProvider,
      (_, isLoading) {
        if (isLoading) {
          LoadingScreen.instance().show(
            context: context,
          );
        } else {
          LoadingScreen.instance().hide();
        }
      },
    );
    ref.listen<AsyncValue>(
      addEditCommitteeMemberScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(addEditCommitteeMemberScreenControllerProvider);
    final isLoading = state.isLoading;
    const autoValidateMode = AutovalidateMode.disabled;
    return Scaffold(
      appBar: HomeAppBar(
        title: (widget.committeeMember != null)
            ? Strings.editCommitteeMember
            : Strings.addCommitteeMember,
        showSaveButton: true,
        onPressed: isLoading ? null : _submit,
      ),
      body: SingleChildScrollView(
        child: ResponsiveCenter(
          child: Form(
            key: _formKey,
            child: ResponsiveTwoColumnLayout(
              startContent: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: state.isLoading
                      ? null
                      : () async {
                          final imagePickerService =
                              ref.watch(imagePickerServiceProvider);
                          final file = await imagePickerService.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            _committeeMemberPhotoFile = file;
                          });
                        },
                  child: Column(
                    children: [
                      _committeeMemberPhotoFile != null
                          ? CustomCircularAvatar(
                              radius: 50,
                              borderColor: AppColors.kcPrimaryColor,
                              imageFile: _committeeMemberPhotoFile,
                            )
                          : CustomCircularAvatar(
                              radius: 50,
                              borderColor: AppColors.kcPrimaryColor,
                              imageUrl: _committeeMemberPhotoURL,
                            ),
                      gapH8,
                      const Text(Strings.uploadImage),
                    ],
                  ),
                ),
              ),
              spacing: Sizes.p16,
              endContent: Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      fieldFocusNode: _nameFocusNode,
                      isEnabled: !isLoading,
                      labelText: 'Name'.hardcoded,
                      autovalidateMode: autoValidateMode,
                      validator: ref
                          .read(committeeMemberValidatorProvider)
                          .minimumCharactersValidator,
                    ),
                    gapH8,
                    CustomTextFormField(
                      controller: _titleController,
                      fieldFocusNode: _titleFocusNode,
                      isEnabled: !isLoading,
                      labelText: 'Title'.hardcoded,
                      autovalidateMode: autoValidateMode,
                      validator: ref
                          .read(committeeMemberValidatorProvider)
                          .minimumCharactersValidator,
                    ),
                    gapH8,
                    CustomTextFormField(
                      controller: _titleIdController,
                      fieldFocusNode: _titleIdFocusNode,
                      isEnabled: !isLoading,
                      labelText: 'Title ID'.hardcoded,
                      autovalidateMode: autoValidateMode,
                    ),
                    gapH8,
                    CustomTextFormField(
                      controller: _emailController,
                      fieldFocusNode: _emailFocusNode,
                      isEnabled: !isLoading,
                      labelText: 'Email'.hardcoded,
                      autovalidateMode: autoValidateMode,
                    ),
                    gapH8,
                    _buildMemberSinceDatePicker(),
                    gapH8,
                    CustomTextFormField(
                      controller: _phoneNumberController,
                      fieldFocusNode: _phoneNumberFocusNode,
                      isEnabled: !isLoading,
                      labelText: 'Phone'.hardcoded,
                      autovalidateMode: autoValidateMode,
                    ),
                    gapH8,
                    gapH8,
                    CustomTextFormField(
                      controller: _streetController,
                      fieldFocusNode: _streetFocusNode,
                      isEnabled: !isLoading,
                      labelText: Strings.address,
                      autovalidateMode: autoValidateMode,
                    ),
                    gapH8,
                    CustomTextFormField(
                      controller: _cityController,
                      fieldFocusNode: _cityFocusNode,
                      isEnabled: !isLoading,
                      labelText: Strings.city,
                      autovalidateMode: autoValidateMode,
                    ),
                    gapH8,
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: _locationStateController,
                            fieldFocusNode: _locationStateFocusNode,
                            isEnabled: !isLoading,
                            labelText: Strings.state,
                            autovalidateMode: autoValidateMode,
                          ),
                        ),
                        gapW8,
                        Expanded(
                          child: CustomTextFormField(
                            controller: _zipController,
                            fieldFocusNode: _zipFocusNode,
                            isEnabled: !isLoading,
                            labelText: Strings.zip,
                            autovalidateMode: autoValidateMode,
                          ),
                        ),
                      ],
                    ),
                    const DividerWithMargins(),
                    if (widget.committeeMember != null)
                      DeleteButton(
                        text: Strings.delete,
                        onPressed: _delete,
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberSinceDatePicker() {
    return CustomDateTimePicker(
      labelText: 'Member Since',
      selectedDate: _memberSinceDate,
      onSelectedDate: (date) {
        setState(() {
          _memberSinceDate = date;
        });
      },
    );
  }
}
