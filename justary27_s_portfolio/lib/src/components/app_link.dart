import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/link.dart';

import '../themes/dimens.dart';
import '../themes/motion.dart';

typedef AppLinkBuilder = Widget Function(
  BuildContext context,
  Set<WidgetState> states,
);

class AppLink extends StatefulWidget {
  // A path is an in-app route; anything with a scheme opens in a new tab.
  final String to;
  final String? label;
  final bool fadeOnHover;
  final AppLinkBuilder? builder;
  final Widget? icon;
  final double? iconSize;
  final Color? color;

  const AppLink({
    super.key,
    required this.to,
    required AppLinkBuilder this.builder,
    this.label,
    this.fadeOnHover = true,
  }) : icon = null,
       iconSize = null,
       color = null;

  const AppLink.icon({
    super.key,
    required this.to,
    required Widget this.icon,
    this.label,
    this.iconSize,
    this.color,
  }) : builder = null,
       fadeOnHover = true;

  @override
  State<AppLink> createState() => _AppLinkState();
}

class _AppLinkState extends State<AppLink> {
  final Set<WidgetState> _states = {};

  void _setState(WidgetState state, bool isOn) {
    setState(() => isOn ? _states.add(state) : _states.remove(state));
  }

  Widget _buildIcon() {
    final iconSize = widget.iconSize ?? 24;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _states.contains(WidgetState.focused)
            ? (widget.color ?? Colors.black).withValues(alpha: 0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(Radii.small),
      ),
      child: SizedBox.square(
        dimension: max(44, iconSize),
        child: Center(
          child: IconTheme.merge(
            data: IconThemeData(size: iconSize, color: widget.color),
            child: widget.icon!,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(widget.to);
    final content = widget.builder?.call(context, _states) ?? _buildIcon();

    return Link(
      uri: uri,
      target: uri.hasScheme ? LinkTarget.blank : LinkTarget.self,
      builder: (context, followLink) {
        return Semantics(
          label: widget.label,
          child: FocusableActionDetector(
            mouseCursor: SystemMouseCursors.click,
            actions: {
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (_) {
                  followLink?.call();
                  return null;
                },
              ),
            },
            onShowHoverHighlight: (value) =>
                _setState(WidgetState.hovered, value),
            // Keyboard focus only, so a mouse click never leaves a ring behind.
            onShowFocusHighlight: (value) =>
                _setState(WidgetState.focused, value),
            child: GestureDetector(
              onTap: () => followLink?.call(),
              onTapDown: (_) => _setState(WidgetState.pressed, true),
              onTapUp: (_) => _setState(WidgetState.pressed, false),
              onTapCancel: () => _setState(WidgetState.pressed, false),
              child: widget.fadeOnHover
                  ? AnimatedOpacity(
                      opacity: _states.contains(WidgetState.hovered) ? 0.75 : 1,
                      duration: Motion.quick,
                      curve: MotionCurves.standard,
                      child: content,
                    )
                  : content,
            ),
          ),
        );
      },
    );
  }
}
