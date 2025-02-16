import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/domain/provider_data.dart';

extension ProviderDataOperations on AppUser {
  bool hasProvider(String providerId) {
    return providerData?.any((p) => p.providerId == providerId) ?? false;
  }

  ProviderData? getProviderData(String providerId) {
    return providerData?.firstWhere(
      (p) => p.providerId == providerId,
      orElse: () => throw ProviderNotFoundException(providerId),
    );
  }

  bool get hasMultipleProviders {
    return (providerData?.length ?? 0) > 1;
  }

  bool canUnlinkProvider(String providerId) {
    return hasMultipleProviders && hasProvider(providerId);
  }
}

class ProviderNotFoundException implements Exception {
  final String providerId;

  ProviderNotFoundException(this.providerId);

  @override
  String toString() => 'Provider data not found for provider: $providerId';
}
