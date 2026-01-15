import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';

import '../../../../core/ui/glass_container.dart';
import '../../production.dart';

class PackerScreen extends ConsumerStatefulWidget {
  const PackerScreen({super.key});

  @override
  ConsumerState<PackerScreen> createState() => _PackerScreenState();
}

class _PackerScreenState extends ConsumerState<PackerScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final packersAsync = ref.watch(packerControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Equipe de Embaladores',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  GlassContainer(
                    color: Theme.of(context).colorScheme.secondary,
                    opacity: 0.8,
                    borderRadius: BorderRadius.circular(8),
                    child: IconButton(
                      icon: const Icon(Icons.person_add, color: Colors.white),
                      onPressed: () => _showAddEditDialog(context, ref),
                    ),
                  ),
                ],
              ),
              const Gap(16),
              // Search Bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar embalador...',
                  hintStyle: const TextStyle(color: Colors.white30),
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
        ),

        // List
        Expanded(
          child: packersAsync.when(
            data: (packers) {
              if (packers.isEmpty) {
                return const Center(
                    child: Text('Nenhum embalador cadastrado.'));
              }

              // Filter and Sort
              final filtered = packers.where((p) {
                return p.name
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase());
              }).toList();

              filtered.sort((a, b) =>
                  a.name.toLowerCase().compareTo(b.name.toLowerCase()));

              if (filtered.isEmpty) {
                return const Center(
                    child: Text('Nenhum embalador encontrado.',
                        style: TextStyle(color: Colors.white54)));
              }

              return MasonryGridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: MediaQuery.of(context).size.width > 1200
                    ? 4
                    : (MediaQuery.of(context).size.width > 800 ? 3 : 2),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final packer = filtered[index];
                  return GlassContainer(
                    opacity: 0.15,
                    borderRadius: BorderRadius.circular(16),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white24,
                              child: Text(packer.name.isNotEmpty
                                  ? packer.name[0].toUpperCase()
                                  : '?'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                packer.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Tooltip(
                              message: "Ativar ou Desativar Embalador",
                              child: Switch(
                                value: packer.isActive,
                                onChanged: (val) {
                                  ref
                                      .read(packerControllerProvider.notifier)
                                      .toggleActive(packer.id, val);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              packer.isActive ? 'Ativo' : 'Inativo',
                              style: TextStyle(
                                color: packer.isActive
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Tel: ${packer.phone}',
                            style: const TextStyle(fontSize: 12)),
                        Text('Email: ${packer.email}',
                            style: const TextStyle(fontSize: 12)),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: const Icon(Icons.edit, size: 20),
                            onPressed: () => _showAddEditDialog(context, ref,
                                packer: packer),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Erro: $err')),
          ),
        ),
      ],
    );
  }

  void _showAddEditDialog(BuildContext context, WidgetRef ref,
      {Packer? packer}) {
    final nameCtrl = TextEditingController(text: packer?.name ?? '');
    final phoneCtrl = TextEditingController(text: packer?.phone ?? '');
    final emailCtrl = TextEditingController(text: packer?.email ?? '');
    final isEditing = packer != null;

    Future<void> save() async {
      try {
        if (isEditing) {
          await ref.read(packerControllerProvider.notifier).updatePacker(
                packer.copyWith(
                  name: nameCtrl.text,
                  phone: phoneCtrl.text,
                  email: emailCtrl.text,
                ),
              );
        } else {
          await ref.read(packerControllerProvider.notifier).createPacker(
                nameCtrl.text,
                phoneCtrl.text,
                emailCtrl.text,
              );
        }
        if (context.mounted) Navigator.pop(context);
      } catch (e) {
        // Handle error (optional: show snackbar)
      }
    }

    showDialog(
      context: context,
      builder: (context) {
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
              title: Text(isEditing ? 'Editar Embalador' : 'Novo Embalador'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneCtrl,
                    decoration: const InputDecoration(labelText: 'Telefone'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(labelText: 'Email'),
                    onSubmitted: (_) => save(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: save,
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
