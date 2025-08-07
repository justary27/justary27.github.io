import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../enums/device_type.dart';
import '../../handlers/route_handler.dart';

class SmallNavBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> navigatorKey;
  final Size size;
  final DeviceType deviceType;

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
              Colors.black.withValues(alpha: 0.2),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        margin: EdgeInsets.only(left: 0.01 * widget.size.width),
        child: IconButton(
          splashColor: Colors.white.withValues(alpha: 0.5),
          icon: SvgPicture.asset(
            "images/ar.svg",
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 0.85),
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
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }
}
