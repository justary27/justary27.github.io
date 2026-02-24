import 'package:flutter/material.dart';

class TrapezoidPainter extends CustomPainter {
  final List<double> widths;
  final int selectedIndex;
  final List<String> labels;
  final double slant;
  final double height;
  final Color activeColor;

  static const Color _inactiveColor = Color(0xFFE0E0E0); // grey[200]
  static const Color _borderColor = Color(0xFFBDBDBD); // grey[400]
  static const double _borderWidth = 1.0;
  static const double _fontSize = 14.0;
  static const String _fontFamily = 'ABeeZee';

  TrapezoidPainter({
    required this.widths,
    required this.selectedIndex,
    required this.labels,
    required this.slant,
    required this.height,
    required this.activeColor,
  });

  /// Path for segment [i].
  /// leftEdge = sum of widths[0..i-1]  (top-left x coordinate).
  /// \ slant means bottom corners shift RIGHT by [slant].
  Path _segmentPath(int i, double leftEdge) {
    final rightEdge = leftEdge + widths[i];
    final path = Path();
    path.moveTo(leftEdge, 0); // top-left
    path.lineTo(rightEdge, 0); // top-right
    path.lineTo(rightEdge + slant, height); // bottom-right  ← \ slant
    if (i == 0) {
      path.lineTo(leftEdge, height); // bottom-left: vertical
    } else {
      path.lineTo(leftEdge + slant, height); // bottom-left: also slanted
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Pre-compute left edges
    final positions = <double>[];
    double acc = 0;
    for (final w in widths) {
      positions.add(acc);
      acc += w;
    }

    // ── 1. Fill inactive segments first ──────────────────────────────────────
    for (int i = 0; i < widths.length; i++) {
      if (i == selectedIndex) continue;
      canvas.drawPath(
        _segmentPath(i, positions[i]),
        Paint()
          ..color = _inactiveColor
          ..style = PaintingStyle.fill,
      );
    }

    // ── 2. Fill active segment on top ─────────────────────────────────────────
    canvas.drawPath(
      _segmentPath(selectedIndex, positions[selectedIndex]),
      Paint()
        ..color = activeColor
        ..style = PaintingStyle.fill,
    );

    // ── 3. Outer border ───────────────────────────────────────────────────────
    final totalWidth = widths.fold(0.0, (a, b) => a + b);
    final outerPath =
        Path()
          ..moveTo(0, 0)
          ..lineTo(totalWidth, 0)
          ..lineTo(totalWidth + slant, height)
          ..lineTo(0, height)
          ..close();

    canvas.drawPath(
      outerPath,
      Paint()
        ..color = _borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _borderWidth,
    );

    // ── 4. Internal \ dividers ─────────────────────────────────────────────────
    final dividerPaint =
        Paint()
          ..color = _borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = _borderWidth;

    double cumX = 0;
    for (int i = 0; i < widths.length - 1; i++) {
      cumX += widths[i];
      canvas.drawLine(
        Offset(cumX, 0), // top point
        Offset(cumX + slant, height), // bottom point  ← \ direction
        dividerPaint,
      );
    }

    // ── 5. Text labels centred in each segment ────────────────────────────────
    for (int i = 0; i < widths.length; i++) {
      final isActive = i == selectedIndex;
      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: _fontSize,
            color: isActive ? Colors.white : Colors.black87,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // Centre of the segment parallelogram at mid-height
      // At y = height/2, left edge is at: leftEdge + slant*0.5 (for i>0), else leftEdge
      final leftAtMid = i == 0 ? positions[i] : positions[i] + slant * 0.5;
      final rightAtMid = positions[i] + widths[i] + slant * 0.5;
      final cx = (leftAtMid + rightAtMid) / 2;
      final cy = height / 2;

      tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(TrapezoidPainter old) =>
      old.selectedIndex != selectedIndex;
}
