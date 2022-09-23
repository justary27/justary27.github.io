import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../routes/routing.dart';
import '../rPainter.dart';
import 'contact.dart';

class SmallDrawer extends StatelessWidget {
  final GlobalKey<NavigatorState> navigator;
  final Size size;
  final String deviceType;
  const SmallDrawer({
    Key? key,
    required this.navigator,
    required this.deviceType,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FittedBox(
        fit: BoxFit.fill,
        child: Container(
          height: size.height,
          width: 0.75 * size.width,
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: 0.75 * size.width,
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
                width: 0.75 * size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0.025 * size.width),
                          child: MaterialButton(
                            elevation: 0,
                            child: SvgPicture.asset(
                              "images/ar.svg",
                              height: 40,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (RouteManager.currentRoute != "home") {
                                RouteManager.navigateToHome(navigator);
                              }
                            },
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 0.8 * size.height,
                      width: 0.75 * size.width,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            title: Text(
                              "Intro",
                              style: TextStyle(
                                fontFamily: "ABeeZee",
                                color: Colors.white,
                              ),
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
                              style: TextStyle(
                                  fontFamily: "ABeeZee", color: Colors.white),
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
                              style: TextStyle(
                                fontFamily: "ABeeZee",
                                color: Colors.white,
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
                              style: TextStyle(
                                fontFamily: "ABeeZee",
                                color: Colors.white,
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
                              style: TextStyle(
                                fontFamily: "ABeeZee",
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: navigator.currentContext!,
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
      ),
    );
  }
}
