import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app_2/src/common_widgets/content_text.dart';
import 'package:social_app_2/src/common_widgets/custom_card.dart';
import 'package:social_app_2/src/common_widgets/custom_image.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/features/news/domain/news.dart';
import 'package:social_app_2/src/utils/format.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.news,
    this.onPressed,
    this.width = 380,
  });
  final News news;
  final VoidCallback? onPressed;
  final double width;

  // * Keys for testing using find.byKey()
  static const newsCardKey = Key('news-card');

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: _buildNewsCard(context));
  }

  Widget _buildNewsCard(BuildContext context) {
    return CustomCard(
      child: InkWell(
        onTap: onPressed,
        child: Semantics(
          label: 'News: ${news.title}',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (news.imageUrl != null && news.imageUrl!.isNotEmpty)
                Hero(
                  tag: 'news-image-${news.id}',
                  child: CustomImage(imageUrl: news.imageUrl),
                ),
              Padding(
                padding: const EdgeInsets.all(Sizes.p8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildTitleAndDate(context),
                    const SizedBox(height: Sizes.p8),
                    _buildNewsDetails(),
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

  Widget _buildTitleAndDate(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Hero(
        tag: 'news-title-${news.id}',
        child: Material(
          color: Colors.transparent,
          child: Text(
            news.title,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  Widget _buildNewsDetails() {
    return Align(
      alignment: Alignment.centerLeft,
      child: ContentText(
        text: news.newsDetails,
        isContentTextMini: true,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return Format.date(date);
  }
}

class NewsCardShimmer extends StatelessWidget {
  const NewsCardShimmer({super.key, this.width = 380});

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
