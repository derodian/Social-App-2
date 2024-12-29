import 'dart:io';

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/news/data/news_repository.dart';
import 'package:social_app_2/src/features/news/domain/news.dart';
import 'package:social_app_2/src/features/news/typedefs/news_id.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/utils/notifier_mounted.dart';

part 'add_edit_news_screen_controller.g.dart';

@riverpod
class AddEditNewsScreenController extends _$AddEditNewsScreenController
    with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // no-op
  }

  final log = Logger();

  Future<bool> addOrUpdateNews({
    NewsID? newsId,
    required News news,
    File? newsImageFile,
  }) async {
    final newsRepository = ref.watch(newsRepositoryProvider);
    try {
      state = const AsyncLoading();

      final value = await AsyncValue.guard(() => newsRepository.createNews(
            id: news.id,
            news: news,
            imageFile: newsImageFile,
          ));

      final success = value.hasError == false;
      if (mounted) {
        state = value;
        if (success) {
          ref.read(goRouterProvider).pop();
        }
      }
      return success;
    } catch (e, st) {
      if (mounted) {
        state = AsyncError(e, st);
      }
      return false;
    }
  }

  Future<void> deleteNews({required NewsID id}) async {
    final imageUploadService = ref.read(newsRepositoryProvider);
    state = const AsyncLoading();
    final value =
        await AsyncValue.guard(() => imageUploadService.deleteNews(id));
    if (mounted) {
      state = value;
      if (!value.hasError) {
        ref.read(goRouterProvider).pop();
      }
    }
  }
}
