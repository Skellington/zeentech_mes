import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/dashboard/data/statistics_service.dart';
import '../features/production/data/repository/downtime_repository_impl.dart';
import '../features/production/data/repository/part_type_repository_impl.dart';
import '../features/production/data/repository/production_repository_impl.dart';
import '../features/production/domain/repository/downtime_repository.dart';
import '../features/production/domain/repository/part_type_repository.dart';
import '../features/production/domain/repository/production_repository.dart';
import 'database/local_database.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
LocalDatabase localDatabase(Ref ref) {
  return LocalDatabase();
}

@Riverpod(keepAlive: true)
IProductionRepository productionRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return ProductionRepositoryImpl(db);
}

// Lazy provider for Statistics Service (not kept alive necessarily, but good for caching if needed)
@riverpod
StatisticsService statisticsService(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return StatisticsService(db);
}

@Riverpod(keepAlive: true)
IDowntimeRepository downtimeRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return DowntimeRepositoryImpl(db);
}

@Riverpod(keepAlive: true)
PartTypeRepository partTypeRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return PartTypeRepositoryImpl(db);
}
