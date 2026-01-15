import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers.dart';
import '../../../../core/services/shift_service.dart';
import '../../../production/domain/entity/shift_configuration.dart';
import '../../domain/dashboard_data.dart';

part 'dashboard_controller.g.dart';

class DashboardFilter extends Equatable {
  final DateTimeRange? dateRange;
  final Set<DateTime> specificDates;
  final DashboardShiftFilter shift;
  final bool isExtended;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  const DashboardFilter({
    this.dateRange,
    this.specificDates = const {},
    this.shift = DashboardShiftFilter.all,
    this.isExtended = false,
    this.startTime,
    this.endTime,
  });

  DashboardFilter copyWith({
    DateTimeRange? dateRange,
    Set<DateTime>? specificDates,
    DashboardShiftFilter? shift,
    bool? isExtended,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool clearDateRange = false,
  }) {
    return DashboardFilter(
      dateRange: clearDateRange ? null : (dateRange ?? this.dateRange),
      specificDates: specificDates ?? this.specificDates,
      shift: shift ?? this.shift,
      isExtended: isExtended ?? this.isExtended,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props =>
      [dateRange, specificDates, shift, isExtended, startTime, endTime];
}

@riverpod
class DashboardController extends _$DashboardController {
  @override
  FutureOr<DashboardData> build(DashboardFilter filter) async {
    final service = ref.watch(statisticsServiceProvider);
    return service.getDashboardData(filter);
  }

  Future<void> updateShiftConfig(
      {required int shift1Manual,
      required int dailyGoal,
      required int minStationGoal}) async {
    final repository = ref.read(productionRepositoryProvider);
    // Use first date of range or Today (Production Date)
    final date = filter.dateRange != null
        ? filter.dateRange!.start
        : ShiftService().getProductionDate(DateTime.now());

    // Fetch existing or create new
    var config = await repository.getShiftConfiguration(date);

    if (config == null) {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final id =
          "${startOfDay.year}${startOfDay.month.toString().padLeft(2, '0')}${startOfDay.day.toString().padLeft(2, '0')}";
      config = ShiftConfiguration(
        id: id,
        date: startOfDay,
        shift1ManualProduction: shift1Manual,
        dailyGoal: dailyGoal,
        minStationGoal: minStationGoal,
      );
    } else {
      config = config.copyWith(
        shift1ManualProduction: shift1Manual,
        dailyGoal: dailyGoal,
        minStationGoal: minStationGoal,
      );
    }

    await repository.updateShiftConfiguration(config);
  }
}

// Separate provider for the filter state so UI can update it
@riverpod
class DashboardFilterController extends _$DashboardFilterController {
  @override
  DashboardFilter build() {
    // Default to null (Today) for initial state
    return const DashboardFilter(dateRange: null);
  }

  void setDateRange(DateTimeRange? range) {
    if (range == null) {
      clearDateFilter();
      return;
    }
    // Setting a range clears specific dates
    state = state.copyWith(dateRange: range, specificDates: {});
  }

  void setSpecificDates(Set<DateTime> dates) {
    if (dates.isEmpty) {
      clearDateFilter();
      return;
    }
    // Setting dates clears range
    state = state.copyWith(specificDates: dates, clearDateRange: true);
  }

  void setTime(TimeOfDay? start, TimeOfDay? end) {
    state = state.copyWith(startTime: start, endTime: end);
  }

  void clearDateFilter() {
    // Reset to default (null -> Today)
    state = state.copyWith(clearDateRange: true, specificDates: {});
  }

  void setShift(DashboardShiftFilter shift) {
    state = state.copyWith(shift: shift);
  }

  void toggleExtended() {
    state = state.copyWith(isExtended: !state.isExtended);
  }
}

@riverpod
Future<DashboardData> dashboardData(Ref ref) {
  final filter = ref.watch(dashboardFilterControllerProvider);
  final service = ref.watch(statisticsServiceProvider);
  return service.getDashboardData(filter);
}

final monthlyStatsProvider = FutureProvider.family<
    ({Map<String, int> stations, Map<String, double> packers}),
    DateTime>((ref, date) async {
  final service = ref.watch(statisticsServiceProvider);
  return service.getMonthlyTopPerformers(date);
});
