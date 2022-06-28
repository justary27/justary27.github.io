import 'package:flutter/material.dart';

class RoorkeePainter extends CustomPainter {
  Color color1;
  Color color2;
  RoorkeePainter(this.color1, this.color2);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            color1,
            color2,
          ]).createShader(Offset.zero & size);
    Path path = Path();

    // path.lineTo(size.width, size.height);

    path.moveTo(size.width, 0.48 * size.height);
    path.quadraticBezierTo(
      0.9 * size.width,
      0.5 * size.height,
      0.9 * size.width,
      0.7 * size.height,
    );
    path.lineTo(0.12 * size.width, 0.7 * size.height);
    path.lineTo(0.12 * size.width, 0.65 * size.height);
    path.lineTo(0, 0.65 * size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
