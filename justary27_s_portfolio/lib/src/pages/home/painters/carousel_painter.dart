import 'dart:math';
import 'package:flutter/material.dart';

class CarouselPainter extends CustomPainter {
  final double angle;
  final double radius;
  final Paint sectorPaint = Paint()
    ..color = const Color(0xFF0d0d0d).withOpacity(0.2)
    ..style = PaintingStyle.fill;

  final Paint borderPaint = Paint()
    ..color = const Color(0xFF0d0d0d)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  final Paint smallBorderPaint = Paint()
    ..color = Colors.black87
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  CarouselPainter({required this.angle, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final double startAngle = angle * (pi / 180);
    const double sweepAngle = 60 * (pi / 180);
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawCircle(center, 0.25 * radius, smallBorderPaint);

    for (int i = 0; i < 3; i++) {
      final double sectorStartAngle = startAngle + i * 2 * sweepAngle;
      canvas.drawArc(
          rect, 2 * sectorStartAngle, 0.35 * sweepAngle, true, sectorPaint);
      canvas.drawArc(rect, sectorStartAngle, sweepAngle, true, sectorPaint);
      canvas.drawArc(rect, sectorStartAngle, sweepAngle, true, borderPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
