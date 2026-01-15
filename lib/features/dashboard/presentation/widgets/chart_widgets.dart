import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/glass_container.dart';
import '../../domain/dashboard_data.dart';
import 'heartbeat_overlay.dart';

// 2 & 3. Bar Chart (Generic for Station/Packer)
class ProductionBarChart extends StatelessWidget {
  final Map<String, ({double national, double export})> data;
  final Map<String, int>? stationTargets;
  final double? dynamicTarget;

  final double? targetLineValue;

  const ProductionBarChart(
      {super.key,
      required this.data,
      this.stationTargets,
      this.dynamicTarget,
      this.targetLineValue});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
          child: Text('Sem dados', style: TextStyle(color: Colors.white24)));
    }

    // Sort by total value
    final entries = data.entries.toList()
      ..sort((a, b) => (b.value.national + b.value.export)
          .compareTo(a.value.national + a.value.export));

    final maxVal = entries.fold(
        0.0,
        (max, e) => (e.value.national + e.value.export) > max
            ? (e.value.national + e.value.export)
            : max);
    final targetLine = targetLineValue?.toDouble() ?? dynamicTarget ?? 40.0;

    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true, // Fix Clipping
            getTooltipColor: (_) => const Color(0xFF1E293B), // Dark Slate
            tooltipPadding: const EdgeInsets.all(12),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final name = entries[group.x].key;
              final vals = entries[group.x].value;
              final total = vals.national + vals.export;

              String fmt(double v) => v % 1 == 0
                  ? v.toInt().toString()
                  : v.toStringAsFixed(1).replaceAll('.', ',');

              return BarTooltipItem(
                '$name\n',
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: fmt(total),
                    style: const TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '\nNacional: ${fmt(vals.national)}\nExportação: ${fmt(vals.export)}',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60, // Increased space for full names
              getTitlesWidget: (double value, TitleMeta meta) {
                final index = value.toInt();
                if (index < 0 || index >= entries.length) {
                  return const SizedBox.shrink();
                }
                final name = entries[index].key;

                return SideTitleWidget(
                  meta: meta,
                  space: 8,
                  child: Text(name, // Full Name
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 10)),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value % 10 != 0) {
                  return const SizedBox.shrink(); // Show every 10
                }
                return Text(value.toInt().toString(),
                    style:
                        const TextStyle(color: Colors.white30, fontSize: 10));
              },
            ),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) =>
              const FlLine(color: Colors.white10, strokeWidth: 1),
        ),
        barGroups: entries.asMap().entries.map((e) {
          final vals = e.value.value;
          final total = vals.national + vals.export;

          return BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: total.toDouble(),
                width: 20,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                rodStackItems: [
                  BarChartRodStackItem(
                      0, vals.national.toDouble(), Colors.greenAccent),
                  BarChartRodStackItem(vals.national.toDouble(),
                      total.toDouble(), Colors.purpleAccent),
                ],
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxVal < targetLine ? targetLine * 1.1 : maxVal * 1.1,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              )
            ],
          );
        }).toList(),
        maxY: (maxVal > targetLine ? maxVal : targetLine) * 1.2,
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: targetLine,
              color: Colors.orangeAccent.withValues(alpha: 0.8),
              strokeWidth: 2,
              dashArray: [5, 5],
              label: HorizontalLineLabel(
                show: true,
                alignment: Alignment.topRight,
                style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
                labelResolver: (line) =>
                    "META MÍNIMA: ${line.y.toStringAsFixed(0)}", // Use dynamic val
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. Pace Line Chart
// 4. Pace Bar Chart (Previously Line)
class PaceLineChart extends StatelessWidget {
  final Map<int, int> hourlyData;
  final double? targetPerHour;

  const PaceLineChart(
      {super.key, required this.hourlyData, this.targetPerHour});

  @override
  Widget build(BuildContext context) {
    if (hourlyData.isEmpty) {
      return const Center(
          child: Text('Aguardando dados...',
              style: TextStyle(color: Colors.white24)));
    }

    // Window Logic: Now - 1h to Now + 6h
    final nowHour = DateTime.now().hour;
    // Offsets: -1, 0, 1, 2, 3, 4, 5 (Total 7 bars)
    final offsets = [-1, 0, 1, 2, 3, 4, 5];

    // Prepare Data Group
    final List<BarChartGroupData> groups = [];
    double maxVal = 0;

    for (int i = 0; i < offsets.length; i++) {
      final offset = offsets[i];
      // Calculate actual hour (handle wrap around 24)
      int h = (nowHour + offset) % 24;
      if (h < 0) {
        h += 24;
      } // Handle negative modulo if any

      final val = hourlyData[h]?.toDouble() ?? 0.0;
      if (val > maxVal) maxVal = val;

      // Color logic: Past/Current = Solid, Future = Faded/Striped?
      // Let's just use Primary Color for all, maybe distinct for Current?
      final isCurrent = offset == 0;
      final color =
          isCurrent ? Colors.cyanAccent : const Color(0xFF00C853); // Green

      groups.add(BarChartGroupData(
        x: i, // Use index 0..6 for X axis positioning
        barRods: [
          BarChartRodData(
            toY: val,
            color: color,
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: (targetPerHour ?? 60) * 1.2, // Visual Cap
              color: Colors.white.withValues(alpha: 0.05),
            ),
          )
        ],
      ));
    }

    final target = targetPerHour ?? 60.0;
    final maxY = (maxVal > target ? maxVal : target) * 1.2;

    return SizedBox(
      height: 200, // Compact fixed height
      child: Stack(
        children: [
          // Layer 1: The Code Chart
          Positioned.fill(
            child: BarChart(BarChartData(
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                      fitInsideHorizontally: true, // Fix clipping
                      fitInsideVertically: true, // Fix clipping
                      getTooltipColor: (_) => const Color(0xFF1E293B),
                      tooltipPadding: const EdgeInsets.all(8),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                            '${rod.toY.toInt()}',
                            const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14));
                      }),
                ),
                titlesData: FlTitlesData(
                    show: true,
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (val, meta) {
                              final index = val.toInt();
                              if (index < 0 || index >= offsets.length) {
                                return const SizedBox.shrink();
                              }

                              final offset = offsets[index];
                              int h = (nowHour + offset) % 24;
                              if (h < 0) {
                                h += 24;
                              }

                              final isCurrent = offset == 0;

                              return SideTitleWidget(
                                  meta: meta,
                                  space: 8,
                                  child: Text("${h}h",
                                      style: TextStyle(
                                          color: isCurrent
                                              ? Colors.white
                                              : Colors.white54,
                                          fontWeight: isCurrent
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 10)));
                            }))),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) =>
                      const FlLine(color: Colors.white10, strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                barGroups: groups,
                maxY: maxY,
                extraLinesData: ExtraLinesData(horizontalLines: [
                  HorizontalLine(
                      y: target,
                      color: Colors.orangeAccent.withValues(alpha: 0.8),
                      strokeWidth: 2,
                      dashArray: [5, 5],
                      label: HorizontalLineLabel(
                          show: true,
                          alignment: Alignment.topRight,
                          style: const TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                          labelResolver: (l) => "Meta: ${l.y.toInt()}"))
                ]))),
          ),

          // Layer 2: The Heartbeat Overlay (ECG Effect)
          const Positioned.fill(
            child: IgnorePointer(
              child: HeartbeatOverlay(),
            ),
          ),
        ],
      ),
    );
  }
}

