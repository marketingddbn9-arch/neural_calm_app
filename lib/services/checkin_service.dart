import '../models/checkin_model.dart';

class CheckInService {
  final List<CheckInModel> _checkIns = [];
  int _idCounter = 0;

  Future<void> saveCheckIn(CheckInModel checkIn) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // Validate check-in data
      if (checkIn.userId.isEmpty) {
        throw Exception('User ID is required');
      }

      // Check if update or create
      final index = _checkIns.indexWhere((c) => c.id == checkIn.id);
      if (index >= 0) {
        _checkIns[index] = checkIn;
      } else {
        _checkIns.add(checkIn);
      }
    } catch (e) {
      throw Exception('Failed to save check-in: ${e.toString()}');
    }
  }

  Future<List<CheckInModel>> getCheckIns(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }

      return _checkIns
          .where((c) => c.userId == userId)
          .toList()
          .reversed
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch check-ins: ${e.toString()}');
    }
  }

  Future<CheckInModel?> getLatestCheckIn(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }

      final userCheckIns =
          _checkIns.where((c) => c.userId == userId).toList();
      if (userCheckIns.isEmpty) {
        return null;
      }

      userCheckIns.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return userCheckIns.first;
    } catch (e) {
      throw Exception('Failed to fetch latest check-in: ${e.toString()}');
    }
  }

  Future<List<CheckInModel>> getWeekCheckIns(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }

      final now = DateTime.now();
      final weekAgo = now.subtract(const Duration(days: 7));

      return _checkIns
          .where((c) =>
              c.userId == userId &&
              c.timestamp.isAfter(weekAgo) &&
              c.timestamp.isBefore(now))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch week check-ins: ${e.toString()}');
    }
  }

  Future<void> deleteCheckIn(String checkInId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      _checkIns.removeWhere((c) => c.id == checkInId);
    } catch (e) {
      throw Exception('Failed to delete check-in: ${e.toString()}');
    }
  }

  CheckInModel createNewCheckIn(String userId) {
    _idCounter++;
    return CheckInModel(
      id: 'checkin_$_idCounter',
      userId: userId,
      timestamp: DateTime.now(),
      mood: 3,
      stressLevel: 5,
      energyLevel: 5,
      sleepQuality: 7,
    );
  }

  Future<int> getCheckInCount(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      return _checkIns.where((c) => c.userId == userId).length;
    } catch (e) {
      return 0;
    }
  }

  Future<bool> hasCheckInToday(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final today = DateTime.now();
      return _checkIns.any((c) =>
          c.userId == userId &&
          c.timestamp.year == today.year &&
          c.timestamp.month == today.month &&
          c.timestamp.day == today.day);
    } catch (e) {
      return false;
    }
  }
}
