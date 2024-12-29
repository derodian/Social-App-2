import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app_2/src/common_widgets/content_text.dart';
import 'package:social_app_2/src/common_widgets/custom_card.dart';
import 'package:social_app_2/src/common_widgets/custom_image.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/features/events/domain/event.dart';
import 'package:social_app_2/src/utils/format.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    this.onPressed,
    this.width = 380,
  });

  final Event event;
  final VoidCallback? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: _buildEventCard(context));
  }

  Widget _buildEventCard(BuildContext context) {
    final eventStartDate = _formatDate(event.startDate);
    final eventEndDate = _formatDate(event.endDate);
    final bool isPastEvent = event.endDate.isBefore(DateTime.now());

    return CustomCard(
      child: InkWell(
        onTap: onPressed,
        child: Semantics(
          label: 'Event: ${event.title}',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (event.imageUrl != null && event.imageUrl!.isNotEmpty)
                Hero(
                  tag: 'event-image-${event.id}',
                  child: CustomImage(imageUrl: event.imageUrl),
                ),
              Padding(
                padding: const EdgeInsets.all(Sizes.p8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildTitleAndDate(
                      context,
                      isPastEvent,
                      eventStartDate,
                      eventEndDate,
                    ),
                    const SizedBox(height: Sizes.p8),
                    _buildEventDetails(),
                  ],
                ),
              ),
              gapH4,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDate(BuildContext context, bool isPastEvent,
      String startDate, String endDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Hero(
            tag: 'event-title-${event.id}',
            child: Material(
              color: Colors.transparent,
              child: Text(
                event.title,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                isPastEvent ? Icons.done : Icons.calendar_month,
                size: 18.0,
                color: isPastEvent ? Colors.green : Colors.black54,
              ),
              gapW8,
              Text(
                isPastEvent ? endDate : startDate,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventDetails() {
    return Align(
      alignment: Alignment.centerLeft,
      child: ContentText(
        text: event.eventDetails,
        isContentTextMini: true,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return Format.date(date);
  }
}

class EventCardShimmer extends StatelessWidget {
  const EventCardShimmer({super.key, this.width = 380});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmer(
              child: Container(
                height: 200,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.p8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmer(
                    child: Container(
                      width: double.infinity,
                      height: 24,
                      color: Colors.white,
                    ),
                  ),
                  gapH8,
                  _buildShimmer(
                    child: Container(
                      width: 100,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                  gapH8,
                  _buildShimmer(
                    child: Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                  gapH4,
                  _buildShimmer(
                    child: Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }
}
