import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app_2/src/common_widgets/alert_dialogs.dart';
import 'package:social_app_2/src/common_widgets/custom_date_picker.dart';
import 'package:social_app_2/src/common_widgets/custom_dropdown_widget.dart';
import 'package:social_app_2/src/common_widgets/custom_text_button.dart';
import 'package:social_app_2/src/common_widgets/custom_text_form_field.dart';
import 'package:social_app_2/src/common_widgets/responsive_center.dart';
import 'package:social_app_2/src/common_widgets/responsive_two_colum_layout.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/extensions/async_value_ui.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/components/app_bar/home_app_bar.dart';
import 'package:social_app_2/src/features/components/image/custom_cover_image.dart';
import 'package:social_app_2/src/features/events/data/event_repository.dart';
import 'package:social_app_2/src/features/events/domain/event.dart';
import 'package:social_app_2/src/features/events/presentation/add_edit_event_screen_controller.dart';
import 'package:social_app_2/src/features/events/presentation/event_validators.dart';
import 'package:social_app_2/src/features/events/typedefs/event_id.dart';
import 'package:social_app_2/src/features/services/image_picker_service.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/theme/app_colors.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

class AddEditEventScreen extends ConsumerStatefulWidget {
  const AddEditEventScreen({super.key, this.eventId});
  final EventID? eventId;

  @override
  ConsumerState<AddEditEventScreen> createState() => _AddEditEventScreenState();
}

