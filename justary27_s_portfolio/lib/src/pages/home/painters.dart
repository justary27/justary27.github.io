import 'dart:math';
import 'dart:ui';
import 'package:material_ui/material_ui.dart';

import '../../themes/colors.dart';

class CarouselPainter extends CustomPainter {
  final double angle;
  final double radius;
  final Paint sectorPaint = Paint()
    ..color = AppColors.ink900.withValues(alpha: 0.2)
    ..style = PaintingStyle.fill;

  final Paint borderPaint = Paint()
    ..color = AppColors.ink900
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

    canvas.drawCircle(center, 0.225 * radius, smallBorderPaint);

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

// Draws each glyph at its real width plus the DS tracking, which
// fixed-angle circular text can't do.
class MilestoneRingPainter extends CustomPainter {
  final List<(String, double)> labels;
  final double radius;
  final Animation<double> turn;
  final TextStyle style;
  final double letterSpacing;

  MilestoneRingPainter({
    required this.labels,
    required this.radius,
    required this.turn,
    required this.style,
    this.letterSpacing = 5,
  }) : super(repaint: turn);

  late final List<List<TextPainter>> _glyphs = [
    for (final (label, _) in labels)
      [
        for (final char in label.toUpperCase().characters)
          TextPainter(
            text: TextSpan(text: char, style: style),
            textDirection: TextDirection.ltr,
          )..layout(),
      ],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double rotation = turn.value * 2 * pi;

    for (int i = 0; i < labels.length; i++) {
      final List<TextPainter> glyphs = _glyphs[i];
      final double arc =
          glyphs.fold(0.0, (sum, g) => sum + g.width) +
          letterSpacing * (glyphs.length - 1);
      // Centred on its angle, like the old CircularText setup.
      final double start =
          labels[i].$2 * pi / 180 + rotation - arc / 2 / radius;
      double cursor = 0;
      for (final glyph in glyphs) {
        final double angle = start + (cursor + glyph.width / 2) / radius;
        final double baseline = glyph.computeDistanceToActualBaseline(
          TextBaseline.alphabetic,
        );
        canvas
          ..save()
          ..translate(center.dx, center.dy)
          ..rotate(angle + pi / 2);
        glyph.paint(canvas, Offset(-glyph.width / 2, -radius - baseline));
        canvas.restore();
        cursor += glyph.width + letterSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(MilestoneRingPainter oldDelegate) =>
      oldDelegate.radius != radius ||
      oldDelegate.labels != labels ||
      oldDelegate.style != style;
}
