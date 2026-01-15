import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/local_database.dart'; // Drift DB
import '../../../../core/services/shift_service.dart';
import '../../domain/entity/dashboard_stats.dart';

import '../../domain/entity/packer.dart' as entity;
import '../../domain/entity/production_record.dart' as entity;
import '../../domain/entity/shift_configuration.dart' as entity;
import '../../domain/entity/station.dart' as entity;
import '../../domain/repository/production_repository.dart';

class ProductionRepositoryImpl implements IProductionRepository {
  final LocalDatabase _db;
  final ShiftService _shiftService;

  ProductionRepositoryImpl(this._db) : _shiftService = ShiftService();

  // --- STATIONS ---

  @override
  Future<int> createStation(String name, String status) {
    return _db.into(_db.stations).insert(StationsCompanion(
          name: Value(name),
          status: Value(status),
          targetGoal: const Value(40), // Default Goal
        ));
  }

  @override
  Future<List<entity.Station>> getAllStations() async {
    final rows = await _db.select(_db.stations).get();
    return rows
        .map((row) => entity.Station(
              id: row.id,
              name: row.name,
              status: row.status,
              assignedPackerId1: row.assignedPackerId1,
              assignedPackerId2: row.assignedPackerId2,
              targetGoal: row.targetGoal,
            ))
        .toList();
  }

  @override
  Future<void> updateStation(entity.Station station) {
    return (_db.update(_db.stations)..where((t) => t.id.equals(station.id)))
        .write(StationsCompanion(
      name: Value(station.name),
      status: Value(station.status),
      assignedPackerId1: Value(station.assignedPackerId1),
      assignedPackerId2: Value(station.assignedPackerId2),
      targetGoal: Value(station.targetGoal),
    ));
  }

  // --- PACKERS ---

  @override
  Future<int> createPacker(entity.Packer packer) {
    return _db.into(_db.packers).insert(PackersCompanion(
          name: Value(packer.name),
          phone: Value(packer.phone),
          email: Value(packer.email),
          photoLocalPath: Value(packer.photoLocalPath),
          isActive: Value(packer.isActive),
        ));
  }

  @override
  Future<List<entity.Packer>> getAllPackers() async {
    final rows = await _db.select(_db.packers).get();
    return rows
        .map((row) => entity.Packer(
              id: row.id,
              name: row.name,
              phone: row.phone,
              email: row.email,
              photoLocalPath: row.photoLocalPath,
              isActive: row.isActive,
            ))
        .toList();
  }

  @override
  Future<void> updatePacker(entity.Packer packer) {
    return (_db.update(_db.packers)..where((t) => t.id.equals(packer.id)))
        .write(PackersCompanion(
      name: Value(packer.name),
      phone: Value(packer.phone),
      email: Value(packer.email),
      photoLocalPath: Value(packer.photoLocalPath),
      isActive: Value(packer.isActive),
    ));
  }

  @override
  Future<void> togglePackerActive(int id, bool isActive) {
    return (_db.update(_db.packers)..where((t) => t.id.equals(id)))
        .write(PackersCompanion(isActive: Value(isActive)));
  }

  // --- PRODUCTION ---

  @override
  Future<void> insertProduction(entity.ProductionRecord record) {
    return _db.into(_db.productionRecords).insert(ProductionRecordsCompanion(
          id: Value(record.id),
          stationId: Value(record.stationId),
          packerId: Value(record.packerId),
          type: Value(record.type),
          barcode: Value(record.barcode),
          volumeCount: Value(record.volumeCount),
          itemCount: Value(record.itemCount),
          timestamp: Value(record.timestamp),
          shiftId: Value(record.shiftId),
          partTypeId: Value(record.partTypeId),
        ));
  }

  @override
  Future<List<entity.ProductionRecord>> getAllProduction() async {
    final rows = await _db.select(_db.productionRecords).get();
    return rows
        .map((row) => entity.ProductionRecord(
              id: row.id,
              stationId: row.stationId,
              packerId: row.packerId,
              type: row.type,
              barcode: row.barcode,
              volumeCount: row.volumeCount,
              itemCount: row.itemCount,
              timestamp: row.timestamp,
              shiftId: row.shiftId,
              partTypeId: row.partTypeId,
            ))
        .toList();
  }

