import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class CarouselPainter extends CustomPainter {
  final double angle;
  final double radius;
  final Paint sectorPaint =
      Paint()
        ..color = const Color(0xFF0d0d0d).withValues(alpha: 0.2)
        ..style = PaintingStyle.fill;

  final Paint borderPaint =
      Paint()
        ..color = const Color(0xFF0d0d0d)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

  final Paint smallBorderPaint =
      Paint()
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
        rect,
        2 * sectorStartAngle,
        0.35 * sweepAngle,
        true,
        sectorPaint,
      );
      canvas.drawArc(rect, sectorStartAngle, sweepAngle, true, sectorPaint);
      canvas.drawArc(rect, sectorStartAngle, sweepAngle, true, borderPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PathPainter extends CustomPainter {
  final Animation<double> animation;

  PathPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0
          ..color = const Color(0xFF0d0d0d).withValues(alpha: 0.5);

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

class SemiCirclePainter extends CustomPainter {
  final Paint painter =
      Paint()
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

class WhoPainter extends CustomPainter {
  final double progress;

  WhoPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..color = const Color(0xFF0d0d0d)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 10;

    Paint fillPaint =
        Paint()
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
