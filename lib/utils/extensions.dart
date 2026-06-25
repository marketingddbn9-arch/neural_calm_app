import 'package:flutter/material.dart';
import 'formatters.dart';

// String Extensions
extension StringExtension on String {
  /// Check if string is email
  bool get isEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Capitalize first letter
  String get capitalize => Formatters.capitalizeFirstLetter(this);

  /// Convert to title case
  String get toTitleCase => Formatters.toTitleCase(this);

  /// Convert to sentence case
  String get toSentenceCase => Formatters.toSentenceCase(this);

  /// Check if string is numeric
  bool get isNumeric => double.tryParse(this) != null;

  /// Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Check if string is blank
  bool get isBlank => trim().isEmpty;

  /// Check if string is not blank
  bool get isNotBlank => trim().isNotEmpty;

  /// Truncate string
  String truncate(int maxLength, {String ellipsis = '...'}) {
    return Formatters.truncateText(this, maxLength, ellipsis: ellipsis);
  }

  /// Convert to slug
  String get toSlug => Formatters.toSlug(this);

  /// Remove special characters
  String get removeSpecialCharacters =>
      Formatters.removeSpecialCharacters(this);

  /// Get first character
  String? get firstCharacter => isNotEmpty ? this[0] : null;

  /// Get last character
  String? get lastCharacter => isNotEmpty ? this[length - 1] : null;

  /// Reverse string
  String get reverse => split('').reversed.join();

  /// Check if palindrome
  bool get isPalindrome => this == reverse;
}

// DateTime Extensions
extension DateTimeExtension on DateTime {
  /// Format as date string
  String get formattedDate => Formatters.formatDate(this);

  /// Format as time string
  String get formattedTime => Formatters.formatTime(this);

  /// Format as relative time
  String get formattedRelativeTime => Formatters.formatRelativeTime(this);

  /// Check if today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get day of week name
  String get dayOfWeekName {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[weekday - 1];
  }

  /// Get month name
  String get monthName {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  /// Get start of day
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Get end of day
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  /// Get start of week
  DateTime get startOfWeek {
    return subtract(Duration(days: weekday - 1));
  }

  /// Get end of week
  DateTime get endOfWeek {
    return add(Duration(days: 7 - weekday)).endOfDay;
  }

  /// Get start of month
  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }

  /// Get end of month
  DateTime get endOfMonth {
    return DateTime(year, month + 1, 0, 23, 59, 59, 999);
  }

  /// Get start of year
  DateTime get startOfYear {
    return DateTime(year, 1, 1);
  }

  /// Get end of year
  DateTime get endOfYear {
    return DateTime(year, 12, 31, 23, 59, 59, 999);
  }
}

// Duration Extensions
extension DurationExtension on Duration {
  /// Format duration as readable string
  String get formatted => Formatters.formatDuration(this);

  /// Get hours
  int get hours => inHours;

  /// Get minutes (remainder after hours)
  int get minutes => inMinutes.remainder(60);

  /// Get seconds (remainder after minutes)
  int get seconds => inSeconds.remainder(60);
}

// int Extensions
extension IntExtension on int {
  /// Check if even
  bool get isEven => this % 2 == 0;

  /// Check if odd
  bool get isOdd => this % 2 != 0;

  /// Format as currency
  String toCurrency({String symbol = '\$'}) {
    return Formatters.formatCurrency(this, currencySymbol: symbol);
  }

  /// Format as percentage
  String toPercentage({int decimals = 0}) {
    return Formatters.formatPercentage(this, decimals: decimals);
  }

  /// Convert to duration in seconds
  Duration get seconds => Duration(seconds: this);

  /// Convert to duration in minutes
  Duration get minutes => Duration(minutes: this);

  /// Convert to duration in hours
  Duration get hours => Duration(hours: this);

  /// Convert to duration in days
  Duration get days => Duration(days: this);
}

// double Extensions
extension DoubleExtension on double {
  /// Format as currency
  String toCurrency({String symbol = '\$'}) {
    return Formatters.formatCurrency(this, currencySymbol: symbol);
  }

  /// Format as percentage
  String toPercentage({int decimals = 2}) {
    return Formatters.formatPercentage(this, decimals: decimals);
  }

  /// Round to decimal places
  double roundTo(int decimals) {
    final factor = 10.0 * decimals;
    return (this * factor).round() / factor;
  }

  /// Check if between two values
  bool isBetween(double min, double max) {
    return this >= min && this <= max;
  }

  /// Clamp between two values
  double clampBetween(double min, double max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }
}

// List Extensions
extension ListExtension<T> on List<T> {
  /// Get first or null
  T? get firstOrNull => isNotEmpty ? first : null;

  /// Get last or null
  T? get lastOrNull => isNotEmpty ? last : null;

  /// Get random element
  T? get random => isNotEmpty ? this[DateTime.now().microsecond % length] : null;

  /// Check if all elements match condition
  bool all(bool Function(T) test) => every(test);

  /// Check if any element matches condition
  bool any(bool Function(T) test) => this.any(test);
}

// BuildContext Extensions
extension BuildContextExtension on BuildContext {
  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get theme data
  ThemeData get theme => Theme.of(this);

  /// Get primary color
  Color get primaryColor => Theme.of(this).primaryColor;

  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Push named route
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  /// Push route
  void push(Route route) {
    Navigator.push(this, route);
  }

  /// Pop route
  void pop<T>([T? result]) {
    Navigator.pop(this, result);
  }

  /// Show snackbar
  void showSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Show dialog
  Future<T?> showCustomDialog<T>(
    Widget Function(BuildContext) builder, {
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: this,
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }

  /// Get keyboard height
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  /// Check if keyboard visible
  bool get isKeyboardVisible => keyboardHeight > 0;
}

// Widget Extensions
extension WidgetExtension on Widget {
  /// Add padding
  Widget withPadding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }

  /// Add center
  Widget withCenter() {
    return Center(child: this);
  }

  /// Add expanded
  Widget withExpanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }

  /// Add opacity
  Widget withOpacity(double opacity) {
    return Opacity(opacity: opacity, child: this);
  }

  /// Add container
  Widget withContainer({
    Color? color,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? width,
    double? height,
  }) {
    return Container(
      color: color,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: this,
    );
  }
}
