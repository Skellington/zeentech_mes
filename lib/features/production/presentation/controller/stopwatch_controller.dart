import 'dart:async';
import 'dart:developer' as developer;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers.dart';
import '../../domain/entity/downtime_record.dart';

part 'stopwatch_controller.g.dart';

class DowntimeState {
  final String id;
  final bool isRunning;
  final DateTime? startTime;
  final Duration elapsed;
  final String? currentReason;

  const DowntimeState({
    required this.id,
    this.isRunning = false,
    this.startTime,
    this.elapsed = Duration.zero,
    this.currentReason,
  });

  DowntimeState copyWith({
    String? id,
    bool? isRunning,
    DateTime? startTime,
    Duration? elapsed,
    String? currentReason,
  }) {
    return DowntimeState(
      id: id ?? this.id,
      isRunning: isRunning ?? this.isRunning,
      startTime: startTime ?? this.startTime,
      elapsed: elapsed ?? this.elapsed,
      currentReason: currentReason ?? this.currentReason,
    );
  }
}

class StopwatchState {
  final Map<int, DowntimeState> activeStops;

  const StopwatchState({this.activeStops = const {}});

  StopwatchState copyWith({Map<int, DowntimeState>? activeStops}) {
    return StopwatchState(
      activeStops: activeStops ?? this.activeStops,
    );
  }
}

@Riverpod(keepAlive: true)
class StopwatchNotifier extends _$StopwatchNotifier {
  Timer? _timer;

  @override
  StopwatchState build() {
    return const StopwatchState();
  }

  void start(int stationId, String reason) {
    if (state.activeStops[stationId]?.isRunning == true) return;

    final now = DateTime.now();
    final id = const Uuid().v4();

    final newDowntime = DowntimeState(
      id: id,
      isRunning: true,
      startTime: now,
      elapsed: Duration.zero,
      currentReason: reason,
    );

    final newMap = Map<int, DowntimeState>.from(state.activeStops);
    newMap[stationId] = newDowntime;

    state = state.copyWith(activeStops: newMap);
    _ensureTimer();
  }

  /// Stops the timer, saves to DB, and returns the total duration in minutes
  Future<int> stop(int stationId) async {
    final s = state.activeStops[stationId];
    if (s == null || !s.isRunning) return 0;

    final finalDuration = s.elapsed;
    final now = DateTime.now();

    // Create Record
    final record = DowntimeRecord(
      id: s.id,
      stationId: stationId,
      startTime: s.startTime!,
      endTime: now,
      reasonStart: s.currentReason,
      reasonEnd: "RETOMADA", // Default end reason
      durationMinutes: finalDuration.inMinutes,
    );

    // Save to Repository
    try {
      await ref.read(downtimeRepositoryProvider).saveDowntime(record);
    } catch (e) {
      // Handle error (maybe log it), but don't break UI flow
      developer.log("Error saving downtime", error: e);
    }

    final newMap = Map<int, DowntimeState>.from(state.activeStops);
    newMap.remove(stationId);

    state = state.copyWith(activeStops: newMap);
    _checkTimer();

    return finalDuration.inMinutes;
  }

  void _ensureTimer() {
    _timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final newMap = Map<int, DowntimeState>.from(state.activeStops);
      bool changed = false;

      state.activeStops.forEach((id, ds) {
        if (ds.isRunning && ds.startTime != null) {
          newMap[id] = ds.copyWith(elapsed: now.difference(ds.startTime!));
          changed = true;
        }
      });

      if (changed) {
        state = state.copyWith(activeStops: newMap);
      }
    });
  }

  void _checkTimer() {
    if (state.activeStops.isEmpty) {
      _timer?.cancel();
      _timer = null;
    }
  }
}
