// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_news_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newsWithUpdatedViewsHash() =>
    r'1167d0d56008971e7380d55409656afe821f3985';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [newsWithUpdatedViews].
@ProviderFor(newsWithUpdatedViews)
const newsWithUpdatedViewsProvider = NewsWithUpdatedViewsFamily();

/// See also [newsWithUpdatedViews].
class NewsWithUpdatedViewsFamily extends Family<AsyncValue<News?>> {
  /// See also [newsWithUpdatedViews].
  const NewsWithUpdatedViewsFamily();

  /// See also [newsWithUpdatedViews].
  NewsWithUpdatedViewsProvider call(
    String newsId,
  ) {
    return NewsWithUpdatedViewsProvider(
      newsId,
    );
  }

  @override
  NewsWithUpdatedViewsProvider getProviderOverride(
    covariant NewsWithUpdatedViewsProvider provider,
  ) {
    return call(
      provider.newsId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'newsWithUpdatedViewsProvider';
}

/// See also [newsWithUpdatedViews].
class NewsWithUpdatedViewsProvider extends AutoDisposeStreamProvider<News?> {
  /// See also [newsWithUpdatedViews].
  NewsWithUpdatedViewsProvider(
    String newsId,
  ) : this._internal(
          (ref) => newsWithUpdatedViews(
            ref as NewsWithUpdatedViewsRef,
            newsId,
          ),
          from: newsWithUpdatedViewsProvider,
          name: r'newsWithUpdatedViewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$newsWithUpdatedViewsHash,
          dependencies: NewsWithUpdatedViewsFamily._dependencies,
          allTransitiveDependencies:
              NewsWithUpdatedViewsFamily._allTransitiveDependencies,
          newsId: newsId,
        );

  NewsWithUpdatedViewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.newsId,
  }) : super.internal();

  final String newsId;

  @override
  Override overrideWith(
    Stream<News?> Function(NewsWithUpdatedViewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NewsWithUpdatedViewsProvider._internal(
        (ref) => create(ref as NewsWithUpdatedViewsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        newsId: newsId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<News?> createElement() {
    return _NewsWithUpdatedViewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NewsWithUpdatedViewsProvider && other.newsId == newsId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, newsId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NewsWithUpdatedViewsRef on AutoDisposeStreamProviderRef<News?> {
  /// The parameter `newsId` of this provider.
  String get newsId;
}

class _NewsWithUpdatedViewsProviderElement
    extends AutoDisposeStreamProviderElement<News?>
    with NewsWithUpdatedViewsRef {
  _NewsWithUpdatedViewsProviderElement(super.provider);

  @override
  String get newsId => (origin as NewsWithUpdatedViewsProvider).newsId;
}

String _$detailNewsScreenControllerHash() =>
    r'8367741423c80595fb8d18d8b88c1cb548c2505f';

/// See also [DetailNewsScreenController].
@ProviderFor(DetailNewsScreenController)
final detailNewsScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<DetailNewsScreenController, void>.internal(
  DetailNewsScreenController.new,
  name: r'detailNewsScreenControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$detailNewsScreenControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DetailNewsScreenController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
