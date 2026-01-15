import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../controller/dashboard_controller.dart';
import '../dialog/advanced_date_filter_dialog.dart';

class DateFilterButton extends ConsumerWidget {
  const DateFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(dashboardFilterControllerProvider);

    // Label Logic
    String label = "Hoje";
    if (filter.specificDates.isNotEmpty) {
      if (filter.specificDates.length == 1) {
        label = DateFormat('dd/MM/yy').format(filter.specificDates.first);
      } else {
        final sorted = filter.specificDates.toList()..sort();
        final minDate = DateFormat('dd/MM/yy').format(sorted.first);
        final maxDate = DateFormat('dd/MM/yy').format(sorted.last);
        label = "$minDate ~ $maxDate";
      }
    } else if (filter.dateRange != null) {
      final start = DateFormat('dd/MM/yy').format(filter.dateRange!.start);
      final end = DateFormat('dd/MM/yy').format(filter.dateRange!.end);
      label = "$start ~ $end";
    }

    final isDefault = filter.specificDates.isEmpty && filter.dateRange == null;

    return Container(
      height: 36,
      constraints: const BoxConstraints(minWidth: 100),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            final result = await showDialog<Map<String, dynamic>>(
              context: context,
              builder: (ctx) => AdvancedDateFilterDialog(
                initialSpecificDates: filter.specificDates,
                initialRange: filter.dateRange,
                initialStartTime: filter.startTime,
                initialEndTime: filter.endTime,
              ),
            );

            if (result != null) {
              final notifier =
                  ref.read(dashboardFilterControllerProvider.notifier);

              final dates = result['dates'] as Set<DateTime>?;
              final range = result['range'] as DateTimeRange?;
              final startTime = result['start'] as TimeOfDay?;
              final endTime = result['end'] as TimeOfDay?;

              // Explicitly handle empty list/null range as RESET
              if ((dates == null || dates.isEmpty) && range == null) {
                notifier.clearDateFilter();
              } else {
                if (dates != null && dates.isNotEmpty) {
                  notifier.setSpecificDates(dates);
                } else if (range != null) {
                  notifier.setDateRange(range);
                }
                notifier.setTime(startTime, endTime);
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            // Right padding reduced because close button has its own padding
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today,
                    size: 16, color: Colors.white70),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                if (!isDefault) ...[
                  const SizedBox(width: 8),
                  // IMPORTANT: Wrapped in GestureDetector to consume the tap
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(dashboardFilterControllerProvider.notifier)
                          .clearDateFilter();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(Icons.close,
                            size: 16, color: Colors.redAccent),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
