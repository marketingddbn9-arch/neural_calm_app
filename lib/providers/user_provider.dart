import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

// User State
class UserState {
  final bool isLoading;
  final UserModel? user;
  final String? error;

  UserState({
    this.isLoading = false,
    this.user,
    this.error,
  });

  UserState copyWith({
    bool? isLoading,
    UserModel? user,
    String? error,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

// User Notifier
class UserNotifier extends StateNotifier<UserState> {
  final FirebaseService _firebaseService;

  UserNotifier(this._firebaseService) : super(UserState());

  Future<void> fetchUser(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final userData = await _firebaseService.getUserData(userId);
      if (userData != null) {
        final user = UserModel.fromJson(userData);
        state = state.copyWith(
          isLoading: false,
          user: user,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> updateUser(UserModel user) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _firebaseService.saveUserData(user.id, user.toJson());
      state = state.copyWith(
        isLoading: false,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> updateWellnessScore(double score) async {
    if (state.user == null) return;

    final updatedUser = state.user!.copyWith(wellnessScore: score);
    await updateUser(updatedUser);
  }

  Future<void> updateStreak(int streak) async {
    if (state.user == null) return;

    final updatedUser = state.user!.copyWith(streak: streak);
    await updateUser(updatedUser);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Providers
final firebaseServiceProvider = Provider((ref) => FirebaseService());

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  return UserNotifier(firebaseService);
});

final userLoadingProvider = Provider((ref) {
  return ref.watch(userProvider).isLoading;
});

final userDataProvider = Provider((ref) {
  return ref.watch(userProvider).user;
});

final userErrorProvider = Provider((ref) {
  return ref.watch(userProvider).error;
});

final wellnessScoreProvider = Provider((ref) {
  return ref.watch(userProvider).user?.wellnessScore ?? 0.0;
});

final userStreakProvider = Provider((ref) {
  return ref.watch(userProvider).user?.streak ?? 0;
});
