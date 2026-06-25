class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final DateTime createdAt;
  final int wellnessScore;
  final int streak;
  final bool isVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.createdAt,
    this.wellnessScore = 0,
    this.streak = 0,
    this.isVerified = false,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    DateTime? createdAt,
    int? wellnessScore,
    int? streak,
    bool? isVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      wellnessScore: wellnessScore ?? this.wellnessScore,
      streak: streak ?? this.streak,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'createdAt': createdAt.toIso8601String(),
      'wellnessScore': wellnessScore,
      'streak': streak,
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'],
      createdAt: DateTime.parse(
        map['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      wellnessScore: map['wellnessScore'] ?? 0,
      streak: map['streak'] ?? 0,
      isVerified: map['isVerified'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, wellnessScore: $wellnessScore, streak: $streak)';
  }
}
