// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/footer.dart';
import 'package:justary27_s_portfolio/src/customIcons/flutterIcon.dart';
import 'package:justary27_s_portfolio/src/customIcons/djangoIcon.dart';
import 'dart:math' as math;
import '../../components/page_components/promo_components.dart';
import 'introConstraints.dart';
import 'package:justary27_s_portfolio/src/components/rPainter.dart';
import 'dart:html' as html;

const Map _cf = ConstraintFactors;

class IntroPage extends StatefulWidget {
  final Size size;
  final String deviceType;
  const IntroPage({
    Key? key,
    required this.size,
    required this.deviceType,
  }) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    final String deviceType = widget.deviceType;

    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.up,
      color: Color.fromRGBO(255, 175, 175, 1).withOpacity(0.3),
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: 4.3 * size.height,
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          height: 3 * size.height,
                          color: Color.fromRGBO(255, 175, 175, 1),
                          child: CustomPaint(
                            painter: DividerPaint(),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
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
                              Color.fromRGBO(236, 131, 131, 1.0),
                              Color.fromRGBO(145, 155, 153, 1.0)
                                  .withOpacity(0.4),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 0.3 * size.height,
                          color: Color.fromRGBO(134, 149, 179, 1.0),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 4.3 * size.height,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: size.width,
                          height: size.height,
                          child: Text(
                            "Intro.",
                            style: GoogleFonts.coveredByYourGrace(
                                textStyle: TextStyle(
                                    color: Color.fromRGBO(14, 43, 133, 1.0),
                                    fontSize: _cf['heading'][deviceType] *
                                        size.width)),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width,
                          height: size.height,
                          // color: Color.fromRGBO(255, 175, 175, 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.02 * size.height),
                                child: Text("Bonjour!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.caveatBrush(
                                        textStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: _cf['taLine']
                                                    [deviceType] *
                                                size.width))),
                              ),
                              Transform.rotate(
                                angle: -math.pi / 9,
                                child: Container(
                                  width: _cf['rotLine'][deviceType]['width'] *
                                      size.width,
                                  height: _cf['rotLine'][deviceType]['height'] *
                                      size.height,
                                  color: Color.fromRGBO(20, 62, 188, 1),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.2 * size.width,
                                    vertical: 0.04 * size.height),
                                child: Text(
                                  "I'm Aryan Ranjan.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.caveatBrush(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(14, 43, 133, 1.0),
                                          fontSize: _cf['name'][deviceType] *
                                              size.width)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.2 * size.width),
                                child: Text(
                                  "I'm a sophomore at Indian Institute of Technology Roorkee. Currently I'm pursuing a Btech degree in Chemical Enginnering. I'm very fascinated with computers, hence I'm interested in all its major fields like development, competitive programming, data science & UI/UX design.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: _cf['aboutMe'][deviceType] *
                                            size.width),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width,
                          height: size.height,
                          // color: Color.fromRGBO(255, 175, 175, 1),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Tech-stack",
                                    style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle()),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: () {
                                          html.window.open(
                                              'https://python.org', 'New Tab');
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.python,
                                          size: _cf['techStack'][deviceType],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: () {
                                          html.window.open(
                                              'https://flutter.dev', 'New Tab');
                                        },
                                        icon: Icon(
                                          HomeButton.flutter,
                                          size: _cf['techStack'][deviceType],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: () {
                                          html.window.open(
                                              'https://www.djangoproject.com/',
                                              'New Tab');
                                        },
                                        icon: Icon(
                                          DjangoButton.django,
                                          size: _cf['techStack'][deviceType],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: () {
                                          html.window.open(
                                              'https://html5.org/', 'New Tab');
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.html5,
                                          size: _cf['techStack'][deviceType],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: () {
                                          html.window.open(
                                              'https://developer.mozilla.org/en-US/docs/Web/CSS',
                                              'New Tab');
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.css3,
                                          size: _cf['techStack'][deviceType],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        PromoRedirector(
                          size: size,
                          deviceType: deviceType,
                          pageName: "Business?",
                          pageDescriptor: "Check out my resume!",
                          button: TextButton.icon(
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            onPressed: () {
                              html.window.open(
                                "https://drive.google.com/file/d/1iLO8MrPIvYoL8wnAvUOJanr2o4-9K27g/view?usp=sharing",
                                "New Tab",
                              );
                            },
                            label: Text(
                              "Resume",
                              style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        NavBar(
                          size: size,
                          deviceType: deviceType,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(255, 175, 175, 1),
            Color.fromRGBO(234, 98, 98, 1.0),
          ]).createShader(Offset.zero & size);

    Path path = Path();

    path.moveTo(size.width, 0.6 * size.height);
    path.lineTo(0, 0.7 * size.height);
    path.lineTo(0, 0.7 * size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
    Path path1 = Path();
    Paint paint1 = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(255, 175, 175, 1),
            Color.fromRGBO(236, 131, 131, 1.0),
          ]).createShader(Offset.zero & size);
    path1.moveTo(size.width, 0.5 * size.height);
    path1.quadraticBezierTo(0.85 * size.width, 0.61 * size.height,
        0.7 * size.width, 0.63 * size.height);
    path1.lineTo(size.width, 0.6 * size.height);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
