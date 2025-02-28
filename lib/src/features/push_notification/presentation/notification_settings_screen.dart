import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/common_widgets/custom_card.dart';
import 'package:social_app_2/src/common_widgets/loading_overlay.dart';
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/components/app_bar/home_app_bar.dart';
import 'package:social_app_2/src/features/push_notification/data/notification_permission_manager.dart';
import 'package:social_app_2/src/features/push_notification/domain/notification_category.dart';
import 'package:social_app_2/src/utils/timeago_formatter.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends ConsumerState<NotificationSettingsScreen> {
  bool _isLoading = true;
  bool _masterSwitch = true;
  Map<NotificationCategory, bool> _categorySettings = {};

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);

    try {
      // Check if notifications are enabled globally
      final notificationManager =
          ref.read(notificationPermissionManagerProvider);
      final enabled = await notificationManager.areNotificationsEnabled();

      // Get category preferences
      final preferences = await notificationManager.getCategoryPreferences();

      setState(() {
        _masterSwitch = enabled;
        _categorySettings = preferences;
        _isLoading = false;
      });
    } catch (e) {
      // Set defaults on error
      setState(() {
        _masterSwitch = true;
        _categorySettings = {
          for (final category in NotificationCategory.values) category: true
        };
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleMasterSwitch(bool value) async {
    setState(() => _isLoading = true);

    try {
      final userId = ref.read(authControllerProvider.notifier).currentUser?.id;
      if (userId == null) return;

      final notificationManager =
          ref.read(notificationPermissionManagerProvider);
      await notificationManager.setNotificationsEnabled(userId, value);

      setState(() {
        _masterSwitch = value;
        _isLoading = false;
      });
    } catch (e) {
      // Revert on error
      setState(() {
        _masterSwitch = !value;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to update notification settings: $e')));
      }
    }
  }

  Future<void> _toggleCategorySetting(
      NotificationCategory category, bool value) async {
    setState(() => _isLoading = true);

    try {
      final userId = ref.read(authControllerProvider.notifier).currentUser?.id;
      if (userId == null) return;

      // Update the category setting
      final updatedSettings =
          Map<NotificationCategory, bool>.from(_categorySettings);
      updatedSettings[category] = value;

      // Save to Firestore
      final notificationManager =
          ref.read(notificationPermissionManagerProvider);
      await notificationManager.updateCategoryPreferences(
          userId, updatedSettings);

      setState(() {
        _categorySettings = updatedSettings;
        _isLoading = false;
      });
    } catch (e) {
      // Revert on error
      setState(() {
        _categorySettings[category] = !value;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update category setting: $e')));
      }
    }
  }

  Future<void> _removeDevice(String deviceId) async {
    setState(() => _isLoading = true);

    try {
      final notificationManager =
          ref.read(notificationPermissionManagerProvider);
      await notificationManager.removeDevice(deviceId);

      // Refresh the list after removal
      _loadSettings();
    } catch (e) {
      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to remove device: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: HomeAppBar(title: 'Notification Settings'),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Master switch
              CustomCard(
                child: SwitchListTile(
                  title: Text(
                    'Enable Notifications',
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Turn off to stop all notifications on this device',
                    style: theme.textTheme.bodySmall,
                  ),
                  value: _masterSwitch,
                  onChanged: _toggleMasterSwitch,
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _masterSwitch
                          ? colorScheme.primaryContainer
                          : colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: _masterSwitch
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Category settings
              if (_masterSwitch) ...[
                Text(
                  'Notification Categories',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                CustomCard(
                  child: Column(
                    children: NotificationCategory.values.map((category) {
                      final isEnabled = _categorySettings[category] ?? true;

                      return SwitchListTile(
                        title: Text(category.displayName),
                        subtitle: Text(
                          category.description,
                          style: theme.textTheme.bodySmall,
                        ),
                        secondary: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isEnabled
                                ? colorScheme.secondaryContainer
                                : colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            category.icon,
                            color: isEnabled
                                ? colorScheme.secondary
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                        value: isEnabled,
                        onChanged: (value) =>
                            _toggleCategorySetting(category, value),
                      );
                    }).toList(),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Registered devices
              Text(
                'Your Devices',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _buildDevicesList(colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDevicesList(ColorScheme colorScheme) {
    final userId = ref.watch(authControllerProvider.notifier).currentUser?.id;

    if (userId == null) {
      return const Center(child: Text('Please sign in to manage devices'));
    }

    final deviceTokensCollection =
        FirebaseFirestore.instance.collection('device_tokens');

    return StreamBuilder<QuerySnapshot>(
      stream: deviceTokensCollection
          .where(FirestoreFieldName.userId, isEqualTo: userId)
          .orderBy(FirestoreFieldName.lastActiveAt, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return CustomCard(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.devices,
                    size: 48,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No devices registered',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return CustomCard(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final device = snapshot.data!.docs[index];
              final deviceData = device.data() as Map<String, dynamic>;
              final deviceInfo =
                  deviceData['deviceInfo'] as Map<String, dynamic>? ?? {};

              // Determine if this is the current device (simplified check)
              // A more robust check would compare the actual device token
              final isCurrentDevice = index == 0;

              final lastActive = deviceData['lastActiveAt'] as Timestamp?;
              final formattedTime = lastActive != null
                  ? TimeagoFormatter.format(lastActive.toDate())
                  : 'Unknown';

              final platform = deviceInfo['platform'] ?? 'Unknown';
              final model = deviceInfo['model'] ?? 'Unknown device';
              final version = deviceInfo['osVersion'] ?? '';

              IconData platformIcon;
              if (platform.toString().toLowerCase().contains('android')) {
                platformIcon = Icons.android;
              } else if (platform.toString().toLowerCase().contains('ios')) {
                platformIcon = Icons.phone_iphone;
              } else {
                platformIcon = Icons.devices;
              }

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.surfaceVariant,
                  child: Icon(
                    platformIcon,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        model,
                        style: TextStyle(
                          fontWeight: isCurrentDevice
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    if (isCurrentDevice)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'This Device',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$platform $version'),
                    Text(
                      'Last active: $formattedTime',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _showRemoveDeviceDialog(device.id, model),
                  tooltip: 'Remove device',
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _showRemoveDeviceDialog(
      String deviceId, String deviceName) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Device?'),
        content: Text(
          'Are you sure you want to remove $deviceName from your registered devices? '
          'This device will no longer receive notifications.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Remove'),
          ),
        ],
      ),
    );

    if (result == true) {
      await _removeDevice(deviceId);
    }
  }
}
