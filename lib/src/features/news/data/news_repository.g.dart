// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newsRepositoryHash() => r'd18d3b845925c05ab6a2a61a9a6ab5110f11464b';

/// See also [newsRepository].
@ProviderFor(newsRepository)
final newsRepositoryProvider = Provider<NewsRepository>.internal(
  newsRepository,
  name: r'newsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NewsRepositoryRef = ProviderRef<NewsRepository>;
String _$newsListStreamHash() => r'4d7bebed33aa8d25a05d9b091145d18f1d450fb5';

/// See also [newsListStream].
@ProviderFor(newsListStream)
final newsListStreamProvider = AutoDisposeStreamProvider<List<News>>.internal(
  newsListStream,
  name: r'newsListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newsListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NewsListStreamRef = AutoDisposeStreamProviderRef<List<News>>;
String _$newsListFutureHash() => r'f3e767b1a1e54eda3a6e8d7ccad0d0bf61e5d9c5';

/// See also [newsListFuture].
@ProviderFor(newsListFuture)
final newsListFutureProvider = AutoDisposeFutureProvider<List<News>>.internal(
  newsListFuture,
  name: r'newsListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newsListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NewsListFutureRef = AutoDisposeFutureProviderRef<List<News>>;
String _$newsStreamHash() => r'1ee9ddf354452099271b46671c34229ab0cf013b';

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

/// See also [newsStream].
@ProviderFor(newsStream)
const newsStreamProvider = NewsStreamFamily();

/// See also [newsStream].
class NewsStreamFamily extends Family<AsyncValue<News?>> {
  /// See also [newsStream].
  const NewsStreamFamily();

  /// See also [newsStream].
  NewsStreamProvider call(
    String id,
  ) {
    return NewsStreamProvider(
      id,
    );
  }

  @override
  NewsStreamProvider getProviderOverride(
    covariant NewsStreamProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'newsStreamProvider';
}

/// See also [newsStream].
class NewsStreamProvider extends AutoDisposeStreamProvider<News?> {
  /// See also [newsStream].
  NewsStreamProvider(
    String id,
  ) : this._internal(
          (ref) => newsStream(
            ref as NewsStreamRef,
            id,
          ),
          from: newsStreamProvider,
          name: r'newsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$newsStreamHash,
          dependencies: NewsStreamFamily._dependencies,
          allTransitiveDependencies:
              NewsStreamFamily._allTransitiveDependencies,
          id: id,
        );

  NewsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<News?> Function(NewsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NewsStreamProvider._internal(
        (ref) => create(ref as NewsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<News?> createElement() {
    return _NewsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NewsStreamProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NewsStreamRef on AutoDisposeStreamProviderRef<News?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _NewsStreamProviderElement extends AutoDisposeStreamProviderElement<News?>
    with NewsStreamRef {
  _NewsStreamProviderElement(super.provider);

  @override
  String get id => (origin as NewsStreamProvider).id;
}

String _$newsFutureHash() => r'cc4199bc9101fee1f42bff2006f36d1a06ce7aeb';

/// See also [newsFuture].
@ProviderFor(newsFuture)
const newsFutureProvider = NewsFutureFamily();

/// See also [newsFuture].
class NewsFutureFamily extends Family<AsyncValue<News?>> {
  /// See also [newsFuture].
  const NewsFutureFamily();

  /// See also [newsFuture].
  NewsFutureProvider call(
    String id,
  ) {
    return NewsFutureProvider(
      id,
    );
  }

  @override
  NewsFutureProvider getProviderOverride(
    covariant NewsFutureProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'newsFutureProvider';
}

/// See also [newsFuture].
class NewsFutureProvider extends AutoDisposeFutureProvider<News?> {
  /// See also [newsFuture].
  NewsFutureProvider(
    String id,
  ) : this._internal(
          (ref) => newsFuture(
            ref as NewsFutureRef,
            id,
          ),
          from: newsFutureProvider,
          name: r'newsFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$newsFutureHash,
          dependencies: NewsFutureFamily._dependencies,
          allTransitiveDependencies:
              NewsFutureFamily._allTransitiveDependencies,
          id: id,
        );

  NewsFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<News?> Function(NewsFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NewsFutureProvider._internal(
        (ref) => create(ref as NewsFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<News?> createElement() {
    return _NewsFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NewsFutureProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NewsFutureRef on AutoDisposeFutureProviderRef<News?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _NewsFutureProviderElement extends AutoDisposeFutureProviderElement<News?>
    with NewsFutureRef {
  _NewsFutureProviderElement(super.provider);

  @override
  String get id => (origin as NewsFutureProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
