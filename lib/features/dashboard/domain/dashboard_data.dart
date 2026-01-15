enum DashboardShiftFilter { all, first, second }

class DashboardData {
  // 1. Total Production
  final int totalItems;
  final int totalVolume;

  // 2. Production per Station (Map<StationName, {national, export}>)
  final Map<String, ({int national, int export})> productionByStation;

  // 3. Production per Packer (Map<PackerName, {national, export}>)
  final Map<String, ({double national, double export})> productionByPacker;

  // 4. Global Pace (Pieces per Hour over time)
  // List of spots for graph: X = hour (0-24), Y = count
  final Map<int, int> hourlyProduction;

  // 6. Goal Data
  final int targetGoal; // e.g. 600
  final double? currentPacePerHour; // calculated (nullable for stabilization)
  final double? requiredPacePerHour; // NEW: Ideal Pace to hit target

  // 11. Market Split
  final int nationalCount;
  final int exportCount;
  final int shift1ManualProduction;
  final Map<String, int> stationTargets; // Name -> Target
  final double averageTarget;
  final int minStationGoal;
  final List<PartTypeStat> partTypeStats;

  // 12. Report Enhancements
  final int totalDowntimeMinutes;
  final Map<String, int> topDowntimeReasons; // Reason -> Minutes
  final Duration totalExpectedDuration;

  // 13. PDF Report Extra Data
  final Map<DateTime, ({int national, int export})> dailyStats;
  final List<
          ({DateTime start, DateTime end, int durationMinutes, String reason})>
      downtimeRecords;

  const DashboardData({
    required this.totalItems,
    required this.totalVolume,
    required this.productionByStation,
    required this.productionByPacker,
    required this.hourlyProduction,
    required this.targetGoal,
    required this.currentPacePerHour,
    this.requiredPacePerHour,
    required this.nationalCount,
    required this.exportCount,
    this.shift1ManualProduction = 0,
    required this.stationTargets,
    this.averageTarget = 40.0,
    this.minStationGoal = 40,
    required this.partTypeStats,
    this.totalDowntimeMinutes = 0,
    this.topDowntimeReasons = const {},
    this.totalExpectedDuration = Duration.zero,
    this.dailyStats = const {},
    this.downtimeRecords = const [],
  });

  factory DashboardData.empty() {
    return const DashboardData(
      totalItems: 0,
      totalVolume: 0,
      productionByStation: {},
      productionByPacker: {},
      hourlyProduction: {},
      targetGoal: 600, // Default daily goal
      currentPacePerHour: 0.0,
      requiredPacePerHour: 0.0,
      nationalCount: 0,
      exportCount: 0,
      stationTargets: {},
      averageTarget: 40.0,
      minStationGoal: 40,
      partTypeStats: [],
      totalDowntimeMinutes: 0,
      topDowntimeReasons: {},
      totalExpectedDuration: Duration.zero,
      dailyStats: {},
      downtimeRecords: [],
    );
  }
}

class PartTypeStat {
  final String name;
  final int shift1Qty;
  final int shift2Qty;

  int get total => shift1Qty + shift2Qty;

  const PartTypeStat({
    required this.name,
    required this.shift1Qty,
    required this.shift2Qty,
  });
}
