import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers.dart';
import '../../../../core/services/shift_service.dart';
import '../../../../features/dashboard/presentation/controller/dashboard_controller.dart';
import '../../domain/entity/production_record.dart';
import 'stopwatch_controller.dart';

part 'production_controller.g.dart';

class StationStoppedException implements Exception {
  final String message;
  StationStoppedException(this.message);
  @override
  String toString() => message;
}

@riverpod
class ProductionController extends _$ProductionController {
  final Map<int, DateTime> _lastAuthorizedTimes = {};

  @override
  FutureOr<void> build() {
    // Stateless mainly, but can hold status of last operation
  }

  Future<void> registerProduction({
    required int stationId,
    required ProductionType type,
    String? barcode,
    bool isExport = false,
    bool force = false,
    int? volume,
    int? quantity,
    int? partTypeId,
  }) async {
    state = const AsyncValue.loading();

    try {
      // 0. Guard Check: Is Station Stopped?
      final stopwatchState = ref.read(stopwatchProvider);
      final downtime = stopwatchState.activeStops[stationId];

      if (downtime != null && downtime.isRunning) {
        // Station IS stopped. Check authorization.
        final lastAuth = _lastAuthorizedTimes[stationId];
        final now = DateTime.now();
        final isAuthValid = lastAuth != null &&
            now.difference(lastAuth) < const Duration(seconds: 60);

        if (!force && !isAuthValid) {
          throw StationStoppedException(
              "A estação está parada! Confirme para registrar.");
        }

        // If we represent here, it means we are authorized (either force=true or valid window).
        // Refresh authorization window
        _lastAuthorizedTimes[stationId] = now;
      }

      // Logic & Validation
      int finalVolume;
      int finalQuantity;

      if (!isExport) {
        // National: Force Quantity = 1
        finalQuantity = 1;
        finalVolume = volume ?? 1;
      } else {
        // Export: Require Volume & Quantity > 0
        if (volume == null || volume <= 0) {
          throw Exception('Volume inválido para exportação.');
        }
        if (quantity == null || quantity <= 0) {
          throw Exception('Quantidade inválida para exportação.');
        }
        finalVolume = volume;
        finalQuantity = quantity;
      }

      final repo = ref.read(productionRepositoryProvider);
      final shiftService = ShiftService();

      // 1. Get current Station info (to see assigned packers)
      final stations = await repo.getAllStations();
      final station = stations.firstWhere((s) => s.id == stationId);

      final p1 = station.assignedPackerId1;
      final p2 = station.assignedPackerId2;

      if (p1 == null && p2 == null) {
        throw Exception("Nenhum embalador atribuído a esta estação.");
      }

      final now = DateTime.now();
      final shift = shiftService.getCurrentShift(now);

      final packerIds = [if (p1 != null) p1, if (p2 != null) p2];

      // Calculate split
      final splitVolume = (finalVolume / packerIds.length).floor();
      final splitItems = (finalQuantity / packerIds.length).floor();

      final int volumeRemainder = finalVolume % packerIds.length;
      final int itemsRemainder = finalQuantity % packerIds.length;

      for (var i = 0; i < packerIds.length; i++) {
        final pid = packerIds[i];

        int rVol = splitVolume;
        int rItems = splitItems;

        // Add remainder to first one
        if (i == 0) {
          rVol += volumeRemainder;
          rItems += itemsRemainder;
        }

        final record = ProductionRecord(
          id: const Uuid().v4(),
          stationId: stationId,
          barcode: barcode ?? "",
          packerId: pid,
          type: type, // Removed isExport ternary as 'type' is passed directly
          volumeCount: rVol,
          itemCount: rItems,
          timestamp: now,
          shiftId: shift.index,
          partTypeId: partTypeId,
        );

        await repo.insertProduction(record);
      }

      state = const AsyncValue.data(null);

      // Force Dashboard Refresh
      // UI watches dashboardDataProvider, so this is essential:
      ref.invalidate(dashboardDataProvider);
      // We also invalidate the controller just in case logic depends on it (per instructions)
      ref.invalidate(dashboardControllerProvider);
      // Also invalidate monthly stats if they change significantly (optional but good practice)
      ref.invalidate(monthlyStatsProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      // Re-throw if it's our special exception so UI can catch it
      if (e is StationStoppedException) rethrow;
    }
  }
}
