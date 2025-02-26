// app_user_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/data/app_user_filter.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';

part 'app_user_controller.g.dart';

@riverpod
class AppUserController extends _$AppUserController {
  AppUserStorageService get _service =>
      ref.watch(appUserStorageServiceProvider);
  AuthController get authController =>
      ref.read(authControllerProvider.notifier);

  @override
  FutureOr<List<AppUser>> build() {
    // Initial empty state
    return [];
  }

  // Pagination methods
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;

  bool get hasMore => _hasMore;
  bool get isAdmin => authController.currentUser?.isAdmin ?? false;

  Future<void> loadNextPage({AppUserFilter? filter}) async {
    if (!_hasMore) return;

    state = const AsyncLoading();
    try {
      final result = await _service.fetchAppUsers(
        startAfter: _lastDocument,
        filter: filter,
      );

      final currentUsers = state.valueOrNull ?? [];
      final updatedUsers = [...currentUsers, ...result.users];

      _lastDocument = result.lastDocument;
      _hasMore = result.hasMore;

      state = AsyncData(updatedUsers);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refresh() async {
    _lastDocument = null;
    _hasMore = true;
    state = const AsyncData([]);
    await loadNextPage();
  }

  // Single user operations
  Future<AppUser?> getUser(String userId) async {
    try {
      return await _service.getUser(userId);
    } catch (e) {
      return null;
    }
  }

  Stream<AppUser?> watchUser(String userId) {
    return _service.watchUser(userId);
  }

  // Admin operations
  Future<void> toggleUserAdmin(String userId, bool isAdmin) async {
    if (!this.isAdmin) {
      throw Exception('Only admins can modify admin status');
    }
    state = const AsyncLoading();
    try {
      await _service.updateAdminStatus(userId, isAdmin);
      await refresh();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> toggleUserApproval(String userId, bool isApproved) async {
    if (!isAdmin) {
      throw Exception('Only admins can modify approval status');
    }
    state = const AsyncLoading();
    try {
      await _service.updateApprovalStatus(userId, isApproved);
      await refresh();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateAdminStatus(String userId, bool isAdmin) async {
    await _service.updateAdminStatus(userId, isAdmin);
    await refresh();
  }

  // Search operations
  Future<List<AppUser>> searchUsers(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final result = await _service.fetchAppUsers(
        filter: AppUserFilter(searchTerm: query),
      );
      return result.users;
    } catch (e) {
      return [];
    }
  }

  // Filtered watching
  Stream<List<AppUser>> watchFilteredUsers(AppUserFilter filter) {
    return _service.watchAppUsers(filter: filter);
  }
}

@riverpod
bool isUserAdmin(Ref ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser?.isAdmin ?? false;
}
