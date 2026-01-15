import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../core/ui/glass_container.dart';
import '../../../production/presentation/controller/part_type_controller.dart';

class PartTypeManagerDialog extends ConsumerWidget {
  const PartTypeManagerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partTypesAsync = ref.watch(partTypeControllerProvider);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () =>
            Navigator.pop(context),
      },
      child: Focus(
        autofocus: true,
        child: AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          surfaceTintColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Gerenciar Tipos de Peça",
                  style: TextStyle(color: Colors.white)),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: SizedBox(
            width: 500,
            height: 400,
            child: Column(
              children: [
                Expanded(
                  child: partTypesAsync.when(
                    data: (partTypes) {
                      if (partTypes.isEmpty) {
                        return const Center(
                          child: Text(
                            "Nenhum tipo de peça cadastrado.",
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }
                      return ListView.separated(
                        itemCount: partTypes.length,
                        separatorBuilder: (_, __) => const Gap(8),
                        itemBuilder: (context, index) {
                          final item = partTypes[index];
                          return GlassContainer(
                            borderRadius: BorderRadius.circular(12),
                            padding: const EdgeInsets.all(12),
                            opacity: 0.1,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Colors.blueAccent.withValues(alpha: 0.2),
                                  child: Text(item.name[0].toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent)),
                                ),
                                const Gap(16),
                                Expanded(
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => ref
                                      .read(partTypeControllerProvider.notifier)
                                      .toggle(item.id, false),
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  tooltip: "Remover",
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, s) => Center(
                        child: Text("Erro: $e",
                            style: const TextStyle(color: Colors.red))),
                  ),
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => _showAddDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text("Adicionar Tipo"),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    void save() {
      if (controller.text.isNotEmpty) {
        ref.read(partTypeControllerProvider.notifier).add(controller.text);
        Navigator.pop(context);
      }
    }

    showDialog(
      context: context,
      builder: (ctx) => CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): () =>
              Navigator.pop(ctx),
        },
        child: Focus(
          autofocus: true,
          child: AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            surfaceTintColor: Colors.transparent,
            title: const Text("Novo Tipo de Peça",
                style: TextStyle(color: Colors.white)),
            content: TextField(
              controller: controller,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Nome da Peça",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => save(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Cancelar"),
              ),
              FilledButton(
                onPressed: save,
                child: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
