import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../data/portfolio_data.dart';
import 'crew.dart';

/// CustomPainter rendering a deep space background with stars, nebulae, and drifting crewmates.
class SpaceCanvas extends CustomPainter {
  SpaceCanvas(this.t, this.scroll)
      : super(repaint: Listenable.merge([t, scroll]));

  final Animation<double> t;
  final ScrollController scroll;
  static final math.Random _r = math.Random(42);

  static final List<List<double>> stars = List.generate(190, (_) => [
    _r.nextDouble(), // x
    _r.nextDouble(), // y
    _r.nextDouble() * 1.6 + 0.4, // radius
    _r.nextDouble() * 0.35 + 0.05, // speed
    _r.nextDouble() * 6.28, // phase
    _r.nextDouble(), // tint selector
  ]);

  static final List<List<double>> driftingCrew = List.generate(5, (_) => [
    _r.nextDouble(), // x
    _r.nextDouble(), // y
    _r.nextDouble() * 0.35 + 0.15, // speed
    _r.nextDouble() * 6.28, // rot phase
    32.0 + _r.nextDouble() * 26.0, // size
  ]);

  @override
  void paint(Canvas canvas, Size size) {
    final time = t.value * 90;
    final off = scroll.hasClients ? scroll.offset : 0.0;

    // Atmospheric deep background
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(0.0, -0.6),
          radius: 1.4,
          colors: [
            Color(0xFF0B1430),
            Color(0xFF060914),
            Color(0xFF030509),
          ],
          stops: [0.0, 0.6, 1.0],
        ).createShader(Offset.zero & size),
    );

    // Glowing Nebula clouds
    final nebulaPaint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 55);
    nebulaPaint.color = const Color(0xFF1E3A8A).withValues(alpha: 0.18);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.25 - off * 0.05), 240, nebulaPaint);

    nebulaPaint.color = const Color(0xFF4C1D95).withValues(alpha: 0.12);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.55 - off * 0.06), 280, nebulaPaint);

    // Starfield
    final p = Paint();
    for (final s in stars) {
      final x = ((s[0] - time * s[3] * 0.008) % 1.0) * size.width;
      final y = (s[1] * size.height - off * (0.02 + s[2] * 0.04)) % size.height;
      final twinkle = 0.35 + 0.65 * (0.5 + 0.5 * math.sin(time * 1.8 + s[4]));

      if (s[5] > 0.82) {
        p.color = const Color(0xFF93C5FD).withValues(alpha: twinkle * 0.8);
      } else if (s[5] > 0.70) {
        p.color = const Color(0xFFFDE68A).withValues(alpha: twinkle * 0.7);
      } else {
        p.color = Colors.white.withValues(alpha: twinkle * 0.75);
      }

      canvas.drawCircle(Offset(x, y), s[2] * 0.9, p);
    }

    // Drifting crewmates
    for (var i = 0; i < driftingCrew.length; i++) {
      final d = driftingCrew[i];
      final x = ((d[0] + time * d[2] * 0.005) % 1.2 - 0.1) * size.width;
      final y = d[1] * size.height + math.sin(time * 0.4 + d[3]) * 18 - off * 0.1;
      final sz = d[4];

      canvas.save();
      canvas.saveLayer(null, Paint()..color = Colors.white.withValues(alpha: 0.22));
      canvas.translate(x, y);
      canvas.rotate(time * d[2] * 0.3 + d[3]);
      canvas.translate(-sz * 0.4, -sz / 2);
      paintCrew(
        canvas,
        Size(sz * 0.8, sz),
        PortfolioData.palettes[i % PortfolioData.palettes.length].primary,
        0,
      );
      canvas.restore();
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(SpaceCanvas oldDelegate) => false;
}
