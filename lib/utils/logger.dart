import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal,
}

class Logger {
  static final Logger _instance = Logger._internal();

  factory Logger() {
    return _instance;
  }

  Logger._internal();

  static const String _prefix = '🧠 NC';
  static const int _maxLogLength = 5000;

  // Log level colors for console
  static const Map<LogLevel, String> _logLevelColors = {
    LogLevel.debug: '🔵',
    LogLevel.info: '🟢',
    LogLevel.warning: '🟡',
    LogLevel.error: '🔴',
    LogLevel.fatal: '⚫',
  };

  static const Map<LogLevel, String> _logLevelNames = {
    LogLevel.debug: 'DEBUG',
    LogLevel.info: 'INFO',
    LogLevel.warning: 'WARNING',
    LogLevel.error: 'ERROR',
    LogLevel.fatal: 'FATAL',
  };

  /// Log debug message
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.debug, message, error, stackTrace);
  }

  /// Log info message
  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.info, message, error, stackTrace);
  }

  /// Log warning message
  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.warning, message, error, stackTrace);
  }

  /// Log error message
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error, stackTrace);
  }

  /// Log fatal message
  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.fatal, message, error, stackTrace);
  }

  /// Main logging function
  static void _log(
    LogLevel level,
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (kReleaseMode) {
      // In release mode, log only warnings and errors
      if (level == LogLevel.debug || level == LogLevel.info) {
        return;
      }
    }

    final emoji = _logLevelColors[level] ?? '⚪';
    final levelName = _logLevelNames[level] ?? 'UNKNOWN';
    final timestamp = DateTime.now().toString();

    // Truncate message if too long
    final displayMessage =
        message.length > _maxLogLength
            ? '${message.substring(0, _maxLogLength)}...'
            : message;

    final logMessage = '''
$emoji [$levelName] $_prefix [$timestamp]
📝 $displayMessage''';

    debugPrint(logMessage);

    if (error != null) {
      debugPrint('❌ Error: $error');
    }

    if (stackTrace != null) {
      debugPrint('📍 Stack Trace:\n$stackTrace');
    }
  }

  /// Log API request
  static void logApiRequest(
    String method,
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    final message = '''
🌐 API REQUEST
  Method: $method
  URL: $url
  ${headers != null ? 'Headers: $headers' : ''}
  ${body != null ? 'Body: $body' : ''}''';

    info(message);
  }

  /// Log API response
  static void logApiResponse(
    String method,
    String url, {
    required int statusCode,
    dynamic responseBody,
    Duration? duration,
  }) {
    final message = '''
✅ API RESPONSE
  Method: $method
  URL: $url
  Status: $statusCode
  ${duration != null ? 'Duration: ${duration.inMilliseconds}ms' : ''}
  ${responseBody != null ? 'Body: $responseBody' : ''}''';

    info(message);
  }

  /// Log API error
  static void logApiError(
    String method,
    String url, {
    required int statusCode,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final message = '''
❌ API ERROR
  Method: $method
  URL: $url
  Status: $statusCode''';

    _log(LogLevel.error, message, error, stackTrace);
  }

  /// Log user action
  static void logUserAction(String action, [Map<String, dynamic>? params]) {
    final message = '''
👤 USER ACTION: $action
  ${params != null ? 'Params: $params' : ''}''';

    info(message);
  }

  /// Log screen navigation
  static void logNavigation(String screenName, [Map<String, dynamic>? args]) {
    final message = '''
📱 NAVIGATION
  Screen: $screenName
  ${args != null ? 'Args: $args' : ''}''';

    debug(message);
  }

  /// Log performance metric
  static void logPerformance(String operation, Duration duration) {
    final message = '''
⚡ PERFORMANCE
  Operation: $operation
  Duration: ${duration.inMilliseconds}ms''';

    info(message);
  }

  /// Log state change
  static void logStateChange(String stateName, dynamic oldValue, dynamic newValue) {
    final message = '''
🔄 STATE CHANGE
  State: $stateName
  Old: $oldValue
  New: $newValue''';

    debug(message);
  }

  /// Log database operation
  static void logDatabase(String operation, [String? details]) {
    final message = '''
💾 DATABASE
  Operation: $operation
  ${details != null ? 'Details: $details' : ''}''';

    debug(message);
  }

  /// Log authentication event
  static void logAuthEvent(String event, [Map<String, dynamic>? params]) {
    final message = '''
🔐 AUTH EVENT: $event
  ${params != null ? 'Params: $params' : ''}''';

    info(message);
  }

  /// Clear logs (placeholder for future implementation)
  static void clearLogs() {
    debug('Logs cleared');
  }

  /// Export logs (placeholder for future implementation)
  static String exportLogs() {
    return 'Log export not yet implemented';
  }
}
