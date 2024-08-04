import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final Animation<double> animation;

  PathPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = const Color(0xFF0d0d0d).withOpacity(0.5);

    Path path = Path();

    path.moveTo(0, 0.65 * size.height);
    path.lineTo(0.1 * size.width, 0.65 * size.height);
    path.lineTo(0.1 * size.width, 0.7 * size.height);

    path.lineTo(0.35 * size.width, 0.7 * size.height);
    path.lineTo(0.35 * size.width, 0.65 * size.height);
    path.lineTo(0.375 * size.width, 0.65 * size.height);

    path.arcTo(
      Rect.fromCenter(
        center: Offset(size.width / 2, 0.65 * size.height),
        height: 0.20 * size.width,
        width: 0.25 * size.width,
      ),
      pi,
      pi,
      false,
    );

    path.lineTo(0.65 * size.width, 0.65 * size.height);
    path.lineTo(0.65 * size.width, 0.7 * size.height);

    path.lineTo(0.9 * size.width, 0.7 * size.height);
    path.lineTo(0.9 * size.width, 0.65 * size.height);
    path.lineTo(size.width, 0.65 * size.height);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    final PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      final Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * animation.value,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
