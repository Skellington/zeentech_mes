import '../../../../core/database/local_database.dart';

abstract class PartTypeRepository {
  Stream<List<PartType>> watchPartTypes();
  Future<void> addPartType(String name);
  Future<void> updatePartType(int id, String name);
  Future<void> togglePartType(int id, bool isActive);
  Future<void> deletePartType(int id);
}
