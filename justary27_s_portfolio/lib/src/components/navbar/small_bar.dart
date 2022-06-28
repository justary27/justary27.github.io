// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../routes/routing.dart';

class SmallNavBar extends ConsumerStatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Size size;
  final String deviceType;

  const SmallNavBar({
    Key? key,
    required this.navigatorKey,
    required this.size,
    required this.deviceType,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SmallNavBarState();
}

class _SmallNavBarState extends ConsumerState<SmallNavBar> {
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
        child: MaterialButton(
          elevation: 0,
          splashColor: Colors.white.withOpacity(0.5),
          child: SvgPicture.asset(
            "images/ar.svg",
            color: Colors.white.withOpacity(0.75),
          ),
          onPressed: () {
            if (RouteManager.currentRoute != "home") {
              RouteManager.navigateToHome(widget.navigatorKey);
            }
          },
          color: Colors.transparent,
        ),
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(widget.navigatorKey.currentContext!).openEndDrawer();
          },
        ),
      ],
    );
  }
}
