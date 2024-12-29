import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app_2/src/common_widgets/alert_dialogs.dart';
import 'package:social_app_2/src/common_widgets/custom_text_button.dart';
import 'package:social_app_2/src/common_widgets/custom_text_form_field.dart';
import 'package:social_app_2/src/common_widgets/responsive_center_scrollable.dart';
import 'package:social_app_2/src/common_widgets/responsive_two_colum_layout.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/extensions/async_value_ui.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/components/app_bar/home_app_bar.dart';
import 'package:social_app_2/src/features/components/image/custom_cover_image.dart';
import 'package:social_app_2/src/features/news/data/news_repository.dart';
import 'package:social_app_2/src/features/news/domain/news.dart';
import 'package:social_app_2/src/features/news/presentation/add_edit_news_screen_controller.dart';
import 'package:social_app_2/src/features/news/presentation/news_validator.dart';
import 'package:social_app_2/src/features/news/typedefs/news_id.dart';
import 'package:social_app_2/src/features/services/image_picker_service.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/theme/app_colors.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

class AddEditNewsScreen extends ConsumerStatefulWidget {
  const AddEditNewsScreen({super.key, this.newsId});
  final NewsID? newsId;

  @override
  ConsumerState<AddEditNewsScreen> createState() => _AddEditNewsScreenState();
}

class _AddEditNewsScreenState extends ConsumerState<AddEditNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _listTitleController;
  late final TextEditingController _newsDetailsController;
  late final TextEditingController _locationController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _zipController;

  String? _postedBy;
  DateTime _postDate = DateTime.now();
  String? _newsImageURL;
  File? _newsImageFile;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _listTitleController = TextEditingController();
    _newsDetailsController = TextEditingController();
    _locationController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _zipController = TextEditingController();
    _initializeEventData();
  }

  void _initializeEventData() {
    if (widget.newsId != null) {
      _loadExistingNewsData();
    }
  }

  Future<void> _loadExistingNewsData() async {
    final newsValue = await ref.read(newsFutureProvider(widget.newsId!).future);
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (newsValue != null) {
      setState(() {
        _titleController.text = newsValue.title;
        _listTitleController.text = newsValue.listTitle;
        _newsDetailsController.text = newsValue.newsDetails;
        _locationController.text = newsValue.location ?? '';
        _addressController.text = newsValue.address ?? '';
        _cityController.text = newsValue.city ?? '';
        _stateController.text = newsValue.state ?? '';
        _zipController.text = newsValue.zip ?? '';
        _newsImageURL = newsValue.imageUrl;
        _postedBy = currentUser != null ? currentUser.email : "admin";
        _postDate = newsValue.postDate;
      });
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _titleController.dispose();
    _listTitleController.dispose();
    _newsDetailsController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final news = News(
        id: widget.newsId ?? DateTime.now().toIso8601String(),
        title: _titleController.text,
        listTitle: _listTitleController.text,
        postedBy: _postedBy!,
        postDate: _postDate,
        lastUpdated: DateTime.now(),
        newsDetails: _newsDetailsController.text,
        location: _locationController.text,
        address: _addressController.text,
        city: _cityController.text,
        state: _stateController.text,
        zip: _zipController.text,
        imageUrl: _newsImageURL,
      );

      final success = await ref
          .read(addEditNewsScreenControllerProvider.notifier)
          .addOrUpdateNews(
            newsId: widget.newsId,
            news: news,
            newsImageFile: _newsImageFile,
          );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.newsId != null
                ? Strings.newsUpdated
                : Strings.newsAdded),
          ),
        );
        // ref.read(goRouterProvider).pop();
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
    if (delete == true && widget.newsId != null) {
      await ref
          .read(addEditNewsScreenControllerProvider.notifier)
          .deleteNews(id: widget.newsId!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Strings.newsDeleted)),
        );
        ref.read(goRouterProvider).goNamed(AppRoute.news.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      addEditNewsScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(addEditNewsScreenControllerProvider);
    final isLoading = state.isLoading;

    return Scaffold(
      appBar: HomeAppBar(
        title: widget.newsId != null ? Strings.editNews : Strings.addNews,
        showSaveButton: true,
        onPressed: isLoading ? null : _submit,
      ),
      body: SingleChildScrollView(
        child: ResponsiveCenter(
          child: Form(
            key: _formKey,
            child: ResponsiveTwoColumnLayout(
              startContent: _buildImageSection(isLoading),
              endContent: _buildFormFields(isLoading),
              spacing: Sizes.p16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: InkWell(
        onTap: isLoading ? null : _pickImage,
        child: Column(
          children: [
            CustomCoverImage(
              imageFile: _newsImageFile,
              imageUrl: _newsImageURL,
              onTap: isLoading ? null : _pickImage,
            ),
            gapH8,
            const Text(Strings.uploadImage),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final imagePickerService = ref.read(imagePickerServiceProvider);
    final file =
        await imagePickerService.pickImage(source: ImageSource.gallery);
    setState(() {
      _newsImageFile = file;
    });
  }

  Widget _buildFormFields(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: _titleController,
            isEnabled: !isLoading,
            labelText: 'Title'.hardcoded,
            validator: ref.read(newsValidatorProvider).titleValidator,
          ),
          gapH8,
          CustomTextFormField(
            controller: _listTitleController,
            isEnabled: !isLoading,
            labelText: 'List Title'.hardcoded,
            validator: ref.read(newsValidatorProvider).titleValidator,
          ),
          gapH8,
          CustomTextFormField(
            controller: _newsDetailsController,
            isEnabled: !isLoading,
            labelText: 'Details'.hardcoded,
            textInputType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 5,
            minLines: 4,
            validator: ref.read(newsValidatorProvider).newsDetailsValidator,
          ),
          gapH8,
          CustomTextFormField(
            controller: _locationController,
            isEnabled: !isLoading,
            labelText: Strings.location,
          ),
          gapH8,
          CustomTextFormField(
            controller: _addressController,
            isEnabled: !isLoading,
            labelText: Strings.address,
          ),
          gapH8,
          CustomTextFormField(
            controller: _cityController,
            isEnabled: !isLoading,
            labelText: Strings.city,
          ),
          gapH8,
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: _stateController,
                  isEnabled: !isLoading,
                  labelText: Strings.state,
                ),
              ),
              gapW8,
              Expanded(
                child: CustomTextFormField(
                  controller: _zipController,
                  isEnabled: !isLoading,
                  labelText: Strings.zip,
                ),
              ),
            ],
          ),
          if (widget.newsId != null) ...[
            gapH16,
            CustomTextButton(
              text: Strings.delete,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.kcRedColor),
              onPressed: _delete,
            ),
          ],
        ],
      ),
    );
  }
}
