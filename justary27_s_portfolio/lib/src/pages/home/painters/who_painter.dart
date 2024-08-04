import 'dart:ui';
import 'package:flutter/material.dart';

class WhoPainter extends CustomPainter {
  final double progress;

  WhoPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF0d0d0d)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    Paint fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF0d0d0d);

    Path path = Path();

    path.moveTo(0.695 * size.width, 0);
    path.quadraticBezierTo(
      0.875 * size.width,
      0.1818 * size.height,
      0.875 * size.width,
      0.25 * size.height,
    );

    path.quadraticBezierTo(
      0.975 * size.width,
      0.5 * size.height,
      0.875 * size.width,
      0.75 * size.height,
    );
    path.quadraticBezierTo(
      0.875 * size.width,
      0.875 * size.height,
      size.width,
      size.height,
    );

    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      final pathLength = pathMetric.length;
      final drawLength = pathLength * progress;

      Path extractPath = pathMetric.extractPath(0.0, drawLength);
      canvas.drawPath(extractPath, paint);

      // Draw circles along the path
      final circleOffsets = [0.25, 0.5, 0.75].map((p) => p * drawLength);
      for (double offset in circleOffsets) {
        Tangent? tangent = pathMetric.getTangentForOffset(offset);
        if (tangent != null) {
          canvas.drawCircle(tangent.position, 35, paint); // Outer circle
          canvas.drawCircle(tangent.position, 20, fillPaint); // Inner circle
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
