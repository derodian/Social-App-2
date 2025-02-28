// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'62c1f69bc76821845957a5ea05d06a7cec1473f1';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeProvider<AppUser?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeProviderRef<AppUser?>;
String _$isAuthenticatedHash() => r'54fa2e7165f29e09a4d03d1f0bf7ae0df72cf5dc';

/// See also [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAuthenticatedRef = AutoDisposeProviderRef<bool>;
String _$isEmailVerifiedHash() => r'acf038e1b8b9984711b658ad184983d0133529e3';

/// See also [isEmailVerified].
@ProviderFor(isEmailVerified)
final isEmailVerifiedProvider = AutoDisposeProvider<bool>.internal(
  isEmailVerified,
  name: r'isEmailVerifiedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isEmailVerifiedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsEmailVerifiedRef = AutoDisposeProviderRef<bool>;
String _$isApprovedHash() => r'e4fd5cd65a3d1cfa143c9b9df37c9b19ecef2e11';

/// See also [isApproved].
@ProviderFor(isApproved)
final isApprovedProvider = AutoDisposeProvider<bool>.internal(
  isApproved,
  name: r'isApprovedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isApprovedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsApprovedRef = AutoDisposeProviderRef<bool>;
String _$isAdminHash() => r'27b36b63f49121c361323b8c40971fa1d7904532';

/// See also [isAdmin].
@ProviderFor(isAdmin)
final isAdminProvider = AutoDisposeProvider<bool>.internal(
  isAdmin,
  name: r'isAdminProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isAdminHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAdminRef = AutoDisposeProviderRef<bool>;
String _$authControllerHash() => r'270548c924a2c094283c9bcc5d767e6ebdf404b1';

/// See also [AuthController].
@ProviderFor(AuthController)
final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthResult?>.internal(
  AuthController.new,
  name: r'authControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthController = AsyncNotifier<AuthResult?>;
String _$deletionStateHash() => r'e8f415fe7518dc8006beff70bf0413aedbac7b57';

/// See also [DeletionState].
@ProviderFor(DeletionState)
final deletionStateProvider =
    AutoDisposeNotifierProvider<DeletionState, bool>.internal(
  DeletionState.new,
  name: r'deletionStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deletionStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeletionState = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
