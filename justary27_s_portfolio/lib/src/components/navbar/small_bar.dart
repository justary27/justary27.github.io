import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../utils/handlers/route_handler.dart';

class SmallNavBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> navigatorKey;
  final Size size;
  final String deviceType;

  const SmallNavBar({
    super.key,
    required this.navigatorKey,
    required this.size,
    required this.deviceType,
  });

  @override
  State<SmallNavBar> createState() => _SmallNavBarState();
}

class _SmallNavBarState extends State<SmallNavBar> {
  void _handleRouteNavigation(String destination) {
    if (GoRouterState.of(context).uri.path != destination) {
      context.push(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 0.15 * widget.size.height,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
      leading: Container(
        margin: EdgeInsets.only(left: 0.01 * widget.size.width),
        child: IconButton(
          splashColor: Colors.white.withOpacity(0.5),
          icon: SvgPicture.asset(
            "images/ar.svg",
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.85),
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => _handleRouteNavigation(
            RouteHandler.homePage,
          ),
          color: Colors.transparent,
        ),
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
            // Scaffold.of(widget.navigatorKey.currentContext!).openEndDrawer();
          },
        ),
      ],
    );
  }
}
