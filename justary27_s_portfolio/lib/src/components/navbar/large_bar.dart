import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../enums/device_type.dart';
import '../../handlers/route_handler.dart';
import '../../components/navbar/contact.dart';

class LargeNavBar extends StatefulWidget {
  final Size size;
  final DeviceType deviceType;

  const LargeNavBar({
    super.key,
    required this.size,
    required this.deviceType,
  });

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
    return AppBar(
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 0.15 * widget.size.height,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _getBgColor(),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
      leading: Container(
        margin: EdgeInsets.only(
          left: 0.01 * widget.size.width,
        ),
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _handleRouteNavigation(
              RouteHandler.homePage,
            ),
            child: SvgPicture.asset(
              "images/ar.svg",
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
      title: OverflowBar(
        alignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () => _handleRouteNavigation(
              RouteHandler.whoPage,
            ),
            child: const Text(
              "Who",
              style: TextStyle(
                fontFamily: "ABeeZee",
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => _handleRouteNavigation(
              RouteHandler.workPage,
            ),
            child: const Text(
              "Work",
              style: TextStyle(
                fontFamily: "ABeeZee",
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => _handleRouteNavigation(
              RouteHandler.blogPage,
            ),
            child: const Text(
              "Blog",
              style: TextStyle(
                fontFamily: "ABeeZee",
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: MaterialButton(
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
            child: const Text(
              "Contact",
              style: TextStyle(
                fontFamily: "ABeeZee",
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
