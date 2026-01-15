import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:printing/printing.dart';

import '../../application/report_service.dart';

import '../controller/dashboard_controller.dart';

class ReportPreviewDialog extends ConsumerWidget {
  final DashboardFilter filter;

  const ReportPreviewDialog({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportService = ref.watch(reportServiceProvider);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: PdfPreview(
          maxPageWidth: 700,
          build: (format) => reportService.generateReport(
            filter,
            format,
          ),
          canChangeOrientation: false,
          canDebug: false,
          actions: const [], // Default save and print actions are sufficient
          loadingWidget: const Center(
            child: CircularProgressIndicator(
              color: Colors.cyanAccent,
            ),
          ),
          pdfFileName: ReportService.generateISOFilename(),
        ),
      ),
    );
  }
}
