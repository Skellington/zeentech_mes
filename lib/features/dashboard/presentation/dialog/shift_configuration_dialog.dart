import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../core/database/local_database.dart';
import '../../../../core/providers.dart';
import '../../../../core/services/shift_service.dart';
import '../controller/dashboard_controller.dart';

class ShiftConfigurationDialog extends ConsumerStatefulWidget {
  final int currentManual;
  final int currentGoal;
  final int currentMinGoal;
  final DashboardFilter filter;

  const ShiftConfigurationDialog({
    super.key,
    required this.currentManual,
    required this.currentGoal,
    required this.currentMinGoal,
    required this.filter,
  });

  @override
  ConsumerState<ShiftConfigurationDialog> createState() =>
      _ShiftConfigurationDialogState();
}

class _ShiftConfigurationDialogState
    extends ConsumerState<ShiftConfigurationDialog> {
  Map<int, int> _parttypeCounts = {};
  List<PartType> _partTypes = [];

  late TextEditingController _goalController;
  late TextEditingController _minGoalController;

  // Internal state for validation
  late int _manualVal;
  bool _isShiftLocked = false;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _manualVal = widget.currentManual;

    _goalController = TextEditingController(
        text: widget.currentGoal > 0 ? widget.currentGoal.toString() : "");
    _minGoalController = TextEditingController(
        text:
            widget.currentMinGoal > 0 ? widget.currentMinGoal.toString() : "");

    _loadData();
  }

  // ... (dispose)

  Future<void> _loadData() async {
    try {
      // Load Part Types
      final types =
          await ref.read(partTypeRepositoryProvider).watchPartTypes().first;

      // Construct Config ID
      // Use ShiftService for date calculation if filter.dateRange is null (Today)
      final date = widget.filter.dateRange != null
          ? widget.filter.dateRange!.start
          : ShiftService().getProductionDate(DateTime.now());

      final startOfDay = DateTime(date.year, date.month, date.day);
      final configId =
          "${startOfDay.year}${startOfDay.month.toString().padLeft(2, '0')}${startOfDay.day.toString().padLeft(2, '0')}";

      // Load Detailed Counts
      final quantities = await ref
          .read(productionRepositoryProvider)
          .getShift1Productions(configId);

      // Load Config Data (Goals) if zeroes passed (Self-Fetch Mode)
      // Always fetch to be sure we have latest
      final config = await ref
          .read(productionRepositoryProvider)
          .getShiftConfiguration(startOfDay);

      if (mounted) {
        setState(() {
          _partTypes = types;
          _parttypeCounts = quantities;

          if (config != null) {
            _goalController.text = config.dailyGoal.toString();
            _minGoalController.text = config.minStationGoal.toString();
            _manualVal = config.shift1ManualProduction;

            // LOCK LOGIC: If manual production > 0, lock it.
            // But only if we are editing "Today" (implicitly) or if strictly required.
            // The requirement says: "If a configuration ALREADY exists for this date AND shift1ManualProduction > 0"
            if (_manualVal > 0) {
              _isShiftLocked = true;
            }
          } else {
            // If defaults needed
            if (_goalController.text.isEmpty) _goalController.text = "600";
            if (_minGoalController.text.isEmpty) _minGoalController.text = "40";
          }

          // If we have detailed counts, update manualVal to match sum automatically
          if (_parttypeCounts.isNotEmpty) {
            _manualVal =
                _parttypeCounts.values.fold(0, (sum, val) => sum + val);
          }

          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _updateTotal() {
    final total = _parttypeCounts.values.fold(0, (sum, val) => sum + val);
    setState(() {
      _manualVal = total;
    });
  }

  Future<void> _save() async {
    // Save Detail Records
    final filter = ref.watch(dashboardFilterControllerProvider);

    // Use proper production date
    final date = filter.dateRange != null
        ? filter.dateRange!.start
        : ShiftService().getProductionDate(DateTime.now());

    final startOfDay = DateTime(date.year, date.month, date.day);
    final configId =
        "${startOfDay.year}${startOfDay.month.toString().padLeft(2, '0')}${startOfDay.day.toString().padLeft(2, '0')}";

    await ref
        .read(productionRepositoryProvider)
        .updateShift1Productions(configId, _parttypeCounts);

    // Save Config (Total & Goals)
    final dailyGoal = int.tryParse(_goalController.text) ?? 600;
    final minGoal = int.tryParse(_minGoalController.text) ?? 40;

    await ref
        .read(dashboardControllerProvider(widget.filter).notifier)
        .updateShiftConfig(
          shift1Manual: _manualVal,
          dailyGoal: dailyGoal,
          minStationGoal: minGoal,
        );

    // Force Dashboard Refresh
    ref.invalidate(dashboardDataProvider);
    ref.invalidate(monthlyStatsProvider);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () =>
            Navigator.pop(context),
      },
      child: Focus(
        autofocus: true,
        child: DefaultTabController(
          length: 2,
          child: AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            surfaceTintColor: Colors.transparent,
            title: Row(
              children: [
                const Expanded(
                  child: Text("Configuração do Turno",
                      style: TextStyle(color: Colors.white)),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white54),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: 500,
              height: 500,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        const TabBar(
                          labelColor: Colors.blueAccent,
                          unselectedLabelColor: Colors.white54,
                          indicatorColor: Colors.blueAccent,
                          tabs: [
                            Tab(text: "Parâmetros Gerais"),
                            Tab(text: "Lançamento 1º Turno"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // TAB 1: General Goals
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Metas de Produção",
                                      style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.7),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    const Gap(16),
                                    TextFormField(
                                      controller: _goalController,
                                      keyboardType: TextInputType.number,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        labelText: "Meta Diária",
                                        labelStyle:
                                            TextStyle(color: Colors.white70),
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white24)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent)),
                                        suffixText: "peças",
                                        suffixStyle:
                                            TextStyle(color: Colors.white54),
                                      ),
                                    ),
                                    const Gap(16),
                                    TextFormField(
                                      controller: _minGoalController,
                                      keyboardType: TextInputType.number,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        labelText: "Meta Mínima (Por Estação)",
                                        labelStyle:
                                            TextStyle(color: Colors.white70),
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white24)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent)),
                                        suffixText: "peças",
                                        suffixStyle:
                                            TextStyle(color: Colors.white54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // TAB 2: Shift 1 Inputs
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_isShiftLocked)
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        margin:
                                            const EdgeInsets.only(bottom: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.orange
                                              .withValues(alpha: 0.1),
                                          border: Border.all(
                                              color: Colors.orangeAccent
                                                  .withValues(alpha: 0.5)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Row(
                                          children: [
                                            Icon(Icons.lock,
                                                color: Colors.orangeAccent),
                                            Gap(12),
                                            Expanded(
                                              child: Text(
                                                "Registro do 1º Turno já realizado para hoje. Edição bloqueada.",
                                                style: TextStyle(
                                                    color: Colors.orangeAccent,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    Text(
                                      "Produção Manual (1º Turno)",
                                      style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.7),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    const Gap(16),
                                    if (_partTypes.isEmpty)
                                      const Center(
                                        child: Text(
                                          "Nenhum tipo de peça cadastrado.",
                                          style: TextStyle(
                                              color: Colors.orangeAccent),
                                        ),
                                      )
                                    else
                                      Expanded(
                                        child: ListView(
                                          children: _partTypes
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            final index = entry.key;
                                            final type = entry.value;
                                            final isLast =
                                                index == _partTypes.length - 1;

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 12.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(type.name,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white))),
                                                  SizedBox(
                                                    width: 120,
                                                    child: TextFormField(
                                                      key: ValueKey(
                                                          "input_${type.id}"),
                                                      initialValue:
                                                          (_parttypeCounts[type
                                                                      .id] ??
                                                                  0)
                                                              .toString(),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      enabled:
                                                          !_isShiftLocked, // Disable input
                                                      style: TextStyle(
                                                          color: _isShiftLocked
                                                              ? Colors.white54
                                                              : Colors.white),
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "Qtd",
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white70),
                                                        border:
                                                            const OutlineInputBorder(),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .white24)),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .blueAccent)),
                                                        isDense: true,
                                                        filled: _isShiftLocked,
                                                        fillColor:
                                                            Colors.black12,
                                                      ),
                                                      onChanged: (v) {
                                                        final val =
                                                            int.tryParse(v) ??
                                                                0;
                                                        _parttypeCounts[
                                                            type.id] = val;
                                                        _updateTotal();
                                                      },
                                                      textInputAction: isLast
                                                          ? TextInputAction.done
                                                          : TextInputAction
                                                              .next,
                                                      onFieldSubmitted: (_) {
                                                        if (isLast &&
                                                            !_isShiftLocked) {
                                                          _save();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    const Gap(16),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.blueAccent
                                                .withValues(alpha: 0.3)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Total Calculado:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                          Text("$_manualVal",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blueAccent)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
