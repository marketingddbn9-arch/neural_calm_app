import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firebase_service.dart';

// Auth State
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? authToken;
  final UserModel? user;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.authToken,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? authToken,
    UserModel? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      authToken: authToken ?? this.authToken,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final FirebaseService _firebaseService;

  AuthNotifier(this._authService, this._firebaseService)
      : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _firebaseService.signInWithEmail(email, password);
      final token = await _firebaseService.getIdToken();

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        authToken: token,
        user: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signup(String email, String password, String name) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result =
          await _firebaseService.signUpWithEmail(email, password);
      await _firebaseService.saveUserData(
        result.id,
        {'name': name, 'email': email},
      );

      final token = await _firebaseService.getIdToken();
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        authToken: token,
        user: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      await _firebaseService.signOut();
      state = AuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _firebaseService.sendPasswordResetEmail(email);
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
final authServiceProvider = Provider((ref) => AuthService());
final firebaseServiceProvider = Provider((ref) => FirebaseService());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final firebaseService = ref.watch(firebaseServiceProvider);
  return AuthNotifier(authService, firebaseService);
});

final isAuthenticatedProvider = Provider((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

final authTokenProvider = Provider((ref) {
  return ref.watch(authProvider).authToken;
});

final currentUserProvider = Provider((ref) {
  return ref.watch(authProvider).user;
});

final authLoadingProvider = Provider((ref) {
  return ref.watch(authProvider).isLoading;
});

final authErrorProvider = Provider((ref) {
  return ref.watch(authProvider).error;
});
