import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/account/app_user_controller.dart';

class AppUsersScreen extends ConsumerStatefulWidget {
  const AppUsersScreen({super.key});

  @override
  ConsumerState<AppUsersScreen> createState() => _AppUsersScreenState();
}

class _AppUsersScreenState extends ConsumerState<AppUsersScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future(() => ref.read(appUserControllerProvider.notifier).loadNextPage());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final controller = ref.read(appUserControllerProvider.notifier);
      if (controller.hasMore) {
        controller.loadNextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(appUserControllerProvider);
    final isAdmin = ref.watch(isUserAdminProvider);

    if (!isAdmin) {
      return const Scaffold(
        body: Center(
          child: Text('Only admins can access this page'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(appUserControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search users...',
              onChanged: (value) {
                // Implement search
              },
              leading: const Icon(Icons.search),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  ref.read(appUserControllerProvider.notifier).refresh(),
              child: usersState.when(
                data: (users) => ListView.builder(
                  controller: _scrollController,
                  itemCount: users.length +
                      (ref.read(appUserControllerProvider.notifier).hasMore
                          ? 1
                          : 0),
                  itemBuilder: (context, index) {
                    if (index == users.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final user = users[index];
                    return UserManagementTile(user: user);
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserManagementTile extends ConsumerWidget {
  final AppUser user;

  const UserManagementTile({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: user.profileImageURL != null
            ? NetworkImage(user.profileImageURL!)
            : null,
        child: user.profileImageURL == null
            ? Text(user.displayName[0].toUpperCase())
            : null,
      ),
      title: Row(
        children: [
          Expanded(child: Text(user.displayName)),
          if (user.isAdmin)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.admin_panel_settings, color: Colors.blue),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.email),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                user.isEmailVerified ? Icons.verified : Icons.pending,
                size: 16,
                color: user.isEmailVerified ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 4),
              Text(
                user.isEmailVerified ? 'Verified' : 'Not Verified',
                style: TextStyle(
                  color: user.isEmailVerified ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) => _handleMenuAction(value, context, ref),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'approve',
            enabled: !user.isAdmin,
            child: const Text('Approve User'),
          ),
          PopupMenuItem(
            value: 'unapprove',
            enabled: user.isAdmin,
            child: const Text('Remove Approval'),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 'admin',
            enabled: !user.isAdmin,
            child: const Text('Make Admin'),
          ),
          PopupMenuItem(
            value: 'removeAdmin',
            enabled: user.isAdmin,
            child: const Text('Remove Admin'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleMenuAction(
      String action, BuildContext context, WidgetRef ref) async {
    try {
      switch (action) {
        case 'approve':
          await ref
              .read(appUserControllerProvider.notifier)
              .toggleUserApproval(user.id, true);
          break;
        case 'unapprove':
          await ref
              .read(appUserControllerProvider.notifier)
              .toggleUserApproval(user.id, false);
          break;
        case 'admin':
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Make Admin'),
              content: Text(
                  'Are you sure you want to make ${user.displayName} an admin?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Confirm'),
                ),
              ],
            ),
          );
          if (confirm == true) {
            await ref
                .read(appUserControllerProvider.notifier)
                .toggleUserAdmin(user.id, true);
          }
          break;
        case 'removeAdmin':
          await ref
              .read(appUserControllerProvider.notifier)
              .toggleUserAdmin(user.id, false);
          break;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
