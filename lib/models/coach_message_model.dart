class CoachMessageModel {
  final String id;
  final String coachId;
  final String coachName;
  final String userId;
  final String message;
  final DateTime timestamp;
  final bool isFromCoach;
  final bool isRead;
  final String? messageType; // 'text', 'insight', 'tip'

  CoachMessageModel({
    required this.id,
    required this.coachId,
    required this.coachName,
    required this.userId,
    required this.message,
    required this.timestamp,
    required this.isFromCoach,
    this.isRead = false,
    this.messageType = 'text',
  });

  CoachMessageModel copyWith({
    String? id,
    String? coachId,
    String? coachName,
    String? userId,
    String? message,
    DateTime? timestamp,
    bool? isFromCoach,
    bool? isRead,
    String? messageType,
  }) {
    return CoachMessageModel(
      id: id ?? this.id,
      coachId: coachId ?? this.coachId,
      coachName: coachName ?? this.coachName,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isFromCoach: isFromCoach ?? this.isFromCoach,
      isRead: isRead ?? this.isRead,
      messageType: messageType ?? this.messageType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'coachId': coachId,
      'coachName': coachName,
      'userId': userId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isFromCoach': isFromCoach,
      'isRead': isRead,
      'messageType': messageType,
    };
  }

  factory CoachMessageModel.fromMap(Map<String, dynamic> map) {
    return CoachMessageModel(
      id: map['id'] ?? '',
      coachId: map['coachId'] ?? '',
      coachName: map['coachName'] ?? 'Coach',
      userId: map['userId'] ?? '',
      message: map['message'] ?? '',
      timestamp: DateTime.parse(
        map['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
      isFromCoach: map['isFromCoach'] ?? true,
      isRead: map['isRead'] ?? false,
      messageType: map['messageType'] ?? 'text',
    );
  }

  @override
  String toString() {
    return 'CoachMessageModel(id: $id, coachName: $coachName, isFromCoach: $isFromCoach)';
  }
}
