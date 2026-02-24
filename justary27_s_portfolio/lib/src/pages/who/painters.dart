import 'package:flutter/material.dart';

class WhoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..color = const Color.fromRGBO(14, 43, 133, 1.0)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 10;

    Path path = Path();

    path.moveTo(0, 0.1818 * size.height);
    path.quadraticBezierTo(
      0.125 * size.width,
      0.1818 * size.height,
      0.125 * size.width,
      0.2727 * size.height,
    );

    path.moveTo(0.125 * size.width, 0.2727 * size.height);
    path.quadraticBezierTo(
      0.125 * size.width,
      0.4545 * size.height,
      0.5 * size.width,
      0.4545 * size.height,
    );
    path.quadraticBezierTo(
      0.875 * size.width,
      0.4545 * size.height,
      0.875 * size.width,
      0.5908 * size.height,
    );
    path.quadraticBezierTo(
      0.875 * size.width,
      0.7272 * size.height,
      0.5 * size.width,
      0.7272 * size.height,
    );
    path.quadraticBezierTo(
      0.125 * size.width,
      0.7272 * size.height,
      0.125 * size.width,
      0.8636 * size.height,
    );
    path.lineTo(0.125 * size.width, size.height);

    canvas.drawPath(path, paint);
    canvas.drawCircle(
      Offset(0.125 * size.width, 0.2727 * size.height),
      35,
      paint,
    );
    canvas.drawCircle(
      Offset(0.875 * size.width, 0.5909 * size.height),
      35,
      paint,
    );
    canvas.drawCircle(
      Offset(0.125 * size.width, 0.8636 * size.height),
      35,
      paint,
    );

    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(0.125 * size.width, 0.2727 * size.height),
      20,
      paint,
    );
    canvas.drawCircle(
      Offset(0.875 * size.width, 0.5909 * size.height),
      20,
      paint,
    );
    canvas.drawCircle(
      Offset(0.125 * size.width, 0.8636 * size.height),
      20,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
