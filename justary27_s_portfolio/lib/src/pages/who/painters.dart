import 'package:flutter/material.dart';

import 'data.dart';

// =============================================================================
// WHO HEADING PAINTER (background decoration on heading section — unchanged)
// =============================================================================
class WhoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..color = const Color.fromRGBO(14, 43, 133, 1.0)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 10;

    final path = Path();
    path.moveTo(0, 0.1818 * size.height);
    path.quadraticBezierTo(
      0.125 * size.width,
      0.1818 * size.height,
      0.125 * size.width,
      0.2727 * size.height,
    );
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
    _drawNode(canvas, Offset(0.125 * size.width, 0.2727 * size.height), paint);
    _drawNode(canvas, Offset(0.875 * size.width, 0.5909 * size.height), paint);
    _drawNode(canvas, Offset(0.125 * size.width, 0.8636 * size.height), paint);
  }

  void _drawNode(Canvas canvas, Offset center, Paint strokePaint) {
    canvas.drawCircle(center, 35, strokePaint);
    canvas.drawCircle(
      center,
      20,
      Paint()
        ..style = PaintingStyle.fill
        ..color = strokePaint.color,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// WHO PATH PAINTER
//
// Spans the full 3x screen height story area.
// Three nodes sit at the center of each section's 1/3 slice.
// The animated circle travels along the path driven by [circleProgress] (0–1).
// The path color shifts between section accent colors based on [frozenSectionIndex].
// =============================================================================
class WhoPathPainter extends CustomPainter {
  /// 0.0–1.0, drives where the animated circle sits on the path.
  final double circleProgress;

  /// -1 = not in any section (neutral), 0/1/2 = Present/Past/Future.
  final int frozenSectionIndex;

  WhoPathPainter({
    required this.circleProgress,
    required this.frozenSectionIndex,
  });

  Color get _activeColor {
    if (frozenSectionIndex < 0 ||
        frozenSectionIndex >= WhoData.sections.length) {
      return WhoData.sections[0].accentShade;
    }
    return WhoData.sections[frozenSectionIndex].accentShade;
  }

  /// Snake path across the full 3x height canvas.
  /// Node centers sit at 1/6, 3/6, 5/6 of total height (center of each section).
  Path _buildPath(Size size) {
    final path = Path();

    // Entry — top of canvas
    path.moveTo(0.125 * size.width, 0);

    // Node 1: Present — center of top third (size.height / 3 * 0.5)
    final n1 = Offset(0.125 * size.width, size.height / 6);
    // Node 2: Past — center of middle third
    final n2 = Offset(0.875 * size.width, size.height / 2);
    // Node 3: Future — center of bottom third
    final n3 = Offset(0.125 * size.width, size.height * 5 / 6);

    // Curve from top into Node 1
    path.quadraticBezierTo(0.125 * size.width, n1.dy * 0.3, n1.dx, n1.dy);

    // Snake from Node 1 to Node 2
    path.quadraticBezierTo(
      0.125 * size.width,
      (n1.dy + n2.dy) / 2,
      0.5 * size.width,
      (n1.dy + n2.dy) / 2,
    );
    path.quadraticBezierTo(
      0.875 * size.width,
      (n1.dy + n2.dy) / 2,
      n2.dx,
      n2.dy,
    );

    // Snake from Node 2 to Node 3
    path.quadraticBezierTo(
      0.875 * size.width,
      (n2.dy + n3.dy) / 2,
      0.5 * size.width,
      (n2.dy + n3.dy) / 2,
    );
    path.quadraticBezierTo(
      0.125 * size.width,
      (n2.dy + n3.dy) / 2,
      n3.dx,
      n3.dy,
    );

    // Exit — bottom of canvas
    path.quadraticBezierTo(
      0.125 * size.width,
      size.height * 0.95,
      0.125 * size.width,
      size.height,
    );

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final color = _activeColor;

    final pathPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..color = color.withValues(alpha: 0.2)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 6;

    final path = _buildPath(size);
    canvas.drawPath(path, pathPaint);

    // Static node rings at the 3 section centers
    final nodeOffsets = [
      Offset(0.125 * size.width, size.height / 6),
      Offset(0.875 * size.width, size.height / 2),
      Offset(0.125 * size.width, size.height * 5 / 6),
    ];

    for (int i = 0; i < nodeOffsets.length; i++) {
      final nodeColor = WhoData.sections[i].accentShade;
      final isActiveNode = frozenSectionIndex == i;

      canvas.drawCircle(
        nodeOffsets[i],
        isActiveNode ? 30 : 22,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = nodeColor.withValues(alpha: isActiveNode ? 0.6 : 0.25)
          ..strokeWidth = isActiveNode ? 4 : 2,
      );
    }

    // Animated circle — travels along path
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;

    final totalLength = metrics.fold(0.0, (sum, m) => sum + m.length);
    final targetLength = totalLength * circleProgress.clamp(0.0, 1.0);

    Offset? circleCenter;
    double consumed = 0;
    for (final metric in metrics) {
      if (consumed + metric.length >= targetLength) {
        final tangent = metric.getTangentForOffset(targetLength - consumed);
        if (tangent != null) circleCenter = tangent.position;
        break;
      }
      consumed += metric.length;
    }

    if (circleCenter == null) return;

    // Outer ring
    canvas.drawCircle(
      circleCenter,
      26,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = color.withValues(alpha: 0.7)
        ..strokeWidth = 3,
    );

    // Inner filled circle
    canvas.drawCircle(
      circleCenter,
      12,
      Paint()
        ..style = PaintingStyle.fill
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant WhoPathPainter old) =>
      old.circleProgress != circleProgress ||
      old.frozenSectionIndex != frozenSectionIndex;
}
