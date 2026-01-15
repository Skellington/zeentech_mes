import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/ui/glass_container.dart';
import '../../production.dart';

class StationScreen extends ConsumerWidget {
  const StationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationsAsync = ref.watch(stationControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gerenciamento de Estações',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              GlassContainer(
                color: Theme.of(context).colorScheme.primary,
                opacity: 0.8,
                borderRadius: BorderRadius.circular(8),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () => _showAddEditDialog(context, ref),
                ),
              ),
            ],
          ),
        ),

        // List
        Expanded(
          child: stationsAsync.when(
            data: (stations) {
              if (stations.isEmpty) {
                return const Center(
                  child: Text('Nenhuma estação cadastrada.'),
                );
              }
              return MasonryGridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: MediaQuery.of(context).size.width > 1200
                    ? 4
                    : (MediaQuery.of(context).size.width > 800 ? 3 : 2),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemCount: stations.length,
                itemBuilder: (context, index) {
                  final station = stations[index];
                  // Ideally we fetch the assigned packer name.
                  // For now, let's assume we can't easily get the name without joining or separate fetch.
                  // But the prompt wants "Display currently assigned Packer's name".
                  // This usually implies a join in Domain or creating a view model.
                  // For simplicity in Phase 2, we can just show "Embalador ID: X" or try to find it if we have packers.
                  // BUT, to do it right, let's just show "Embalador Atribuído" or "N/A" for now,
                  // and focus on the Assign Button.

                  return GlassContainer(
                    opacity: 0.15,
                    borderRadius: BorderRadius.circular(12),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                station.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Colors.blueAccent),
                              onPressed: () => _showAddEditDialog(context, ref,
                                  station: station),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(station.status)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: _getStatusColor(station.status)
                                    .withValues(alpha: 0.5)),
                          ),
                          child: Text(
                            station.status,
                            style: TextStyle(
                              color: _getStatusColor(station.status),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: Colors.white10),
                        const SizedBox(height: 8),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Embaladores:",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            Consumer(builder: (context, ref, child) {
                              final packersAsync =
                                  ref.watch(packerControllerProvider);

                              return packersAsync.when(
                                data: (packers) {
                                  final p1 = packers.firstWhere(
                                      (p) => p.id == station.assignedPackerId1,
                                      orElse: () => const Packer(
                                          id: -1,
                                          name: 'Vago',
                                          phone: '',
                                          email: '',
                                          isActive: false));
                                  final p2 = packers.firstWhere(
                                      (p) => p.id == station.assignedPackerId2,
                                      orElse: () => const Packer(
                                          id: -1,
                                          name: 'Vago',
                                          phone: '',
                                          email: '',
                                          isActive: false));

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          station.assignedPackerId1 != null
                                              ? "1. ${p1.name}"
                                              : "1. --",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                      Text(
                                          station.assignedPackerId2 != null
                                              ? "2. ${p2.name}"
                                              : "2. --",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                    ],
                                  );
                                },
                                loading: () => const LinearProgressIndicator(),
                                error: (_, __) =>
                                    const Text("Erro ao carregar"),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () =>
                                _showAssignPackerDialog(context, ref, station),
                            child: const Text("Gerenciar Equipe"),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Ativa':
        return Colors.greenAccent;
      case 'Manutenção':
        return Colors.orangeAccent;
      case 'Inativa':
        return Colors.grey;
      default:
        return Colors.white;
    }
  }

  void _showAssignPackerDialog(
      BuildContext context, WidgetRef ref, Station station) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _PackerAssignmentDialog(station: station),
    );
  }

  void _showAddEditDialog(BuildContext context, WidgetRef ref,
      {Station? station}) {
    final nameController = TextEditingController(text: station?.name ?? '');
    final goalController =
        TextEditingController(text: station?.targetGoal.toString() ?? '40');
    String selectedStatus = station?.status ?? 'Ativa';
    final isEditing = station != null;
    final statusOptions = ['Ativa', 'Manutenção', 'Inativa'];

    if (!statusOptions.contains(selectedStatus)) {
      selectedStatus = 'Ativa';
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            surfaceTintColor: Colors.transparent,
            title: Text(isEditing ? 'Editar Estação' : 'Nova Estação'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autofocus: true,
                  controller: nameController,
                  decoration:
                      const InputDecoration(labelText: 'Nome da Estação'),
                  onSubmitted: (_) async {
                    try {
                      if (isEditing) {
                        await ref
                            .read(stationControllerProvider.notifier)
                            .updateStation(station.copyWith(
                              name: nameController.text,
                              status: selectedStatus,
                              targetGoal:
                                  int.tryParse(goalController.text) ?? 40,
                            ));
                      } else {
                        await ref
                            .read(stationControllerProvider.notifier)
                            .createStation(nameController.text, selectedStatus);
                      }
                      if (context.mounted) Navigator.pop(context);
                    } catch (e) {
                      // Handle error
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedStatus,
                  items: statusOptions.map((status) {
                    return DropdownMenuItem(value: status, child: Text(status));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => selectedStatus = val);
                  },
                  decoration: const InputDecoration(labelText: 'Status'),
                  dropdownColor: const Color(0xFF1E293B),
                ),
                if (isEditing) ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: goalController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Meta Diária da Estação'),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (isEditing) {
                      await ref
                          .read(stationControllerProvider.notifier)
                          .updateStation(station.copyWith(
                            name: nameController.text,
                            status: selectedStatus,
                            targetGoal: int.tryParse(goalController.text) ?? 40,
                          ));
                    } else {
                      await ref
                          .read(stationControllerProvider.notifier)
                          .createStation(nameController.text, selectedStatus);
                    }
                    if (context.mounted) Navigator.pop(context);
                  } catch (e) {
                    // Handle error
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          );
        });
      },
    );
  }
}