// 11. Market Split Pie Chart
// 11. Market Split Pie Chart
class MarketSplitPieChart extends StatefulWidget {
  final int national;
  final int export;

  const MarketSplitPieChart(
      {super.key, required this.national, required this.export});

  @override
  State<MarketSplitPieChart> createState() => _MarketSplitPieChartState();
}

class _MarketSplitPieChartState extends State<MarketSplitPieChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final total = widget.national + widget.export;
    if (total == 0) {
      return const Center(
          child: Text('Sem produção', style: TextStyle(color: Colors.white24)));
    }

    final natPct = ((widget.national / total) * 100).toStringAsFixed(0);
    final expPct = ((widget.export / total) * 100).toStringAsFixed(0);

    return LayoutBuilder(builder: (context, constraints) {
      final isVerySmall = constraints.maxWidth < 200;

      return Row(
        children: [
          // CHART
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          _touchedIndex = -1;
                          return;
                        }
                        _touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  sectionsSpace: 4,
                  centerSpaceRadius: isVerySmall ? 20 : 30, // Responsive Donut
                  startDegreeOffset: -90,
                  sections: [
                    PieChartSectionData(
                      color: const Color(0xFF00C853),
                      value: widget.national.toDouble(),
                      title: "$natPct%",
                      radius: _touchedIndex == 0
                          ? 80
                          : (isVerySmall ? 40 : 70), // Interactive Radius
                      titleStyle: TextStyle(
                          fontSize:
                              _touchedIndex == 0 ? 20 : (isVerySmall ? 10 : 16),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: const [
                            Shadow(color: Colors.black45, blurRadius: 2)
                          ]),
                      showTitle: widget.national > 0, // Only show if valid
                    ),
                    PieChartSectionData(
                      color: Colors.purpleAccent,
                      value: widget.export.toDouble(),
                      title: "$expPct%",
                      radius: _touchedIndex == 1
                          ? 80
                          : (isVerySmall ? 40 : 70), // Interactive Radius
                      titleStyle: TextStyle(
                          fontSize:
                              _touchedIndex == 1 ? 20 : (isVerySmall ? 10 : 16),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: const [
                            Shadow(color: Colors.black45, blurRadius: 2)
                          ]),
                      showTitle: widget.export > 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // LEGEND
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              // Fix Overflow
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem(
                      const Color(0xFF00C853), "Nacional", widget.national, 0),
                  const SizedBox(height: 12),
                  _buildLegendItem(
                      Colors.purpleAccent, "Exportação", widget.export, 1),
                ],
              ),
            ),
          )
        ],
      );
    });
  }

  Widget _buildLegendItem(Color color, String label, int value, int index) {
    final isTouched = index == _touchedIndex;
    return GestureDetector(
      onTapDown: (_) => setState(() => _touchedIndex = index),
      onTapCancel: () => setState(() => _touchedIndex = -1),
      onTapUp: (_) => setState(() => _touchedIndex = -1),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isTouched
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          color: isTouched ? Colors.white : Colors.white70,
                          fontSize: 12),
                      overflow: TextOverflow.ellipsis),
                  Text(value.toString(),
                      style: TextStyle(
                          color: isTouched ? color : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 5. Super Pace Widget (Speedometer + Chart)
class PaceDashboardWidget extends StatefulWidget {
  final DashboardData data;

  const PaceDashboardWidget({super.key, required this.data});

  @override
  State<PaceDashboardWidget> createState() => _PaceDashboardWidgetState();
}

class _PaceDashboardWidgetState extends State<PaceDashboardWidget> {
  Color _getStatusColor(
      double current, double targetCurrent, double? targetIdeal) {
    // 1. If we have an explicit "Ideal Pace" required to finish the shift:
    if (targetIdeal != null && targetIdeal > 0) {
      // Simple Compare: Are we above the ideal?
      if (current >= targetIdeal) return Colors.greenAccent;
      // If we are slightly below (90%)
      if (current >= targetIdeal * 0.9) return Colors.yellowAccent;
      // Else failing
      return Colors.redAccent;
    }

    // 2. Fallback to original "Target Hourly" (Static)
    if (targetCurrent == 0) return Colors.greenAccent;
    final pct = current / targetCurrent;
    if (pct < 0.60) return Colors.redAccent;
    if (pct < 0.80) return Colors.orangeAccent;
    if (pct < 0.95) return Colors.yellowAccent;
    if (pct <= 1.15) return Colors.greenAccent;
    return Colors.cyanAccent;
  }

  @override
  Widget build(BuildContext context) {
    // 1. Calculate Metrics
    final targetHourly = widget.data.targetGoal / 8.8; // ~68
    final currentPace = widget.data.currentPacePerHour ?? 0.0;
    final requiredPace = widget.data.requiredPacePerHour;

    final statusColor =
        _getStatusColor(currentPace, targetHourly, requiredPace);

    // 2. Prepare Chart Data
    // We want a live line chart of hourly pace
    // Map hourlyProduction (which is count per hour) directly?
    // Or accumulated? "Hourly Evolution of Pace". Assuming just count per hour for now.
    final hourlyData = widget.data.hourlyProduction;

    // Filter to "Production Day" range (e.g. 06h to 05h next day)
    // Actually the map is already 0-23. The sort handles 0..23.
    // Ideally we want to show the sequence 06..23..00..05
    // But let's just use what we have, it's a map 0-23.
    // To show "Evolution", we probably want to sort by "Shift Time".
    // Shift Start = 6.

    // We want to re-order so 6 is first.
    final shiftSpots = <FlSpot>[];
    for (int i = 0; i < 24; i++) {
      final h = (6 + i) % 24;
      final count = hourlyData[h] ?? 0;
      shiftSpots.add(FlSpot(
          i.toDouble(), count.toDouble())); // X is 0..23 (Shift Hour Index)
    }

    return LayoutBuilder(builder: (context, constraints) {
      // Fixed Height Container
      return SizedBox(
        height: 220, // Increased height
        child: GlassContainer(
            padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 12,
                bottom: 20), // Added bottom padding
            borderRadius: BorderRadius.circular(16),
            opacity: 0.1,
            child: Row(children: [
              // LEFT: Digital Speedometer (Fixed Width)
              SizedBox(
                width: 200,
                child:
                    _buildSpeedometer(currentPace, targetHourly, statusColor),
              ),

              const SizedBox(width: 16),

              // RIGHT: Monitoring Chart (60%)
              Expanded(
                flex: 3,
                child: _buildChartSection(shiftSpots, statusColor),
              )
            ])),
      );
    });
  }

  Widget _buildSpeedometer(double current, double target, Color color) {
    final pct = (target > 0) ? (current / target).clamp(0.0, 1.0) : 0.0;

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Stack(alignment: Alignment.center, children: [
          // Background Circle
          SizedBox(
              width: 110,
              height: 110,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 8,
                valueColor:
                    AlwaysStoppedAnimation(Colors.grey.withValues(alpha: 0.2)),
              )),
          // Value Arc
          SizedBox(
              width: 110,
              height: 110,
              child: CircularProgressIndicator(
                value: pct.toDouble(),
                strokeWidth: 8,
                strokeCap: StrokeCap.round,
                valueColor: AlwaysStoppedAnimation(color),
              )),
          // Central Value
          Column(mainAxisSize: MainAxisSize.min, children: [
            Text(current.toInt().toString(),
                style: TextStyle(
                    fontSize: 32, // Large
                    fontWeight: FontWeight.bold,
                    color: color,
                    shadows: [
                      Shadow(
                          color: color.withValues(alpha: 0.5), blurRadius: 10)
                    ])),
          ])
        ]),
      ),
      const SizedBox(height: 8),
      const Text("Peças/hora",
          style: TextStyle(color: Colors.white70, fontSize: 12))
    ]);
  }

  Widget _buildChartSection(List<FlSpot> spots, Color color) {
    return Stack(children: [
      // CHART
      LineChart(LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipColor: (_) => const Color(0xFF1E293B),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                return LineTooltipItem(
                  '${touchedSpot.y.toInt()}',
                  TextStyle(
                    color: touchedSpot.bar.color ?? Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              }).toList();
            },
          ),
        ),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
            show: true,
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    interval: 6, // Show every 6 hours (0, 6, 12, 18)
                    getTitlesWidget: (val, meta) {
                      final index = val.toInt();
                      if (index % 4 != 0) {
                        return const SizedBox.shrink();
                      } // Show every 4th point?
                      // Actually index 0 = 06:00.
                      final h = (6 + index) % 24;
                      return SideTitleWidget(
                          meta: meta,
                          space: 4,
                          child: Text("${h}h",
                              style: const TextStyle(
                                  color: Colors.white30, fontSize: 10)));
                    }))),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 4,
              color: color,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.3),
                      color.withValues(alpha: 0.0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ))),

          // 2. IDEAL LINE (Dashed)
          if (widget.data.requiredPacePerHour != null &&
              widget.data.requiredPacePerHour! > 0)
            LineChartBarData(
              spots: [
                // From Start (0) to End (23) of chart? Or just current to end?
                // Simple approach: Horizontal line across the whole shift view
                const FlSpot(
                    0, 0), // Dummy start (will be replaced by map below)
                const FlSpot(23, 0),
              ]
                  .map((_) {
                    // We want a horizontal line at Y = requiredPace
                    // But allow it to be drawn across all X (0..23)
                    return [
                      for (int i = 0; i < 24; i++)
                        FlSpot(i.toDouble(), widget.data.requiredPacePerHour!)
                    ];
                  })
                  .expand((i) => i)
                  .toList(),

              isCurved: false,
              barWidth: 2,
              color: Colors.white.withValues(alpha: 0.5),
              dashArray: [5, 5], // Dashed Pattern
              dotData: const FlDotData(show: false),
            ),
        ],
        // Min/Max to stabilize chart
        minY: 0,
        maxY: (spots.isEmpty) ? 100 : null, // Auto max otherwise
      )),

      // HEARTBEAT OVERLAY
      const Positioned.fill(child: IgnorePointer(child: HeartbeatOverlay()))
    ]);
  }
}
