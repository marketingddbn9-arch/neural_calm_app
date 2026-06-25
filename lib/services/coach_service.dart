import '../models/coach_message_model.dart';

class CoachService {
  final List<CoachMessageModel> _messages = [];
  int _messageIdCounter = 0;

  Future<void> sendMessage(CoachMessageModel message) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (message.userId.isEmpty) {
        throw Exception('User ID is required');
      }

      _messages.add(message);
    } catch (e) {
      throw Exception('Failed to send message: ${e.toString()}');
    }
  }

  Future<List<CoachMessageModel>> getMessages(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }

      return _messages
          .where((m) => m.userId == userId)
          .toList()
          .reversed
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch messages: ${e.toString()}');
    }
  }

  Future<CoachMessageModel?> getLatestMessage(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }

      final userMessages =
          _messages.where((m) => m.userId == userId).toList();
      if (userMessages.isEmpty) {
        return null;
      }

      userMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return userMessages.first;
    } catch (e) {
      throw Exception('Failed to fetch latest message: ${e.toString()}');
    }
  }

  Future<void> markAsRead(String messageId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));

      final index = _messages.indexWhere((m) => m.id == messageId);
      if (index >= 0) {
        _messages[index] = _messages[index].copyWith(isRead: true);
      }
    } catch (e) {
      throw Exception('Failed to mark message as read: ${e.toString()}');
    }
  }

  CoachMessageModel createUserMessage(String userId, String message, String coachId) {
    _messageIdCounter++;
    return CoachMessageModel(
      id: 'msg_user_$_messageIdCounter',
      coachId: coachId,
      coachName: 'Coach',
      userId: userId,
      message: message,
      timestamp: DateTime.now(),
      isFromCoach: false,
      isRead: true,
      messageType: 'text',
    );
  }

  CoachMessageModel createCoachMessage(
    String userId,
    String message,
    String coachId,
    String coachName, {
    String messageType = 'text',
  }) {
    _messageIdCounter++;
    return CoachMessageModel(
      id: 'msg_coach_$_messageIdCounter',
      coachId: coachId,
      coachName: coachName,
      userId: userId,
      message: message,
      timestamp: DateTime.now(),
      isFromCoach: true,
      isRead: false,
      messageType: messageType,
    );
  }

  Future<List<CoachMessageModel>> getCoachMessages(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      return _messages
          .where((m) => m.userId == userId && m.isFromCoach)
          .toList()
          .reversed
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch coach messages: ${e.toString()}');
    }
  }

  Future<int> getUnreadMessageCount(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));

      return _messages
          .where((m) => m.userId == userId && m.isFromCoach && !m.isRead)
          .length;
    } catch (e) {
      return 0;
    }
  }
}
