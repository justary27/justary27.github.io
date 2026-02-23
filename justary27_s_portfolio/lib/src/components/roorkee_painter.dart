import 'dart:math';

import 'package:flutter/material.dart';

class RoorkeePainter extends CustomPainter {
  Color color1;
  Color color2;
  RoorkeePainter(this.color1, this.color2);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..style = PaintingStyle.fill
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [color1, color2],
          ).createShader(Offset.zero & size);
    Path path = Path();

    path.moveTo(0, 0.65 * size.height);
    path.lineTo(0.1 * size.width, 0.65 * size.height);
    path.lineTo(0.1 * size.width, 0.7 * size.height);

    path.lineTo(0.35 * size.width, 0.7 * size.height);
    path.lineTo(0.35 * size.width, 0.65 * size.height);
    path.lineTo(0.65 * size.width, 0.65 * size.height);
    path.lineTo(0.65 * size.width, 0.7 * size.height);

    path.lineTo(0.9 * size.width, 0.7 * size.height);
    path.lineTo(0.9 * size.width, 0.65 * size.height);
    path.lineTo(size.width, 0.65 * size.height);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, 0.65 * size.height),
        height: 0.20 * size.width,
        width: 0.25 * size.width,
      ),
      pi,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
