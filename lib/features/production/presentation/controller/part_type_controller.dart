import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/local_database.dart';
import '../../../../core/providers.dart';

class PartTypeController extends StreamNotifier<List<PartType>> {
  @override
  Stream<List<PartType>> build() {
    return ref.watch(partTypeRepositoryProvider).watchPartTypes();
  }

  Future<void> add(String name) async {
    await ref.read(partTypeRepositoryProvider).addPartType(name);
  }

  Future<void> updateName(int id, String newName) async {
    await ref.read(partTypeRepositoryProvider).updatePartType(id, newName);
  }

  Future<void> delete(int id) async {
    await ref.read(partTypeRepositoryProvider).deletePartType(id);
  }

  Future<void> toggle(int id, bool isActive) async {
    await ref.read(partTypeRepositoryProvider).togglePartType(id, isActive);
  }
}

final partTypeControllerProvider =
    StreamNotifierProvider<PartTypeController, List<PartType>>(
        PartTypeController.new);
