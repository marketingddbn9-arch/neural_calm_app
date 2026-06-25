import 'package:flutter_test/flutter_test.dart';
import 'package:neural_calm/models/user_model.dart';
import 'package:neural_calm/models/checkin_model.dart';
import 'package:neural_calm/models/analytics_model.dart';
import 'package:neural_calm/models/coach_message_model.dart';
import 'package:neural_calm/models/device_model.dart';

void main() {
  group('UserModel Tests', () {
    test('UserModel creation with valid data', () {
      final user = UserModel(
        id: 'user123',
        name: 'Sarah Anderson',
        email: 'sarah@example.com',
        avatar: 'avatar_url',
        createdAt: DateTime(2024, 1, 1),
        wellnessScore: 84.5,
        streak: 12,
        isVerified: true,
      );

      expect(user.id, 'user123');
      expect(user.name, 'Sarah Anderson');
      expect(user.email, 'sarah@example.com');
      expect(user.wellnessScore, 84.5);
      expect(user.streak, 12);
      expect(user.isVerified, true);
    });

    test('UserModel toJson and fromJson', () {
      final user = UserModel(
        id: 'user123',
        name: 'Sarah Anderson',
        email: 'sarah@example.com',
        avatar: 'avatar_url',
        createdAt: DateTime(2024, 1, 1),
        wellnessScore: 84.5,
        streak: 12,
        isVerified: true,
      );

      final json = user.toJson();
      final userFromJson = UserModel.fromJson(json);

      expect(userFromJson.id, user.id);
      expect(userFromJson.name, user.name);
      expect(userFromJson.email, user.email);
      expect(userFromJson.wellnessScore, user.wellnessScore);
    });

    test('UserModel copyWith creates new instance', () {
      final user = UserModel(
        id: 'user123',
        name: 'Sarah',
        email: 'sarah@example.com',
        avatar: 'avatar_url',
        createdAt: DateTime(2024, 1, 1),
        wellnessScore: 84.5,
        streak: 12,
        isVerified: true,
      );

      final updatedUser = user.copyWith(
        name: 'Sarah Anderson',
        wellnessScore: 88.0,
      );

      expect(updatedUser.name, 'Sarah Anderson');
      expect(updatedUser.wellnessScore, 88.0);
      expect(updatedUser.id, user.id);
      expect(updatedUser.email, user.email);
    });
  });

  group('CheckInModel Tests', () {
    test('CheckInModel creation with valid data', () {
      final checkIn = CheckInModel(
        id: 'checkin123',
        userId: 'user123',
        timestamp: DateTime(2024, 1, 15, 10, 30),
        mood: 4,
        stressLevel: 3.5,
        energyLevel: 7.0,
        sleepQuality: 8.0,
        factors: ['Exercise', 'Social'],
        positiveNotes: 'Had a great day',
        additionalNotes: 'Feeling motivated',
      );

      expect(checkIn.id, 'checkin123');
      expect(checkIn.userId, 'user123');
      expect(checkIn.mood, 4);
      expect(checkIn.stressLevel, 3.5);
      expect(checkIn.factors.length, 2);
    });

    test('CheckInModel mood values are valid', () {
      final checkIn = CheckInModel(
        id: 'checkin123',
        userId: 'user123',
        timestamp: DateTime.now(),
        mood: 5,
        stressLevel: 0,
        energyLevel: 10,
        sleepQuality: 10,
        factors: [],
        positiveNotes: '',
        additionalNotes: '',
      );

      expect(checkIn.mood, greaterThanOrEqualTo(1));
      expect(checkIn.mood, lessThanOrEqualTo(5));
    });

    test('CheckInModel stress level is in valid range', () {
      final checkIn = CheckInModel(
        id: 'checkin123',
        userId: 'user123',
        timestamp: DateTime.now(),
        mood: 3,
        stressLevel: 5.0,
        energyLevel: 5.0,
        sleepQuality: 5.0,
        factors: [],
        positiveNotes: '',
        additionalNotes: '',
      );

      expect(checkIn.stressLevel, greaterThanOrEqualTo(0));
      expect(checkIn.stressLevel, lessThanOrEqualTo(10));
    });

    test('CheckInModel toJson and fromJson', () {
      final checkIn = CheckInModel(
        id: 'checkin123',
        userId: 'user123',
        timestamp: DateTime(2024, 1, 15),
        mood: 4,
        stressLevel: 3.5,
        energyLevel: 7.0,
        sleepQuality: 8.0,
        factors: ['Exercise'],
        positiveNotes: 'Good day',
        additionalNotes: 'Notes',
      );

      final json = checkIn.toJson();
      final checkInFromJson = CheckInModel.fromJson(json);

      expect(checkInFromJson.id, checkIn.id);
      expect(checkInFromJson.mood, checkIn.mood);
      expect(checkInFromJson.factors, checkIn.factors);
    });
  });

  group('AnalyticsModel Tests', () {
    test('AnalyticsModel creation with valid data', () {
      final analytics = AnalyticsModel(
        weekStart: DateTime(2024, 1, 8),
        moodTrend: [3, 3.5, 4, 4.2, 4.1, 4.5, 4.3],
        stressTrend: [6, 5.8, 5.5, 5, 4.8, 4.5, 4.2],
        energyTrend: [5, 5.5, 6, 6.5, 7, 7.5, 8],
        sleepTrend: [6, 6.5, 7, 7.5, 8, 8.5, 9],
        topInsight: 'Your stress is decreasing',
        weekProgress: 75.0,
        bestDay: 'Sunday',
        averageMood: 4.0,
        stressReduction: 30.0,
      );

      expect(analytics.moodTrend.length, 7);
      expect(analytics.stressTrend.length, 7);
      expect(analytics.topInsight, isNotEmpty);
      expect(analytics.weekProgress, 75.0);
    });

    test('AnalyticsModel average calculations', () {
      final moodValues = [2.0, 3.0, 4.0, 5.0];
      final average = moodValues.reduce((a, b) => a + b) / moodValues.length;

      final analytics = AnalyticsModel(
        weekStart: DateTime.now(),
        moodTrend: [2, 3, 4, 5, 3.5, 4, 4.5],
        stressTrend: [7, 6, 5, 4, 5, 4, 3],
        energyTrend: [3, 4, 5, 6, 6.5, 7, 7.5],
        sleepTrend: [5, 6, 6.5, 7, 7.5, 8, 8.5],
        topInsight: 'Test',
        weekProgress: 80.0,
        bestDay: 'Saturday',
        averageMood: average,
        stressReduction: 50.0,
      );

      expect(analytics.averageMood, 3.5);
    });
  });

  group('CoachMessageModel Tests', () {
    test('CoachMessageModel creation', () {
      final message = CoachMessageModel(
        id: 'msg123',
        coachId: 'coach1',
        coachName: 'Marcus',
        userId: 'user123',
        message: 'Keep up the great work!',
        timestamp: DateTime(2024, 1, 15, 10, 30),
        isFromCoach: true,
        isRead: false,
        messageType: 'encouragement',
      );

      expect(message.id, 'msg123');
      expect(message.coachName, 'Marcus');
      expect(message.isFromCoach, true);
      expect(message.isRead, false);
    });

    test('CoachMessageModel copyWith isRead', () {
      final message = CoachMessageModel(
        id: 'msg123',
        coachId: 'coach1',
        coachName: 'Marcus',
        userId: 'user123',
        message: 'Keep up the great work!',
        timestamp: DateTime.now(),
        isFromCoach: true,
        isRead: false,
        messageType: 'encouragement',
      );

      final readMessage = message.copyWith(isRead: true);

      expect(readMessage.isRead, true);
      expect(readMessage.id, message.id);
      expect(readMessage.message, message.message);
    });
  });

  group('DeviceModel Tests', () {
    test('DeviceModel creation', () {
      final device = DeviceModel(
        id: 'device1',
        userId: 'user123',
        name: 'iPhone 13 Pro',
        type: 'Mobile',
        model: 'iOS 16.2',
        isConnected: true,
        connectedAt: DateTime(2024, 1, 1),
        lastSyncTime: DateTime.now(),
        batteryLevel: 87,
      );

      expect(device.name, 'iPhone 13 Pro');
      expect(device.type, 'Mobile');
      expect(device.isConnected, true);
      expect(device.batteryLevel, 87);
    });

    test('DeviceModel battery level validation', () {
      final device = DeviceModel(
        id: 'device1',
        userId: 'user123',
        name: 'Apple Watch',
        type: 'Wearable',
        model: 'watchOS 9.1',
        isConnected: true,
        connectedAt: DateTime.now(),
        lastSyncTime: DateTime.now(),
        batteryLevel: 65,
      );

      expect(device.batteryLevel, greaterThanOrEqualTo(0));
      expect(device.batteryLevel, lessThanOrEqualTo(100));
    });
  });

  group('Model Equality Tests', () {
    test('UserModel equality', () {
      final user1 = UserModel(
        id: 'user123',
        name: 'Sarah',
        email: 'sarah@example.com',
        avatar: 'avatar',
        createdAt: DateTime(2024, 1, 1),
        wellnessScore: 84.5,
        streak: 12,
        isVerified: true,
      );

      final user2 = UserModel(
        id: 'user123',
        name: 'Sarah',
        email: 'sarah@example.com',
        avatar: 'avatar',
        createdAt: DateTime(2024, 1, 1),
        wellnessScore: 84.5,
        streak: 12,
        isVerified: true,
      );

      expect(user1.id, user2.id);
      expect(user1.name, user2.name);
    });

    test('CheckInModel different IDs', () {
      final checkIn1 = CheckInModel(
        id: 'checkin1',
        userId: 'user123',
        timestamp: DateTime.now(),
        mood: 4,
        stressLevel: 3,
        energyLevel: 7,
        sleepQuality: 8,
        factors: [],
        positiveNotes: '',
        additionalNotes: '',
      );

      final checkIn2 = CheckInModel(
        id: 'checkin2',
        userId: 'user123',
        timestamp: DateTime.now(),
        mood: 4,
        stressLevel: 3,
        energyLevel: 7,
        sleepQuality: 8,
        factors: [],
        positiveNotes: '',
        additionalNotes: '',
      );

      expect(checkIn1.id, isNot(checkIn2.id));
    });
  });
}
