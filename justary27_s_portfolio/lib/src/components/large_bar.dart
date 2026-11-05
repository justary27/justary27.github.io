import 'dart:math';

import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../enums/device_type.dart';
import '../constants/route.dart';
import '../themes/motion.dart';
import '../themes/route_ink.dart';
import '../themes/typography.dart';
import 'contact.dart';

class LargeNavBar extends StatefulWidget {
  static const double height = 72;

  final Size size;
  final DeviceType deviceType;

  const LargeNavBar({super.key, required this.size, required this.deviceType});

  @override
  State<LargeNavBar> createState() => _LargeNavBarState();
}

class _LargeNavBarState extends State<LargeNavBar> {
  void _handleRouteNavigation(String destination) {
    if (GoRouterState.of(context).uri.path != destination) {
      context.push(destination);
    }
  }

  void _openContact() {
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return ContactCard(size: widget.size, deviceType: widget.deviceType);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final ink = RouteInk.of(context);
    final linkGap = (0.04 * widget.size.width).clamp(16.0, 48.0);

    return Container(
      height: LargeNavBar.height,
      padding: EdgeInsets.symmetric(
        horizontal: max(16, 0.04 * widget.size.width),
      ),
      decoration: BoxDecoration(
        color: ink.navbar,
        border: Border(bottom: BorderSide(color: ink.navbarHairline)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: _NavLogo(
                color: ink.onNavbar,
                onTap: () => _handleRouteNavigation(RouteHandler.homePage),
              ),
            ),
          ),
          _NavButton(
            label: "Work",
            color: ink.onNavbar,
            isActive: currentPath == RouteHandler.workPage,
            onPressed: () => _handleRouteNavigation(RouteHandler.workPage),
          ),
          SizedBox(width: linkGap),
          _NavButton(
            label: "Who",
            color: ink.onNavbar,
            isActive: currentPath == RouteHandler.whoPage,
            onPressed: () => _handleRouteNavigation(RouteHandler.whoPage),
          ),
          SizedBox(width: linkGap),
          _NavButton(
            label: "Blog",
            color: ink.onNavbar,
            isActive: currentPath.startsWith(RouteHandler.blogPage),
            onPressed: () => _handleRouteNavigation(RouteHandler.blogPage),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _NavButton(
                label: "Contact",
                color: ink.onNavbar,
                isActive: false,
                onPressed: _openContact,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavLogo extends StatefulWidget {
  final Color color;
  final VoidCallback onTap;

  const _NavLogo({required this.color, required this.onTap});

  @override
  State<_NavLogo> createState() => _NavLogoState();
}

class _NavLogoState extends State<_NavLogo> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: Motion.swap,
          curve: MotionCurves.standard,
          child: SvgPicture.asset(
            "assets/images/ar.svg",
            width: 26,
            height: 40,
            semanticsLabel: "Home",
            colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final Color color;
  final bool isActive;
  final VoidCallback onPressed;

  const _NavButton({
    required this.label,
    required this.color,
    required this.isActive,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                widget.label,
                style: AppText.label.copyWith(
                  fontSize: 15,
                  color: widget.color,
                ),
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
                widthFactor: widget.isActive || _isHovered ? 1 : 0,
                child: ColoredBox(color: widget.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
