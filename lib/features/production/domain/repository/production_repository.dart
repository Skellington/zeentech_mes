import '../../../../core/services/shift_service.dart';
import '../entity/dashboard_stats.dart';

import '../entity/packer.dart';
import '../entity/production_record.dart';
import '../entity/shift_configuration.dart';
import '../entity/station.dart';

abstract class IProductionRepository {
  // Station
  Future<int> createStation(String name, String status);
  Future<void> updateStation(Station station);
  Future<List<Station>> getAllStations();

  // Packer
  Future<int> createPacker(Packer packer);
  Future<void> updatePacker(Packer packer);
  Future<List<Packer>> getAllPackers();
  Future<void> togglePackerActive(int id, bool isActive);

  // Production
  Future<void> insertProduction(ProductionRecord record);
  Future<List<ProductionRecord>> getAllProduction();
  Future<List<ProductionRecord>> searchProduction(String query);
  Future<ProductionRecord?> findProductionByBarcode(
      String barcode, DateTime date);

  // Downtime
  Future<String> startDowntime(int stationId, String? reason);
  Future<void> stopDowntime(
      String id, DateTime endTime, String? reason, int durationMinutes);

  // Dashboard
  Future<DashboardStats> getDailyStats(DateTime date, UserShift shift,
      {bool isExtended = false});
  // Shift Configuration
  Future<ShiftConfiguration?> getShiftConfiguration(DateTime date);
  Future<void> updateShiftConfiguration(ShiftConfiguration config);
  Future<void> updateShift1Productions(
      String configId, Map<int, int> quantities);
  Future<Map<int, int>> getShift1Productions(String configId);
}
