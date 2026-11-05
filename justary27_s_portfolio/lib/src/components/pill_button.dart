import 'package:material_ui/material_ui.dart';

import '../themes/dimens.dart';
import '../themes/motion.dart';
import '../themes/route_ink.dart';
import '../themes/typography.dart';

enum PillVariant { filled, outlined }

class PillButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final PillVariant variant;
  // Default to the route ink; the footer overrides them on its slate band.
  final Color? color;
  final Color? onColor;

  const PillButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.variant = PillVariant.outlined,
    this.color,
    this.onColor,
  });

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? RouteInk.of(context).ink;
    final isFilled = widget.variant == PillVariant.filled;
    final textColor = isFilled ? widget.onColor ?? Colors.white : color;

    return Semantics(
      button: true,
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onPressed();
              return null;
            },
          ),
        },
        onShowHoverHighlight: (value) => setState(() => _isHovered = value),
        // Keyboard focus only, so a mouse click never leaves a ring behind.
        onShowFocusHighlight: (value) => setState(() => _isFocused = value),
        child: GestureDetector(
          onTap: widget.onPressed,
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          child: AnimatedScale(
            scale: _isPressed ? 0.97 : 1,
            duration: Motion.quick,
            curve: MotionCurves.standard,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: Motion.quick,
                  curve: MotionCurves.standard,
                  constraints: const BoxConstraints(minHeight: 44),
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  decoration: BoxDecoration(
                    color: isFilled
                        ? color.withValues(alpha: _isHovered ? 0.88 : 1)
                        : color.withValues(alpha: _isHovered ? 0.08 : 0),
                    borderRadius: BorderRadius.circular(Radii.pill),
                    border: isFilled
                        ? null
                        : Border.all(color: color, width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          widget.label,
                          style: AppText.label.copyWith(
                            fontSize: 15,
                            color: textColor,
                          ),
                        ),
                      ),
                      if (widget.icon != null) ...[
                        const SizedBox(width: Space.s8),
                        Icon(widget.icon, size: 16, color: textColor),
                      ],
                    ],
                  ),
                ),
                if (_isFocused)
                  Positioned.fill(
                    left: -4,
                    top: -4,
                    right: -4,
                    bottom: -4,
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Radii.pill),
                          border: Border.all(color: color, width: 2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
