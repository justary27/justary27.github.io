import 'package:material_ui/material_ui.dart';

import '../themes/typography.dart';

class HandNote extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color? color;
  final double angle;

  const HandNote(
    this.text, {
    super.key,
    this.style = AppText.handMedium,
    this.color,
    this.angle = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Text(text, style: style.copyWith(color: color)),
    );
  }
}
