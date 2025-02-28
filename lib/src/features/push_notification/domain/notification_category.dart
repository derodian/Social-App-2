import 'package:flutter/material.dart';

/// Notification categories available in the app
enum NotificationCategory {
  communityNews,
  communityEvents,
  photos,
  albums,
  localBands,
  socialGatherings,
  directMessages,
  comments,
  likes;

  /// Get Firebase topic name for this category
  String get topicName => name.toLowerCase();

  /// Get user-friendly display name
  String get displayName {
    switch (this) {
      case NotificationCategory.communityNews:
        return 'Community News';
      case NotificationCategory.communityEvents:
        return 'Upcoming Events';
      case NotificationCategory.photos:
        return 'New Photos';
      case NotificationCategory.albums:
        return 'New Album';
      case NotificationCategory.localBands:
        return 'Local Band Updates';
      case NotificationCategory.socialGatherings:
        return 'Social Gatherings';
      case NotificationCategory.directMessages:
        return 'Direct Message';
      case NotificationCategory.comments:
        return 'Comments on Your Posts';
      case NotificationCategory.likes:
        return 'Likes on You Content';
    }
  }

  /// Get description of what this notification type is for
  String get description {
    switch (this) {
      case NotificationCategory.communityNews:
        return 'Important news and announcements from your community';
      case NotificationCategory.communityEvents:
        return 'Notifications about upcoming events in your community';
      case NotificationCategory.photos:
        return 'When new photos are shared in the community';
      case NotificationCategory.albums:
        return 'When new photo albums are created for events';
      case NotificationCategory.localBands:
        return 'Updates about local bands and music events';
      case NotificationCategory.socialGatherings:
        return 'Invitations and updates about community gatherings';
      case NotificationCategory.directMessages:
        return 'When someone sends you a direct message';
      case NotificationCategory.comments:
        return 'When someone comments on your posts or photos';
      case NotificationCategory.likes:
        return 'When someone likes your posts or photos';
    }
  }

  /// Get icon for this notification category
  IconData get icon {
    switch (this) {
      case NotificationCategory.communityNews:
        return Icons.article;
      case NotificationCategory.communityEvents:
        return Icons.event;
      case NotificationCategory.photos:
        return Icons.photo;
      case NotificationCategory.albums:
        return Icons.photo_album;
      case NotificationCategory.localBands:
        return Icons.music_note;
      case NotificationCategory.socialGatherings:
        return Icons.people;
      case NotificationCategory.directMessages:
        return Icons.message;
      case NotificationCategory.comments:
        return Icons.comment;
      case NotificationCategory.likes:
        return Icons.favorite;
    }
  }
}
