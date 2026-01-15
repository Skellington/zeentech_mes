import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers.dart';
import '../../../dashboard/domain/dashboard_data.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../../../dashboard/presentation/dialog/shift_configuration_dialog.dart';
import '../dialog/part_type_manager_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Configurações",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              _buildSectionHeader("Produção"),
              _buildSettingTile(
                context,
                icon: Icons.tune,
                title: "Configuração de Turno",
                subtitle: "Definir metas diárias e produção manual do 1º Turno",
                onTap: () async {
                  ref
                      .read(dashboardFilterControllerProvider.notifier)
                      .clearDateFilter(); // Reset to Today
                  const filter = DashboardFilter(
                    dateRange: null,
                    shift: DashboardShiftFilter.all,
                  );

                  await showDialog(
                    context: context,
                    builder: (context) => const ShiftConfigurationDialog(
                      currentManual: 0,
                      currentGoal: 0,
                      currentMinGoal: 0,
                      filter: filter,
                    ),
                  );
                },
              ),
              _buildSettingTile(
                context,
                icon: Icons.category,
                title: "Gerenciar Tipos de Peça",
                subtitle: "Adicionar, editar ou remover tipos de peças",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const PartTypeManagerDialog(),
                  );
                },
              ),
            ],
          ),
        ),
        _buildDangerZone(context, ref),
      ],
    );
  }

  Widget _buildDangerZone(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.white24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            "ZONA DE PERIGO",
            style: TextStyle(
              color: Colors.redAccent.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Card(
            color: Colors.red.withValues(alpha: 0.1),
            margin: const EdgeInsets.only(bottom: 24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    const Icon(Icons.delete_forever, color: Colors.redAccent),
              ),
              title: const Text("Zerar Banco de Dados",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text("Apagar todos os registros de produção",
                  style: TextStyle(color: Colors.white70)),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Tem certeza?"),
                    content: const Text(
                        "Isso apagará TODO o histórico de produção e paradas. Essa ação não pode ser desfeita."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.redAccent),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Apagar Tudo"),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await ref.read(localDatabaseProvider).clearAllData();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Dados apagados com sucesso!"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                  // Force refresh dashboard just in case
                  ref.invalidate(dashboardControllerProvider);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
// ... rest of file (headers logic) ...

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.5),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildSettingTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Card(
      color: Colors.white.withValues(alpha: 0.05),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blueAccent),
        ),
        title: Text(title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: Colors.white54),
        onTap: onTap,
      ),
    );
  }
}