class _PackerAssignmentDialog extends ConsumerStatefulWidget {
  final Station station;
  const _PackerAssignmentDialog({required this.station});

  @override
  ConsumerState<_PackerAssignmentDialog> createState() =>
      _PackerAssignmentDialogState();
}

class _PackerAssignmentDialogState
    extends ConsumerState<_PackerAssignmentDialog> {
  @override
  Widget build(BuildContext context) {
    // Watch packers to show the list
    final packersAsync = ref.watch(packerControllerProvider);
    // Watch stations to get the LATEST state of assignments (reactive update)
    final stationsAsync = ref.watch(stationControllerProvider);

    // Fallback to local station if provider is loading (though normally it should be cached)
    final currentStationList = stationsAsync.asData?.value;
    final currentStation = currentStationList?.firstWhere(
            (s) => s.id == widget.station.id,
            orElse: () => widget.station) ??
        widget.station;

    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      surfaceTintColor: Colors.transparent,
      title: Text('Gerenciar Equipe - ${currentStation.name}'),
      content: SizedBox(
        width: 450,
        height: 400,
        child: packersAsync.when(
          data: (packers) {
            final activePackers = packers.where((p) => p.isActive).toList();

            if (activePackers.isEmpty) {
              return const Center(
                  child: Text("Nenhum embalador ativo cadastrado.",
                      style: TextStyle(color: Colors.white54)));
            }

            final p1Id = currentStation.assignedPackerId1;
            final p2Id = currentStation.assignedPackerId2;

            return ListView.separated(
              itemCount: activePackers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final packer = activePackers[index];
                final isAssignedHere = (p1Id == packer.id || p2Id == packer.id);

                return InkWell(
                  onTap: () =>
                      _toggleAssignment(currentStation, packer, isAssignedHere),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isAssignedHere
                          ? Colors.blueAccent.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            isAssignedHere ? Colors.blueAccent : Colors.white10,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Avatar / Initial
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: isAssignedHere
                              ? Colors.blueAccent
                              : Colors.white10,
                          child: Text(
                            packer.name.isNotEmpty ? packer.name[0] : "?",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Name & Status
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(packer.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white)),
                              if (isAssignedHere)
                                const Text("ATIVO NESTA ESTAÇÃO",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        // Action Icon
                        Icon(
                          isAssignedHere
                              ? Icons.check_circle
                              : Icons.add_circle_outline,
                          color: isAssignedHere
                              ? Colors.blueAccent
                              : Colors.white24,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text("Erro: $e")),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: Colors.white54),
          child: const Text('FECHAR'),
        ),
      ],
    );
  }

  Future<void> _toggleAssignment(
      Station station, Packer packer, bool isAssignedHere) async {
    try {
      if (isAssignedHere) {
        // Remove
        await ref
            .read(stationControllerProvider.notifier)
            .unassignPacker(station.id, packer.id);
      } else {
        // Add
        await ref
            .read(stationControllerProvider.notifier)
            .assignPacker(station.id, packer.id);
      }
      // No Navigator.pop here! The UI Updates via Riverpod watch.
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()), backgroundColor: Colors.redAccent));
      }
    }
  }
}
