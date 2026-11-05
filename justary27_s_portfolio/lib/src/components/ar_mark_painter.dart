import 'dart:math';
import 'dart:ui' show PathMetric;

import 'package:material_ui/material_ui.dart';

class ArMarkPainter extends CustomPainter {
  static const double aspectRatio = 145 / 219;

  final Animation<double> progress;
  final Color color;
  final double strokeWidth;

  ArMarkPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 9,
  }) : super(repaint: progress);

  // Same geometry as assets/images/ar.svg, reordered so a pen writes the A, then
  // the R.
  static final Path _mark = Path()
    ..moveTo(5, 136.779)
    ..cubicTo(5, 136.779, 5, 101.044, 5, 78.1474)
    ..cubicTo(5, 55.2505, 5, 19.5162, 5, 19.5162)
    ..cubicTo(28.0523, -0.463039, 42.0092, 0.795776, 68.2689, 19.5162)
    ..lineTo(68.2689, 78.1474)
    ..lineTo(68.2689, 136.779)
    ..moveTo(5, 78.1474)
    ..cubicTo(29.708, 86.85, 43.5609, 88.4444, 68.2689, 78.1474)
    ..cubicTo(91.581, 64.4049, 119.206, 71.1759, 127.963, 78.1474)
    ..cubicTo(136.721, 85.1189, 140.474, 126.947, 127.963, 136.779)
    ..cubicTo(115.452, 146.61, 68.2689, 136.779, 68.2689, 136.779)
    ..cubicTo(90.2448, 169.485, 117.101, 196.474, 142, 214)
    ..moveTo(68.2689, 136.779)
    ..cubicTo(68.2689, 136.779, 71.3072, 193.086, 59.69, 214);

  static final List<PathMetric> _strokes = _mark.computeMetrics().toList();
  static final double _totalLength = _strokes.fold(
    0,
    (sum, stroke) => sum + stroke.length,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 145);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    var remaining = progress.value * _totalLength;
    for (final stroke in _strokes) {
      if (remaining <= 0) break;
      canvas.drawPath(
        stroke.extractPath(0, min(remaining, stroke.length)),
        paint,
      );
      remaining -= stroke.length;
    }
  }

  @override
  bool shouldRepaint(ArMarkPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
