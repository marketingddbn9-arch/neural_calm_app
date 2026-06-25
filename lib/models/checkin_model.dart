class CheckInModel {
  final String id;
  final String userId;
  final DateTime timestamp;
  final int mood;              // 1-5
  final int stressLevel;       // 0-10
  final int energyLevel;       // 0-10
  final int sleepQuality;      // 0-10
  final List<String> factors;  // Contributing factors
  final String? positiveNotes;
  final String? additionalNotes;

  CheckInModel({
    required this.id,
    required this.userId,
    required this.timestamp,
    required this.mood,
    required this.stressLevel,
    required this.energyLevel,
    required this.sleepQuality,
    this.factors = const [],
    this.positiveNotes,
    this.additionalNotes,
  });

  CheckInModel copyWith({
    String? id,
    String? userId,
    DateTime? timestamp,
    int? mood,
    int? stressLevel,
    int? energyLevel,
    int? sleepQuality,
    List<String>? factors,
    String? positiveNotes,
    String? additionalNotes,
  }) {
    return CheckInModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
      mood: mood ?? this.mood,
      stressLevel: stressLevel ?? this.stressLevel,
      energyLevel: energyLevel ?? this.energyLevel,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      factors: factors ?? this.factors,
      positiveNotes: positiveNotes ?? this.positiveNotes,
      additionalNotes: additionalNotes ?? this.additionalNotes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'timestamp': timestamp.toIso8601String(),
      'mood': mood,
      'stressLevel': stressLevel,
      'energyLevel': energyLevel,
      'sleepQuality': sleepQuality,
      'factors': factors,
      'positiveNotes': positiveNotes,
      'additionalNotes': additionalNotes,
    };
  }

  factory CheckInModel.fromMap(Map<String, dynamic> map) {
    return CheckInModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      timestamp: DateTime.parse(
        map['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
      mood: map['mood'] ?? 3,
      stressLevel: map['stressLevel'] ?? 5,
      energyLevel: map['energyLevel'] ?? 5,
      sleepQuality: map['sleepQuality'] ?? 7,
      factors: List<String>.from(map['factors'] ?? []),
      positiveNotes: map['positiveNotes'],
      additionalNotes: map['additionalNotes'],
    );
  }

  @override
  String toString() {
    return 'CheckInModel(id: $id, mood: $mood, stressLevel: $stressLevel, energyLevel: $energyLevel)';
  }
}
