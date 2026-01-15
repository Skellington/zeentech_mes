import 'package:flutter_test/flutter_test.dart';
import 'package:zeentech_mes/core/services/shift_service.dart';

void main() {
  late ShiftService shiftService;

  setUp(() {
    shiftService = ShiftService();
  });

  group('ShiftService - Standard Mode', () {
    test('Should return Shift 1 for 06:00', () {
      final time = DateTime(2023, 10, 5, 6, 0);
      expect(shiftService.getCurrentShift(time), UserShift.first);
    });

    test('Should return Shift 1 for 15:47', () {
      final time = DateTime(2023, 10, 5, 15, 47);
      expect(shiftService.getCurrentShift(time), UserShift.first);
    });

    test('Should return Shift 2 for 15:48', () {
      final time = DateTime(2023, 10, 5, 15, 48);
      expect(shiftService.getCurrentShift(time), UserShift.second);
    });

    test('Should return Shift 2 for 01:08 (next day)', () {
      final time = DateTime(2023, 10, 6, 1, 8);
      expect(shiftService.getCurrentShift(time), UserShift.second);
    });

    test('Should return Off-Shift for 01:09 (next day)', () {
      final time = DateTime(2023, 10, 6, 1, 9);
      expect(shiftService.getCurrentShift(time), UserShift.offShift);
    });

    test('Should return Off-Shift for 05:59', () {
      final time = DateTime(2023, 10, 6, 5, 59);
      expect(shiftService.getCurrentShift(time), UserShift.offShift);
    });
  });

  group('ShiftService - Extended Mode', () {
    test('Should return Shift 1 for 16:47 (Extended by 1h)', () {
      final time = DateTime(2023, 10, 5, 16, 47);
      expect(shiftService.getCurrentShift(time, isExtended: true),
          UserShift.first);
    });

    test('Should return Shift 2 for 16:48', () {
      final time = DateTime(2023, 10, 5, 16, 48);
      expect(shiftService.getCurrentShift(time, isExtended: true),
          UserShift.second);
    });

    test('Should return Shift 2 for 02:08 (next day, Extended by 1h)', () {
      final time = DateTime(2023, 10, 6, 2, 8);
      expect(shiftService.getCurrentShift(time, isExtended: true),
          UserShift.second);
    });

    test('Should return Off-Shift for 02:09 (next day, Extended end)', () {
      final time = DateTime(2023, 10, 6, 2, 9);
      expect(shiftService.getCurrentShift(time, isExtended: true),
          UserShift.offShift);
    });
  });

  group('ShiftService - Production Date', () {
    test('Should return same date for afternoon', () {
      final time = DateTime(2023, 10, 5, 14, 0);
      final productionDate = shiftService.getProductionDate(time);
      expect(productionDate.year, 2023);
      expect(productionDate.month, 10);
      expect(productionDate.day, 5);
    });

    test('Should return PREVIOUS date for early morning (01:30)', () {
      final time = DateTime(2023, 10, 5, 1, 30);
      final productionDate = shiftService.getProductionDate(time);
      expect(productionDate.year, 2023);
      expect(productionDate.month, 10);
      expect(productionDate.day, 4);
    });

    test('Should return same date for 06:00', () {
      final time = DateTime(2023, 10, 5, 6, 0);
      final productionDate = shiftService.getProductionDate(time);
      expect(productionDate.year, 2023);
      expect(productionDate.month, 10);
      expect(productionDate.day, 5);
    });
  });
}
