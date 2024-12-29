import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
import 'package:social_app_2/src/common_widgets/content_text.dart';
import 'package:social_app_2/src/common_widgets/custom_image.dart';
import 'package:social_app_2/src/common_widgets/divider_with_margins.dart';
import 'package:social_app_2/src/common_widgets/empty_placeholder_widget.dart';
import 'package:social_app_2/src/common_widgets/responsive_center.dart';
import 'package:social_app_2/src/common_widgets/url_launcher_widgets.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/extensions/async_value_ui.dart';
import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';
import 'package:social_app_2/src/features/events/domain/event.dart';
import 'package:social_app_2/src/features/events/presentation/detail_event_screen_controller.dart';
import 'package:social_app_2/src/features/events/typedefs/event_id.dart';
import 'package:social_app_2/src/features/services/calendar_service.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/theme/app_colors.dart';

class DetailEventScreen extends ConsumerWidget {
  const DetailEventScreen({required this.eventId, super.key});
  final EventID eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      detailEventScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0.0,
        leading: _buildAppBarIcon(
          context: context,
          icon: Icons.arrow_back,
          onPressed: () => context.pop(),
        ),
        actions: [
          AdminOnlyWidget(
            child: _buildAppBarIcon(
              context: context,
              icon: Icons.edit,
              onPressed: () => context.goNamed(
                AppRoute.editEvent.name,
                pathParameters: {
                  'id': eventId,
                },
              ),
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final eventStream = ref.watch(eventWithUpdatedViewsProvider(eventId));
          return AsyncValueWidget(
            value: eventStream,
            data: (event) => event == null
                ? const EmptyPlaceholderWidget(
                    message: Strings.noEventAvailable,
                  )
                : CustomScrollView(
                    slivers: [
                      ResponsiveSliverCenter(
                        child: EventDetails(event: event),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildAppBarIcon({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.kcBlackColor.withOpacity(0.65),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: AppColors.kcWhiteColor,
        onPressed: onPressed,
      ),
    );
  }
}

/// Shows all the event details along with actions to:
/// - open links (web, maps)
class EventDetails extends ConsumerWidget {
  const EventDetails({required this.event, super.key});
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageURL = event.imageUrl != null && event.imageUrl!.isNotEmpty
        ? event.imageUrl
        : Strings.assetImage;
    final title = event.title;
    final details = event.eventDetails;
    final lastUpdated = event.lastUpdated;
    final location = event.location ?? "";
    final address = event.address ?? "";
    final city = event.city ?? "";
    final state = event.state ?? "";
    final zip = event.zip ?? "";
    final startDate = event.startDate;
    final endDate = event.endDate;
    final isEventOld = endDate.isBefore(DateTime.now());

    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * (imageURL == null ? 0.2 : 0.7);

    String calculateEventDuration(
        {required DateTime startDate, required DateTime endDate}) {
      final Duration duration = endDate.difference(startDate);
      final int days = duration.inDays;
      final int hours = duration.inHours % 24;
      final int minutes = duration.inMinutes % 60;

      if (days > 0) {
        if (hours == 0) {
          return '$days days';
        }
        return '$days days and $hours hours';
      } else {
        if (hours > 0) {
          if (minutes == 0) {
            return '$hours hours';
          }
          return '$hours hours and $minutes minutes';
        } else {
          return '$minutes minutes';
        }
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: imageHeight,
            width: screenWidth,
            child: Hero(
              tag: 'event-image-${event.id}',
              child: CustomImage(
                imageUrl: imageURL,
                aspectRatio: 1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'event-title-${event.id}',
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                gapH8,
                const DividerWithMargins(),
                gapH8,
                ContentText(text: details),
                gapH8,
                InkWell(
                  onTap: isEventOld
                      ? null
                      : () {
                          final calendarService = CalendarService();
                          calendarService.addToCalendar(appEvent: event);
                        },
                  child: ListTile(
                    leading: Icon(
                      Icons.date_range,
                      size: 36,
                      color: isEventOld
                          ? AppColors.kcLightGreyColor
                          : AppColors.kcPrimaryColor,
                    ),
                    title: _showDate(
                      startDate: startDate,
                      endDate: endDate,
                      context: context,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Duration: ${calculateEventDuration(startDate: event.startDate, endDate: event.endDate)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.kcMediumGreyColor),
                  ),
                ),
                gapH8,
                if (address.isNotEmpty)
                  ShowAddress(
                    location: location,
                    address: '$address \n$city $state $zip',
                  ),
                gapH24,
                Text(
                  "Last updated: ${DateFormat.yMMMd().format(lastUpdated.toLocal())}",
                  textAlign: TextAlign.right,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.kcMediumGreyColor),
                ),
                gapH24,
                AdminOnlyWidget(
                  child: Text(
                    'Views: ${event.views}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.kcMediumGreyColor),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _showDate({
    required DateTime startDate,
    required DateTime endDate,
    required BuildContext context,
  }) {
    final DateFormat dateFmt = DateFormat.yMMMd();
    final DateFormat timeFmt = DateFormat.jm();

    if (startDate.day == endDate.day &&
        startDate.month == endDate.month &&
        startDate.year == endDate.year) {
      // Event starts and ends on the same day
      return Text(
        '${dateFmt.format(startDate)}\nfrom ${timeFmt.format(startDate)} to ${timeFmt.format(endDate)}',
        style: Theme.of(context).textTheme.bodyLarge,
      );
    } else {
      // Event spans multiple days
      return Text(
        'From\n${dateFmt.format(startDate)} at ${timeFmt.format(startDate)} to\n${dateFmt.format(endDate)} at ${timeFmt.format(endDate)}',
        style: Theme.of(context).textTheme.labelLarge,
      );
    }
  }
}
