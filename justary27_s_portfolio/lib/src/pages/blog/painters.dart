import 'dart:math';

import 'package:material_ui/material_ui.dart';

import '../../themes/colors.dart';

// The Roorkee skyline stroke from the Components board's blog card fallback,
// drawn on the board's 120 × 76 grid and scaled to the thumbnail.
class SkylineThumbPainter extends CustomPainter {
  const SkylineThumbPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 120, size.height / 76);
    final path = Path()
      ..moveTo(4, 60)
      ..lineTo(18, 60)
      ..lineTo(18, 56)
      ..lineTo(44, 56)
      ..lineTo(44, 60)
      ..lineTo(48, 60)
      ..arcToPoint(
        const Offset(72, 60),
        radius: const Radius.elliptical(12, 10),
      )
      ..lineTo(76, 60)
      ..lineTo(76, 56)
      ..lineTo(102, 56)
      ..lineTo(102, 60)
      ..lineTo(116, 60);
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.ink900
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(SkylineThumbPainter oldDelegate) => false;
}

// Dot paper behind the notes list; it stays put while the list scrolls.
class DotPaperPainter extends CustomPainter {
  const DotPaperPainter();

  static const double _gap = 24;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.line.withValues(alpha: 0.55);
    for (double y = _gap / 2; y < size.height; y += _gap) {
      for (double x = _gap / 2; x < size.width; x += _gap) {
        canvas.drawCircle(Offset(x, y), 1.3, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DotPaperPainter oldDelegate) => false;
}

// The filled Roorkee skyline at the foot of a post header (board viewBox
// 1280 × 150, scaled to cover and pinned to the bottom).
class PostSkylinePainter extends CustomPainter {
  const PostSkylinePainter();

  static const Color _fill = Color(0xFF7E150E);

  Path _skyline() => Path()
    ..moveTo(0, 120)
    ..lineTo(128, 120)
    ..lineTo(128, 136)
    ..lineTo(448, 136)
    ..lineTo(448, 120)
    ..lineTo(480, 120)
    ..arcToPoint(
      const Offset(800, 120),
      radius: const Radius.elliptical(160, 128),
    )
    ..lineTo(832, 120)
    ..lineTo(832, 136)
    ..lineTo(1152, 136)
    ..lineTo(1152, 120)
    ..lineTo(1280, 120);

  @override
  void paint(Canvas canvas, Size size) {
    final double scale = max(size.width / 1280, size.height / 150);
    canvas
      ..translate((size.width - 1280 * scale) / 2, size.height - 150 * scale)
      ..scale(scale);
    canvas.drawPath(
      _skyline(),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
    canvas.drawPath(
      _skyline()
        ..lineTo(1280, 150)
        ..lineTo(0, 150)
        ..close(),
      Paint()..color = _fill,
    );
  }

  @override
  bool shouldRepaint(PostSkylinePainter oldDelegate) => false;
}
