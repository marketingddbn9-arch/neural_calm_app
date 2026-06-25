import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/analytics_model.dart';
import '../services/analytics_service.dart';

// Analytics State
class AnalyticsState {
  final bool isLoading;
  final AnalyticsModel? weeklyAnalytics;
  final double wellnessScore;
  final List<String> insights;
  final String? error;

  AnalyticsState({
    this.isLoading = false,
    this.weeklyAnalytics,
    this.wellnessScore = 0.0,
    this.insights = const [],
    this.error,
  });

  AnalyticsState copyWith({
    bool? isLoading,
    AnalyticsModel? weeklyAnalytics,
    double? wellnessScore,
    List<String>? insights,
    String? error,
  }) {
    return AnalyticsState(
      isLoading: isLoading ?? this.isLoading,
      weeklyAnalytics: weeklyAnalytics ?? this.weeklyAnalytics,
      wellnessScore: wellnessScore ?? this.wellnessScore,
      insights: insights ?? this.insights,
      error: error ?? this.error,
    );
  }
}

// Analytics Notifier
class AnalyticsNotifier extends StateNotifier<AnalyticsState> {
  final AnalyticsService _analyticsService;

  AnalyticsNotifier(this._analyticsService) : super(AnalyticsState());

  Future<void> fetchWeeklyAnalytics() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final analytics = await _analyticsService.getWeeklyAnalytics();
      final insights = await _analyticsService.getInsights();

      state = state.copyWith(
        isLoading: false,
        weeklyAnalytics: analytics,
        insights: insights,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> calculateWellnessScore() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final score = await _analyticsService.calculateWellnessScore();
      state = state.copyWith(
        isLoading: false,
        wellnessScore: score,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refreshAnalytics() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.wait([
        fetchWeeklyAnalytics(),
        calculateWellnessScore(),
      ]);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Providers
final analyticsServiceProvider = Provider((ref) => AnalyticsService());

final analyticsProvider =
    StateNotifierProvider<AnalyticsNotifier, AnalyticsState>((ref) {
  final analyticsService = ref.watch(analyticsServiceProvider);
  return AnalyticsNotifier(analyticsService);
});

final analyticsLoadingProvider = Provider((ref) {
  return ref.watch(analyticsProvider).isLoading;
});

final weeklyAnalyticsProvider = Provider((ref) {
  return ref.watch(analyticsProvider).weeklyAnalytics;
});

final wellnessScoreProvider = Provider((ref) {
  return ref.watch(analyticsProvider).wellnessScore;
});

final insightsProvider = Provider((ref) {
  return ref.watch(analyticsProvider).insights;
});

final analyticsErrorProvider = Provider((ref) {
  return ref.watch(analyticsProvider).error;
});

final moodTrendProvider = Provider((ref) {
  final analytics = ref.watch(weeklyAnalyticsProvider);
  return analytics?.moodTrend ?? [];
});

final stressTrendProvider = Provider((ref) {
  final analytics = ref.watch(weeklyAnalyticsProvider);
  return analytics?.stressTrend ?? [];
});

final energyTrendProvider = Provider((ref) {
  final analytics = ref.watch(weeklyAnalyticsProvider);
  return analytics?.energyTrend ?? [];
});

final sleepTrendProvider = Provider((ref) {
  final analytics = ref.watch(weeklyAnalyticsProvider);
  return analytics?.sleepTrend ?? [];
});

final topInsightProvider = Provider((ref) {
  final analytics = ref.watch(weeklyAnalyticsProvider);
  return analytics?.topInsight ?? '';
});

final bestDayProvider = Provider((ref) {
  final analytics = ref.watch(weeklyAnalyticsProvider);
  return analytics?.bestDay ?? '';
});
