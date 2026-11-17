import 'package:material_ui/material_ui.dart';

import '../themes/colors.dart';

class TapeStrip extends StatelessWidget {
  final double width;
  final double height;
  final double angle;
  final Color color;

  const TapeStrip({
    super.key,
    this.width = 90,
    this.height = 24,
    this.angle = 0,
    this.color = AppColors.tapeSheer,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: SizedBox(
        width: width,
        height: height,
        child: ColoredBox(color: color),
      ),
    );
  }
}
