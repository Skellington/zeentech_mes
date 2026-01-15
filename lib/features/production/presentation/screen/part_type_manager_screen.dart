import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../core/database/local_database.dart';
import '../../../../core/ui/glass_container.dart';
import '../controller/part_type_controller.dart';

class PartTypeManagerScreen extends ConsumerStatefulWidget {
  const PartTypeManagerScreen({super.key});

  @override
  ConsumerState<PartTypeManagerScreen> createState() =>
      _PartTypeManagerScreenState();
}

class _PartTypeManagerScreenState extends ConsumerState<PartTypeManagerScreen> {
  final _textController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showEditor({PartType? type}) {
    _textController.text = type?.name ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Text(
          type == null ? 'Novo Tipo de Peça' : 'Editar Tipo de Peça',
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: _textController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Nome da Peça',
            hintStyle: TextStyle(color: Colors.white30),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white30)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent)),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancelar', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final name = _textController.text.trim();
              if (name.isEmpty) return;

              if (type == null) {
                // ADD
                await ref.read(partTypeControllerProvider.notifier).add(name);
              } else {
                // EDIT
                await ref
                    .read(partTypeControllerProvider.notifier)
                    .updateName(type.id, name);
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(PartType type) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red[900],
        title: const Text('Confirmar Exclusão',
            style: TextStyle(color: Colors.white)),
        content: Text(
          'Deseja excluir "${type.name}"?\nIsso não afetará os registros históricos passados, mas removerá a opção para novos registros.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child:
                const Text('Cancelar', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red[900],
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(partTypeControllerProvider.notifier).delete(type.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final typesAsync = ref.watch(partTypeControllerProvider);

    return Scaffold(
      backgroundColor: Colors.black, // Dark background to match app theme
      appBar: AppBar(
        title: const Text('Gerenciar Tipos de Peça',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showEditor(),
        label: const Text('Novo Tipo'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Buscar tipo de peça...',
                    hintStyle: const TextStyle(color: Colors.white30),
                    prefixIcon: const Icon(Icons.search, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: typesAsync.when(
                    data: (types) {
                      if (types.isEmpty) {
                        return const Center(
                          child: Text(
                            'Nenhum tipo de peça cadastrado.\nToque em "Novo Tipo" para adicionar.',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white30, fontSize: 16),
                          ),
                        );
                      }

                      // Filter and Sort
                      final filtered = types.where((t) {
                        return t.name
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase());
                      }).toList();

                      filtered.sort((a, b) =>
                          a.name.toLowerCase().compareTo(b.name.toLowerCase()));

                      if (filtered.isEmpty) {
                        return const Center(
                            child: Text('Nenhum tipo de peça encontrado.',
                                style: TextStyle(color: Colors.white54)));
                      }

                      return ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const Gap(8),
                        itemBuilder: (context, index) {
                          final type = filtered[index];
                          return GlassContainer(
                            opacity: 0.1,
                            borderRadius: BorderRadius.circular(12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                const Icon(Icons.extension,
                                    color: Colors.blueAccent),
                                const Gap(16),
                                Expanded(
                                  child: Text(
                                    type.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white70),
                                  onPressed: () => _showEditor(type: type),
                                  tooltip: 'Editar',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () => _confirmDelete(type),
                                  tooltip: 'Excluir',
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(
                      child: Text('Erro: $err',
                          style: const TextStyle(color: Colors.red)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
