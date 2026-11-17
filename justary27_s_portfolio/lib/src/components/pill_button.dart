import 'package:material_ui/material_ui.dart';

import '../themes/dimens.dart';
import '../themes/motion.dart';
import '../themes/route_ink.dart';
import '../themes/typography.dart';
import 'app_link.dart';

enum PillVariant { filled, outlined }

class PillButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  // Set this instead of onPressed when the pill goes somewhere.
  final String? to;
  final PillVariant variant;
  // Default to the route ink; the footer overrides them on its slate band.
  final Color? color;
  final Color? onColor;

  const PillButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.to,
    this.variant = PillVariant.outlined,
    this.color,
    this.onColor,
  }) : assert((onPressed == null) != (to == null));

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final to = widget.to;
    if (to != null) {
      return AppLink(
        to: to,
        fadeOnHover: false,
        builder: (context, states) {
          return _PillFace(
            pill: widget,
            isHovered: states.contains(WidgetState.hovered),
            isFocused: states.contains(WidgetState.focused),
            isPressed: states.contains(WidgetState.pressed),
          );
        },
      );
    }

    return Semantics(
      button: true,
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onPressed!();
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
          child: _PillFace(
            pill: widget,
            isHovered: _isHovered,
            isFocused: _isFocused,
            isPressed: _isPressed,
          ),
        ),
      ),
    );
  }
}

class _PillFace extends StatelessWidget {
  final PillButton pill;
  final bool isHovered;
  final bool isFocused;
  final bool isPressed;

  const _PillFace({
    required this.pill,
    required this.isHovered,
    required this.isFocused,
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = pill.color ?? RouteInk.of(context).ink;
    final isFilled = pill.variant == PillVariant.filled;
    final textColor = isFilled ? pill.onColor ?? Colors.white : color;

    return AnimatedScale(
      scale: isPressed ? 0.97 : 1,
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
                  ? color.withValues(alpha: isHovered ? 0.88 : 1)
                  : color.withValues(alpha: isHovered ? 0.08 : 0),
              borderRadius: BorderRadius.circular(Radii.pill),
              border: isFilled ? null : Border.all(color: color, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    pill.label,
                    style: AppText.label.copyWith(
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                ),
                if (pill.icon != null) ...[
                  const SizedBox(width: Space.s8),
                  Icon(pill.icon, size: 16, color: textColor),
                ],
              ],
            ),
          ),
          if (isFocused)
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
    );
  }
}
