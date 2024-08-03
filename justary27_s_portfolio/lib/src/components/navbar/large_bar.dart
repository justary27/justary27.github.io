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
              Colors.white.withOpacity(0.75),
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => _handleRouteNavigation(
            RouteHandler.homePage,
          ),
          color: Colors.transparent,
        ),
      ),
      title: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onHover: (pointer) {},
            child: MaterialButton(
              onPressed: () => _handleRouteNavigation(
                RouteHandler.introPage,
              ),
              child: const Text(
                "Intro",
                style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => _handleRouteNavigation(
              RouteHandler.whoPage,
            ),
            child: const Text(
              "Who",
              style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: () => _handleRouteNavigation(
              RouteHandler.workPage,
            ),
            child: const Text(
              "Work",
              style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
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
              ),
            ),
          ),
        ],
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            showDialog(
              useRootNavigator: false,
              context: context,
              builder: (context) {
                return ContactCard(
                    size: widget.size, deviceType: widget.deviceType);
              },
            );
          },
          child: const Text(
            "Contact",
            style: TextStyle(
              fontFamily: "ABeeZee",
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
