import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/ui/glass_container.dart';
import '../../domain/dashboard_data.dart';

class PartTypeBreakdownWidget extends StatefulWidget {
  final List<PartTypeStat> stats;

  const PartTypeBreakdownWidget({super.key, required this.stats});

  @override
  State<PartTypeBreakdownWidget> createState() =>
      _PartTypeBreakdownWidgetState();
}

class _PartTypeBreakdownWidgetState extends State<PartTypeBreakdownWidget> {
  int _touchedIndex = -1;

  // WCAG Compliant Palette
  static const _accessiblePalette = [
    Color(0xFF2563EB), // Blue
    Color(0xFFDC2626), // Red
    Color(0xFFD97706), // Amber
    Color(0xFF7C3AED), // Purple
    Color(0xFF059669), // Emerald
    Color(0xFFDB2777), // Pink
    Color(0xFF4B5563), // Grey
  ];

  Color _getColor(int index) {
    return _accessiblePalette[index % _accessiblePalette.length];
  }

  @override
  Widget build(BuildContext context) {
    // 1. Sempre renderize o Container base para manter a consistência do grid
    return GlassContainer(
      opacity: 0.1,
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Sempre visível)
          Row(
            children: [
              const Icon(Icons.pie_chart, color: Colors.blueAccent, size: 20),
              const Gap(8),
              Text(
                "Produção por Tipo de Peça",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Gap(8),

          // 2. Decisão de Conteúdo: Dados vs Vazio
          if (widget.stats.isEmpty)
            _buildEmptyState()
          else
            _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const SizedBox(
      height: 200, // Altura mínima para não colapsar o layout
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.data_usage, color: Colors.white24, size: 48),
            Gap(8),
            Text(
              "Nenhum dado registrado hoje",
              style: TextStyle(color: Colors.white38, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final totalProduction =
        widget.stats.fold(0, (sum, item) => sum + item.total);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Chart (Larger)
            Expanded(
              flex: 5,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: _buildChart(totalProduction),
                ),
              ),
            ),
            const Gap(8),
            const VerticalDivider(color: Colors.white10),
            const Gap(8),
            // Right: Table
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: _buildTable(context),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChart(int total) {
    final sorted = List<PartTypeStat>.from(widget.stats);

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 30, // Slightly smaller hole for larger sections
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                _touchedIndex = -1;
                return;
              }
              _touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        sections: sorted.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final color = _getColor(index);

          final isTouched = index == _touchedIndex;
          final double radius = isTouched ? 80.0 : 70.0; // Increased radius

          final double pctVal = total > 0 ? (item.total / total) * 100 : 0;
          final String pctText = pctVal.toStringAsFixed(0);
          final bool showLabel = pctVal >= 5;

          return PieChartSectionData(
            color: color,
            value: item.total.toDouble(),
            title: showLabel ? "$pctText%" : "",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: isTouched ? 20 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: const [Shadow(color: Colors.black45, blurRadius: 2)],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        const Row(
          children: [
            Expanded(
                flex: 3,
                child: Text("Tipo",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 14))),
            Expanded(
                flex: 2,
                child: Text("Total",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14))),
          ],
        ),
        const Divider(color: Colors.white10),
        // Rows
        ...widget.stats.asMap().entries.map((entry) {
          final index = entry.key;
          final stat = entry.value;
          final color = _getColor(index);
          final isTouched = index == _touchedIndex;

          final bgColor = isTouched
              ? Colors.white.withValues(alpha: 0.1)
              : (index % 2 == 0 ? Colors.transparent : const Color(0xFF27272A));

          return GestureDetector(
            onTapDown: (_) => setState(() => _touchedIndex = index),
            onTapCancel: () => setState(() => _touchedIndex = -1),
            onTapUp: (_) => setState(() => _touchedIndex = -1),
            child: Container(
              color: bgColor,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: color, shape: BoxShape.circle)),
                        const Gap(12),
                        Flexible(
                          child: Text(stat.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:
                                      isTouched ? Colors.white : Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(stat.total.toString(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14))),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
