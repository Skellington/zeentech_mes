import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import '../../../../core/ui/glass_container.dart';

// 1. Total Production
class TotalProductionCard extends StatelessWidget {
  final int totalItems;
  final int totalVolume;

  const TotalProductionCard(
      {super.key, required this.totalItems, required this.totalVolume});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      opacity: 0.1,
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.all(16),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$totalItems',
                style: const TextStyle(
                    fontSize: 64, // Hero Size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.0),
              ),
            ),
            const SizedBox(height: 8),
            const Text('Peças Produzidas',
                style: TextStyle(color: Colors.white70, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// 6. Goal Widget (Complex)
class GoalProgressWidget extends StatelessWidget {
  final int current;
  final int target;
  final double? pace;

  const GoalProgressWidget({
    super.key,
    required this.current,
    required this.target,
    required this.pace,
    this.labelOverride,
  });

  final String? labelOverride;

  @override
  Widget build(BuildContext context) {
    final progress = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;
    final remaining = target - current;

    // Status Logic
    Color statusColor;
    String statusText;
    if (progress < 0.4) {
      statusColor = Colors.redAccent;
      statusText = 'Muito Abaixo';
    } else if (progress < 0.8) {
      statusColor = Colors.orangeAccent;
      statusText = 'Abaixo da Meta';
    } else if (progress < 1.0) {
      statusColor = Colors.lightGreenAccent;
      statusText = 'Próximo';
    } else {
      statusColor = Colors.amberAccent;
      statusText = 'Meta Atingida!';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${(progress * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor)),
              child: Text(statusText,
                  style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
          ],
        ),
        const Gap(8),
        LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white10,
            color: statusColor,
            minHeight: 12,
            borderRadius: BorderRadius.circular(6)),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(labelOverride ?? 'Faltam',
                    style:
                        const TextStyle(color: Colors.white54, fontSize: 12)),
                Text(remaining > 0 ? '$remaining' : '0',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Ritmo (Líquido)',
                    style: TextStyle(color: Colors.white54, fontSize: 12)),
                Text(
                  pace != null
                      ? '${pace!.toStringAsFixed(0)} p/h${labelOverride != null ? " (2T)" : ""}'
                      : '-- p/h', // Stabilization
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// 7 & 8. Generic Ranking List
class RankingListWidget extends StatelessWidget {
  final Map<String, num> data;
  final String title;
  final bool isPacker;

  const RankingListWidget(
      {super.key,
      required this.data,
      required this.title,
      this.isPacker = false});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
          child: Text('Sem dados', style: TextStyle(color: Colors.white30)));
    }

    final sortedEntries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top5 = sortedEntries.take(5).toList();

    return SingleChildScrollView(
      child: Column(
        children: top5.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            color: index.isOdd
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.transparent,
            child: Row(
              children: [
                Container(
                  width: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? Colors.amber
                        : (index == 1
                            ? Colors.grey
                            : (index == 2 ? Colors.brown : Colors.transparent)),
                    shape: BoxShape.circle,
                  ),
                  child: Text('${index + 1}',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: index < 3 ? Colors.black : Colors.white)),
                ),
                const Gap(12),
                Expanded(
                    child: Text(item.key,
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis)),
                Text(
                    item.value % 1 == 0
                        ? item.value.toInt().toString()
                        : item.value.toStringAsFixed(1).replaceAll('.', ','),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
