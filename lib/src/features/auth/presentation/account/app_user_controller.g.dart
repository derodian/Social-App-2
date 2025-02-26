// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isUserAdminHash() => r'de4457ae38154384453547c0911feaa2917025bc';

/// See also [isUserAdmin].
@ProviderFor(isUserAdmin)
final isUserAdminProvider = AutoDisposeProvider<bool>.internal(
  isUserAdmin,
  name: r'isUserAdminProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isUserAdminHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsUserAdminRef = AutoDisposeProviderRef<bool>;
String _$appUserControllerHash() => r'9609722165aea1642dca63b63c2c12c3b64db604';

/// See also [AppUserController].
@ProviderFor(AppUserController)
final appUserControllerProvider =
    AutoDisposeAsyncNotifierProvider<AppUserController, List<AppUser>>.internal(
  AppUserController.new,
  name: r'appUserControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appUserControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppUserController = AutoDisposeAsyncNotifier<List<AppUser>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
