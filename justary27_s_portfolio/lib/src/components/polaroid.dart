import 'package:material_ui/material_ui.dart';

import '../themes/colors.dart';
import '../themes/typography.dart';

class Polaroid extends StatelessWidget {
  final String caption;
  final ImageProvider? image;
  final double width;
  final double height;

  const Polaroid({
    super.key,
    required this.caption,
    this.image,
    this.width = 150,
    this.height = 178,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ColoredBox(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 8,
              top: 8,
              right: 8,
              bottom: 32,
              child: image != null
                  ? Image(image: image!, fit: BoxFit.cover)
                  : const _PhotoPlaceholder(),
            ),
            Positioned(
              left: 10,
              bottom: 5,
              child: Text(
                caption,
                style: AppText.handSmall.copyWith(
                  fontSize: 17,
                  color: AppColors.ink700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: _StripesPainter(),
        child: Center(
          child: Text(
            "PHOTO",
            style: AppText.meta.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.ink300,
            ),
          ),
        ),
      ),
    );
  }
}

class _StripesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFEEEEEE),
    );
    final stripe = Paint()
      ..color = const Color(0xFFE4E4E4)
      ..strokeWidth = 10;
    final span = size.width + size.height;
    for (double x = -span; x < span; x += 28.3) {
      canvas.drawLine(Offset(x, 0), Offset(x + span, span), stripe);
    }
  }

  @override
  bool shouldRepaint(_StripesPainter oldDelegate) => false;
}
