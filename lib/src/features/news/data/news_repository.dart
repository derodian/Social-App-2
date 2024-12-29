import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/constants/firebase_collection_name.dart';
import 'package:social_app_2/src/constants/firebase_field_name.dart';
import 'package:social_app_2/src/features/news/domain/news.dart';
import 'package:social_app_2/src/features/news/domain/news_payload.dart';
import 'package:social_app_2/src/features/news/typedefs/news_id.dart';
import 'package:social_app_2/src/features/services/logger.dart';

part 'news_repository.g.dart';

class NewsRepository {
  NewsRepository(this._firestore, this._storage);
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  final _log = getLogger("EventRepository");

  static String newsPath() => 'news';
  static String singleNewsPath(NewsID id) => 'news/$id';

  Future<List<News>> fetchNewsList({int limit = 20, News? startAfter}) async {
    try {
      var query = _newsRef().limit(limit);
      if (startAfter != null) {
        query = query.startAfterDocument(
            await _firestore.doc(singleNewsPath(startAfter.id)).get());
      }
      final snapshot = await query.get();
      return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
    } catch (e) {
      _log.e('Error fetching news list: $e');
      rethrow;
    }
  }

  Stream<List<News>> watchNewsList({int limit = 20, News? startAfter}) {
    Query<News> query = _newsRef().limit(limit);

    if (startAfter != null) {
      query = query.startAfter([startAfter.id]);
    }

    return query
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<News?> fetchNews(NewsID id) async {
    try {
      final ref = _singleNewsRef(id);
      final snapshot = await ref.get();
      return snapshot.data();
    } catch (e) {
      _log.e('Error fetching news $id: $e');
      rethrow;
    }
  }

  Stream<News?> watchNews(NewsID id) {
    final ref = _singleNewsRef(id);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  Future<void> createNews({
    required NewsID id,
    required News news,
    File? imageFile,
  }) async {
    try {
      String? imageUrl;
      String? imageFileName;

      if (imageFile != null) {
        final uploadResult = await _uploadImage(id, imageFile);
        imageUrl = uploadResult.imageUrl;
        imageFileName = uploadResult.fileName;
      }

      final updatedNews = news.copyWith(
        imageUrl: imageUrl ?? news.imageUrl,
        imageFileName: imageFileName ?? news.imageFileName,
      );

      final payload = NewsPayload.fromNews(updatedNews);

      await _firestore.doc(singleNewsPath(id)).set(
            payload,
            SetOptions(merge: true),
          );
    } catch (e) {
      _log.e('Error creating/updating news $id: $e');
      rethrow;
    }
  }

  Future<void> updateNews(News news) async {
    try {
      final ref = _singleNewsRef(news.id);
      await ref.set(news);
    } catch (e) {
      _log.e('Error updating news ${news.id}: $e');
      rethrow;
    }
  }

  Future<void> deleteNews(NewsID id) async {
    try {
      final newsImageRef = FirebaseStorage.instance
          .ref()
          .child(FirebaseCollectionName.news)
          .child(id);

      await _firestore.runTransaction((transaction) async {
        final newsRef = _firestore.doc(singleNewsPath(id));
        transaction.delete(newsRef);
      });

      try {
        await newsImageRef.delete();
      } catch (e) {
        _log.w('Error deleting news image for $id: $e');
        // Continue execution even if image deletion fails
      }
    } catch (e) {
      _log.e('Error deleting news $id: $e');
      rethrow;
    }
  }

  Future<void> deleteMultipleNews(List<NewsID> ids) async {
    final batch = _firestore.batch();
    for (final id in ids) {
      batch.delete(_firestore.doc(singleNewsPath(id)));
    }
    try {
      await batch.commit();
    } catch (e) {
      _log.e('Error deleting multiple news: $e');
      rethrow;
    }
  }

  Future<void> incrementNewsViewsCount(NewsID id) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final newsRef = _firestore.doc(singleNewsPath(id));
        final snapshot = await transaction.get(newsRef);
        final currentViews =
            (snapshot.data()?[FirebaseFieldName.newsViews] as int?) ?? 0;
        transaction
            .update(newsRef, {FirebaseFieldName.newsViews: currentViews + 1});
      });
    } catch (e) {
      _log.e('Error incrementing views for news $id: $e');
      rethrow;
    }
  }

  Future<({String imageUrl, String fileName})> _uploadImage(
      NewsID newsId, File imageFile) async {
    final fileName = '${newsId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = _storage
        .ref()
        .child(FirebaseCollectionName.news)
        .child(newsId)
        .child(fileName);

    final uploadTask = await ref.putFile(imageFile);
    final imageUrl = await uploadTask.ref.getDownloadURL();

    return (imageUrl: imageUrl, fileName: fileName);
  }

  Future<void> _deleteImage(NewsID newsId, String fileName) async {
    final ref = _storage
        .ref()
        .child(FirebaseCollectionName.news)
        .child(newsId)
        .child(fileName);
    await ref.delete();
  }

  DocumentReference<News> _singleNewsRef(NewsID id) =>
      _firestore.doc(singleNewsPath(id)).withConverter(
            fromFirestore: (doc, _) => News.fromMap(doc.data()!),
            toFirestore: (News news, options) => news.toMap(),
          );

  Query<News> _newsRef() => _firestore
      .collection(newsPath())
      .withConverter(
        fromFirestore: (doc, _) => News.fromMap(doc.data()!),
        toFirestore: (News news, options) => news.toMap(),
      )
      .orderBy(FirebaseFieldName.newsPostDate, descending: true);

  // * Temporary search implementation
  // * Note: this is quite inefficient as it pulls the
  // * entire news list and then filters the data on
  // * the client
  Future<List<News>> search(String query) async {
    // 1. Get all news from firebase
    final newsList = await fetchNewsList();
    // 2. Perform client-side filtering
    return newsList
        .where((news) => news.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

@Riverpod(keepAlive: true)
NewsRepository newsRepository(NewsRepositoryRef ref) {
  return NewsRepository(FirebaseFirestore.instance, FirebaseStorage.instance);
}

@riverpod
Stream<List<News>> newsListStream(NewsListStreamRef ref) {
  final newsRepository = ref.watch(newsRepositoryProvider);
  return newsRepository.watchNewsList();
}

@riverpod
Future<List<News>> newsListFuture(NewsListFutureRef ref) {
  final newsRepository = ref.watch(newsRepositoryProvider);
  return newsRepository.fetchNewsList();
}

@riverpod
Stream<News?> newsStream(NewsStreamRef ref, NewsID id) {
  final newsRepository = ref.watch(newsRepositoryProvider);
  return newsRepository.watchNews(id);
}

@riverpod
Future<News?> newsFuture(NewsFutureRef ref, NewsID id) {
  final newsRepository = ref.watch(newsRepositoryProvider);
  return newsRepository.fetchNews(id);
}
