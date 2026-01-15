import 'package:drift/drift.dart';

import '../../../core/database/local_database.dart';
import '../../../core/services/shift_service.dart';
import '../../production/application/production_logic_service.dart';
import '../../production/production.dart';
import '../domain/dashboard_data.dart';
import '../presentation/controller/dashboard_controller.dart'; // For DashboardFilter

class StatisticsService {
  final LocalDatabase _db;
  final ShiftService _shiftService;
  final ProductionLogicService _logicService;

  StatisticsService(this._db)
      : _shiftService = ShiftService(),
        _logicService = ProductionLogicService();

  Future<DashboardData> getDashboardData(DashboardFilter filter) async {
    // 0. Resolve Dates from Filter
    List<DateTime> dates = [];
    if (filter.specificDates.isNotEmpty) {
      dates = filter.specificDates.toList();
    } else if (filter.dateRange != null) {
      for (int i = 0; i <= filter.dateRange!.duration.inDays; i++) {
        dates.add(filter.dateRange!.start.add(Duration(days: i)));
      }
    } else {
      // Default to today if nothing provided
      final now = DateTime.now();
      dates = [DateTime(now.year, now.month, now.day)];
    }

    // Safety Fallback
    if (dates.isEmpty) {
      final now = DateTime.now();
      dates = [DateTime(now.year, now.month, now.day)];
    }

    final shiftFilter = filter.shift;

    // 1. Define ranges for ALL selected dates
    final ranges = dates.map((date) {
      final start =
          DateTime(date.year, date.month, date.day, 6, 0, 0); // 06:00 AM
      final end = start.add(const Duration(days: 1)); // Next day 06:00 AM
      return (start: start, end: end);
    }).toList();

    // 2. Build the Expression
    Expression<bool> filterExpression =
        const Constant(false); // Start with False

    if (ranges.isNotEmpty) {
      for (var range in ranges) {
        // Accumulate using OR operator (|)
        filterExpression = filterExpression |
            _db.productionRecords.timestamp
                .isBetweenValues(range.start, range.end);
      }
    } else {
      filterExpression = const Constant(false);
    }

    // 3. Apply to Query
    final query = _db.select(_db.productionRecords).join([
      leftOuterJoin(_db.stations,
          _db.stations.id.equalsExp(_db.productionRecords.stationId)),
    ]);
    query.where(filterExpression);

    final rows = await query.get();

    // 4. Fetch Configs for ALL dates
    final configIds = dates.map((d) {
      final startOfDay = DateTime(d.year, d.month, d.day);
      return "${startOfDay.year}${startOfDay.month.toString().padLeft(2, '0')}${startOfDay.day.toString().padLeft(2, '0')}";
    }).toList();

    Expression<bool> configExpr = const Constant(false);
    for (var id in configIds) {
      configExpr = configExpr | _db.shiftConfigurations.id.equals(id);
    }

    final configRows = await (_db.select(_db.shiftConfigurations)
          ..where((t) => configExpr))
        .get();

    // Aggregate Config Data
    int totalShift1Manual = 0;
    int sumDailyGoal = 0;
    int sumMinStationGoal = 0;

    for (var row in configRows) {
      totalShift1Manual += row.shift1ManualProduction;
      sumDailyGoal += row.dailyGoal;
      sumMinStationGoal += row.minStationGoal;
    }

    final int effectiveDailyGoal = configRows.isNotEmpty
        ? (sumDailyGoal / configRows.length).round()
        : 600;

    final int minStationGoal = configRows.isNotEmpty
        ? (sumMinStationGoal / configRows.length).round()
        : 40;

    // 5. Aggregate Production Data
    int totalItems = 0;
    int totalVolume = 0;
    int national = 0;
    int export = 0;

    final allPackersList = await _db.select(_db.packers).get();
    final packerMap = {for (var p in allPackersList) p.id: p.name};

    final Map<String, ({int national, int export})> byStation = {};
    final Map<String, ({double national, double export})> byPacker = {};
    final Map<int, int> hourly = {};
    final Map<String, int> stationTargets = {};
    final Map<DateTime, ({int national, int export})> dailyStats = {};

    // Initialize hourly map
    for (int i = 0; i < 24; i++) {
      hourly[i] = 0;
    }

    if (shiftFilter == DashboardShiftFilter.all) {
      totalItems += totalShift1Manual;
    }

    for (var row in rows) {
      final record = row.readTable(_db.productionRecords);
      final station = row.readTableOrNull(_db.stations);

      totalItems += record.itemCount;
      totalVolume += record.volumeCount;

      if (record.type == ProductionType.national) {
        national += record.itemCount;
      } else {
        export += record.itemCount;
      }

      final prodDate = _shiftService.getProductionDate(record.timestamp);
      final currentDateStats = dailyStats[prodDate] ?? (national: 0, export: 0);

      if (record.type == ProductionType.national) {
        dailyStats[prodDate] = (
          national: currentDateStats.national + record.itemCount,
          export: currentDateStats.export
        );
      } else {
        dailyStats[prodDate] = (
          national: currentDateStats.national,
          export: currentDateStats.export + record.itemCount
        );
      }

      // Station Grouping
      final sName = station?.name ?? 'Desconhecida';
      final sCurrent = byStation[sName] ?? (national: 0, export: 0);
      if (record.type == ProductionType.national) {
        byStation[sName] = (
          national: sCurrent.national + record.itemCount,
          export: sCurrent.export
        );
      } else {
        byStation[sName] = (
          national: sCurrent.national,
          export: sCurrent.export + record.itemCount
        );
      }

      // Packer Grouping
      final activePackerIds = <int>[];
      if (station != null) {
        if (station.assignedPackerId1 != null) {
          activePackerIds.add(station.assignedPackerId1!);
        }
        if (station.assignedPackerId2 != null) {
          activePackerIds.add(station.assignedPackerId2!);
        }
      }
      if (activePackerIds.isEmpty) {
        activePackerIds.add(record.packerId);
      }

      final share = record.itemCount.toDouble() / activePackerIds.length;
      for (var pid in activePackerIds) {
        final pName = packerMap[pid] ?? 'Desconhecido';
        final pCurrent = byPacker[pName] ?? (national: 0.0, export: 0.0);
        if (record.type == ProductionType.national) {
          byPacker[pName] =
              (national: pCurrent.national + share, export: pCurrent.export);
        } else {
          byPacker[pName] =
              (national: pCurrent.national, export: pCurrent.export + share);
        }
      }

      // Hourly
      final h = record.timestamp.hour;
      hourly[h] = (hourly[h] ?? 0) + record.itemCount;

      // Station Targets
      if (station != null) {
        final sName = station.name;
        if (!stationTargets.containsKey(sName)) {
          final baseTarget = station.targetGoal;
          final packerCount = (station.assignedPackerId1 != null ? 1 : 0) +
              (station.assignedPackerId2 != null ? 1 : 0);
          final effectiveTarget =
              packerCount >= 2 ? baseTarget * 2 : baseTarget;
          stationTargets[sName] = effectiveTarget;
        }
      }
    }

    // 6. Pace & Goals
    int finalTargetGoal = effectiveDailyGoal;
    if (shiftFilter == DashboardShiftFilter.second) {
      finalTargetGoal = _logicService.calculateDailyTarget(
          totalShift1Manual, effectiveDailyGoal);
    } else if (shiftFilter == DashboardShiftFilter.first) {
      finalTargetGoal = (effectiveDailyGoal / 2).round();
    }

    // 7. Downtime & Net Time
    int totalDowntimeMinutes = 0;
    final Map<String, int> topDowntimeReasons = {};
    Duration totalExpectedDuration = Duration.zero;
    final List<
        ({
          DateTime start,
          DateTime end,
          int durationMinutes,
          String reason
        })> downtimeRecords = [];

    if (ranges.isNotEmpty) {
      for (var range in ranges) {
        final now = DateTime.now();
        var rEnd = range.end;
        if (range.start.isBefore(now) && range.end.isAfter(now)) {
          rEnd = now;
        }
        if (rEnd.isAfter(range.start)) {
          totalExpectedDuration += rEnd.difference(range.start);
        }
      }

      Expression<bool> downtimeWhere = const Constant(false);
      for (var range in ranges) {
        downtimeWhere = downtimeWhere |
            _db.downtimeRecords.startTime
                .isBetweenValues(range.start, range.end);
      }

      final downtimeRows = await (_db.select(_db.downtimeRecords)
            ..where((t) => downtimeWhere))
          .get();

      for (var row in downtimeRows) {
        totalDowntimeMinutes += row.durationMinutes;
        final reason = row.reasonStart ?? 'Desconhecido';
        topDowntimeReasons[reason] =
            (topDowntimeReasons[reason] ?? 0) + row.durationMinutes;

        downtimeRecords.add((
          start: row.startTime,
          end: row.endTime ??
              row.startTime.add(Duration(minutes: row.durationMinutes)),
          durationMinutes: row.durationMinutes,
          reason: reason
        ));
      }
    }

    double? pace = 0.0;
    if (dates.isNotEmpty) {
      final totalMinutes = totalExpectedDuration.inMinutes;
      final netMinutes = totalMinutes - totalDowntimeMinutes;

      if (netMinutes > 0) {
        pace = (totalItems / netMinutes) * 60;
      }
    }

    // 8. Part Types
    final List<PartTypeStat> partTypeStats =
        await getProductionByPartType(dates);

    final activeStationsCount = (await (_db.select(_db.stations)
              ..where((t) => t.status.equals('ACTIVE')))
            .get())
        .length;
    final double avgTarget = activeStationsCount > 0
        ? finalTargetGoal / activeStationsCount
        : minStationGoal.toDouble();

    // Required Pace Logic (Approximate)
    double? requiredPace = 0.0;
    final now = DateTime.now();
    final includesToday = dates.any(
        (d) => d.year == now.year && d.month == now.month && d.day == now.day);

    if (includesToday &&
        (shiftFilter == DashboardShiftFilter.second ||
            shiftFilter == DashboardShiftFilter.all)) {
      final netRemaining = _calculateNetRemainingHours(now);
      final remainingItems = finalTargetGoal - totalItems;
      if (remainingItems > 0 && netRemaining > 0) {
        requiredPace = remainingItems / netRemaining;
      } else if (remainingItems <= 0) {
        requiredPace = 0.0;
      } else {
        requiredPace = null;
      }
    }

    return DashboardData(
      totalItems: totalItems,
      totalVolume: totalVolume,
      productionByStation: byStation,
      productionByPacker: byPacker,
      hourlyProduction: hourly,
      targetGoal: finalTargetGoal,
      currentPacePerHour: pace,
      requiredPacePerHour: requiredPace,
      nationalCount: national,
      exportCount: export,
      shift1ManualProduction: totalShift1Manual,
      stationTargets: stationTargets,
      averageTarget: avgTarget,
      minStationGoal: minStationGoal,
      partTypeStats: partTypeStats,
      totalDowntimeMinutes: totalDowntimeMinutes,
      topDowntimeReasons: topDowntimeReasons,
      totalExpectedDuration: totalExpectedDuration,
      dailyStats: dailyStats,
      downtimeRecords: downtimeRecords,
    );
  }

