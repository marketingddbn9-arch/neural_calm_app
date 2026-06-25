import 'package:intl/intl.dart';

class Formatters {
  // Date formatting
  static String formatDate(DateTime date, {String format = 'MMM dd, yyyy'}) {
    return DateFormat(format).format(date);
  }

  // Time formatting
  static String formatTime(DateTime time, {String format = 'hh:mm a'}) {
    return DateFormat(format).format(time);
  }

  // DateTime formatting
  static String formatDateTime(
    DateTime dateTime, {
    String format = 'MMM dd, yyyy hh:mm a',
  }) {
    return DateFormat(format).format(dateTime);
  }

  // Relative time (e.g., "2 hours ago")
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

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
    } else {
      return formatDate(dateTime);
    }
  }

  // Number formatting
  static String formatNumber(num value, {int decimals = 0}) {
    final formatter = NumberFormat('#,##0.${'0' * decimals}');
    return formatter.format(value);
  }

  // Currency formatting
  static String formatCurrency(num amount, {String currencySymbol = '\$'}) {
    return '$currencySymbol${formatNumber(amount, decimals: 2)}';
  }

  // Percentage formatting
  static String formatPercentage(num value, {int decimals = 0}) {
    return '${formatNumber(value, decimals: decimals)}%';
  }

  // Email formatting (lowercase and trim)
  static String formatEmail(String email) {
    return email.toLowerCase().trim();
  }

  // Phone number formatting
  static String formatPhoneNumber(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (cleaned.length == 10) {
      return '(${cleaned.substring(0, 3)}) ${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
    } else if (cleaned.length == 11 && cleaned.startsWith('1')) {
      return '+1 (${cleaned.substring(1, 4)}) ${cleaned.substring(4, 7)}-${cleaned.substring(7)}';
    }

    return phone;
  }

  // Text capitalization
  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // Title case
  static String toTitleCase(String text) {
    return text
        .split(' ')
        .map((word) => capitalizeFirstLetter(word.toLowerCase()))
        .join(' ');
  }

  // Sentence case
  static String toSentenceCase(String text) {
    if (text.isEmpty) return text;
    return capitalizeFirstLetter(text.toLowerCase());
  }

  // Capitalize all words
  static String capitalizeAllWords(String text) {
    return text
        .split(' ')
        .map((word) => capitalizeFirstLetter(word.toLowerCase()))
        .join(' ');
  }

  // Duration formatting
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // File size formatting
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }

  // Mood to emoji
  static String moodToEmoji(int mood) {
    switch (mood) {
      case 1:
        return '😢';
      case 2:
        return '😕';
      case 3:
        return '😐';
      case 4:
        return '🙂';
      case 5:
        return '😄';
      default:
        return '😐';
    }
  }

  // Mood to text
  static String moodToText(int mood) {
    switch (mood) {
      case 1:
        return 'Terrible';
      case 2:
        return 'Bad';
      case 3:
        return 'Okay';
      case 4:
        return 'Good';
      case 5:
        return 'Great';
      default:
        return 'Unknown';
    }
  }

  // Double to score string
  static String formatScore(double score) {
    return score.toStringAsFixed(0);
  }

  // Leading zeros
  static String padZero(int number, {int length = 2}) {
    return number.toString().padLeft(length, '0');
  }

  // Abbreviate number (e.g., 1500 -> 1.5K)
  static String abbreviateNumber(num value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(0);
  }

  // Remove special characters
  static String removeSpecialCharacters(String text) {
    return text.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }

  // Truncate text
  static String truncateText(String text, int maxLength, {String ellipsis = '...'}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  // URL slug
  static String toSlug(String text) {
    return text
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'[\s_]+'), '-')
        .replaceAll(RegExp(r'-+'), '-');
  }
}
