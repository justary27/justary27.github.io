// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'introConstraints.dart';
import '../../components/footer.dart';
import '../../components/rPainter.dart';
import '../../components/deviceDetector.dart';
import '../../constants/page_constants/intro_constants.dart';
import '../../components/page_components/promo_components.dart';

const Map _cf = ConstraintFactors;

class IntroPage extends StatefulWidget {
  final Size size;
  const IntroPage({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;

    return LayoutBuilder(builder: (context, constraints) {
      String _deviceType = deviceDetector(constraints.maxWidth);
      return GlowingOverscrollIndicator(
        axisDirection: AxisDirection.up,
        color: Color.fromRGBO(255, 175, 175, 1).withOpacity(0.3),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: size.width,
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
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: size.width,
                          height: size.height,
                          child: Text(
                            "Intro.",
                            style: TextStyle(
                              fontFamily: "CoveredByYourGrace",
                              color: Color.fromRGBO(14, 43, 133, 1.0),
                              fontSize:
                                  _cf['heading'][_deviceType] * size.width,
                            ),
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
                                child: Text(
                                  "Bonjour!",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.abel(
                                    textStyle: TextStyle(
                                      // fontFamily: "Caveat",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: _cf['taLine'][_deviceType] *
                                          size.width,
                                    ),
                                  ),
                                ),
                              ),
                              Transform.rotate(
                                angle: -math.pi / 9,
                                child: Container(
                                  width: _cf['rotLine'][_deviceType]['width'] *
                                      size.width,
                                  height: _cf['rotLine'][_deviceType]
                                          ['height'] *
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
                                  style: GoogleFonts.openSansCondensed(
                                    textStyle: TextStyle(
                                      // fontFamily: "Caveat",
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(14, 43, 133, 1.0),
                                      fontSize:
                                          _cf['name'][_deviceType] * size.width,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.2 * size.width),
                                child: Text(
                                  introDesc.replaceAll("\n", ""),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.redHatDisplay(
                                    textStyle: TextStyle(
                                      // fontFamily: "ABeeZee",
                                      color: Colors.black,
                                      fontSize: _cf['aboutMe'][_deviceType] *
                                          size.width,
                                    ),
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
                                    "Tech Stack",
                                    style: GoogleFonts.abel(
                                      textStyle: TextStyle(
                                        // fontFamily: "Caveat",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: _cf['taLine'][_deviceType] *
                                            size.width,
                                      ),
                                    ),
                                    // style: TextStyle(fontFamily: "Ubuntu"),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: -math.pi / 9,
                                  child: Container(
                                    width: _cf['rotLine'][_deviceType]
                                            ['width'] *
                                        size.width,
                                    height: _cf['rotLine'][_deviceType]
                                            ['height'] *
                                        size.height,
                                    color: Color.fromRGBO(20, 62, 188, 1),
                                  ),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://python.org',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/python.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://dart.dev/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/dart.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://www.javascript.com/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/js.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://www.typescriptlang.org/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/ts.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://isocpp.org/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/cpp.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://go.dev/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/go.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://www.java.com/en/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/java.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://julialang.org/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/julia.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://learn.microsoft.com/en-us/dotnet/csharp/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/csharp.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://www.terraform.io/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/terraform.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://html5.org/',
                                          'New Tab',
                                        );
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.html5,
                                        size: _cf['techStack'][_deviceType],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://developer.mozilla.org/en-US/docs/Web/CSS',
                                          'New Tab',
                                        );
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.css3,
                                        size: _cf['techStack'][_deviceType],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://sass-lang.com/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/sass.svg",
                                        height: 40,
                                      ),
                                    ),
                                  ],
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://www.djangoproject.com/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/django.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://flutter.dev/',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/flutter.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://reactjs.org',
                                          'New Tab',
                                        );
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.react,
                                        size: _cf['techStack'][_deviceType],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://reactjs.org',
                                          'New Tab',
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "images/intro/firebase.svg",
                                        height: 40,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        html.window.open(
                                          'https://reactjs.org',
                                          'New Tab',
                                        );
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.aws,
                                        size: _cf['techStack'][_deviceType],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        PromoRedirector(
                          size: size,
                          deviceType: _deviceType,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
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
