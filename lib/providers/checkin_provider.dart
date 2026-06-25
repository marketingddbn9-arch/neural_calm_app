import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/checkin_model.dart';
import '../services/checkin_service.dart';

// CheckIn State
class CheckInState {
  final bool isLoading;
  final List<CheckInModel> checkIns;
  final CheckInModel? latestCheckIn;
  final bool hasCheckInToday;
  final String? error;

  CheckInState({
    this.isLoading = false,
    this.checkIns = const [],
    this.latestCheckIn,
    this.hasCheckInToday = false,
    this.error,
  });

  CheckInState copyWith({
    bool? isLoading,
    List<CheckInModel>? checkIns,
    CheckInModel? latestCheckIn,
    bool? hasCheckInToday,
    String? error,
  }) {
    return CheckInState(
      isLoading: isLoading ?? this.isLoading,
      checkIns: checkIns ?? this.checkIns,
      latestCheckIn: latestCheckIn ?? this.latestCheckIn,
      hasCheckInToday: hasCheckInToday ?? this.hasCheckInToday,
      error: error ?? this.error,
    );
  }
}

// CheckIn Notifier
class CheckInNotifier extends StateNotifier<CheckInState> {
  final CheckInService _checkInService;

  CheckInNotifier(this._checkInService) : super(CheckInState());

  Future<void> saveCheckIn(CheckInModel checkIn) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _checkInService.saveCheckIn(checkIn);
      
      final hasCheckInToday = await _checkInService.hasCheckInToday();
      await fetchCheckIns();

      state = state.copyWith(
        isLoading: false,
        hasCheckInToday: hasCheckInToday,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> fetchCheckIns() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final checkIns = await _checkInService.getCheckIns();
      final latest = await _checkInService.getLatestCheckIn();
      final hasCheckInToday = await _checkInService.hasCheckInToday();

      state = state.copyWith(
        isLoading: false,
        checkIns: checkIns,
        latestCheckIn: latest,
        hasCheckInToday: hasCheckInToday,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> fetchWeekCheckIns() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final checkIns = await _checkInService.getWeekCheckIns();
      state = state.copyWith(
        isLoading: false,
        checkIns: checkIns,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> deleteCheckIn(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _checkInService.deleteCheckIn(id);
      await fetchCheckIns();
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
final checkInServiceProvider = Provider((ref) => CheckInService());

final checkInProvider =
    StateNotifierProvider<CheckInNotifier, CheckInState>((ref) {
  final checkInService = ref.watch(checkInServiceProvider);
  return CheckInNotifier(checkInService);
});

final checkInLoadingProvider = Provider((ref) {
  return ref.watch(checkInProvider).isLoading;
});

final checkInsProvider = Provider((ref) {
  return ref.watch(checkInProvider).checkIns;
});

final latestCheckInProvider = Provider((ref) {
  return ref.watch(checkInProvider).latestCheckIn;
});

final hasCheckInTodayProvider = Provider((ref) {
  return ref.watch(checkInProvider).hasCheckInToday;
});

final checkInErrorProvider = Provider((ref) {
  return ref.watch(checkInProvider).error;
});

final averageMoodProvider = Provider((ref) {
  final checkIns = ref.watch(checkInsProvider);
  if (checkIns.isEmpty) return 0.0;
  
  final sum = checkIns.fold<double>(
    0,
    (prev, checkIn) => prev + checkIn.mood,
  );
  return sum / checkIns.length;
});

final weekCheckInsProvider =
    FutureProvider.autoDispose((ref) async {
  final checkInService = ref.watch(checkInServiceProvider);
  return checkInService.getWeekCheckIns();
});
