import 'package:material_ui/material_ui.dart';

import '../themes/colors.dart';
import '../themes/typography.dart';

class FillInField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const FillInField({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: CustomPaint(
        foregroundPainter: _DashedUnderlinePainter(),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          cursorColor: AppColors.ink900,
          style: AppText.handSmall.copyWith(color: AppColors.ink900),
          decoration: InputDecoration(
            isCollapsed: true,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
            hintText: hint,
            hintStyle: AppText.handSmall.copyWith(color: AppColors.ink300),
          ),
        ),
      ),
    );
  }
}

class _DashedUnderlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.ink300
      ..strokeWidth = 1.5;
    final y = size.height - 0.75;
    for (double x = 0; x < size.width; x += 7) {
      canvas.drawLine(Offset(x, y), Offset(x + 4, y), paint);
    }
  }

  @override
  bool shouldRepaint(_DashedUnderlinePainter oldDelegate) => false;
}
