// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_event_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventWithUpdatedViewsHash() =>
    r'6353931781fa8fe900f4d269d07d0c8864594e47';

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

/// See also [eventWithUpdatedViews].
@ProviderFor(eventWithUpdatedViews)
const eventWithUpdatedViewsProvider = EventWithUpdatedViewsFamily();

/// See also [eventWithUpdatedViews].
class EventWithUpdatedViewsFamily extends Family<AsyncValue<Event?>> {
  /// See also [eventWithUpdatedViews].
  const EventWithUpdatedViewsFamily();

  /// See also [eventWithUpdatedViews].
  EventWithUpdatedViewsProvider call(
    String eventId,
  ) {
    return EventWithUpdatedViewsProvider(
      eventId,
    );
  }

  @override
  EventWithUpdatedViewsProvider getProviderOverride(
    covariant EventWithUpdatedViewsProvider provider,
  ) {
    return call(
      provider.eventId,
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
  String? get name => r'eventWithUpdatedViewsProvider';
}

/// See also [eventWithUpdatedViews].
class EventWithUpdatedViewsProvider extends AutoDisposeStreamProvider<Event?> {
  /// See also [eventWithUpdatedViews].
  EventWithUpdatedViewsProvider(
    String eventId,
  ) : this._internal(
          (ref) => eventWithUpdatedViews(
            ref as EventWithUpdatedViewsRef,
            eventId,
          ),
          from: eventWithUpdatedViewsProvider,
          name: r'eventWithUpdatedViewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventWithUpdatedViewsHash,
          dependencies: EventWithUpdatedViewsFamily._dependencies,
          allTransitiveDependencies:
              EventWithUpdatedViewsFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  EventWithUpdatedViewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    Stream<Event?> Function(EventWithUpdatedViewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventWithUpdatedViewsProvider._internal(
        (ref) => create(ref as EventWithUpdatedViewsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Event?> createElement() {
    return _EventWithUpdatedViewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventWithUpdatedViewsProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EventWithUpdatedViewsRef on AutoDisposeStreamProviderRef<Event?> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventWithUpdatedViewsProviderElement
    extends AutoDisposeStreamProviderElement<Event?>
    with EventWithUpdatedViewsRef {
  _EventWithUpdatedViewsProviderElement(super.provider);

  @override
  String get eventId => (origin as EventWithUpdatedViewsProvider).eventId;
}

String _$detailEventScreenControllerHash() =>
    r'5819a39b6025f77225099c1fd9af61624da5cade';

/// See also [DetailEventScreenController].
@ProviderFor(DetailEventScreenController)
final detailEventScreenControllerProvider = AutoDisposeAsyncNotifierProvider<
    DetailEventScreenController, void>.internal(
  DetailEventScreenController.new,
  name: r'detailEventScreenControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$detailEventScreenControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DetailEventScreenController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
