// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'committee_member_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$committeeMemberRepositoryHash() =>
    r'e1d10d82e1eb6a96c8d49be2f5c0deb33cd7dab0';

/// See also [committeeMemberRepository].
@ProviderFor(committeeMemberRepository)
final committeeMemberRepositoryProvider =
    Provider<CommitteeMemberRepository>.internal(
  committeeMemberRepository,
  name: r'committeeMemberRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$committeeMemberRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CommitteeMemberRepositoryRef = ProviderRef<CommitteeMemberRepository>;
String _$committeeMemberListStreamHash() =>
    r'cecdf93cf3106f86fc783f4f22768a7feb032e3f';

/// See also [committeeMemberListStream].
@ProviderFor(committeeMemberListStream)
final committeeMemberListStreamProvider =
    AutoDisposeStreamProvider<List<CommitteeMember>>.internal(
  committeeMemberListStream,
  name: r'committeeMemberListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$committeeMemberListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CommitteeMemberListStreamRef
    = AutoDisposeStreamProviderRef<List<CommitteeMember>>;
String _$committeeMemberListFutureHash() =>
    r'32ae20366c6e2377ed80df5922b9d02aa13417de';

/// See also [committeeMemberListFuture].
@ProviderFor(committeeMemberListFuture)
final committeeMemberListFutureProvider =
    AutoDisposeFutureProvider<List<CommitteeMember>>.internal(
  committeeMemberListFuture,
  name: r'committeeMemberListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$committeeMemberListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CommitteeMemberListFutureRef
    = AutoDisposeFutureProviderRef<List<CommitteeMember>>;
String _$committeeMemberStreamHash() =>
    r'6ad3a728fd3e6428e478b1954b69b50a5b4a782e';

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

/// See also [committeeMemberStream].
@ProviderFor(committeeMemberStream)
const committeeMemberStreamProvider = CommitteeMemberStreamFamily();

/// See also [committeeMemberStream].
class CommitteeMemberStreamFamily extends Family<AsyncValue<CommitteeMember?>> {
  /// See also [committeeMemberStream].
  const CommitteeMemberStreamFamily();

  /// See also [committeeMemberStream].
  CommitteeMemberStreamProvider call(
    String id,
  ) {
    return CommitteeMemberStreamProvider(
      id,
    );
  }

  @override
  CommitteeMemberStreamProvider getProviderOverride(
    covariant CommitteeMemberStreamProvider provider,
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
  String? get name => r'committeeMemberStreamProvider';
}

/// See also [committeeMemberStream].
class CommitteeMemberStreamProvider
    extends AutoDisposeStreamProvider<CommitteeMember?> {
  /// See also [committeeMemberStream].
  CommitteeMemberStreamProvider(
    String id,
  ) : this._internal(
          (ref) => committeeMemberStream(
            ref as CommitteeMemberStreamRef,
            id,
          ),
          from: committeeMemberStreamProvider,
          name: r'committeeMemberStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$committeeMemberStreamHash,
          dependencies: CommitteeMemberStreamFamily._dependencies,
          allTransitiveDependencies:
              CommitteeMemberStreamFamily._allTransitiveDependencies,
          id: id,
        );

  CommitteeMemberStreamProvider._internal(
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
    Stream<CommitteeMember?> Function(CommitteeMemberStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CommitteeMemberStreamProvider._internal(
        (ref) => create(ref as CommitteeMemberStreamRef),
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
  AutoDisposeStreamProviderElement<CommitteeMember?> createElement() {
    return _CommitteeMemberStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommitteeMemberStreamProvider && other.id == id;
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
mixin CommitteeMemberStreamRef
    on AutoDisposeStreamProviderRef<CommitteeMember?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CommitteeMemberStreamProviderElement
    extends AutoDisposeStreamProviderElement<CommitteeMember?>
    with CommitteeMemberStreamRef {
  _CommitteeMemberStreamProviderElement(super.provider);

  @override
  String get id => (origin as CommitteeMemberStreamProvider).id;
}

String _$committeeMemberFutureHash() =>
    r'44f3845daf9684bf13457dd9a08b784585ed28ce';

/// See also [committeeMemberFuture].
@ProviderFor(committeeMemberFuture)
const committeeMemberFutureProvider = CommitteeMemberFutureFamily();

/// See also [committeeMemberFuture].
class CommitteeMemberFutureFamily extends Family<AsyncValue<CommitteeMember?>> {
  /// See also [committeeMemberFuture].
  const CommitteeMemberFutureFamily();

  /// See also [committeeMemberFuture].
  CommitteeMemberFutureProvider call(
    String id,
  ) {
    return CommitteeMemberFutureProvider(
      id,
    );
  }

  @override
  CommitteeMemberFutureProvider getProviderOverride(
    covariant CommitteeMemberFutureProvider provider,
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
  String? get name => r'committeeMemberFutureProvider';
}

/// See also [committeeMemberFuture].
class CommitteeMemberFutureProvider
    extends AutoDisposeFutureProvider<CommitteeMember?> {
  /// See also [committeeMemberFuture].
  CommitteeMemberFutureProvider(
    String id,
  ) : this._internal(
          (ref) => committeeMemberFuture(
            ref as CommitteeMemberFutureRef,
            id,
          ),
          from: committeeMemberFutureProvider,
          name: r'committeeMemberFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$committeeMemberFutureHash,
          dependencies: CommitteeMemberFutureFamily._dependencies,
          allTransitiveDependencies:
              CommitteeMemberFutureFamily._allTransitiveDependencies,
          id: id,
        );

  CommitteeMemberFutureProvider._internal(
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
    FutureOr<CommitteeMember?> Function(CommitteeMemberFutureRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CommitteeMemberFutureProvider._internal(
        (ref) => create(ref as CommitteeMemberFutureRef),
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
  AutoDisposeFutureProviderElement<CommitteeMember?> createElement() {
    return _CommitteeMemberFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommitteeMemberFutureProvider && other.id == id;
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
mixin CommitteeMemberFutureRef
    on AutoDisposeFutureProviderRef<CommitteeMember?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CommitteeMemberFutureProviderElement
    extends AutoDisposeFutureProviderElement<CommitteeMember?>
    with CommitteeMemberFutureRef {
  _CommitteeMemberFutureProviderElement(super.provider);

  @override
  String get id => (origin as CommitteeMemberFutureProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
