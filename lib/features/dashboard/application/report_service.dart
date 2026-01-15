import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/providers.dart';
import '../data/statistics_service.dart';
import '../domain/dashboard_data.dart';
import '../presentation/controller/dashboard_controller.dart';

final reportServiceProvider = Provider<ReportService>((ref) {
  final stats = ref.watch(statisticsServiceProvider);
  return ReportService(stats);
});

class ReportService {
  final StatisticsService _stats;

  ReportService(this._stats);

  static String generateISOFilename() {
    final now = DateTime.now();
    return 'producao_volumoso_${DateFormat('yyyyMMdd-HHmmss').format(now)}.pdf';
  }

  Future<Uint8List> generateReport(
      DashboardFilter filter, PdfPageFormat format) async {
    // 1. Fetch Data

    // Determine dates from filter
    final List<DateTime> dates = [];
    DateTime start;
    DateTime end;

    if (filter.specificDates.isNotEmpty) {
      dates.addAll(filter.specificDates);
      dates.sort();
      start = dates.first;
      end = dates.last;
    } else if (filter.dateRange != null) {
      start = filter.dateRange!.start;
      end = filter.dateRange!.end;
      for (var d = start;
          d.isBefore(end) || d.isAtSameMomentAs(end);
          d = d.add(const Duration(days: 1))) {
        dates.add(d);
      }
    } else {
      // Default to "Today" if empty
      // But we should usually have a filter
      final now = DateTime.now();
      start = now;
      end = now;
      dates.add(now);
    }

    // A. Aggregate Dashboard Data
    // A. Aggregate Dashboard Data
    final dashboardData = await _stats.getDashboardData(filter);

    // B. Daily Evolution is now inside DashboardData
    // No separate fetch needed.

    // 2. Build PDF
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          _buildHeader(start, end, filter),
          pw.SizedBox(height: 20),
          _buildSummary(dashboardData),
          pw.SizedBox(height: 20),
          _buildChartsRow(dashboardData),
          pw.SizedBox(height: 20),
          _buildDowntimeSection(dashboardData),
          pw.SizedBox(height: 20),
          _buildTables(dashboardData),
        ],
        footer: (context) => _buildFooter(context),
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildHeader(DateTime start, DateTime end, DashboardFilter filter) {
    final dateFormat = DateFormat('dd/MM/yy');
    String period;

    if (filter.specificDates.isNotEmpty) {
      if (filter.specificDates.length == 1) {
        period = dateFormat.format(filter.specificDates.first);
      } else {
        period = "${dateFormat.format(start)} ~ ${dateFormat.format(end)}";
      }
    } else if (filter.dateRange != null) {
      period = "${dateFormat.format(start)} ~ ${dateFormat.format(end)}";
    } else {
      period = "Hoje (${dateFormat.format(start)})";
    }

    final shift = filter.shift;
    final shiftLabel = shift == DashboardShiftFilter.all
        ? "Todos os Turnos"
        : (shift == DashboardShiftFilter.first ? "1º Turno" : "2º Turno");

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("RELATÓRIO DE PRODUÇÃO",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 24,
                    color: PdfColors.blueGrey800)),
            pw.Text("Zeentech MES",
                style:
                    const pw.TextStyle(color: PdfColors.grey600, fontSize: 12)),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("Período:",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(period, style: const pw.TextStyle(fontSize: 12)),
            pw.Text(shiftLabel, style: const pw.TextStyle(fontSize: 12)),
            pw.Text(
                "Gerado em: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}",
                style:
                    const pw.TextStyle(fontSize: 10, color: PdfColors.grey500)),
          ],
        )
      ],
    );
  }

  pw.Widget _buildSummary(DashboardData data) {
    final total = data.totalItems;

    // Efficiency (vs Goal)
    // Sum goals from dailyStats if available, else derive?
    // Actually, dailyStats is now a Map<DateTime, ...>. Goal is not explicitly in there, but we have targetGoal in data.
    // Let's rely on data.targetGoal (the daily goal) * active days? OR just use average?
    // The prompt implies we want "Summary".
    // Let's just use data.targetGoal as reference for "Today" or average.
    // But for multiple days, "Efic vs Meta" depends on sum of goals.
    // Simple approach: Use data.targetGoal (which is adjusted for shift) * numDays vs Total.

    final days = data.dailyStats.isNotEmpty ? data.dailyStats.length : 1;
    final totalperiodGoal = data.targetGoal * days; // Approx
    final effVsGoal =
        totalperiodGoal > 0 ? (total / totalperiodGoal) * 100 : 0.0;

    // Real Metrics
    // Net Time = Expected - Downtime
    final downtimeMinutes = data.totalDowntimeMinutes;
    final totalExpectedMinutes = data.totalExpectedDuration.inMinutes;
    final netMinutes = totalExpectedMinutes - downtimeMinutes;
    final netHours = netMinutes / 60.0;

    // Real Efficiency = Items / Net Hours
    final realPace = netHours > 0.1 ? (total / netHours) : 0.0;

    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem("Total Produzido", "$total"),
              _buildSummaryItem(
                  "Efic. vs Meta", "${effVsGoal.toStringAsFixed(1)}%",
                  color: effVsGoal >= 100
                      ? PdfColors.green700
                      : (effVsGoal >= 80
                          ? PdfColors.orange700
                          : PdfColors.red700)),
              _buildSummaryItem("Média Diária",
                  (days > 0 ? total / days : 0).toStringAsFixed(0)),
            ],
          ),
          pw.Divider(color: PdfColors.grey300),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem("Tempo Líquido",
                  "${(netMinutes / 60).floor()}h ${netMinutes % 60}m"),
              _buildSummaryItem("Total Paradas", "$downtimeMinutes min",
                  color: PdfColors.red700),
              _buildSummaryItem("Ritmo Real",
                  "${realPace > 0 ? realPace.toStringAsFixed(0) : '0'} p/h"),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildSummaryItem(String label, String value, {PdfColor? color}) {
    return pw.Column(
      children: [
        pw.Text(label,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
        pw.Text(value,
            style: pw.TextStyle(
                fontSize: 14, // Slightly smaller to fit more
                fontWeight: pw.FontWeight.bold,
                color: color ?? PdfColors.black)),
      ],
    );
  }

  pw.Widget _buildChartsRow(DashboardData data) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Daily Bar Chart
        pw.Expanded(
          flex: 3,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Evolução Diária (Nacional vs Exportação)",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Container(
                height: 200, // Taller
                child: _buildStackedBarChart(data.dailyStats),
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 20),
        // Pie Chart Legend
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Nacional vs Exportação",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              _buildPieStat("Nacional", data.nationalCount, PdfColors.green),
              pw.SizedBox(height: 5),
              _buildPieStat("Exportação", data.exportCount, PdfColors.purple),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildStackedBarChart(
      Map<DateTime, ({int national, int export})> dailyStats) {
    if (dailyStats.isEmpty) return pw.Center(child: pw.Text("Sem dados"));

    final sortedEntries = dailyStats.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    int maxVal = 0;
    for (var e in sortedEntries) {
      final t = e.value.national + e.value.export;
      if (t > maxVal) maxVal = t;
    }

    final yMax = (maxVal > 0 ? maxVal * 1.1 : 100.0).ceil().toDouble();

    return pw.LayoutBuilder(builder: (context, constraints) {
      final w = constraints?.maxWidth ?? 200;
      final h = constraints?.maxHeight ?? 150;

      const marginLeft = 30.0;
      const marginBottom = 30.0; // More space for date labels
      final chartW = w - marginLeft;
      final chartH = h - marginBottom;

      final barWidth = (chartW / sortedEntries.length) * 0.6;

      // Date Format: "12/01\nSeg"
      // Need pt_BR locale initialized or just force custom map if needed.
      // Intl usually needs initialization for locales, assume it's working or use basic.
      // EEEE gives full day name.

      return pw.Stack(
        children: [
          // Axes
          pw.Positioned(
            left: marginLeft,
            top: 0,
            bottom: marginBottom,
            child: pw.Container(width: 1, color: PdfColors.black),
          ),
          pw.Positioned(
            left: marginLeft,
            right: 0,
            bottom: marginBottom,
            child: pw.Container(height: 1, color: PdfColors.black),
          ),

          // Grid lines
          ...[0.0, 0.25, 0.5, 0.75, 1.0].map((pct) {
            final val = (yMax * pct).round();
            final yPos = marginBottom + (chartH * pct);
            return pw.Positioned(
              left: 0,
              bottom: yPos,
              right: 0,
              child: pw.Row(children: [
                pw.SizedBox(
                    width: marginLeft - 5,
                    child: pw.Text("$val",
                        textAlign: pw.TextAlign.right,
                        style: const pw.TextStyle(
                            fontSize: 8, color: PdfColors.grey600))),
                pw.SizedBox(width: 5),
                pw.Expanded(
                    child: pw.Container(height: 0.5, color: PdfColors.grey300)),
              ]),
            );
          }),

          // Bars
          ...sortedEntries.asMap().entries.map((entry) {
            final index = entry.key;
            final date = entry.value.key;
            final stats = entry.value.value;
            final total = stats.national + stats.export;

            final hTotal = (total / yMax) * chartH;
            final hNat = (stats.national / yMax) * chartH;
            final hExp = (stats.export / yMax) *
                chartH; // or hTotal - hNat usually covers rounding

            final slotWidth = chartW / sortedEntries.length;
            final xPos =
                marginLeft + (index * slotWidth) + (slotWidth - barWidth) / 2;

            final dayName =
                DateFormat('EEE', 'pt_BR').format(date); // Seg/Ter...
            final dateStr = DateFormat('dd/MM').format(date);

            return pw.Positioned(
              left: xPos,
              bottom: marginBottom,
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  // Total Label
                  pw.Text("$total",
                      style: pw.TextStyle(
                          fontSize: 8,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black)),
                  pw.SizedBox(height: 2),
                  // Stacked Bar
                  // Stacked Bar
                  pw.Container(
                    width: 8, // Fixed Width
                    height: hTotal,
                    child: pw.Column(
                      children: [
                        // Export on Top (Purple - Exportação)
                        pw.Container(
                            width: 8, height: hExp, color: PdfColors.purple),
                        // National on Bottom (Green - Nacional)
                        pw.Container(
                            width: 8, height: hNat, color: PdfColors.green),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  // Label
                  pw.Text("$dateStr\n$dayName",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.black)),
                ],
              ),
            );
          }),
        ],
      );
    });
  }

  pw.Widget _buildDowntimeSection(DashboardData data) {
    // Header
    final header = pw.Text("Log de Paradas",
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14));

    if (data.downtimeRecords.isEmpty) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          header,
          pw.SizedBox(height: 8),
          pw.Text("Nenhuma parada registrada no período.",
              style: const pw.TextStyle(color: PdfColors.grey600)),
        ],
      );
    }

    // Table
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        header,
        pw.SizedBox(height: 8),
        pw.TableHelper.fromTextArray(
            headers: ["Início", "Fim", "Duração", "Motivo"],
            data: data.downtimeRecords.map((e) {
              final startStr = DateFormat('HH:mm').format(e.start);
              final endStr = DateFormat('HH:mm').format(e.end);
              return [startStr, endStr, "${e.durationMinutes} min", e.reason];
            }).toList(),
            headerStyle:
                pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            rowDecoration: const pw.BoxDecoration(
                border:
                    pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300))),
            oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey100),
            cellStyle: const pw.TextStyle(fontSize: 10),
            cellAlignment: pw.Alignment.centerLeft,
            headerAlignment: pw.Alignment.centerLeft,
            columnWidths: {
              0: const pw.FixedColumnWidth(50),
              1: const pw.FixedColumnWidth(50),
              2: const pw.FixedColumnWidth(60),
              3: const pw.FlexColumnWidth(),
            }),
      ],
    );
  }

  pw.Widget _buildPieStat(String label, int value, PdfColor color) {
    return pw.Row(
      children: [
        pw.Container(
          width: 12,
          height: 12,
          color: color,
        ),
        pw.SizedBox(width: 8),
        pw.Text("$label: $value", style: const pw.TextStyle(fontSize: 12)),
      ],
    );
  }

  pw.Widget _buildTables(DashboardData data) {
    // Sort Stations by Total
    final stations = data.productionByStation.entries.toList()
      ..sort((a, b) {
        final totalA = a.value.national + a.value.export;
        final totalB = b.value.national + b.value.export;
        return totalB.compareTo(totalA);
      });

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("Top Performers (Estações)",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
        pw.SizedBox(height: 8),
        pw.TableHelper.fromTextArray(
          headers: ["Estação", "Nacional", "Exportação", "Total"],
          data: stations.map((e) {
            final total = e.value.national + e.value.export;
            return [
              e.key,
              "${e.value.national}",
              "${e.value.export}",
              "$total"
            ];
          }).toList(),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          rowDecoration: const pw.BoxDecoration(
              border:
                  pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300))),
          oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey100),
          cellAlignment: pw.Alignment.centerLeft,
          headerAlignment: pw.Alignment.centerLeft,
        ),
        pw.SizedBox(height: 20),
        pw.Text("Detalhamento por Tipo de Peça",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
        pw.SizedBox(height: 8),
        pw.TableHelper.fromTextArray(
          headers: ["Tipo de Peça", "1º Turno", "2º Turno", "Total"],
          data: data.partTypeStats.map((e) {
            return [e.name, "${e.shift1Qty}", "${e.shift2Qty}", "${e.total}"];
          }).toList(),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          rowDecoration: const pw.BoxDecoration(
              border:
                  pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300))),
          oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey100),
          cellAlignment: pw.Alignment.centerLeft,
          headerAlignment: pw.Alignment.centerLeft,
        ),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 20),
      child: pw.Text(
        "Página ${context.pageNumber} de ${context.pagesCount}",
        style: const pw.TextStyle(color: PdfColors.grey500, fontSize: 10),
      ),
    );
  }
}
