import '../models/analytics_model.dart';
import '../models/checkin_model.dart';

class AnalyticsService {
  Future<AnalyticsModel> getWeeklyAnalytics(
    List<CheckInModel> weekCheckIns,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      if (weekCheckIns.isEmpty) {
        return AnalyticsModel(
          weekStart: DateTime.now().subtract(const Duration(days: 7)),
          moodTrend: List.filled(7, 0),
          stressTrend: List.filled(7, 0),
          energyTrend: List.filled(7, 0),
          sleepTrend: List.filled(7, 0),
          topInsight: 'Start your daily check-ins to see insights',
          weekProgress: 0,
          bestDay: 'N/A',
          averageMood: 0,
        );
      }

      // Sort check-ins by date
      final sorted = List<CheckInModel>.from(weekCheckIns);
      sorted.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      // Calculate trends for each day
      final moodTrend = <double>[];
      final stressTrend = <double>[];
      final energyTrend = <double>[];
      final sleepTrend = <double>[];

      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));

      for (int i = 0; i < 7; i++) {
        final dayStart = weekStart.add(Duration(days: i));
        final dayEnd = dayStart.add(const Duration(days: 1));

        final dayCheckIns = sorted.where((c) =>
            c.timestamp.isAfter(dayStart) && c.timestamp.isBefore(dayEnd));

        if (dayCheckIns.isNotEmpty) {
          final avgMood = dayCheckIns.map((c) => c.mood).reduce((a, b) => a + b) /
              dayCheckIns.length;
          final avgStress = dayCheckIns
                  .map((c) => c.stressLevel)
                  .reduce((a, b) => a + b) /
              dayCheckIns.length;
          final avgEnergy = dayCheckIns
                  .map((c) => c.energyLevel)
                  .reduce((a, b) => a + b) /
              dayCheckIns.length;
          final avgSleep = dayCheckIns
                  .map((c) => c.sleepQuality)
                  .reduce((a, b) => a + b) /
              dayCheckIns.length;

          moodTrend.add(avgMood / 5 * 100);
          stressTrend.add(100 - (avgStress / 10 * 100));
          energyTrend.add(avgEnergy / 10 * 100);
          sleepTrend.add(avgSleep / 10 * 100);
        } else {
          moodTrend.add(0);
          stressTrend.add(0);
          energyTrend.add(0);
          sleepTrend.add(0);
        }
      }

      // Calculate metrics
      final validMood = moodTrend.where((m) => m > 0).toList();
      final averageMood =
          validMood.isEmpty ? 0 : validMood.reduce((a, b) => a + b) / validMood.length;
      final weekProgress =
          (moodTrend.reduce((a, b) => a + b) / 700 * 100).clamp(0, 100);
      final bestDayIndex = moodTrend.indexOf(moodTrend.reduce((a, b) => a > b ? a : b));
      final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      final bestDay = bestDayIndex >= 0 ? days[bestDayIndex] : 'N/A';

      return AnalyticsModel(
        weekStart: weekStart,
        moodTrend: moodTrend,
        stressTrend: stressTrend,
        energyTrend: energyTrend,
        sleepTrend: sleepTrend,
        topInsight: 'Great progress! Keep up your daily check-ins.',
        weekProgress: weekProgress,
        bestDay: bestDay,
        averageMood: averageMood,
        stressReduction: stressTrend.isNotEmpty ? stressTrend.reduce((a, b) => a + b) / stressTrend.length : 0,
      );
    } catch (e) {
      throw Exception('Failed to calculate analytics: ${e.toString()}');
    }
  }

  double calculateWellnessScore(List<CheckInModel> checkIns) {
    if (checkIns.isEmpty) return 0;

    double score = 0;
    score += (checkIns.map((c) => c.mood).reduce((a, b) => a + b) / checkIns.length / 5 * 25);
    score += (100 - (checkIns.map((c) => c.stressLevel).reduce((a, b) => a + b) / checkIns.length / 10 * 100)) * 0.25;
    score += (checkIns.map((c) => c.energyLevel).reduce((a, b) => a + b) / checkIns.length / 10 * 25);
    score += (checkIns.map((c) => c.sleepQuality).reduce((a, b) => a + b) / checkIns.length / 10 * 25);

    return score.clamp(0, 100);
  }

  Future<Map<String, dynamic>> getInsights(List<CheckInModel> checkIns) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (checkIns.isEmpty) {
        return {
          'title': 'Start Tracking',
          'message': 'Begin your daily check-ins to receive personalized insights',
          'icon': '📊',
        };
      }

      // Calculate average mood
      final avgMood = checkIns.map((c) => c.mood).reduce((a, b) => a + b) / checkIns.length;

      if (avgMood >= 4) {
        return {
          'title': 'Great Mood!',
          'message': 'You\'re having a great week. Keep it up!',
          'icon': '😊',
        };
      } else if (avgMood >= 3) {
        return {
          'title': 'Stable Mood',
          'message': 'Your mood is stable this week. Consider a self-care activity.',
          'icon': '😌',
        };
      } else {
        return {
          'title': 'Challenging Week',
          'message': 'Try to focus on wellness activities this week.',
          'icon': '💪',
        };
      }
    } catch (e) {
      return {
        'title': 'Unable to fetch insights',
        'message': 'Please try again later',
        'icon': '❓',
      };
    }
  }
}
