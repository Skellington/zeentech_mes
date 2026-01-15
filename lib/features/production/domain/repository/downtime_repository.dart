import '../entity/downtime_record.dart';

abstract class IDowntimeRepository {
  Future<void> saveDowntime(DowntimeRecord record);
  Future<List<DowntimeRecord>> getDowntimeHistory();
  Future<List<DowntimeRecord>> getDowntimeHistoryByStation(int stationId);
}
