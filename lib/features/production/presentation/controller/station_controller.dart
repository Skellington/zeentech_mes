import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers.dart';
import '../../domain/entity/station.dart';

part 'station_controller.g.dart';

@riverpod
class StationController extends _$StationController {
  @override
  FutureOr<List<Station>> build() async {
    final repo = ref.watch(productionRepositoryProvider);
    return repo.getAllStations();
  }

  Future<void> createStation(String name, String status) async {
    final repo = ref.read(productionRepositoryProvider);
    await repo.createStation(name, status);
    ref.invalidateSelf();
  }

  Future<void> updateStation(Station station) async {
    final repo = ref.read(productionRepositoryProvider);
    await repo.updateStation(station);
    ref.invalidateSelf();
  }

  Future<void> assignPacker(int stationId, int packerId) async {
    final repo = ref.read(productionRepositoryProvider);

    // Check if packer is assigned elsewhere (in either slot 1 or 2)
    final stations = await repo.getAllStations();
    final isTaken = stations.any((s) =>
        (s.assignedPackerId1 == packerId || s.assignedPackerId2 == packerId) &&
        s.id != stationId);

    if (isTaken) {
      throw Exception('Este empacotador já está alocado em outra bancada.');
    }

    final station = stations.firstWhere((s) => s.id == stationId);

    // Check duplication in same station
    if (station.assignedPackerId1 == packerId ||
        station.assignedPackerId2 == packerId) {
      return; // Already assigned here
    }

    // Assign to first available slot
    Station updated;
    if (station.assignedPackerId1 == null) {
      updated = station.copyWith(assignedPackerId1: packerId);
    } else if (station.assignedPackerId2 == null) {
      updated = station.copyWith(assignedPackerId2: packerId);
    } else {
      throw Exception('Esta estação já possui 2 empacotadores (Lotada).');
    }

    await repo.updateStation(updated);
    ref.invalidateSelf();
  }

  Future<void> unassignPacker(int stationId, int packerId) async {
    final repo = ref.read(productionRepositoryProvider);
    final stations = await repo.getAllStations();
    final station = stations.firstWhere((s) => s.id == stationId);

    Station updated = station;
    if (station.assignedPackerId1 == packerId) {
      updated = station.copyWith(assignedPackerId1: null);
    } else if (station.assignedPackerId2 == packerId) {
      updated = station.copyWith(assignedPackerId2: null);
    }

    // If explicit null is tricky with Freezed, passing null to copyWith usually works
    // provided the field is nullable in the constructor.
    // Our entity has: int? assignedPackerId1

    await repo.updateStation(updated);
    ref.invalidateSelf();
  }
}
