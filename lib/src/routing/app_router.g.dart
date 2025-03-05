// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRouterHash() => r'18e75337373d30d359165cdccbe83d9e17a2c9a9';

/// See also [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = Provider<GoRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppRouterRef = ProviderRef<GoRouter>;
String _$currentPathHash() => r'b09deab92f65290a6c2a544a60ed94d66e1247b3';

/// See also [currentPath].
@ProviderFor(currentPath)
final currentPathProvider = AutoDisposeProvider<String?>.internal(
  currentPath,
  name: r'currentPathProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentPathHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentPathRef = AutoDisposeProviderRef<String?>;
String _$routerControllerHash() => r'c9adc1797a62432bf6fbe5d9d18dbffe7a5379b1';

/// See also [RouterController].
@ProviderFor(RouterController)
final routerControllerProvider =
    AutoDisposeNotifierProvider<RouterController, void>.internal(
  RouterController.new,
  name: r'routerControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routerControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RouterController = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
