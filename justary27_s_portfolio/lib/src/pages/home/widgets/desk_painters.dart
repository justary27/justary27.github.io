import 'dart:ui' show PathMetric;

import 'package:material_ui/material_ui.dart';

import '../../../themes/colors.dart';

class SkylinePainter extends CustomPainter {
  final Animation<double> progress;
  // Desk units of skyline beyond each end of the stage, on wide screens.
  final double margin;
  final double scale;
  // The skyline is drawn for 1280 and narrowed to the stage (768 on tablet).
  final double stageWidth;

  SkylinePainter({
    required this.progress,
    required this.margin,
    required this.scale,
    this.stageWidth = 1280,
  }) : super(repaint: progress);

  late final double _k = stageWidth / 1280;

  late final Path _outline = Path()
    ..moveTo(-margin, 200)
    ..lineTo(128 * _k, 200)
    ..lineTo(128 * _k, 216)
    ..lineTo(448 * _k, 216)
    ..lineTo(448 * _k, 200)
    ..lineTo(480 * _k, 200)
    ..arcToPoint(
      Offset(800 * _k, 200),
      radius: Radius.elliptical(160 * _k, 128 * _k),
    )
    ..lineTo(832 * _k, 200)
    ..lineTo(832 * _k, 216)
    ..lineTo(1152 * _k, 216)
    ..lineTo(1152 * _k, 200)
    ..lineTo(stageWidth + margin, 200);
  late final Path _ground = Path.from(_outline)
    ..lineTo(stageWidth + margin, 240)
    ..lineTo(-margin, 240)
    ..close();
  late final PathMetric _stroke = _outline.computeMetrics().first;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale);
    canvas.translate(margin, 0);
    canvas.drawPath(_ground, Paint()..color = const Color(0x0A0D0D0D));
    canvas.drawPath(
      _stroke.extractPath(0, progress.value * _stroke.length),
      Paint()
        ..color = AppColors.ink900
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(SkylinePainter oldDelegate) =>
      oldDelegate.margin != margin ||
      oldDelegate.scale != scale ||
      oldDelegate.stageWidth != stageWidth;
}

class DeskGridPainter extends CustomPainter {
  static const double _cell = 28;

  final double scale;

  DeskGridPainter({required this.scale});

  @override
  void paint(Canvas canvas, Size size) {
    final cell = _cell * scale;
    final paint = Paint()..color = AppColors.deskGrid;
    for (double x = 0; x < size.width; x += cell) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += cell) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(DeskGridPainter oldDelegate) => oldDelegate.scale != scale;
}

class PeekLinkPainter extends CustomPainter {
  final Offset from;
  final Offset to;

  PeekLinkPainter({required this.from, required this.to});

  @override
  void paint(Canvas canvas, Size size) {
    final midX = (from.dx + to.dx) / 2;
    final curve = Path()
      ..moveTo(from.dx, from.dy)
      ..cubicTo(midX, from.dy - 80, midX, to.dy - 40, to.dx, to.dy);
    final paint = Paint()
      ..color = AppColors.ink900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    for (final metric in curve.computeMetrics()) {
      for (double d = 0; d < metric.length; d += 12) {
        canvas.drawPath(metric.extractPath(d, d + 6), paint);
      }
    }
  }

  @override
  bool shouldRepaint(PeekLinkPainter oldDelegate) =>
      oldDelegate.from != from || oldDelegate.to != to;
}
