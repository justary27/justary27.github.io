import 'dart:math';
import 'package:flutter/material.dart';

class SemiCirclePainter extends CustomPainter {
  final Paint painter = Paint()
    ..color = const Color(0xFF0d0d0d)
    ..strokeWidth = 4
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    double circumference = 2 * pi * radius;
    double dashWidth = 30.0;
    double dashSpace = 20.0;
    double dashCount = circumference / (dashWidth + dashSpace);

    Path path = Path();
    for (int i = 0; i < dashCount; i++) {
      double startAngle = (i * (dashWidth + dashSpace)) / radius;
      double endAngle = startAngle + (dashWidth / radius);
      path.addArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        endAngle - startAngle,
      );
    }
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
