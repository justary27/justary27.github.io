// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justary27_s_portfolio/src/components/deviceDetector.dart';
import 'package:justary27_s_portfolio/src/routes/routing.dart';
import 'dart:html' as html;

import '../app.dart';

Map _cf = {
  'techStack': {
    'mobiles390-': 30,
    'mobiles450-': 30,
    'tablets768-': 35,
    'tablets1024-': 35,
    'laptops1536-': 35,
    'laptops1920-': 40,
  },
};

class NavBar extends StatefulWidget {
  final Size size;
  final String deviceType;

  const NavBar({Key? key, required this.size, required this.deviceType})
      : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    Size size = widget.size;
    final String deviceType = deviceDetector(size);
    return Stack(
      children: [
        Container(
          width: size.width,
          height: 0.3 * size.height,
          child: CustomPaint(
            painter: CircuitPainter(),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          width: size.width,
          height: 0.3 * size.height,
          color: Colors.transparent,
          child: Row(
            children: [
              Container(
                width: 0.3 * size.width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Aryan Ranjan",
                      style: TextStyle(
                          fontFamily: "Allison",
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 0.05 * size.width),
                    ),
                  ],
                ),
              ),
              Container(
                width: 0.2 * size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (RouteManager.currentRoute != "intro") {
                          RouteManager.navigateToIntro(navigator);
                        }
                      },
                      child: Text(
                        "Intro",
                        style: TextStyle(
                          fontFamily: "ABeeZee",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.01 * size.height, 0, 0),
                      child: MaterialButton(
                        onPressed: () {
                          if (RouteManager.currentRoute != "who") {
                            RouteManager.navigateToWho(navigator);
                          }
                        },
                        child: Text(
                          "Who",
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.01 * size.height, 0, 0),
                      child: MaterialButton(
                        onPressed: () {
                          if (RouteManager.currentRoute != "work") {
                            RouteManager.navigateToWork(navigator);
                          }
                        },
                        child: Text(
                          "Work",
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.01 * size.height, 0, 0),
                      child: MaterialButton(
                        onPressed: () {
                          if (RouteManager.currentRoute != "blog") {
                            RouteManager.navigateToBlog(navigator);
                          }
                        },
                        child: Text(
                          "Blog",
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 0.50 * size.width,
                alignment: Alignment.center,
                child: (deviceType == 'mobiles390-' ||
                        deviceType == 'mobiles450-')
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                      color: Colors.transparent,
                                      child: IconButton(
                                        iconSize: _cf['techStack'][deviceType],
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.alternate_email_rounded,
                                        ),
                                        color: Colors.white.withOpacity(0.7),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.04 * size.width, 0, 0, 0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: IconButton(
                                        iconSize: _cf['techStack'][deviceType],
                                        onPressed: () {
                                          html.window.open(
                                              'https://twitter.com/JustAry27',
                                              'New Tab');
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.twitter,
                                        ),
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      iconSize: _cf['techStack'][deviceType],
                                      onPressed: () {
                                        html.window.open(
                                          'https://github.com/just-ary27',
                                          'New Tab',
                                        );
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.github,
                                      ),
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.04 * size.width, 0, 0, 0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: IconButton(
                                        iconSize: _cf['techStack'][deviceType],
                                        onPressed: () {
                                          html.window.open(
                                            'https://www.linkedin.com/in/aryan-ranjan27/',
                                            'New Tab',
                                          );
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.linkedin,
                                        ),
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      // child: Link(
                                      //     uri: Uri.parse(
                                      //         "https://www.linkedin.com/in/aryan-ranjan-672899205/"),
                                      //     target: LinkTarget.blank,
                                      //     builder: (context, openLink) {
                                      //       return IconButton(
                                      //         onPressed: () {},
                                      //         icon: Icon(FontAwesomeIcons.linkedin),
                                      //         color: Colors.white.withOpacity(0.7),
                                      //       );
                                      //     }),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                              color: Colors.transparent,
                              child: IconButton(
                                iconSize: _cf['techStack'][deviceType],
                                onPressed: () {
                                  html.window.open(
                                      'mailto:aryan_r@ch.iitr.ac.in',
                                      'New Tab');
                                },
                                icon: Icon(
                                  Icons.alternate_email_rounded,
                                ),
                                color: Colors.white.withOpacity(0.7),
                              )),
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              iconSize: _cf['techStack'][deviceType],
                              onPressed: () {
                                html.window.open(
                                    'https://twitter.com/JustAry27', 'New Tab');
                              },
                              icon: Icon(
                                FontAwesomeIcons.twitter,
                              ),
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              iconSize: _cf['techStack'][deviceType],
                              onPressed: () {
                                html.window.open(
                                  'https://github.com/just-ary27',
                                  'New Tab',
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.github,
                              ),
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              iconSize: _cf['techStack'][deviceType],
                              onPressed: () {
                                html.window.open(
                                  'https://www.linkedin.com/in/aryan-ranjan27/',
                                  'New Tab',
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.linkedin,
                              ),
                              color: Colors.white.withOpacity(0.7),
                            ),
                            // child: Link(
                            //     uri: Uri.parse(
                            //         "https://www.linkedin.com/in/aryan-ranjan-672899205/"),
                            //     target: LinkTarget.blank,
                            //     builder: (context, openLink) {
                            //       return IconButton(
                            //         onPressed: () {},
                            //         icon: Icon(FontAwesomeIcons.linkedin),
                            //         color: Colors.white.withOpacity(0.7),
                            //       );
                            //     }),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withOpacity(0.7)
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 4;
    Path path = Path();

    path.moveTo(0.97 * size.width, 0.9 * size.height);
    path.quadraticBezierTo(0.98 * size.width, 0.89 * size.height,
        0.99 * size.width, 0.6 * size.height);
    path.quadraticBezierTo(0.94 * size.width, 0.57 * size.height,
        0.85 * size.width, 0.4 * size.height);
    path.moveTo(0.97 * size.width, 0.9 * size.height);
    path.quadraticBezierTo(0.72 * size.width, 0.98 * size.height,
        0.7 * size.width, 0.99 * size.height);
    path.lineTo(0.2 * size.width, 0.99 * size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
