import 'package:material_ui/material_ui.dart';

import '../themes/colors.dart';
import '../themes/dimens.dart';
import '../themes/motion.dart';
import '../themes/typography.dart';

class TopicChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  // The envelope's letter is smaller than Say hi's card, so its chips are too.
  final bool compact;

  const TopicChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.pill),
        child: AnimatedContainer(
          duration: Motion.quick,
          curve: MotionCurves.standard,
          padding: compact
              ? const EdgeInsets.symmetric(horizontal: 11, vertical: 4)
              : const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.ink900 : Colors.transparent,
            borderRadius: BorderRadius.circular(Radii.pill),
            border: Border.all(color: AppColors.ink900, width: 1.5),
          ),
          child: Text(
            label,
            style: AppText.label.copyWith(
              fontSize: compact ? 12 : 13,
              color: isSelected ? Colors.white : AppColors.ink900,
            ),
          ),
        ),
      ),
    );
  }
}
