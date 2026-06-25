import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_theme.dart';
import '../services/storage_service.dart';

// Theme State
enum ThemeMode {
  light,
  dark,
  system,
}

class ThemeState {
  final ThemeMode themeMode;
  final bool isDarkMode;

  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.isDarkMode = false,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    bool? isDarkMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

// Theme Notifier
class ThemeNotifier extends StateNotifier<ThemeState> {
  final StorageService _storageService;

  ThemeNotifier(this._storageService) : super(const ThemeState()) {
    _initializeTheme();
  }

  Future<void> _initializeTheme() async {
    final isDarkMode = _storageService.getDarkMode() ?? false;
    state = state.copyWith(isDarkMode: isDarkMode);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);

    // For system theme, determine based on device
    if (mode == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.window.platformDispatcher.views.first.physicalSize;
      // In a real app, you'd use MediaQuery to get system brightness
      state = state.copyWith(isDarkMode: false);
    }

    await _storageService.setDarkMode(state.isDarkMode);
  }

  Future<void> toggleDarkMode() async {
    final newDarkMode = !state.isDarkMode;
    state = state.copyWith(isDarkMode: newDarkMode);
    await _storageService.setDarkMode(newDarkMode);
  }

  Future<void> setDarkMode(bool isDark) async {
    state = state.copyWith(isDarkMode: isDark);
    await _storageService.setDarkMode(isDark);
  }
}

// Providers
final storageServiceProvider = Provider((ref) => StorageService());

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return ThemeNotifier(storageService);
});

final isDarkModeProvider = Provider((ref) {
  return ref.watch(themeProvider).isDarkMode;
});

final themeModeProvider = Provider((ref) {
  return ref.watch(themeProvider).themeMode;
});

final appThemeProvider = Provider((ref) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return isDarkMode ? AppTheme.darkTheme() : AppTheme.lightTheme();
});

final lightThemeProvider = Provider((ref) {
  return AppTheme.lightTheme();
});

final darkThemeProvider = Provider((ref) {
  return AppTheme.darkTheme();
});
