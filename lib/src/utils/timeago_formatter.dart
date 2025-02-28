import 'package:intl/intl.dart';

/// A utility class for formatting dates into relative time strings
class TimeagoFormatter {
  /// Format a date into a relative time string
  static String format(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      return DateFormat.MMMMd().format(date);
    } else {
      return DateFormat.yMMMMd().format(date);
    }
  }

  /// Format a date into a detailed time string with absolute date
  static String formatDetailed(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    final timeString = DateFormat.jm().format(date);

    if (difference.inDays == 0) {
      return 'Today at $timeString';
    } else if (difference.inDays == 1) {
      return 'Yesterday at $timeString';
    } else if (difference.inDays < 7) {
      final dayName = DateFormat.EEEE().format(date);
      return '$dayName at $timeString';
    } else {
      return '${DateFormat.yMMMd().format(date)} at $timeString';
    }
  }

  /// Format a date for last active/seen status
  static String formatLastActive(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 2) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat.MMMd().format(date);
    }
  }

  /// Format a date for chat message timestamp
  static String formatChatTimestamp(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return DateFormat.jm().format(date); // Today, just show time
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else if (now.difference(date).inDays < 7) {
      return DateFormat.E().format(date); // Day of week
    } else {
      return DateFormat.MMMd().format(date); // Month and day
    }
  }

  /// Get message status time display
  static String getMessageStatusDisplay(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  /// Format for event dates
  static String formatEventDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final eventDate = DateTime(date.year, date.month, date.day);

    if (eventDate == today) {
      return 'Today, ${DateFormat.jm().format(date)}';
    } else if (eventDate == tomorrow) {
      return 'Tomorrow, ${DateFormat.jm().format(date)}';
    } else {
      return DateFormat('EEEE, MMM d, yyyy • h:mm a').format(date);
    }
  }

  /// Format for event time remaining
  static String formatEventTimeRemaining(DateTime eventDate) {
    final now = DateTime.now();
    final difference = eventDate.difference(now);

    if (difference.isNegative) {
      // Event already happened
      return 'Event has passed';
    }

    if (difference.inMinutes < 60) {
      return 'Starting in ${difference.inMinutes} minutes';
    } else if (difference.inHours < 24) {
      return 'Starting in ${difference.inHours} hours';
    } else if (difference.inDays < 7) {
      return 'Starting in ${difference.inDays} days';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return 'In $weeks ${weeks == 1 ? 'week' : 'weeks'}';
    } else {
      return DateFormat.MMMd().format(eventDate);
    }
  }
}
