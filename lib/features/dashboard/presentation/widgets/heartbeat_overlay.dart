import 'package:flutter/material.dart';

class HeartbeatOverlay extends StatefulWidget {
  const HeartbeatOverlay({super.key});

  @override
  State<HeartbeatOverlay> createState() => _HeartbeatOverlayState();
}

class _HeartbeatOverlayState extends State<HeartbeatOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _HeartbeatPainter(_controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _HeartbeatPainter extends CustomPainter {
  final double animationValue;

  _HeartbeatPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    // Defines the current X position of the "scan line"
    final xPos = size.width * animationValue;

    // 1. Draw the Scan Line (Bright Vertical Line)
    paint.shader = null;
    paint.color = Colors.cyanAccent.withValues(alpha: 0.8);
    paint.maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);

    // Draw line
    canvas.drawLine(
      Offset(xPos, 0),
      Offset(xPos, size.height),
      paint..strokeWidth = 2,
    );

    // 2. Draw the Fading Trail (Gradient to the left)
    // We draw a rectangle from 0 to xPos, but we want the gradient to be opaque at xPos and transparent much earlier.
    // Actually simpler: Draw a Rect from (xPos - trailWidth) to xPos.

    final trailWidth = size.width * 0.3; // 30% of screen width trail
    if (xPos > 0) {
      final rect = Rect.fromLTRB(xPos - trailWidth, 0, xPos, size.height);

      final gradient = LinearGradient(
        colors: [
          Colors.cyanAccent.withValues(alpha: 0.0), // Transparent at tail
          Colors.cyanAccent
              .withValues(alpha: 0.1), // Semi-transparent near head
          Colors.cyanAccent.withValues(alpha: 0.4), // Brighter at head
        ],
        stops: const [0.0, 0.7, 1.0],
      );

      paint.shader = gradient.createShader(rect);
      paint.maskFilter = null;
      canvas.drawRect(rect, paint);
    }

    // Wrap-around trail (for loop seamlesness)
    // If the trail extends "before" 0, we should draw it at the end of the screen?
    // Not strictly necessary for a simple scan effect, but nice.
    // Let's stick to simple "wipe" for now as requested.
  }

  @override
  bool shouldRepaint(covariant _HeartbeatPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
