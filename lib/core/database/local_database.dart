import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import '../../features/production/domain/entity/production_record.dart';
import '../utils/app_paths.dart';

part 'local_database.g.dart';

// Tables
class Stations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  IntColumn get assignedPackerId1 =>
      integer().nullable().references(Packers, #id)();
  IntColumn get assignedPackerId2 =>
      integer().nullable().references(Packers, #id)();
  IntColumn get targetGoal =>
      integer().withDefault(const Constant(40))(); // Default 40
}

class Packers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text()();
  TextColumn get email => text()();
  TextColumn get photoLocalPath => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class PartTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class Shift1Productions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get configId => text().references(ShiftConfigurations, #id)();
  IntColumn get partTypeId => integer().references(PartTypes, #id)();
  IntColumn get quantity => integer()();
}

class ProductionRecords extends Table {
  TextColumn get id => text()(); // UUID
  IntColumn get stationId => integer().references(Stations, #id)();
  IntColumn get packerId => integer().references(Packers, #id)();
  IntColumn get type => intEnum<ProductionType>()();
  TextColumn get barcode => text()();
  IntColumn get volumeCount => integer()();
  IntColumn get itemCount => integer()();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get shiftId => integer()();
  IntColumn get partTypeId =>
      integer().nullable().references(PartTypes, #id)(); // New

  @override
  Set<Column> get primaryKey => {id};
}

class DowntimeRecords extends Table {
  TextColumn get id => text()(); // UUID
  IntColumn get stationId => integer().references(Stations, #id)();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get reasonStart => text().nullable()();
  TextColumn get reasonEnd => text().nullable()();
  IntColumn get durationMinutes => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class ShiftConfigurations extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get isExtendedMode =>
      boolean().withDefault(const Constant(false))();
  IntColumn get shift1ManualProduction =>
      integer().withDefault(const Constant(0))();
  IntColumn get dailyGoal =>
      integer().withDefault(const Constant(600))(); // Default 600
  IntColumn get minStationGoal =>
      integer().withDefault(const Constant(40))(); // Default 40

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Stations,
    Packers,
    ProductionRecords,
    DowntimeRecords,
    ShiftConfigurations,
    PartTypes, // New
    Shift1Productions, // New
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4; // Incremented version

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Seed default part types
        await batch((batch) {
          batch.insertAll(partTypes, [
            const PartTypesCompanion(name: Value('Capô')),
            const PartTypesCompanion(name: Value('Porta')),
            const PartTypesCompanion(name: Value('Lateral')),
            const PartTypesCompanion(name: Value('Tampa Traseira')),
            const PartTypesCompanion(name: Value('Vidro')),
            const PartTypesCompanion(name: Value('Assoalho')),
            const PartTypesCompanion(name: Value('Para-lama')),
          ]);
        });
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 4) {
          // Add table PartTypes
          await m.createTable(partTypes);
          // Add table Shift1Productions
          await m.createTable(shift1Productions);
          // Add column partTypeId to ProductionRecords
          await m.addColumn(productionRecords, productionRecords.partTypeId);

          // Seed default part types
          await batch((batch) {
            batch.insertAll(partTypes, [
              const PartTypesCompanion(name: Value('Capô')),
              const PartTypesCompanion(name: Value('Porta')),
              const PartTypesCompanion(name: Value('Lateral')),
              const PartTypesCompanion(name: Value('Tampa Traseira')),
              const PartTypesCompanion(name: Value('Vidro')),
              const PartTypesCompanion(name: Value('Assoalho')),
              const PartTypesCompanion(name: Value('Para-lama')),
            ]);
          });
        }
      },
    );
  }

  Future<void> clearAllData() async {
    await delete(productionRecords).go();
    await delete(downtimeRecords).go();
    await delete(shiftConfigurations).go();
    await delete(shift1Productions).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = await AppPaths.getDatabaseFile();
    return NativeDatabase.createInBackground(file);
  });
}
