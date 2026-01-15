class ProductionLogicService {
  /// Rule 1: Shift 2 Goal Formula
  /// Shift2_Target = Max(300, 300 + (DailyGoal - Shift1_Actual))
  /// DailyGoal is typically 600.
  int calculateDailyTarget(int shift1Production, int dailyGoal) {
    const int baseShift2Goal = 300; // Minimum requirement for Shift 2

    // Shift 1 "Should Have Done" = DailyGoal - BaseShift2Goal?
    // Or simpler: Debt = DailyGoal - Shift1Total - BaseShift2Goal?
    // Formula from prompt: "Shift 2 Goal = Max(300, 300 + (DailyGoal - Shift1_Total))"
    // Wait, prompt says: "Max(300, 300 + (DailyGoal - Shift1_Total))"
    // Let's trace:
    // DailyGoal = 600. Shift1 = 250.
    // Goal = Max(300, 300 + (600 - 250)) = Max(300, 300 + 350) = 650.
    // That seems wrong. If Shift 1 did 250 (short 50), Shift 2 should do 350.
    // The prompt formula was: "Max(300, 300 + (DailyGoal - Shift1_Total))" -> Max(300, 300 + 350) = 650?
    // Maybe the user meant: "Max(300, DailyGoal - Shift1_Total)".
    // Let's re-read prompt carefully:
    // "Shift 2 Goal = Max(300, 300 + (DailyGoal - Shift1_Total))"
    // Example: "If DailyGoal is 600 and Shift 1 did 250 -> Shift 2 Goal = 350."
    // 600 - 250 = 350. Max(300, 350) = 350. Correct.
    // The prompt's text FORMULA "300 + ..." might be a typo, but the EXAMPLE "Shift 2 Goal = 350" is clear.
    // Example 2: "If Shift 1 did 350 -> Shift 2 Goal = 300 (Minimum)."
    // 600 - 350 = 250. Max(300, 250) = 300. Correct.
    // CONCLUSION: The formula is `Max(300, dailyGoal - shift1Production)`.

    final int remainder = dailyGoal - shift1Production;
    return remainder < baseShift2Goal ? baseShift2Goal : remainder;
  }

  /// Rule 2: Net Working Time (Tempo Líquido)
  /// Subtracts breaks from elapsed time.
  /// Shift 2 Breaks:
  /// - 18:00 - 18:20 (20 min)
  /// - 20:30 - 21:30 (60 min)
  /// - 00:00 - 00:20 (20 min)
  Duration getNetTimeElapsed(DateTime startTime, {DateTime? endTime}) {
    final now = DateTime.now();
    final calcEnd = endTime ?? now;

    if (calcEnd.isBefore(startTime)) return Duration.zero;

    // We iterate minute by minute? Efficient enough for "Shift Duration" (max 10h = 600 iterations).
    // Or we can subtract ranges.
    // Given the breaks are fixed times of day, we need to apply them to the specific date of the shift.

    // Identify Date Context (Shift starts on Day X, might end on Day X+1)
    // Breaks are relative to the Shift Start Day.

    final startDay = DateTime(startTime.year, startTime.month, startTime.day);

    // Define breaks for this specific day context
    // 18:00
    final b1Start = startDay.add(const Duration(hours: 18));
    final b1End = startDay.add(const Duration(hours: 18, minutes: 20));

    // 20:30
    final b2Start = startDay.add(const Duration(hours: 20, minutes: 30));
    final b2End = startDay.add(const Duration(hours: 21, minutes: 30));

    // 00:00 (Next Day!)
    // If start time is 16:00, 00:00 is Day+1.
    final b3Start = startDay.add(const Duration(days: 1, hours: 0, minutes: 0));
    final b3End = startDay.add(const Duration(days: 1, hours: 0, minutes: 20));

    // Calculate total duration
    Duration total = calcEnd.difference(startTime);

    // Subtract overlaps
    total -= _calculateOverlap(startTime, calcEnd, b1Start, b1End);
    total -= _calculateOverlap(startTime, calcEnd, b2Start, b2End);
    total -= _calculateOverlap(startTime, calcEnd, b3Start, b3End);

    if (total.isNegative) return Duration.zero;

    return total;
  }

  Duration _calculateOverlap(
      DateTime start, DateTime end, DateTime bStart, DateTime bEnd) {
    // Find intersection
    final overlapStart = start.isAfter(bStart) ? start : bStart;
    final overlapEnd = end.isBefore(bEnd) ? end : bEnd;

    if (overlapStart.isBefore(overlapEnd)) {
      return overlapEnd.difference(overlapStart);
    }
    return Duration.zero;
  }

  /// Calculates Pace: Items / Hours
  /// Returns null if netTime is less than 10 minutes (stabilization period).
  double? calculateCurrentPace(int currentProduction, Duration netTime) {
    // 1. Stabilization Check (10 minutes)
    if (netTime.inMinutes < 10) {
      return null;
    }

    final hours = netTime.inMinutes / 60.0;
    if (hours <= 0) return 0.0;
    return currentProduction / hours;
  }
}
