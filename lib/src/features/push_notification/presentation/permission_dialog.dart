import 'package:flutter/material.dart';
import 'package:social_app_2/src/common_widgets/custom_filled_button.dart';
import 'package:social_app_2/src/common_widgets/custom_outlined_button.dart';
import 'package:social_app_2/src/features/push_notification/domain/notification_category.dart';

/// A dialog shown before requesting system notification permissions
/// to explain the benefits and allow the user to make an informed decision
class NotificationPermissionDialog extends StatelessWidget {
  const NotificationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      // Illustration
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.notifications_active,
                          size: 64,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Title
                      Text(
                        'Stay Connected with Your Community',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // Description
                      Text(
                        'Enable notifications to stay updated on community events, '
                        'news, and important updates.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      // Benefits
                      _buildBenefitsList(theme, colorScheme),
                      const SizedBox(height: 32),

                      // Categories
                      _buildCategoriesList(theme, colorScheme),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // Buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomFilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    backgroundColor: colorScheme.primary,
                    textColor: colorScheme.onPrimary,
                    text: 'Enable Notifications',
                    icon: Icons.notifications_active,
                  ),
                  const SizedBox(height: 12),
                  CustomOutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    text: 'Not Now',
                    borderColor: colorScheme.outline,
                    textColor: colorScheme.onSurface,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You can change this later in settings',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitsList(ThemeData theme, ColorScheme colorScheme) {
    final benefits = [
      {
        'icon': Icons.event_note,
        'title': 'Never Miss an Event',
        'description': 'Get timely alerts about community events.',
      },
      {
        'icon': Icons.article,
        'title': 'Important News',
        'description': 'Stay informed about community announcements.',
      },
      {
        'icon': Icons.photo_album,
        'title': 'New Photos & Albums',
        'description': 'See when new memories are shared.',
      },
      {
        'icon': Icons.chat_bubble_outline,
        'title': 'Direct Communication',
        'description': 'Know when someone messages you.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: benefits.map((benefit) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  benefit['icon'] as IconData,
                  size: 24,
                  color: colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      benefit['title'] as String,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      benefit['description'] as String,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoriesList(ThemeData theme, ColorScheme colorScheme) {
    // Show a subset of categories to avoid overwhelming
    final categories = [
      NotificationCategory.communityEvents,
      NotificationCategory.communityNews,
      NotificationCategory.photos,
      NotificationCategory.directMessages,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You\'ll be notified about:',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        ...categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  category.icon,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  category.displayName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'and more...',
            style: theme.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
