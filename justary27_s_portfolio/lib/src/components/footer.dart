// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/anchor.dart';
import '../enums/device_type.dart';
import '../constants/route.dart';

/// Storage class for Footer constraints.
class FC {
  FC._();

  static const Map<DeviceType, double> techStack = {
    DeviceType.smallMobile: 30,
    DeviceType.largeMobile: 30,
    DeviceType.smallTablet: 35,
    DeviceType.largeTablet: 35,
    DeviceType.smallLaptop: 35,
    DeviceType.largeLaptop: 40,
    DeviceType.smallDesktop: 45,
  };
}

class Footer extends StatefulWidget {
  final Size size;

  const Footer({super.key, required this.size});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  void _handleRouteNavigation(String destination) {
    if (GoRouterState.of(context).uri.path != destination) {
      context.push(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = widget.size;
    final DeviceType deviceType = DeviceType.getDeviceType(size.width);

    return Stack(
      children: [
        Container(
          width: size.width,
          height: 0.3 * size.height,
          color: const Color.fromRGBO(134, 149, 179, 1.0),
          child: CustomPaint(painter: CircuitPainter()),
        ),
        Container(
          alignment: Alignment.topLeft,
          width: size.width,
          height: 0.3 * size.height,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 0.32 * size.width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Aryan Ranjan",
                      style: TextStyle(
                        fontFamily: "Allison",
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 0.065 * size.width,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 0.18 * size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.01 * size.height, 0, 0),
                      child: MaterialButton(
                        onPressed: () {
                          _handleRouteNavigation(RouteHandler.whoPage);
                        },
                        child: const Text(
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
                          _handleRouteNavigation(RouteHandler.workPage);
                        },
                        child: const Text(
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
                          _handleRouteNavigation(RouteHandler.blogPage);
                        },
                        child: const Text(
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
                child:
                    (deviceType < DeviceType.smallTablet)
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnchorButton(
                                      iconSize: FC.techStack[deviceType],
                                      destUrl: 'mailto:aryan_r@ch.iitr.ac.in',
                                      icon: const Icon(
                                        Icons.alternate_email_rounded,
                                      ),
                                      color: Colors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                      parentContext: context,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        0.04 * size.width,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: AnchorButton(
                                        iconSize: FC.techStack[deviceType],
                                        destUrl:
                                            'https://twitter.com/JustAry27',
                                        icon: const Icon(
                                          FontAwesomeIcons.xTwitter,
                                        ),
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                        parentContext: context,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnchorButton(
                                      iconSize: FC.techStack[deviceType],
                                      destUrl: 'https://github.com/justary27',
                                      icon: const Icon(FontAwesomeIcons.github),
                                      color: Colors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                      parentContext: context,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        0.04 * size.width,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: AnchorButton(
                                        iconSize: FC.techStack[deviceType],
                                        destUrl:
                                            'https://www.linkedin.com/in/aryan-ranjan27/',
                                        icon: const Icon(
                                          FontAwesomeIcons.linkedin,
                                        ),
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                        parentContext: context,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                        : OverflowBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            AnchorButton(
                              iconSize: FC.techStack[deviceType],
                              destUrl: 'mailto:aryan_r@ch.iitr.ac.in',
                              icon: const Icon(Icons.alternate_email_rounded),
                              color: Colors.white.withValues(alpha: 0.7),
                              parentContext: context,
                            ),
                            AnchorButton(
                              iconSize: FC.techStack[deviceType],
                              destUrl: 'https://twitter.com/JustAry27',
                              icon: const Icon(FontAwesomeIcons.xTwitter),
                              color: Colors.white.withValues(alpha: 0.7),
                              parentContext: context,
                            ),
                            AnchorButton(
                              iconSize: FC.techStack[deviceType],
                              destUrl: 'https://github.com/justary27',
                              icon: const Icon(FontAwesomeIcons.github),
                              color: Colors.white.withValues(alpha: 0.7),
                              parentContext: context,
                            ),
                            AnchorButton(
                              iconSize: FC.techStack[deviceType],
                              destUrl:
                                  'https://www.linkedin.com/in/aryan-ranjan27/',
                              icon: const Icon(FontAwesomeIcons.linkedin),
                              color: Colors.white.withValues(alpha: 0.7),
                              parentContext: context,
                            ),
                          ],
                        ),
              ),
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
    Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.white.withValues(alpha: 0.7)
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = 4;
    Path path = Path();

    path.moveTo(0.97 * size.width, 0.9 * size.height);

    path.quadraticBezierTo(
      0.98 * size.width,
      0.89 * size.height,
      1.00 * size.width,
      0.00 * size.height,
    );

    path.moveTo(0.97 * size.width, 0.9 * size.height);
    path.quadraticBezierTo(
      0.72 * size.width,
      0.98 * size.height,
      0.7 * size.width,
      0.99 * size.height,
    );
    path.lineTo(0.2 * size.width, 0.99 * size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
