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
import 'package:social_app_2/src/common_widgets/responsive_two_colum_layout.dart';
import 'package:social_app_2/src/common_widgets/url_launcher_widgets.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/extensions/async_value_ui.dart';
import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';
import 'package:social_app_2/src/features/news/domain/news.dart';
import 'package:social_app_2/src/features/news/presentation/detail_news_screen_controller.dart';
import 'package:social_app_2/src/features/news/typedefs/news_id.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/theme/app_colors.dart';

class DetailNewsScreen extends ConsumerWidget {
  const DetailNewsScreen({required this.newsId, super.key});
  final NewsID newsId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      detailNewsScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: _buildAppBarIcon(
          icon: Icons.arrow_back,
          onPressed: () => context.pop(),
        ),
        actions: [
          AdminOnlyWidget(
            child: _buildAppBarIcon(
              icon: Icons.edit,
              onPressed: () => context.goNamed(
                AppRoute.editNews.name,
                pathParameters: {
                  'id': newsId,
                },
              ),
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          // final singleNewsValue =
          //     ref.watch(newsWithUpdatedViewsProvider(newsId));
          final newsStream = ref.watch(newsWithUpdatedViewsProvider(newsId));
          return AsyncValueWidget(
            value: newsStream,
            data: (news) => news == null
                ? const EmptyPlaceholderWidget(
                    message: Strings.noNewsAvailable,
                  )
                : CustomScrollView(
                    slivers: [
                      ResponsiveSliverCenter(
                        child: NewsDetails(news: news),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildAppBarIcon({
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

/// Shows all the news details along with actions to:
/// - open links (web, maps)
class NewsDetails extends ConsumerWidget {
  const NewsDetails({required this.news, super.key});
  final News news;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageURL = news.imageUrl != null && news.imageUrl!.isNotEmpty
        ? news.imageUrl
        : Strings.assetImage;
    final title = news.title;
    final details = news.newsDetails;
    final lastUpdated = news.lastUpdated;
    final location = news.location ?? "";
    final address = news.address ?? "";
    final city = news.city ?? "";
    final state = news.state ?? "";
    final zip = news.zip ?? "";

    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * (imageURL == null ? 0.2 : 0.7);

    return ResponsiveTwoColumnLayout(
      startContent: SizedBox(
        height: imageHeight,
        width: screenWidth,
        child: Hero(
          tag: 'news-image-${news.id}',
          child: CustomImage(
            imageUrl: imageURL,
            aspectRatio: 1,
          ),
        ),
      ),
      spacing: Sizes.p8,
      endContent: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'news-title-${news.id}',
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
            address.isNotEmpty
                ? ShowAddress(
                    location: location, address: '$address \n$city $state $zip')
                : Container(),
            gapH8,
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
                'Views: ${news.views}',
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
    );
  }
}
