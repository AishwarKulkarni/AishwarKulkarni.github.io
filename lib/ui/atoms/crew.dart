import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Renders a vector Among Us-style crewmate on the provided canvas.
void paintCrew(Canvas c, Size s, Color color, double phase) {
  c.save();
  c.scale(s.width / 100, s.height / 125);

  final hsl = HSLColor.fromColor(color);
  final dark = hsl
      .withLightness((hsl.lightness * 0.52).clamp(0.0, 1.0))
      .toColor();
  final shine = hsl
      .withLightness((hsl.lightness * 1.35).clamp(0.0, 1.0))
      .toColor();

  final outlinePaint = Paint()
    ..color = AppColors.ink
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.8
    ..strokeJoin = StrokeJoin.round;

  final fillShader = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [shine, color, dark],
    stops: const [0.0, 0.45, 1.0],
  ).createShader(const Rect.fromLTWH(0, 0, 100, 125));

  final fillPaint = Paint()..shader = fillShader;

  final legA = RRect.fromRectAndRadius(
    Rect.fromLTWH(18, 88 + math.sin(phase) * 3.5, 27, 33),
    const Radius.circular(8.5),
  );
  final legB = RRect.fromRectAndRadius(
    Rect.fromLTWH(54, 88 - math.sin(phase) * 3.5, 27, 33),
    const Radius.circular(8.5),
  );
  final pack = RRect.fromRectAndRadius(
    const Rect.fromLTWH(2, 46, 20, 48),
    const Radius.circular(9),
  );
  final body = RRect.fromRectAndCorners(
    const Rect.fromLTWH(14, 6, 72, 98),
    topLeft: const Radius.circular(36),
    topRight: const Radius.circular(36),
    bottomLeft: const Radius.circular(10),
    bottomRight: const Radius.circular(10),
  );

  for (final r in [pack, legA, legB, body]) {
    c.drawRRect(r, fillPaint);
    c.drawRRect(r, outlinePaint);
  }

  // Visor
  final visor = RRect.fromRectAndRadius(
    const Rect.fromLTWH(44, 20, 46, 30),
    const Radius.circular(15),
  );
  c.drawRRect(
    visor,
    Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE0F2FE), Color(0xFF38BDF8), Color(0xFF0284C7)],
        stops: [0.0, 0.45, 1.0],
      ).createShader(const Rect.fromLTWH(44, 20, 46, 30)),
  );
  c.drawRRect(visor, outlinePaint..strokeWidth = 2.8);

  // Visor Glint Reflection
  final glint = Paint()..color = Colors.white.withValues(alpha: 0.92);
  c.drawRRect(
    RRect.fromRectAndRadius(
      const Rect.fromLTWH(64, 24, 18, 7),
      const Radius.circular(3.5),
    ),
    glint,
  );
  c.drawCircle(const Offset(60, 27.5), 2.2, glint);

  c.restore();
}

class _CrewPainter extends CustomPainter {
  const _CrewPainter(this.color, this.phase);

  final Color color;
  final double phase;

  @override
  void paint(Canvas canvas, Size size) => paintCrew(canvas, size, color, phase);

  @override
  bool shouldRepaint(_CrewPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.phase != phase;
}

/// Animated or static crewmate avatar atom.
class Crew extends StatefulWidget {
  const Crew({
    super.key,
    required this.color,
    this.height = 120,
    this.bob = false,
  });

  final Color color;
  final double height;
  final bool bob;

  @override
  State<Crew> createState() => _CrewState();
}

class _CrewState extends State<Crew> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.bob) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      )..repeat();
    }
  }

  @override
  void didUpdateWidget(Crew oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.bob != oldWidget.bob) {
      if (widget.bob) {
        _controller ??= AnimationController(
          vsync: this,
          duration: const Duration(seconds: 3),
        );
        _controller!.repeat();
      } else {
        _controller?.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = Size(widget.height * 0.8, widget.height);
    if (_controller == null || !widget.bob) {
      return CustomPaint(size: size, painter: _CrewPainter(widget.color, 0));
    }
    return AnimatedBuilder(
      animation: _controller!,
      builder: (_, _) {
        final t = _controller!.value * math.pi * 2;
        return Transform.translate(
          offset: Offset(0, math.sin(t) * 7),
          child: CustomPaint(
            size: size,
            painter: _CrewPainter(widget.color, t * 2),
          ),
        );
      },
    );
  }
}
