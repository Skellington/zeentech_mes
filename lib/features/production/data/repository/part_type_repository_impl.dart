import 'package:drift/drift.dart';
import '../../../../core/database/local_database.dart';
import '../../domain/repository/part_type_repository.dart';

class PartTypeRepositoryImpl implements PartTypeRepository {
  final LocalDatabase _db;

  PartTypeRepositoryImpl(this._db);

  @override
  Stream<List<PartType>> watchPartTypes() {
    return (_db.select(_db.partTypes)
          ..where((tbl) => tbl.isActive.equals(true)))
        .watch();
  }

  Stream<List<PartType>> watchAllPartTypes() {
    return _db.select(_db.partTypes).watch();
  }

  @override
  Future<void> addPartType(String name) async {
    await _db.into(_db.partTypes).insert(
          PartTypesCompanion(
            name: Value(name),
            isActive: const Value(true),
          ),
        );
  }

  @override
  Future<void> updatePartType(int id, String name) async {
    await (_db.update(_db.partTypes)..where((t) => t.id.equals(id))).write(
      PartTypesCompanion(name: Value(name)),
    );
  }

  @override
  Future<void> togglePartType(int id, bool isActive) async {
    await (_db.update(_db.partTypes)..where((t) => t.id.equals(id))).write(
      PartTypesCompanion(isActive: Value(isActive)),
    );
  }

  @override
  Future<void> deletePartType(int id) async {
    // Soft delete by default, or hard delete if really needed.
    // Implementing soft delete via togglePartType is preferred, but for this method I'll do verify
    await togglePartType(id, false);
  }
}
