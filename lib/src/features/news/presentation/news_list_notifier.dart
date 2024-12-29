// EventsListNotifier to handle pagination
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/news/data/news_repository.dart';
import 'package:social_app_2/src/features/news/domain/news.dart';

part 'news_list_notifier.g.dart';

@riverpod
class NewsListNotifier extends _$NewsListNotifier {
  static const int _pageSize = 20;
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  @override
  Stream<List<News>> build() {
    return _watchNews();
  }

  Stream<List<News>> _watchNews() {
    final newsRepository = ref.watch(newsRepositoryProvider);
    return newsRepository.watchNewsList(limit: _pageSize);
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;

    final currentNews = state.value ?? [];
    if (currentNews.isEmpty) return;

    final lastNews = currentNews.last;
    final newsRepository = ref.read(newsRepositoryProvider);

    final newNews = await newsRepository.fetchNewsList(
      limit: _pageSize,
      startAfter: lastNews,
    );

    _hasMore = newNews.length == _pageSize;
    state = AsyncValue.data([...currentNews, ...newNews]);
  }

  Future<void> refresh() async {
    _hasMore = true;
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _watchNews().first);
  }
}
