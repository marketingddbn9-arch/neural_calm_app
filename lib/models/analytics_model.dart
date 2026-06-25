class AnalyticsModel {
  final DateTime weekStart;
  final List<double> moodTrend;        // 7 days (Mon-Sun)
  final List<double> stressTrend;      // 7 days (Mon-Sun)
  final List<double> energyTrend;      // 7 days (Mon-Sun)
  final List<double> sleepTrend;       // 7 days (Mon-Sun)
  final String topInsight;
  final double weekProgress;
  final String bestDay;
  final double averageMood;
  final double stressReduction;

  AnalyticsModel({
    required this.weekStart,
    required this.moodTrend,
    required this.stressTrend,
    required this.energyTrend,
    required this.sleepTrend,
    required this.topInsight,
    required this.weekProgress,
    required this.bestDay,
    required this.averageMood,
    this.stressReduction = 0,
  });

  AnalyticsModel copyWith({
    DateTime? weekStart,
    List<double>? moodTrend,
    List<double>? stressTrend,
    List<double>? energyTrend,
    List<double>? sleepTrend,
    String? topInsight,
    double? weekProgress,
    String? bestDay,
    double? averageMood,
    double? stressReduction,
  }) {
    return AnalyticsModel(
      weekStart: weekStart ?? this.weekStart,
      moodTrend: moodTrend ?? this.moodTrend,
      stressTrend: stressTrend ?? this.stressTrend,
      energyTrend: energyTrend ?? this.energyTrend,
      sleepTrend: sleepTrend ?? this.sleepTrend,
      topInsight: topInsight ?? this.topInsight,
      weekProgress: weekProgress ?? this.weekProgress,
      bestDay: bestDay ?? this.bestDay,
      averageMood: averageMood ?? this.averageMood,
      stressReduction: stressReduction ?? this.stressReduction,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weekStart': weekStart.toIso8601String(),
      'moodTrend': moodTrend,
      'stressTrend': stressTrend,
      'energyTrend': energyTrend,
      'sleepTrend': sleepTrend,
      'topInsight': topInsight,
      'weekProgress': weekProgress,
      'bestDay': bestDay,
      'averageMood': averageMood,
      'stressReduction': stressReduction,
    };
  }

  factory AnalyticsModel.fromMap(Map<String, dynamic> map) {
    return AnalyticsModel(
      weekStart: DateTime.parse(map['weekStart'] ?? DateTime.now().toIso8601String()),
      moodTrend: List<double>.from(map['moodTrend'] ?? []),
      stressTrend: List<double>.from(map['stressTrend'] ?? []),
      energyTrend: List<double>.from(map['energyTrend'] ?? []),
      sleepTrend: List<double>.from(map['sleepTrend'] ?? []),
      topInsight: map['topInsight'] ?? '',
      weekProgress: (map['weekProgress'] ?? 0).toDouble(),
      bestDay: map['bestDay'] ?? '',
      averageMood: (map['averageMood'] ?? 0).toDouble(),
      stressReduction: (map['stressReduction'] ?? 0).toDouble(),
    );
  }

  @override
  String toString() {
    return 'AnalyticsModel(weekProgress: $weekProgress, averageMood: $averageMood, bestDay: $bestDay)';
  }
}
