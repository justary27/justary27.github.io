import 'package:material_ui/material_ui.dart';

import '../themes/colors.dart';

class RuledPaperPainter extends CustomPainter {
  final double lineGap;

  const RuledPaperPainter({this.lineGap = 32});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.paper);
    final line = Paint()..color = AppColors.deskGrid;
    for (double y = lineGap - 0.5; y < size.height; y += lineGap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
  }

  @override
  bool shouldRepaint(RuledPaperPainter oldDelegate) =>
      oldDelegate.lineGap != lineGap;
}
