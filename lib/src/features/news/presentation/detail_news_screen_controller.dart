import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/news/data/news_repository.dart';
import 'package:social_app_2/src/features/news/domain/news.dart';
import 'package:social_app_2/src/features/news/typedefs/news_id.dart';
import 'package:social_app_2/src/utils/notifier_mounted.dart';

part 'detail_news_screen_controller.g.dart';

@riverpod
class DetailNewsScreenController extends _$DetailNewsScreenController
    with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // no-op
  }

  Future<void> incrementViewCount(NewsID newsId) async {
    final newsRepository = ref.read(newsRepositoryProvider);
    await newsRepository.incrementNewsViewsCount(newsId);
  }
}

@riverpod
Stream<News?> newsWithUpdatedViews(Ref ref, NewsID newsId) {
  final controller = ref.watch(detailNewsScreenControllerProvider.notifier);

  // Increment view count when the stream is first listened to
  ref.onDispose(() {
    controller.incrementViewCount(newsId);
  });

  final eventRepository = ref.watch(newsRepositoryProvider);
  return eventRepository.watchNews(newsId);
}
