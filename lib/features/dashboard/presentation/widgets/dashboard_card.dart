import 'package:flutter/material.dart';
import '../../../../core/ui/glass_container.dart';

class DashboardCard extends StatelessWidget {
  final Widget child;
  final String title;
  final EdgeInsets padding;
  final TextStyle? titleStyle;

  const DashboardCard({
    super.key,
    required this.child,
    required this.title,
    this.padding = const EdgeInsets.all(16),
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      opacity: 0.1,
      borderRadius: BorderRadius.circular(16),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style: titleStyle ??
                  TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14)),
          const SizedBox(height: 12),
          Flexible(child: child),
        ],
      ),
    );
  }
}
