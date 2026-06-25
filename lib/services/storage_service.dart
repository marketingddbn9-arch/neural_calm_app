import 'dart:convert';

class StorageService {
  // In-memory storage (for demo purposes)
  // Replace with shared_preferences in production
  final Map<String, dynamic> _storage = {};

  Future<void> init() async {
    // Initialize storage if needed
    await Future.delayed(const Duration(milliseconds: 100));
  }

  // User preferences
  Future<void> saveUserId(String userId) async {
    _storage['user_id'] = userId;
  }

  String? getUserId() {
    return _storage['user_id'] as String?;
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    _storage['user_data'] = jsonEncode(userData);
  }

  Map<String, dynamic>? getUserData() {
    final data = _storage['user_data'];
    if (data == null) return null;
    try {
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Theme preferences
  Future<void> setDarkMode(bool isDarkMode) async {
    _storage['dark_mode'] = isDarkMode;
  }

  bool isDarkMode() {
    return _storage['dark_mode'] as bool? ?? false;
  }

  // Notification settings
  Future<void> setNotificationsEnabled(bool enabled) async {
    _storage['notifications_enabled'] = enabled;
  }

  bool isNotificationsEnabled() {
    return _storage['notifications_enabled'] as bool? ?? true;
  }

  // Check-in reminder time
  Future<void> setCheckInReminderTime(String time) async {
    _storage['checkin_reminder_time'] = time;
  }

  String getCheckInReminderTime() {
    return _storage['checkin_reminder_time'] as String? ?? '09:00';
  }

  // Auth token
  Future<void> saveAuthToken(String token) async {
    _storage['auth_token'] = token;
  }

  String? getAuthToken() {
    return _storage['auth_token'] as String?;
  }

  Future<void> clearAuthToken() async {
    _storage.remove('auth_token');
  }

  // General key-value storage
  Future<void> saveData(String key, dynamic value) async {
    _storage[key] = value;
  }

  dynamic getData(String key) {
    return _storage[key];
  }

  Future<void> remove(String key) async {
    _storage.remove(key);
  }

  // Clear all data
  Future<void> clearAll() async {
    _storage.clear();
  }

  // Get all keys
  Set<String> getKeys() {
    return _storage.keys.toSet();
  }

  // Check if key exists
  bool containsKey(String key) {
    return _storage.containsKey(key);
  }

  // Get storage size
  int getStorageSize() {
    return _storage.length;
  }
}
