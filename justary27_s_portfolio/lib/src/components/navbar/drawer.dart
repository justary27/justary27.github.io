import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'contact.dart';
import '../rPainter.dart';
import '../../routes/routing.dart';
import '../../utils/handlers/route_handler.dart';

class SmallDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> navigator;
  final Size size;
  final String deviceType;
  const SmallDrawer({
    super.key,
    required this.navigator,
    required this.deviceType,
    required this.size,
  });

  @override
  State<SmallDrawer> createState() => _SmallDrawerState();
}

class _SmallDrawerState extends State<SmallDrawer> {
  void _handleRouteNavigation(String destination) {
    if (GoRouterState.of(context).uri.path != destination) {
      context.push(destination);
      widget.navigator.currentState!.closeEndDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height,
      width: 0.75 * widget.size.width,
      child: Drawer(
        child: Stack(
          children: [
            Container(
              height: widget.size.height,
              width: widget.size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(218, 224, 224, 1.0),
                    Color.fromRGBO(183, 193, 192, 1.0),
                  ],
                ),
              ),
              child: CustomPaint(
                painter: RoorkeePainter(
                  RouteManager.currentColor,
                  const Color.fromRGBO(145, 155, 153, 1.0).withOpacity(0.4),
                ),
              ),
            ),
            SizedBox(
              height: widget.size.height,
              width: widget.size.width,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(0.025 * widget.size.width),
                        child: IconButton(
                          onPressed: () => _handleRouteNavigation(
                            RouteHandler.homePage,
                          ),
                          color: Colors.transparent,
                          icon: SvgPicture.asset(
                            "images/ar.svg",
                            height: 40,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.1 * widget.size.height,
                  ),
                  ListTile(
                    title: const Text(
                      "Intro",
                      style: TextStyle(
                        fontFamily: "ABeeZee",
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => _handleRouteNavigation(
                      RouteHandler.introPage,
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Who",
                      style: TextStyle(
                        fontFamily: "ABeeZee",
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => _handleRouteNavigation(
                      RouteHandler.whoPage,
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Work",
                      style: TextStyle(
                        fontFamily: "ABeeZee",
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => _handleRouteNavigation(
                      RouteHandler.workPage,
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Blog",
                      style: TextStyle(
                        fontFamily: "ABeeZee",
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => _handleRouteNavigation(
                      RouteHandler.blogPage,
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Contact",
                      style: TextStyle(
                        fontFamily: "ABeeZee",
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      showDialog(
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
