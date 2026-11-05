// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:math' show cos, pi, sin;

import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/anchor.dart';
import '../enums/device_type.dart';
import '../constants/route.dart';
import 'large_footer.dart';

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

    if (!(deviceType < DeviceType.largeTablet)) {
      return LargeFooter(size: size);
    }

    return Stack(
      children: [
        Container(
          width: size.width,
          height: 0.3 * size.height,
          color: const Color.fromRGBO(134, 149, 179, 1.0),
          child: CustomPaint(painter: SakuraPainter()),
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
                                        icon: const FaIcon(
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
                                      icon: const FaIcon(FontAwesomeIcons.github),
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
                                        icon: const FaIcon(
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
                              icon: const FaIcon(FontAwesomeIcons.xTwitter),
                              color: Colors.white.withValues(alpha: 0.7),
                              parentContext: context,
                            ),
                            AnchorButton(
                              iconSize: FC.techStack[deviceType],
                              destUrl: 'https://github.com/justary27',
                              icon: const FaIcon(FontAwesomeIcons.github),
                              color: Colors.white.withValues(alpha: 0.7),
                              parentContext: context,
                            ),
                            AnchorButton(
                              iconSize: FC.techStack[deviceType],
                              destUrl:
                                  'https://www.linkedin.com/in/aryan-ranjan27/',
                              icon: const FaIcon(FontAwesomeIcons.linkedin),
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

/// Hand-drawn sakura (cherry blossom) branch, line-art style, anchored to
/// the right side of the footer.
class SakuraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final branchPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.white.withValues(alpha: 0.7)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = 3;

    final twigPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.white.withValues(alpha: 0.7)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = 2.2;

    // Petals are filled, not just outlined — thin stroked circles read as
    // near-invisible specks at this scale, filled dots read as flowers.
    final petalPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.white.withValues(alpha: 0.65);

    final centerPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.white.withValues(alpha: 0.9);

    // Main branch: e^x-like — stays low and nearly flat from the start all
    // the way past where the social icons end, then bends into a sudden,
    // steep rise over the last stretch to the tip.
    final mainBranch =
        Path()
          ..moveTo(0.46 * size.width, 0.98 * size.height)
          ..cubicTo(
            0.78 * size.width,
            0.94 * size.height, // stays flat/low well past the icon row
            0.92 * size.width,
            0.80 * size.height, // still low here — the rise is yet to come
            0.96 * size.width,
            0.05 * size.height, // sudden shoot-up over the final stretch
          );
    canvas.drawPath(mainBranch, branchPaint);

    // Side twigs sprouting from points along the main curve, alternating
    // left and right so the branch doesn't read as a single bare line.
    final twigA = // on the flat stretch, twigs back left/down
        Path()
          ..moveTo(0.702 * size.width, 0.903 * size.height)
          ..quadraticBezierTo(
            0.65 * size.width,
            0.88 * size.height,
            0.58 * size.width,
            0.82 * size.height,
          );
    canvas.drawPath(twigA, twigPaint);

    final twigB = // right where the flat stretch starts bending, twigs right
        Path()
          ..moveTo(0.838 * size.width, 0.738 * size.height)
          ..quadraticBezierTo(
            0.90 * size.width,
            0.68 * size.height,
            0.96 * size.width,
            0.62 * size.height,
          );
    canvas.drawPath(twigB, twigPaint);

    final twigC = // on the steep rise, twigs back left
        Path()
          ..moveTo(0.918 * size.width, 0.462 * size.height)
          ..quadraticBezierTo(
            0.85 * size.width,
            0.35 * size.height,
            0.78 * size.width,
            0.25 * size.height,
          );
    canvas.drawPath(twigC, twigPaint);

    // Blossoms sit directly on the branch/twig paths above (points taken
    // along the curves), so the composition reads as one connected sprig.
    // Includes midpoints, not just tips, so the branch looks in full bloom
    // rather than a bare line with a flower at each end.
    final blossomCenters = [
      Offset(0.507 * size.width, 0.973 * size.height), // near the base
      Offset(0.646 * size.width, 0.871 * size.height), // twig A mid
      Offset(0.58 * size.width, 0.82 * size.height), // twig A tip
      Offset(0.900 * size.width, 0.680 * size.height), // twig B mid
      Offset(0.96 * size.width, 0.62 * size.height), // twig B tip
      Offset(0.850 * size.width, 0.353 * size.height), // twig C mid
      Offset(0.78 * size.width, 0.25 * size.height), // twig C tip
      Offset(0.96 * size.width, 0.05 * size.height), // main branch tip
    ];

    for (final center in blossomCenters) {
      _drawBlossom(
        canvas,
        center,
        0.06 * size.height,
        petalPaint,
        centerPaint,
      );
    }

    // Tiny unopened buds, marking where each twig meets the main branch.
    final budCenters = [
      Offset(0.592 * size.width, 0.954 * size.height),
      Offset(0.702 * size.width, 0.903 * size.height),
      Offset(0.838 * size.width, 0.738 * size.height),
      Offset(0.918 * size.width, 0.462 * size.height),
    ];

    for (final center in budCenters) {
      canvas.drawCircle(center, 0.016 * size.height, petalPaint);
    }
  }

  void _drawBlossom(
    Canvas canvas,
    Offset center,
    double radius,
    Paint petalPaint,
    Paint centerPaint,
  ) {
    const petalCount = 5;
    final petalRadius = radius * 0.5;
    for (var i = 0; i < petalCount; i++) {
      final angle = (2 * pi / petalCount) * i - pi / 2;
      final petalCenter =
          center + Offset(cos(angle), sin(angle)) * radius * 0.58;
      canvas.drawCircle(petalCenter, petalRadius, petalPaint);
    }
    canvas.drawCircle(center, radius * 0.22, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
