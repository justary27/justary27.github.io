import 'dart:math';

import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../enums/device_type.dart';
import '../constants/route.dart';
import '../enums/layout.dart';
import '../themes/motion.dart';
import '../themes/route_ink.dart';
import '../themes/typography.dart';
import 'app_link.dart';
import 'contact_envelope.dart';

// What a post page tells the navbar: its title, and whether the red header
// has scrolled under the bar.
class NavReading {
  final String title;
  final bool titleOn;

  const NavReading({required this.title, this.titleOn = false});
}

class NavBar extends StatefulWidget {
  static const double height = 72;

  // Set by a post page; the bar only reads it on post routes.
  static final ValueNotifier<NavReading?> reading = ValueNotifier(null);

  final Size size;
  final DeviceType deviceType;

  const NavBar({super.key, required this.size, required this.deviceType});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void _openContact() => showContactEnvelope(context);

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final ink = RouteInk.of(context);
    final linkGap = (0.04 * widget.size.width).clamp(16.0, 48.0);
    final onPost = currentPath.startsWith("${RouteHandler.blogPage}/");
    final phone = Layout.of(widget.size).isPhone;

    final links = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _NavLink(
          label: "Work",
          to: RouteHandler.workPage,
          color: ink.onNavbar,
          isActive: currentPath == RouteHandler.workPage,
        ),
        SizedBox(width: linkGap),
        _NavLink(
          label: "Who",
          to: RouteHandler.whoPage,
          color: ink.onNavbar,
          isActive: currentPath == RouteHandler.whoPage,
        ),
        SizedBox(width: linkGap),
        _NavLink(
          label: "Blog",
          to: RouteHandler.blogPage,
          color: ink.onNavbar,
          isActive: currentPath.startsWith(RouteHandler.blogPage),
        ),
      ],
    );

    return Container(
      height: NavBar.height,
      padding: EdgeInsets.symmetric(
        horizontal: max(16, 0.04 * widget.size.width),
      ),
      decoration: BoxDecoration(
        color: ink.navbar,
        border: Border(bottom: BorderSide(color: ink.navbarHairline)),
      ),
      child: ValueListenableBuilder<NavReading?>(
        valueListenable: NavBar.reading,
        builder: (context, reading, _) {
          final post = onPost ? reading : null;
          // Past a post's header the links make room for its title.
          final titleOn = post?.titleOn ?? false;
          return Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NavLogo(color: ink.onNavbar),
                    if (post != null) ...[
                      _Reveal(
                        open: titleOn,
                        gap: phone ? 14 : 28,
                        child: AppLink(
                          to: RouteHandler.blogPage,
                          label: "All notes",
                          fadeOnHover: false,
                          builder: (context, states) => _NavLabel(
                            label: "← All notes",
                            color: ink.onNavbar,
                            isUnderlined: states.contains(WidgetState.hovered),
                          ),
                        ),
                      ),
                      _Reveal(
                        open: titleOn,
                        gap: 16,
                        delay: 80 / 320,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: phone
                                ? 0.36 * widget.size.width
                                : min(0.34 * widget.size.width, 460),
                          ),
                          child: ExcludeSemantics(
                            excluding: !titleOn,
                            // Same baseline as the links, which leave room for
                            // their underline.
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "/  ",
                                      style: TextStyle(color: _onRedMuted),
                                    ),
                                    TextSpan(text: post.title),
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppText.label.copyWith(
                                  fontSize: 15,
                                  color: ink.onNavbar,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Centred normally; on a scrolled post it docks left of Contact.
              Positioned.fill(
                child: AnimatedPadding(
                  duration: _morph,
                  curve: MotionCurves.standard,
                  padding: EdgeInsets.only(right: titleOn ? 124 : 0),
                  child: AnimatedAlign(
                    duration: _morph,
                    curve: MotionCurves.standard,
                    alignment: titleOn
                        ? Alignment.centerRight
                        : Alignment.center,
                    // A phone has no room for both: the title replaces them.
                    child: AnimatedOpacity(
                      duration: _morph,
                      opacity: phone && titleOn ? 0 : 1,
                      child: IgnorePointer(
                        ignoring: phone && titleOn,
                        child: links,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _NavButton(
                  label: "Contact",
                  color: ink.onNavbar,
                  onPressed: _openContact,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

const Duration _morph = Duration(milliseconds: 320);
const Color _onRedMuted = Color(0xFFF7C9C4);

// Grows in from zero width after a [gap], fading as it opens.
class _Reveal extends StatelessWidget {
  final bool open;
  final double gap;
  final double delay;
  final Widget child;

  const _Reveal({
    required this.open,
    required this.gap,
    required this.child,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: open ? 1 : 0),
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : _morph,
      curve: MotionCurves.standard,
      builder: (context, t, child) {
        final fade = ((t - delay) / (1 - delay)).clamp(0.0, 1.0);
        return IgnorePointer(
          ignoring: !open,
          child: Padding(
            padding: EdgeInsets.only(left: gap * t),
            child: ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: t,
                child: Opacity(opacity: fade, child: child),
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}

class _NavLogo extends StatelessWidget {
  final Color color;

  const _NavLogo({required this.color});

  @override
  Widget build(BuildContext context) {
    return AppLink(
      to: RouteHandler.homePage,
      label: "Home",
      fadeOnHover: false,
      builder: (context, states) {
        return AnimatedScale(
          scale: states.contains(WidgetState.hovered) ? 1.05 : 1.0,
          duration: Motion.swap,
          curve: MotionCurves.standard,
          child: SvgPicture.asset(
            "assets/images/ar.svg",
            width: 26,
            height: 40,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        );
      },
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String to;
  final Color color;
  final bool isActive;

  const _NavLink({
    required this.label,
    required this.to,
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AppLink(
      to: to,
      fadeOnHover: false,
      builder: (context, states) {
        return _NavLabel(
          label: label,
          color: color,
          isUnderlined: isActive || states.contains(WidgetState.hovered),
        );
      },
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _NavButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (hovered) => setState(() => _isHovered = hovered),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: widget.color.withValues(alpha: 0.12),
      child: _NavLabel(
        label: widget.label,
        color: widget.color,
        isUnderlined: _isHovered,
      ),
    );
  }
}

class _NavLabel extends StatelessWidget {
  final String label;
  final Color color;
  final bool isUnderlined;

  const _NavLabel({
    required this.label,
    required this.color,
    required this.isUnderlined,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              label,
              style: AppText.label.copyWith(fontSize: 15, color: color),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 2,
            child: AnimatedFractionallySizedBox(
              duration: Motion.step,
              curve: MotionCurves.standard,
              alignment: Alignment.centerLeft,
              widthFactor: isUnderlined ? 1 : 0,
              child: ColoredBox(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
