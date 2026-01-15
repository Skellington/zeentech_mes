import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers.dart';
import '../../domain/entity/packer.dart';

part 'packer_controller.g.dart';

@riverpod
class PackerController extends _$PackerController {
  @override
  FutureOr<List<Packer>> build() async {
    final repo = ref.watch(productionRepositoryProvider);
    return repo.getAllPackers();
  }

  Future<void> createPacker(String name, String phone, String email) async {
    final repo = ref.read(productionRepositoryProvider);
    await repo.createPacker(Packer(
      id: 0, // Auto-increment ignores this
      name: name,
      phone: phone,
      email: email,
      photoLocalPath: null,
      isActive: true,
    ));
    ref.invalidateSelf();
  }

  Future<void> updatePacker(Packer packer) async {
    final repo = ref.read(productionRepositoryProvider);
    await repo.updatePacker(packer);
    ref.invalidateSelf();
  }

  Future<void> toggleActive(int id, bool isActive) async {
    final repo = ref.read(productionRepositoryProvider);
    await repo.togglePackerActive(id, isActive);
    ref.invalidateSelf();
  }
}
