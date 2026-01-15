import 'dart:ui';
import 'package:flutter/material.dart';

class BlurFade extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Offset offset;

  const BlurFade({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.offset = const Offset(0, 20),
  });

  @override
  Widget build(BuildContext context) {
    return _StaggeredWrapper(
        delay: delay, duration: duration, offset: offset, child: child);
  }
}

class _StaggeredWrapper extends StatefulWidget {
  final Widget? child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  const _StaggeredWrapper(
      {this.child,
      required this.delay,
      required this.duration,
      required this.offset});
  @override
  State<_StaggeredWrapper> createState() => _StaggeredWrapperState();
}

class _StaggeredWrapperState extends State<_StaggeredWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<double> _blur;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _blur = Tween(begin: 10.0, end: 0.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween(begin: widget.offset, end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (ctx, child) {
        return Opacity(
          opacity: _opacity.value,
          child: ImageFiltered(
            imageFilter:
                ImageFilter.blur(sigmaX: _blur.value, sigmaY: _blur.value),
            child: Transform.translate(
              offset: _slide.value,
              child: widget.child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
