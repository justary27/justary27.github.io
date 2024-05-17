import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/footer.dart';
import '../../components/rPainter.dart';
import '../../components/deviceDetector.dart';
import '../../utils/handlers/route_handler.dart';
import '../../constants/page_constants/who_constants.dart';
import '../../components/page_components/promo_components.dart';

import 'who_constraints.dart' show cf;

class WhoPage extends StatefulWidget {
  const WhoPage({
    super.key,
  });

  @override
  State<WhoPage> createState() => _WhoPageState();
}

class _WhoPageState extends State<WhoPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final Size size = Size(
        constraints.maxWidth,
        constraints.maxHeight,
      );
      String _deviceType = deviceDetector(size.width);
      return GlowingOverscrollIndicator(
        axisDirection: AxisDirection.up,
        color: const Color.fromRGBO(198, 197, 255, 1.0).withOpacity(0.3),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: size.width,
                        height: 5.5 * size.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromRGBO(198, 197, 255, 1.0),
                                Color.fromRGBO(133, 130, 234, 1.0),
                              ]),
                        ),
                        child: CustomPaint(
                          painter: WhoPainter(),
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: size.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromRGBO(218, 224, 224, 1.0),
                                Color.fromRGBO(183, 193, 192, 1.0)
                              ]),
                        ),
                        child: CustomPaint(
                          painter: RoorkeePainter(
                              const Color.fromRGBO(14, 43, 133, 1.0),
                              const Color.fromRGBO(184, 194, 215, 1.0)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height,
                        alignment: Alignment.center,
                        child: Text(
                          "Who?",
                          style: TextStyle(
                            fontFamily: "CoveredByYourGrace",
                            color: const Color.fromRGBO(14, 43, 133, 1.0),
                            fontSize: cf['heading'][_deviceType] * size.width,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: 1.5 * size.height,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.25 * size.width,
                              height: 1.5 * size.height,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.1 * size.width,
                              ),
                              width: 0.7 * size.width,
                              height: 1.5 * size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Present",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        // fontFamily: "Caveat",
                                        color: const Color.fromRGBO(
                                            14, 43, 133, 1.0),
                                        fontSize: cf['time'][_deviceType] *
                                            size.width,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    presentDesc.replaceAll("\n", ""),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.redHatDisplay(
                                      textStyle: TextStyle(
                                        // fontFamily: "ABeeZee",
                                        color: Colors.black,
                                        fontSize: cf['timeDesc'][_deviceType] *
                                            size.width,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: 1.5 * size.height,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.1 * size.width,
                              ),
                              width: 0.7 * size.width,
                              height: 1.5 * size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Future",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        // fontFamily: "Caveat",
                                        color: const Color.fromRGBO(
                                            14, 43, 133, 1.0),
                                        fontSize: cf['time'][_deviceType] *
                                            size.width,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    futureDesc.replaceAll("\n", ""),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.redHatDisplay(
                                      textStyle: TextStyle(
                                        // fontFamily: "ABeeZee",
                                        color: Colors.black,
                                        fontSize: cf['timeDesc'][_deviceType] *
                                            size.width,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 0.25 * size.width,
                              height: 1.5 * size.height,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: 1.5 * size.height,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.25 * size.width,
                              height: 1.5 * size.height,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.1 * size.width,
                              ),
                              width: 0.7 * size.width,
                              height: 1.5 * size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Past",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        // fontFamily: "Caveat",
                                        color: const Color.fromRGBO(
                                            14, 43, 133, 1.0),
                                        fontSize: cf['time'][_deviceType] *
                                            size.width,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    pastDesc.replaceAll("\n", ""),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.redHatDisplay(
                                      textStyle: TextStyle(
                                        // fontFamily: "ABeeZee",
                                        color: Colors.black,
                                        fontSize: cf['timeDesc'][_deviceType] *
                                            size.width,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      PromoRedirector(
                        size: size,
                        deviceType: _deviceType,
                        pageName: "Blog",
                        pageDescriptor: "Know more 'bout me!",
                        button: TextButton.icon(
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          onPressed: () {
                            context.push(RouteHandler.blogPage);
                          },
                          label: Text(
                            "Blog",
                            style: TextStyle(
                              fontFamily: "ABeeZee",
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Footer(
                        size: size,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

class WhoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color.fromRGBO(14, 43, 133, 1.0)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    Path path = Path();

    path.moveTo(0, 0.1818 * size.height);
    path.quadraticBezierTo(
      0.125 * size.width,
      0.1818 * size.height,
      0.125 * size.width,
      0.2727 * size.height,
    );

    path.moveTo(0.125 * size.width, 0.2727 * size.height);
    path.quadraticBezierTo(
      0.125 * size.width,
      0.4545 * size.height,
      0.5 * size.width,
      0.4545 * size.height,
    );
    path.quadraticBezierTo(
      0.875 * size.width,
      0.4545 * size.height,
      0.875 * size.width,
      0.5908 * size.height,
    );
    path.quadraticBezierTo(
      0.875 * size.width,
      0.7272 * size.height,
      0.5 * size.width,
      0.7272 * size.height,
    );
    path.quadraticBezierTo(
      0.125 * size.width,
      0.7272 * size.height,
      0.125 * size.width,
      0.8636 * size.height,
    );
    path.lineTo(0.125 * size.width, size.height);

    canvas.drawPath(path, paint);
    canvas.drawCircle(
        Offset(0.125 * size.width, 0.2727 * size.height), 35, paint);
    canvas.drawCircle(
        Offset(0.875 * size.width, 0.5909 * size.height), 35, paint);
    canvas.drawCircle(
        Offset(0.125 * size.width, 0.8636 * size.height), 35, paint);

    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(0.125 * size.width, 0.2727 * size.height), 20, paint);
    canvas.drawCircle(
        Offset(0.875 * size.width, 0.5909 * size.height), 20, paint);
    canvas.drawCircle(
        Offset(0.125 * size.width, 0.8636 * size.height), 20, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
