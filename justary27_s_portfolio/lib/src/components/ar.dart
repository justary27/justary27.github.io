import 'package:flutter/material.dart';

class ArPainter extends CustomPainter {
  Color color;

  ArPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.01326260, size.height * 0.6315346);
    path.cubicTo(
        size.width * 0.01326260,
        size.height * 0.6315346,
        size.width * 0.01326260,
        size.height * 0.4629781,
        size.width * 0.01326260,
        size.height * 0.3549747);
    path.moveTo(size.width * 0.4827586, size.height * 0.6315346);
    path.lineTo(size.width * 0.4827586, size.height * 0.3549747);
    path.moveTo(size.width * 0.4827586, size.height * 0.6315346);
    path.cubicTo(
        size.width * 0.4827586,
        size.height * 0.6315346,
        size.width * 0.8328912,
        size.height * 0.6779089,
        size.width * 0.9257294,
        size.height * 0.6315346);
    path.cubicTo(
        size.width * 1.018568,
        size.height * 0.5851602,
        size.width * 0.9907162,
        size.height * 0.3878600,
        size.width * 0.9257294,
        size.height * 0.3549747);
    path.cubicTo(
        size.width * 0.8607427,
        size.height * 0.3220911,
        size.width * 0.6557507,
        size.height * 0.2901518,
        size.width * 0.4827586,
        size.height * 0.3549747);
    path.moveTo(size.width * 0.4827586, size.height * 0.6315346);
    path.cubicTo(
        size.width * 0.4827586,
        size.height * 0.6315346,
        size.width * 0.5053050,
        size.height * 0.8971332,
        size.width * 0.4190981,
        size.height * 0.9957841);
    path.moveTo(size.width * 0.4827586, size.height * 0.6315346);
    path.cubicTo(
        size.width * 0.6320504,
        size.height * 0.7655211,
        size.width * 0.7258488,
        size.height * 0.8340607,
        size.width * 0.9257294,
        size.height * 0.9350759);
    path.moveTo(size.width * 0.4827586, size.height * 0.3549747);
    path.lineTo(size.width * 0.4827586, size.height * 0.07841518);
    path.cubicTo(
        size.width * 0.2878939,
        size.height * -0.009888128,
        size.width * 0.1843257,
        size.height * -0.01582589,
        size.width * 0.01326260,
        size.height * 0.07841518);
    path.cubicTo(
        size.width * 0.01326260,
        size.height * 0.07841518,
        size.width * 0.01326260,
        size.height * 0.2469713,
        size.width * 0.01326260,
        size.height * 0.3549747);
    path.moveTo(size.width * 0.4827586, size.height * 0.3549747);
    path.cubicTo(
        size.width * 0.2994085,
        size.height * 0.4035447,
        size.width * 0.1966119,
        size.height * 0.3960253,
        size.width * 0.01326260,
        size.height * 0.3549747);

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05305040;
    paint.color = color.withOpacity(1.0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