  // Helper: Shift 2 Net Remaining Hours
  double _calculateNetRemainingHours(DateTime now) {
    DateTime shiftEnd;
    if (now.hour < 6) {
      shiftEnd = DateTime(now.year, now.month, now.day, 1, 9);
    } else {
      final tomorrow = now.add(const Duration(days: 1));
      shiftEnd = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 1, 9);
    }

    if (now.isAfter(shiftEnd)) return 0.0;

    int activeMinutes = 0;
    DateTime cursor = now;
    while (cursor.isBefore(shiftEnd)) {
      if (!_isInShift2Break(cursor)) {
        activeMinutes++;
      }
      cursor = cursor.add(const Duration(minutes: 1));
      if (cursor.difference(now).inHours > 24) break;
    }

    return activeMinutes / 60.0;
  }

  bool _isInShift2Break(DateTime t) {
    final h = t.hour;
    final m = t.minute;
    if (h == 18 && m >= 0 && m < 20) return true;
    if (h == 20 && m >= 30) return true;
    if (h == 21 && m < 30) return true;
    if (h == 0 && m >= 0 && m < 20) return true;
    return false;
  }

  Future<({Map<String, int> stations, Map<String, double> packers})>
      getMonthlyTopPerformers(DateTime date) async {
    try {
      final start = DateTime(date.year, date.month, 1);
      final end = DateTime(date.year, date.month + 1, 1)
          .subtract(const Duration(seconds: 1));

      final allPackersList = await _db.select(_db.packers).get();
      final packerMap = {for (var p in allPackersList) p.id: p.name};

      final query = _db.select(_db.productionRecords).join([
        leftOuterJoin(_db.stations,
            _db.stations.id.equalsExp(_db.productionRecords.stationId)),
      ]);

      query.where(_db.productionRecords.timestamp.isBetweenValues(start, end));

      final rows = await query.get();

      if (rows.isEmpty) {
        return (stations: <String, int>{}, packers: <String, double>{});
      }

      final Map<String, int> byStation = {};
      final Map<String, double> byPacker = {};

      for (var row in rows) {
        final record = row.readTable(_db.productionRecords);
        final station = row.readTableOrNull(_db.stations);

        final sName = station?.name ?? 'Unknown';
        byStation[sName] = (byStation[sName] ?? 0) + record.itemCount;

        final activePackerIds = <int>[];
        if (station != null) {
          if (station.assignedPackerId1 != null) {
            activePackerIds.add(station.assignedPackerId1!);
          }
          if (station.assignedPackerId2 != null) {
            activePackerIds.add(station.assignedPackerId2!);
          }
        }
        if (activePackerIds.isEmpty) {
          activePackerIds.add(record.packerId);
        }

        if (activePackerIds.isNotEmpty) {
          final share = record.itemCount.toDouble() / activePackerIds.length;
          for (var pid in activePackerIds) {
            final pName = packerMap[pid] ?? 'Unknown';
            byPacker[pName] = (byPacker[pName] ?? 0.0) + share;
          }
        }
      }

      return (stations: byStation, packers: byPacker);
    } catch (e) {
      return (stations: <String, int>{}, packers: <String, double>{});
    }
  }

  Future<List<PartTypeStat>> getProductionByPartType(
      List<DateTime> dates) async {
    if (dates.isEmpty) {
      final now = DateTime.now();
      dates = [DateTime(now.year, now.month, now.day)];
    }

    final partTypes = await _db.select(_db.partTypes).get();
    final Map<int, int> shift1Counts = {};
    final Map<int, int> shift2Counts = {};

    final ranges = dates.map((date) {
      final start = DateTime(date.year, date.month, date.day, 6, 0, 0);
      final end = start.add(const Duration(days: 1));
      return (start: start, end: end);
    }).toList();

    Expression<bool> s2Expression = const Constant(false);
    for (var range in ranges) {
      s2Expression = s2Expression |
          _db.productionRecords.timestamp
              .isBetweenValues(range.start, range.end);
    }

    final configIds = dates.map((d) {
      final startOfDay = DateTime(d.year, d.month, d.day);
      return "${startOfDay.year}${startOfDay.month.toString().padLeft(2, '0')}${startOfDay.day.toString().padLeft(2, '0')}";
    }).toList();

    Expression<bool> s1Expression = const Constant(false);
    for (var id in configIds) {
      s1Expression = s1Expression | _db.shift1Productions.configId.equals(id);
    }

    final s1Rows = await (_db.select(_db.shift1Productions)
          ..where((t) => s1Expression))
        .get();

    final s2Rows = await (_db.select(_db.productionRecords)
          ..where((t) => s2Expression))
        .get();

    for (var row in s1Rows) {
      shift1Counts[row.partTypeId] =
          (shift1Counts[row.partTypeId] ?? 0) + row.quantity;
    }

    for (var row in s2Rows) {
      if (row.partTypeId != null) {
        shift2Counts[row.partTypeId!] =
            (shift2Counts[row.partTypeId!] ?? 0) + row.itemCount;
      }
    }

    final List<PartTypeStat> stats = [];
    for (var type in partTypes) {
      final s1 = shift1Counts[type.id] ?? 0;
      final s2 = shift2Counts[type.id] ?? 0;

      if (s1 > 0 || s2 > 0) {
        stats.add(PartTypeStat(
          name: type.name,
          shift1Qty: s1,
          shift2Qty: s2,
        ));
      }
    }

    stats.sort((a, b) => b.total.compareTo(a.total));

    return stats;
  }
}
