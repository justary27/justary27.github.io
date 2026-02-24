import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../enums/device_type.dart';
import '../../constants/route.dart';
import '../../components/navbar/contact.dart';

class LargeNavBar extends StatefulWidget {
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

  Color _getBgColor() {
    if (GoRouterState.of(context).uri.path == RouteHandler.homePage) {
      return Colors.black.withValues(alpha: 0.4);
    } else {
      return Colors.black.withValues(alpha: 0.2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return AppBar(
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 0.15 * widget.size.height,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_getBgColor(), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
      leading: Container(
        margin: EdgeInsets.only(left: 0.01 * widget.size.width),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: _NavLogo(
          color: Colors.white,
          onTap: () => _handleRouteNavigation(RouteHandler.homePage),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NavButton(
            label: "Who",
            color: Colors.white,
            isActive: currentPath == RouteHandler.whoPage,
            onPressed: () => _handleRouteNavigation(RouteHandler.whoPage),
          ),
          _NavButton(
            label: "Work",
            color: Colors.white,
            isActive: currentPath == RouteHandler.workPage,
            onPressed: () => _handleRouteNavigation(RouteHandler.workPage),
          ),
          _NavButton(
            label: "Blog",
            color: Colors.white,
            isActive: currentPath.startsWith(RouteHandler.blogPage),
            onPressed: () => _handleRouteNavigation(RouteHandler.blogPage),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: _NavButton(
            label: "Contact",
            color: Colors.white,
            isActive: false,
            onPressed: () {
              showDialog(
                useRootNavigator: false,
                context: context,
                builder: (context) {
                  return ContactCard(
                    size: widget.size,
                    deviceType: widget.deviceType,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Logo widget with hover scale effect
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
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: SvgPicture.asset(
            "images/ar.svg",
            colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

/// Navigation button with animated underline
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: InkWell(
          onTap: widget.onPressed,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: "ABeeZee",
                    color: widget.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                _AnimatedUnderline(
                  color: widget.color,
                  isActive: widget.isActive,
                  isHovered: _isHovered,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Animated underline that appears on hover or when page is active
class _AnimatedUnderline extends StatelessWidget {
  final Color color;
  final bool isActive;
  final bool isHovered;

  const _AnimatedUnderline({
    required this.color,
    required this.isActive,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showUnderline = isActive || isHovered;
        // Handle infinite constraints by providing a fallback width
        final maxWidth =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 100.0;

        return SizedBox(
          width: maxWidth,
          height: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: 2,
              width: showUnderline ? maxWidth : 0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        );
      },
    );
  }
}
