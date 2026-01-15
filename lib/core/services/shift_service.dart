enum UserShift { first, second, offShift }

class ShiftService {
  /// Returns the current shift based on the time and extended mode.
  /// Shift 1: 06:00 to 15:48
  /// Shift 2: 15:48 to 01:09 (next day)
  /// Extended Mode: Adds 1h to the end of each shift
  UserShift getCurrentShift(DateTime now, {bool isExtended = false}) {
    // 1. Normalize time to minutes from midnight for easier comparison
    final minutes = now.hour * 60 + now.minute;

    // Shift 1 Start: 06:00 (360 min)
    const shift1Start = 6 * 60;

    // Shift 1 Standard End: 15:48 (15 * 60 + 48 = 948 min)
    int shift1End = 15 * 60 + 48;
    if (isExtended) shift1End += 60; // 16:48 (1008 min)

    // Shift 2 Standard End: 01:09 next day (1 * 60 + 9 = 69 min)
    // We treat "next day" times by adding 24h (1440 min)
    int shift2End = 25 * 60 + 9; // 01:09 next day -> 1509 min
    if (isExtended) shift2End += 60; // 02:09 next day -> 1569 min

    // Adjust current minutes if it's early morning (00:00 - 06:00)
    // to be treated as part of the "previous day" timeline for Shift 2
    int currentMinutes = minutes;
    if (now.hour < 6) {
      currentMinutes += 24 * 60;
    }

    if (currentMinutes >= shift1Start && currentMinutes < shift1End) {
      return UserShift.first;
    } else if (currentMinutes >= shift1End && currentMinutes < shift2End) {
      return UserShift.second;
    } else {
      return UserShift.offShift;
    }
  }

  /// Returns the "Accounting Date".
  /// If the current time is between 00:00 and 06:00, it belongs to the PREVIOUS day.
  /// Example: 2023-10-05 01:30 -> Returns 2023-10-04
  DateTime getProductionDate(DateTime now) {
    if (now.hour < 6) {
      return DateTime(now.year, now.month, now.day - 1);
    }
    return DateTime(now.year, now.month, now.day);
  }

  /// Returns the start and end time for a specific shift on a given accounting date.
  ({DateTime start, DateTime end}) getShiftRange(DateTime date, UserShift shift,
      {bool isExtended = false}) {
    // Ensure we are working with strictly the date part (00:00:00)
    final d = DateTime(date.year, date.month, date.day);

    DateTime start;
    DateTime end;

    if (shift == UserShift.first) {
      start = d.add(const Duration(hours: 6)); // 06:00
      end = d.add(const Duration(hours: 15, minutes: 48)); // 15:48
      if (isExtended) {
        end = end.add(const Duration(hours: 1)); // 16:48
      }
    } else {
      // Shift 2 (UserShift.second)
      // Starts at 15:48 FIXED
      start = d.add(const Duration(hours: 15, minutes: 48)); 
      
      // Ends at 01:09 next day standard
      end = d.add(const Duration(days: 1, hours: 1, minutes: 9)); 

      if (isExtended) {
        // Extended: Adds 1h -> 02:09 next day
        end = end.add(const Duration(hours: 1));
      }
    }

    return (start: start, end: end);
  }
}