class _AddEditEventScreenState extends ConsumerState<AddEditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _listTitleController;
  late final TextEditingController _eventDetailsController;
  late final TextEditingController _locationController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _zipController;

  String? _postedBy;
  String? _eventStatus;
  String? _eventType;
  String? _eventImageURL;
  File? _eventImageFile;
  DateTime _postDate = DateTime.now();

  DateTime _eventStartDate = DateTime.now();
  TimeOfDay _eventStartTime = TimeOfDay.now();
  DateTime _eventEndDate = DateTime.now();
  TimeOfDay _eventEndTime = TimeOfDay.now();

  final List<String> _eventStatusOptions = [
    'Scheduled',
    'Rescheduled',
    'Postponed',
    'Moved',
    'Cancelled'
  ];

  final List<String> _eventTypeOptions = [
    'Bhajan',
    'Diwali',
    'Garba',
    'Holi',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _listTitleController = TextEditingController();
    _eventDetailsController = TextEditingController();
    _locationController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _zipController = TextEditingController();
    _initializeEventData();
  }

  void _initializeEventData() {
    _eventStatus = _eventStatusOptions[0];
    _eventType = _eventTypeOptions[0];

    final now = DateTime.now();
    _eventStartDate = now;
    _eventStartTime = TimeOfDay.fromDateTime(now);
    _eventEndDate = _eventStartDate;
    _eventEndTime = TimeOfDay.fromDateTime(now.add(const Duration(hours: 1)));

    if (widget.eventId != null) {
      _loadExistingEventData();
    }
  }

  Future<void> _loadExistingEventData() async {
    final eventValue =
        await ref.read(eventFutureProvider(widget.eventId!).future);
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (eventValue != null) {
      setState(() {
        _titleController.text = eventValue.title;
        _listTitleController.text = eventValue.listTitle;
        _eventDetailsController.text = eventValue.eventDetails;
        _locationController.text = eventValue.location ?? '';
        _addressController.text = eventValue.address ?? '';
        _cityController.text = eventValue.city ?? '';
        _stateController.text = eventValue.state ?? '';
        _zipController.text = eventValue.zip ?? '';
        _eventStatus = eventValue.status;
        _eventType = eventValue.type;
        _eventImageURL = eventValue.imageUrl;
        _eventStartDate = eventValue.startDate;
        _eventStartTime = TimeOfDay.fromDateTime(eventValue.startDate);
        _eventEndDate = eventValue.endDate;
        _eventEndTime = TimeOfDay.fromDateTime(eventValue.endDate);
        _postedBy = currentUser != null ? currentUser.email : "admin";
        _postDate = eventValue.postDate;
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
    _eventDetailsController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
  }

  Future<void> _submit() async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (_formKey.currentState!.validate()) {
      final event = Event(
        id: widget.eventId ?? DateTime.now().toIso8601String(),
        title: _titleController.text,
        listTitle: _listTitleController.text,
        postedBy:
            currentUser != null ? currentUser.email : "admin@srbsofhouston.com",
        postDate: _postDate,
        lastUpdated: DateTime.now(),
        type: _eventType,
        status: _eventStatus!,
        eventDetails: _eventDetailsController.text,
        startDate: DateTime(
          _eventStartDate.year,
          _eventStartDate.month,
          _eventStartDate.day,
          _eventStartTime.hour,
          _eventStartTime.minute,
        ),
        endDate: DateTime(
          _eventEndDate.year,
          _eventEndDate.month,
          _eventEndDate.day,
          _eventEndTime.hour,
          _eventEndTime.minute,
        ),
        location: _locationController.text,
        address: _addressController.text,
        city: _cityController.text,
        state: _stateController.text,
        zip: _zipController.text,
        imageUrl: _eventImageURL,
      );

      final success = await ref
          .read(addEditEventScreenControllerProvider.notifier)
          .addOrUpdateEvent(
            eventId: widget.eventId,
            event: event,
            eventImageFile: _eventImageFile,
          );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.eventId != null
                ? Strings.eventUpdated
                : Strings.eventAdded),
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
    if (delete == true && widget.eventId != null) {
      await ref
          .read(addEditEventScreenControllerProvider.notifier)
          .deleteEvent(widget.eventId!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Strings.eventDeleted)),
        );
        ref.read(goRouterProvider).goNamed(AppRoute.events.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      addEditEventScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(addEditEventScreenControllerProvider);
    final isLoading = state.isLoading;

    return Scaffold(
      appBar: HomeAppBar(
        title: widget.eventId != null ? Strings.editEvent : Strings.addEvent,
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
              imageFile: _eventImageFile,
              imageUrl: _eventImageURL,
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
      _eventImageFile = file;
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
            validator: ref.read(eventValidatorProvider).titleValidator,
          ),
          gapH8,
          CustomTextFormField(
            controller: _listTitleController,
            isEnabled: !isLoading,
            labelText: 'List Title'.hardcoded,
            validator: ref.read(eventValidatorProvider).titleValidator,
          ),
          gapH8,
          CustomDropdownWidget(
            hint: 'Event Status',
            itemsList: _eventStatusOptions,
            labelText: 'Status',
            value: _eventStatus!,
            onChanged: (value) => setState(() => _eventStatus = value),
          ),
          gapH8,
          CustomDropdownWidget(
            hint: 'Event Type',
            itemsList: _eventTypeOptions,
            labelText: 'Type',
            value: _eventType!,
            onChanged: (value) => setState(() => _eventType = value),
          ),
          gapH8,
          CustomTextFormField(
            controller: _eventDetailsController,
            isEnabled: !isLoading,
            labelText: 'Details'.hardcoded,
            textInputType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 5,
            minLines: 4,
            validator: ref.read(eventValidatorProvider).eventDetailsValidator,
          ),
          gapH8,
          CustomDateTimePicker(
            labelText: 'Start',
            selectedDate: _eventStartDate,
            selectedTime: _eventStartTime,
            onSelectedDate: (date) => setState(() => _eventStartDate = date),
            onSelectedTime: (time) => setState(() => _eventStartTime = time),
          ),
          gapH8,
          CustomDateTimePicker(
            labelText: 'End',
            selectedDate: _eventStartDate,
            selectedTime: TimeOfDay.fromDateTime(
                DateTime(0, 0, 0, _eventStartTime.hour, _eventStartTime.minute)
                    .add(const Duration(hours: 1))),
            onSelectedDate: (date) => setState(() => _eventEndDate = date),
            onSelectedTime: (time) => setState(() => _eventEndTime = time),
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
          if (widget.eventId != null) ...[
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
