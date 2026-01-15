import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/providers.dart';
import '../../../../core/ui/glass_container.dart';
import '../../domain/entity/downtime_record.dart';

class DowntimeHistoryScreen extends ConsumerWidget {
  const DowntimeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(downtimeRepositoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        const GlassContainer(
          padding: EdgeInsets.all(16),
          child: Text(
            "Histórico de Paradas",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        // Content
        Expanded(
          child: GlassContainer(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<List<DowntimeRecord>>(
              future: repo.getDowntimeHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                }

                final data = snapshot.data ?? [];
                if (data.isEmpty) {
                  return const Center(
                      child: Text("Nenhuma parada registrada."));
                }

                return SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text("Estação")),
                      DataColumn(label: Text("Início")),
                      DataColumn(label: Text("Fim")),
                      DataColumn(label: Text("Duração")),
                      DataColumn(label: Text("Motivo")),
                    ],
                    rows: data.map((record) {
                      final startFmt =
                          DateFormat('dd/MM HH:mm').format(record.startTime);
                      final endFmt = record.endTime != null
                          ? DateFormat('HH:mm').format(record.endTime!)
                          : "Em andamento";

                      return DataRow(cells: [
                        DataCell(Text(record.stationId
                            .toString())), // Ideally fetch station name
                        DataCell(Text(startFmt)),
                        DataCell(Text(endFmt)),
                        DataCell(Text("${record.durationMinutes} min")),
                        DataCell(Text(record.reasonStart ?? "-")),
                      ]);
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
