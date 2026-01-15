import 'package:drift/drift.dart';

import '../../../../core/database/local_database.dart';
import '../../domain/entity/downtime_record.dart' as entity;
import '../../domain/repository/downtime_repository.dart';

class DowntimeRepositoryImpl implements IDowntimeRepository {
  final LocalDatabase _db;

  DowntimeRepositoryImpl(this._db);

  @override
  Future<void> saveDowntime(entity.DowntimeRecord record) async {
    await _db.into(_db.downtimeRecords).insert(
          DowntimeRecordsCompanion.insert(
            id: record.id,
            stationId: record.stationId,
            startTime: record.startTime,
            endTime: Value(record.endTime),
            reasonStart: Value(record.reasonStart),
            reasonEnd: Value(record.reasonEnd),
            durationMinutes: Value(record.durationMinutes),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Future<List<entity.DowntimeRecord>> getDowntimeHistory() async {
    final query = _db.select(_db.downtimeRecords)
      ..orderBy([
        (t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)
      ]);

    final rows = await query.get();

    return rows.map((row) {
      return entity.DowntimeRecord(
        id: row.id,
        stationId: row.stationId,
        startTime: row.startTime,
        endTime: row.endTime,
        reasonStart: row.reasonStart,
        reasonEnd: row.reasonEnd,
        durationMinutes: row.durationMinutes,
      );
    }).toList();
  }

  @override
  Future<List<entity.DowntimeRecord>> getDowntimeHistoryByStation(
      int stationId) async {
    final query = _db.select(_db.downtimeRecords)
      ..where((t) => t.stationId.equals(stationId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)
      ]);

    final rows = await query.get();

    return rows.map((row) {
      return entity.DowntimeRecord(
        id: row.id,
        stationId: row.stationId,
        startTime: row.startTime,
        endTime: row.endTime,
        reasonStart: row.reasonStart,
        reasonEnd: row.reasonEnd,
        durationMinutes: row.durationMinutes,
      );
    }).toList();
  }
}
