import 'package:social_app_2/src/features/auth/domain/app_user.dart';

class AppUserFilter {
  final bool? isEmailVerified;
  final bool? isAdminApproved;
  final bool? isAdmin;
  final AppAuthProvider? provider;
  final String? domain;
  final String? searchTerm;
  final DateTime? createdAfter;
  final DateTime? createdBefore;
  final SortOrder sortOrder;
  final UserSortField sortField;

  const AppUserFilter({
    this.isEmailVerified,
    this.isAdminApproved,
    this.isAdmin,
    this.provider,
    this.domain,
    this.searchTerm,
    this.createdAfter,
    this.createdBefore,
    this.sortOrder = SortOrder.descending,
    this.sortField = UserSortField.lastLoginAt,
  });

  AppUserFilter copyWith({
    bool? isEmailVerified,
    bool? isAdminApproved,
    bool? isAdmin,
    AppAuthProvider? provider,
    String? domain,
    String? searchTerm,
    DateTime? createdAfter,
    DateTime? createdBefore,
    SortOrder? sortOrder,
    UserSortField? sortField,
  }) {
    return AppUserFilter(
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isAdminApproved: isAdminApproved ?? this.isAdminApproved,
      isAdmin: isAdmin ?? this.isAdmin,
      provider: provider ?? this.provider,
      domain: domain ?? this.domain,
      searchTerm: searchTerm ?? this.searchTerm,
      createdAfter: createdAfter ?? this.createdAfter,
      createdBefore: createdBefore ?? this.createdBefore,
      sortOrder: sortOrder ?? this.sortOrder,
      sortField: sortField ?? this.sortField,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppUserFilter &&
        other.isEmailVerified == isEmailVerified &&
        other.isAdminApproved == isAdminApproved &&
        other.isAdmin == isAdmin &&
        other.provider == provider &&
        other.domain == domain &&
        other.searchTerm == searchTerm &&
        other.createdAfter == createdAfter &&
        other.createdBefore == createdBefore &&
        other.sortOrder == sortOrder &&
        other.sortField == sortField;
  }

  @override
  int get hashCode {
    return Object.hash(
      isEmailVerified,
      isAdminApproved,
      isAdmin,
      provider,
      domain,
      searchTerm,
      createdAfter,
      createdBefore,
      sortOrder,
      sortField,
    );
  }
}

enum SortOrder {
  ascending,
  descending;

  bool get isAscending => this == SortOrder.ascending;
}

enum UserSortField {
  name,
  email,
  createdAt,
  lastLoginAt,
  lastUpdatedAt;

  String get fieldName => switch (this) {
        UserSortField.name => 'name',
        UserSortField.email => 'email',
        UserSortField.createdAt => 'createdAt',
        UserSortField.lastLoginAt => 'lastLoginAt',
        UserSortField.lastUpdatedAt => 'lastUpdatedAt',
      };
}
