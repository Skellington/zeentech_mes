import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gap/gap.dart';

import '../../../../core/ui/animated_grid_background.dart';

import '../../../../core/ui/glass_container.dart';
import '../../../production/presentation/controller/production_controller.dart';
import '../../domain/dashboard_data.dart';
import '../controller/dashboard_controller.dart';

import '../dialog/report_preview_dialog.dart';
import '../widgets/chart_widgets.dart';

import '../widgets/custom_date_picker_filter.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/part_type_breakdown_widget.dart';
import '../widgets/summary_widgets.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(dashboardFilterControllerProvider);
    final dashboardAsync = ref.watch(dashboardDataProvider);
    // Use first date for monthly context, or today if empty
    // Fix: Use stable date (start of month) to prevent infinite loop
    final currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    final referenceDate =
        filter.dateRange != null ? filter.dateRange!.start : currentMonth;
    final monthlyAsync = ref.watch(monthlyStatsProvider(referenceDate));

    // Date Label Logic - Moved to DateFilterButton Widget

    // Global Reactivity: Refresh dashboard when production is added
    ref.listen(productionControllerProvider, (_, next) {
      if (next is AsyncData) {
        ref.invalidate(dashboardDataProvider);
        ref.invalidate(monthlyStatsProvider);
      }
    });

    return AnimatedGridBackground(
      child: Column(
        children: [
          // 1. Filter Bar
          _buildResponsiveHeader(context, ref, filter),

          const Gap(16),

          // 2. Metrics Grid (Responsive)
          Expanded(
            child: dashboardAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                  child: Text('Erro: $err',
                      style: const TextStyle(color: Colors.red))),
              data: (data) {
                // --- WIDGET DEFINITIONS ---
                final widgetTotal = DashboardCard(
                  title: 'Total Produzido',
                  child: TotalProductionCard(
                    totalItems: data.totalItems,
                    totalVolume: data.totalVolume,
                  ),
                );

                final widgetGoal = DashboardCard(
                  title: 'Meta do Turno',
                  child: GoalProgressWidget(
                    current: data.totalItems,
                    target: data.targetGoal,
                    pace: data.currentPacePerHour,
                  ),
                );

                final widgetPace = DashboardCard(
                  title: 'Ritmo (Peças/Hora)',
                  child: PaceDashboardWidget(data: data),
                );

                final widgetPartType =
                    PartTypeBreakdownWidget(stats: data.partTypeStats);

                final widgetMarket = DashboardCard(
                  title: 'Nacional vs Exportação',
                  child: MarketSplitPieChart(
                    national: data.nationalCount,
                    export: data.exportCount,
                  ),
                );

                final widgetRankStation = DashboardCard(
                  title: 'Ranking Estações (Dia)',
                  child: RankingListWidget(
                      data: Map<String, num>.from(data.productionByStation
                          .map((k, v) => MapEntry(k, v.national + v.export))),
                      title: ''),
                );

                final widgetRankPacker = DashboardCard(
                  title: 'Ranking Embaladores (Dia)',
                  child: RankingListWidget(
                      data: Map<String, num>.from(data.productionByPacker
                          .map((k, v) => MapEntry(k, v.national + v.export))),
                      title: '',
                      isPacker: true),
                );

                final widgetRankStationMonth = DashboardCard(
                  title: 'Top 3 Mês (Estações)',
                  titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                  child: monthlyAsync.when(
                    data: (m) => m.stations.isEmpty
                        ? const Center(
                            child: Text("Sem dados este mês",
                                style: TextStyle(color: Colors.white38)))
                        : RankingListWidget(
                            data: Map<String, num>.from(m.stations), title: ''),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const Center(
                        child: Text('Indisponível',
                            style: TextStyle(color: Colors.white24))),
                  ),
                );

                final widgetRankPackerMonth = DashboardCard(
                  title: 'Top 3 Mês (Embaladores)',
                  titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                  child: monthlyAsync.when(
                    data: (m) => m.packers.isEmpty
                        ? const Center(
                            child: Text("Sem dados este mês",
                                style: TextStyle(color: Colors.white38)))
                        : RankingListWidget(
                            data: Map<String, num>.from(m.packers),
                            title: '',
                            isPacker: true),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const Center(
                        child: Text('Indisponível',
                            style: TextStyle(color: Colors.white24))),
                  ),
                );

                return LayoutBuilder(builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 1100;

                  if (!isDesktop) {
                    // --- MOBILE / TABLET LAYOUT (Vertical Stack) ---
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 240, child: widgetTotal),
                            const Gap(16),
                            SizedBox(height: 240, child: widgetGoal),
                            const Gap(16),
                            SizedBox(height: 260, child: widgetPace),
                            const Gap(16),
                            SizedBox(height: 400, child: widgetPartType),
                            const Gap(16),
                            SizedBox(height: 300, child: widgetMarket),
                            const Gap(16),
                            SizedBox(height: 300, child: widgetRankStation),
                            const Gap(16),
                            SizedBox(height: 300, child: widgetRankPacker),
                            const Gap(16),
                            SizedBox(
                                height: 300, child: widgetRankStationMonth),
                            const Gap(16),
                            SizedBox(height: 300, child: widgetRankPackerMonth),
                            const Gap(32),
                          ],
                        ),
                      ),
                    );
                  }

                  // --- DESKTOP LAYOUT (Grid) ---
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Top Row: Total | Goal | Pace
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 280,
                                  child: widgetTotal,
                                ),
                              ),
                              const Gap(16),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 280,
                                  child: widgetGoal,
                                ),
                              ),
                              const Gap(16),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 280,
                                  child: widgetPace,
                                ),
                              ),
                            ],
                          ),

                          const Gap(20),

                          // 2. Charts Row: Part Type | Market Split
                          SizedBox(
                            height: 520,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: widgetPartType,
                                ),
                                const Gap(20),
                                Expanded(
                                  flex: 2,
                                  child: widgetMarket,
                                ),
                              ],
                            ),
                          ),

                          const Gap(20),

                          // 3. Rankings Group
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 300,
                                      child: widgetRankStation,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: SizedBox(
                                      height: 300,
                                      child: widgetRankPacker,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(16),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 300,
                                      child: widgetRankStationMonth,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: SizedBox(
                                      height: 300,
                                      child: widgetRankPackerMonth,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const Gap(32),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfButton(
      BuildContext context, WidgetRef ref, DashboardFilter filter) {
    return SizedBox(
      height: 36,
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => ReportPreviewDialog(filter: filter),
          );
        },
        icon: const Icon(Icons.picture_as_pdf, size: 18),
        label: const Text("Relatório"),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E293B), // Dark Slate
          foregroundColor: Colors.cyanAccent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.white12),
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveHeader(
      BuildContext context, WidgetRef ref, DashboardFilter filter) {
    final isDesktop = MediaQuery.of(context).size.width >= 1100;

    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      opacity: 0.15,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Dashboard de Produção',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isDesktop ? 24 : 20),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isDesktop) ...[
            const Spacer(),
            const DateFilterButton(),
            const SizedBox(width: 12),
            _buildPdfButton(context, ref, filter),
            const SizedBox(width: 12),
            _buildShiftSelector(context, ref, filter),
          ] else ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _showMobileMenu(context, ref, filter),
              icon: const Icon(Icons.menu, color: Colors.white),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            )
          ]
        ],
      ),
    );
  }

  void _showMobileMenu(
      BuildContext context, WidgetRef ref, DashboardFilter filter) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: GlassContainer(
          opacity: 0.1,
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Configuração",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white70),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    style: IconButton.styleFrom(
                      iconSize: 20,
                      backgroundColor: Colors.white10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
              const Gap(24),
              const DateFilterButton(),
              const Gap(16),
              _buildPdfButton(context, ref, filter),
              const Gap(16),
              _buildMobileShiftSelector(context, ref, filter),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShiftSelector(
      BuildContext context, WidgetRef ref, DashboardFilter filter) {
    return SizedBox(
      height: 36,
      child: SegmentedButton<DashboardShiftFilter>(
        segments: const [
          ButtonSegment(value: DashboardShiftFilter.all, label: Text('Hoje')),
          ButtonSegment(
              value: DashboardShiftFilter.first, label: Text('1º Turno')),
          ButtonSegment(
              value: DashboardShiftFilter.second, label: Text('2º Turno')),
        ],
        selected: {filter.shift},
        onSelectionChanged: (Set<DashboardShiftFilter> newSelection) {
          ref
              .read(dashboardFilterControllerProvider.notifier)
              .setShift(newSelection.first);
        },
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).colorScheme.primary;
            }
            return null;
          }),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ),
    );
  }

  Widget _buildMobileShiftSelector(
      BuildContext context, WidgetRef ref, DashboardFilter filter) {
    return SizedBox(
      height: 48, // Larger for mobile touch targets
      child: SegmentedButton<DashboardShiftFilter>(
        segments: const [
          ButtonSegment(value: DashboardShiftFilter.all, label: Text('Hoje')),
          ButtonSegment(
              value: DashboardShiftFilter.first, label: Text('1º Turno')),
          ButtonSegment(
              value: DashboardShiftFilter.second, label: Text('2º Turno')),
        ],
        selected: {filter.shift},
        onSelectionChanged: (Set<DashboardShiftFilter> newSelection) {
          // 1. Update State
          ref
              .read(dashboardFilterControllerProvider.notifier)
              .setShift(newSelection.first);

          // 2. Close Modal
          Navigator.pop(context);
        },
        style: ButtonStyle(
          visualDensity: VisualDensity.standard, // Standard density for mobile
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).colorScheme.primary;
            }
            return null;
          }),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ),
    );
  }
}
