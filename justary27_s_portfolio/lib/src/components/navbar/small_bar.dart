// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/navbar/contact.dart';

import '../../app.dart';
import '../../routes/routing.dart';
import '../ar.dart';
import '../rPainter.dart';

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
      leading: MaterialButton(
        elevation: 0,
        child: CustomPaint(
          size: Size(
              40,
              (40 * 1.572944297082228)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: ArPainter(Colors.white),
        ),
        onPressed: () {
          if (RouteManager.currentRoute != "home") {
            RouteManager.navigateToHome(navigator);
            print(navigator.currentState!.restorationId);
          }
        },
        color: Colors.transparent,
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

  buildEndDrawer(Size size, String deviceType) {
    return Drawer(
      child: Container(
        height: size.height,
        width: 0.5 * size.width,
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: 0.5 * size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(218, 224, 224, 1.0),
                      Color.fromRGBO(183, 193, 192, 1.0),
                    ]),
              ),
              child: CustomPaint(
                painter: RoorkeePainter(
                  RouteManager.currentColor,
                  Color.fromRGBO(145, 155, 153, 1.0).withOpacity(0.4),
                ),
              ),
            ),
            Container(
              height: size.height,
              width: 0.5 * size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(0.025 * size.width),
                        child: MaterialButton(
                          elevation: 0,
                          child: CustomPaint(
                            size: Size(
                                40,
                                (40 * 1.572944297082228)
                                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            painter: ArPainter(Colors.white),
                          ),
                          onPressed: () {
                            if (RouteManager.currentRoute != "home") {
                              RouteManager.navigateToHome(navigator);
                              print(navigator.currentState!.restorationId);
                            }
                          },
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0.8 * size.height,
                    width: 0.5 * size.width,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text(
                            "Intro",
                            style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(color: Colors.white)),
                          ),
                          onTap: () {
                            if (RouteManager.currentRoute != "intro") {
                              RouteManager.navigateToIntro(navigator);
                            }
                          },
                        ),
                        ListTile(
                          title: Text(
                            "Who",
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            if (RouteManager.currentRoute != "who") {
                              RouteManager.navigateToWho(navigator);
                            }
                          },
                        ),
                        ListTile(
                          title: Text(
                            "Work",
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            if (RouteManager.currentRoute != "work") {
                              RouteManager.navigateToWork(navigator);
                            }
                          },
                        ),
                        ListTile(
                          title: Text(
                            "Blog",
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            if (RouteManager.currentRoute != "blog") {
                              RouteManager.navigateToBlog(navigator);
                            }
                          },
                        ),
                        ListTile(
                          title: Text(
                            "Contact",
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: widget.navigatorKey.currentContext!,
                              builder: (context) {
                                return ContactCard(
                                  size: size,
                                  deviceType: deviceType,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
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
