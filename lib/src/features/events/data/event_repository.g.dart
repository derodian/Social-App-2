// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventRepositoryHash() => r'9db793d081807891c884bd4ba06ea86cce8a527b';

/// See also [eventRepository].
@ProviderFor(eventRepository)
final eventRepositoryProvider = Provider<EventRepository>.internal(
  eventRepository,
  name: r'eventRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventRepositoryRef = ProviderRef<EventRepository>;
String _$eventsListStreamHash() => r'ac0c0610af1c72402f52a7145e175e3d3151e09f';

/// See also [eventsListStream].
@ProviderFor(eventsListStream)
final eventsListStreamProvider =
    AutoDisposeStreamProvider<List<Event>>.internal(
  eventsListStream,
  name: r'eventsListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventsListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventsListStreamRef = AutoDisposeStreamProviderRef<List<Event>>;
String _$pastEventsListStreamHash() =>
    r'737726cceec27a60a076185ed5769bcf9b815ddd';

/// See also [pastEventsListStream].
@ProviderFor(pastEventsListStream)
final pastEventsListStreamProvider =
    AutoDisposeStreamProvider<List<Event>>.internal(
  pastEventsListStream,
  name: r'pastEventsListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pastEventsListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PastEventsListStreamRef = AutoDisposeStreamProviderRef<List<Event>>;
String _$eventsListFutureHash() => r'1db71d6ae6ded439b71f845a618f10a75c342dd3';

/// See also [eventsListFuture].
@ProviderFor(eventsListFuture)
final eventsListFutureProvider =
    AutoDisposeFutureProvider<List<Event>>.internal(
  eventsListFuture,
  name: r'eventsListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventsListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventsListFutureRef = AutoDisposeFutureProviderRef<List<Event>>;
String _$eventStreamHash() => r'9819311e58b80c11b5acb7847d44250551519321';

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

/// See also [eventStream].
@ProviderFor(eventStream)
const eventStreamProvider = EventStreamFamily();

/// See also [eventStream].
class EventStreamFamily extends Family<AsyncValue<Event?>> {
  /// See also [eventStream].
  const EventStreamFamily();

  /// See also [eventStream].
  EventStreamProvider call(
    String id,
  ) {
    return EventStreamProvider(
      id,
    );
  }

  @override
  EventStreamProvider getProviderOverride(
    covariant EventStreamProvider provider,
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
  String? get name => r'eventStreamProvider';
}

/// See also [eventStream].
class EventStreamProvider extends AutoDisposeStreamProvider<Event?> {
  /// See also [eventStream].
  EventStreamProvider(
    String id,
  ) : this._internal(
          (ref) => eventStream(
            ref as EventStreamRef,
            id,
          ),
          from: eventStreamProvider,
          name: r'eventStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventStreamHash,
          dependencies: EventStreamFamily._dependencies,
          allTransitiveDependencies:
              EventStreamFamily._allTransitiveDependencies,
          id: id,
        );

  EventStreamProvider._internal(
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
    Stream<Event?> Function(EventStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventStreamProvider._internal(
        (ref) => create(ref as EventStreamRef),
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
  AutoDisposeStreamProviderElement<Event?> createElement() {
    return _EventStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventStreamProvider && other.id == id;
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
mixin EventStreamRef on AutoDisposeStreamProviderRef<Event?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _EventStreamProviderElement
    extends AutoDisposeStreamProviderElement<Event?> with EventStreamRef {
  _EventStreamProviderElement(super.provider);

  @override
  String get id => (origin as EventStreamProvider).id;
}

String _$eventFutureHash() => r'e0ae7a393ed6e9467ece70c870c71cfc22055abe';

/// See also [eventFuture].
@ProviderFor(eventFuture)
const eventFutureProvider = EventFutureFamily();

/// See also [eventFuture].
class EventFutureFamily extends Family<AsyncValue<Event?>> {
  /// See also [eventFuture].
  const EventFutureFamily();

  /// See also [eventFuture].
  EventFutureProvider call(
    String id,
  ) {
    return EventFutureProvider(
      id,
    );
  }

  @override
  EventFutureProvider getProviderOverride(
    covariant EventFutureProvider provider,
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
  String? get name => r'eventFutureProvider';
}

/// See also [eventFuture].
class EventFutureProvider extends AutoDisposeFutureProvider<Event?> {
  /// See also [eventFuture].
  EventFutureProvider(
    String id,
  ) : this._internal(
          (ref) => eventFuture(
            ref as EventFutureRef,
            id,
          ),
          from: eventFutureProvider,
          name: r'eventFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventFutureHash,
          dependencies: EventFutureFamily._dependencies,
          allTransitiveDependencies:
              EventFutureFamily._allTransitiveDependencies,
          id: id,
        );

  EventFutureProvider._internal(
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
    FutureOr<Event?> Function(EventFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventFutureProvider._internal(
        (ref) => create(ref as EventFutureRef),
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
  AutoDisposeFutureProviderElement<Event?> createElement() {
    return _EventFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventFutureProvider && other.id == id;
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
mixin EventFutureRef on AutoDisposeFutureProviderRef<Event?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _EventFutureProviderElement
    extends AutoDisposeFutureProviderElement<Event?> with EventFutureRef {
  _EventFutureProviderElement(super.provider);

  @override
  String get id => (origin as EventFutureProvider).id;
}

String _$cachedEventsListHash() => r'934fadda9c6168f654763792fd1470f556c16f85';

/// See also [CachedEventsList].
@ProviderFor(CachedEventsList)
final cachedEventsListProvider =
    AsyncNotifierProvider<CachedEventsList, List<Event>>.internal(
  CachedEventsList.new,
  name: r'cachedEventsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cachedEventsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CachedEventsList = AsyncNotifier<List<Event>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