  @override
  Future<List<entity.ProductionRecord>> searchProduction(String query) async {
    SimpleSelectStatement<$ProductionRecordsTable, ProductionRecord> statement;

    if (query.isEmpty) {
      // Empty: Show ALL for TODAY (00:00 - 23:59)
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      statement = _db.select(_db.productionRecords)
        ..where((t) => t.timestamp.isBetweenValues(startOfDay, endOfDay))
        ..orderBy([
          (t) => OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc)
        ]);
      // Limit removed as requested
    } else {
      // Smart Query Logic
      if (query.toLowerCase().contains("estação") ||
          query.toLowerCase().startsWith("estacao")) {
        // Extract number
        final stationIdRegex = RegExp(r'(\d+)');
        final match = stationIdRegex.firstMatch(query);

        if (match != null) {
          final id = int.tryParse(match.group(0)!);
          if (id != null) {
            statement = _db.select(_db.productionRecords)
              ..where((t) => t.stationId.equals(id))
              ..orderBy([
                (t) => OrderingTerm(
                    expression: t.timestamp, mode: OrderingMode.desc)
              ]);
          } else {
            // Fallback
            statement = _db.select(_db.productionRecords)
              ..where((t) => t.id.equals("non_existent"));
          }
        } else {
          statement = _db.select(_db.productionRecords)
            ..where((t) => t.id.equals("non_existent"));
        }
      } else {
        // Barcode Search
        final q = "%$query%";
        statement = _db.select(_db.productionRecords)
          ..where((t) => t.barcode.like(q))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc)
          ]);
      }
    }

    final rows = await statement.get();

    return rows
        .map((row) => entity.ProductionRecord(
              id: row.id,
              stationId: row.stationId,
              packerId: row.packerId,
              type: row.type,
              barcode: row.barcode,
              volumeCount: row.volumeCount,
              itemCount: row.itemCount,
              timestamp: row.timestamp,
              shiftId: row.shiftId,
              partTypeId: row.partTypeId,
            ))
        .toList();
  }

  @override
  Future<entity.ProductionRecord?> findProductionByBarcode(
      String barcode, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final row = await (_db.select(_db.productionRecords)
          ..where((t) => t.barcode.equals(barcode))
          ..where((t) => t.timestamp.isBetweenValues(startOfDay, endOfDay)))
        .getSingleOrNull();

    if (row == null) return null;

    return entity.ProductionRecord(
      id: row.id,
      stationId: row.stationId,
      packerId: row.packerId,
      type: row.type,
      barcode: row.barcode,
      volumeCount: row.volumeCount,
      itemCount: row.itemCount,
      timestamp: row.timestamp,
      shiftId: row.shiftId,
      partTypeId: row.partTypeId,
    );
  }

  // --- DOWNTIME ---

  @override
  Future<String> startDowntime(int stationId, String? reason) async {
    final id = const Uuid().v4();
    await _db.into(_db.downtimeRecords).insert(DowntimeRecordsCompanion(
          id: Value(id),
          stationId: Value(stationId),
          startTime: Value(DateTime.now()),
          reasonStart: Value(reason),
        ));
    return id;
  }

  @override
  Future<void> stopDowntime(
      String id, DateTime endTime, String? reason, int durationMinutes) {
    return (_db.update(_db.downtimeRecords)..where((t) => t.id.equals(id)))
        .write(DowntimeRecordsCompanion(
      endTime: Value(endTime),
      reasonEnd: Value(reason),
      durationMinutes: Value(durationMinutes),
    ));
  }

  // --- DASHBOARD ---

  @override
  Future<DashboardStats> getDailyStats(DateTime date, UserShift shift,
      {bool isExtended = false}) async {
    // Determine the time range for the query
    final range =
        _shiftService.getShiftRange(date, shift, isExtended: isExtended);

    final query = _db.select(_db.productionRecords)
      ..where((t) => t.timestamp.isBetweenValues(range.start, range.end));

    final records = await query.get();

    int totalVolume = 0;
    int totalItems = 0;
    for (var r in records) {
      totalVolume += r.volumeCount;
      totalItems += r.itemCount;
    }

    // Calculate duration in hours
    final duration = range.end.difference(range.start).inMinutes / 60.0;
    final speed = duration > 0 ? totalItems / duration : 0.0;

    return DashboardStats(
      totalVolume: totalVolume,
      totalItems: totalItems,
      itemsPerHour: speed,
    );
  }

  // --- SHIFT CONFIGURATION ---
  @override
  Future<entity.ShiftConfiguration?> getShiftConfiguration(
      DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    // Simple ID based on YYYYMMDD for unique daily config
    final id =
        "${startOfDay.year}${startOfDay.month.toString().padLeft(2, '0')}${startOfDay.day.toString().padLeft(2, '0')}";

    final row = await (_db.select(_db.shiftConfigurations)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();

    if (row == null) return null;

    return entity.ShiftConfiguration(
      id: row.id,
      date: row.date,
      isExtendedMode: row.isExtendedMode,
      shift1ManualProduction: row.shift1ManualProduction,
      dailyGoal: row.dailyGoal,
      minStationGoal: row.minStationGoal,
    );
  }

  @override
  Future<void> updateShiftConfiguration(
      entity.ShiftConfiguration config) async {
    // Upsert
    await _db.into(_db.shiftConfigurations).insertOnConflictUpdate(
          ShiftConfigurationsCompanion(
            id: Value(config.id),
            date: Value(config.date),
            isExtendedMode: Value(config.isExtendedMode),
            shift1ManualProduction: Value(config.shift1ManualProduction),
            dailyGoal: Value(config.dailyGoal),
            minStationGoal: Value(config.minStationGoal),
          ),
        );
  }

  @override
  Future<void> updateShift1Productions(
      String configId, Map<int, int> quantities) async {
    await _db.transaction(() async {
      // Clear existing for this config
      await (_db.delete(_db.shift1Productions)
            ..where((t) => t.configId.equals(configId)))
          .go();

      // Insert new
      for (var entry in quantities.entries) {
        if (entry.value > 0) {
          await _db.into(_db.shift1Productions).insert(
                Shift1ProductionsCompanion(
                  configId: Value(configId),
                  partTypeId: Value(entry.key),
                  quantity: Value(entry.value),
                ),
              );
        }
      }
    });
  }

  @override
  Future<Map<int, int>> getShift1Productions(String configId) async {
    final rows = await (_db.select(_db.shift1Productions)
          ..where((t) => t.configId.equals(configId)))
        .get();

    final Map<int, int> result = {};
    for (var row in rows) {
      result[row.partTypeId] = row.quantity;
    }
    return result;
  }
}
