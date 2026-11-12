import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Painter rendering procedural barcode strips.
class BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final r = math.Random(19);
    final p = Paint()..color = AppColors.dim.withValues(alpha: 0.45);
    var x = 0.0;
    while (x < size.width) {
      final w = 1.0 + r.nextInt(3);
      if (r.nextBool()) {
        canvas.drawRect(Rect.fromLTWH(x, 0, w, size.height), p);
      }
      x += w + 1.2 + r.nextInt(3);
    }
  }

  @override
  bool shouldRepaint(BarcodePainter oldDelegate) => false;
}

/// Barcode display atom widget.
class BarcodeWidget extends StatelessWidget {
  const BarcodeWidget({
    super.key,
    this.height = 24.0,
    this.width = double.infinity,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CustomPaint(
        painter: BarcodePainter(),
        size: Size(width, height),
      ),
    );
  }
}
