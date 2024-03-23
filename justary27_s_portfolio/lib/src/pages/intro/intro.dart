// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justary27_s_portfolio/src/components/anchor.dart';

import '../../components/footer.dart';
import '../../components/rPainter.dart';
import '../../components/deviceDetector.dart';
import '../../constants/page_constants/intro_constants.dart';
import '../../components/page_components/promo_components.dart';

import 'intro_constraints.dart' show cf;

class IntroPage extends StatefulWidget {
  final Size size;
  const IntroPage({
    super.key,
    required this.size,
  });

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;

    return LayoutBuilder(
      builder: (context, constraints) {
        String _deviceType = deviceDetector(constraints.maxWidth);
        return GlowingOverscrollIndicator(
          axisDirection: AxisDirection.up,
          color: const Color.fromRGBO(255, 175, 175, 1).withOpacity(0.3),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: size.width,
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            height: 3 * size.height,
                            color: const Color.fromRGBO(255, 175, 175, 1),
                            child: CustomPaint(
                              painter: DividerPaint(),
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
                                const Color.fromRGBO(236, 131, 131, 1.0),
                                const Color.fromRGBO(145, 155, 153, 1.0)
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
                                color: const Color.fromRGBO(14, 43, 133, 1.0),
                                fontSize:
                                    cf['heading'][_deviceType] * size.width,
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
                                        fontSize: cf['taLine'][_deviceType] *
                                            size.width,
                                      ),
                                    ),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: -math.pi / 9,
                                  child: Container(
                                    width: cf['rotLine'][_deviceType]['width'] *
                                        size.width,
                                    height: cf['rotLine'][_deviceType]
                                            ['height'] *
                                        size.height,
                                    color: const Color.fromRGBO(20, 62, 188, 1),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.2 * size.width,
                                      vertical: 0.04 * size.height),
                                  child: Text(
                                    "I'm Aryan Ranjan.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Allison",
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromRGBO(
                                          14, 43, 133, 1.0),
                                      fontSize:
                                          cf['name'][_deviceType] * size.width,
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
                                        fontSize: cf['aboutMe'][_deviceType] *
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
                                          fontSize: cf['taLine'][_deviceType] *
                                              size.width,
                                        ),
                                      ),
                                      // style: TextStyle(fontFamily: "Ubuntu"),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: -math.pi / 9,
                                    child: Container(
                                      width: cf['rotLine'][_deviceType]
                                              ['width'] *
                                          size.width,
                                      height: cf['rotLine'][_deviceType]
                                              ['height'] *
                                          size.height,
                                      color:
                                          const Color.fromRGBO(20, 62, 188, 1),
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      AnchorButton(
                                        destUrl: 'https://python.org',
                                        icon: Icon(
                                          FontAwesomeIcons.python,
                                          size: cf['techStack'][_deviceType],
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://dart.dev/',
                                        icon: SvgPicture.asset(
                                          "images/intro/dart.svg",
                                          height: 40,
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://www.javascript.com/',
                                        icon: Icon(
                                          FontAwesomeIcons.js,
                                          size: cf['techStack'][_deviceType],
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl:
                                            'https://www.typescriptlang.org/',
                                        icon: SvgPicture.asset(
                                          "images/intro/ts.svg",
                                          height: 40,
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://isocpp.org/',
                                        icon: SvgPicture.asset(
                                          "images/intro/cpp.svg",
                                          height: 40,
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://go.dev/',
                                        icon: Icon(
                                          FontAwesomeIcons.golang,
                                          size: cf['techStack'][_deviceType],
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://www.java.com/en/',
                                        icon: Icon(
                                          FontAwesomeIcons.java,
                                          size: cf['techStack'][_deviceType],
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://julialang.org/',
                                        icon: SvgPicture.asset(
                                          "images/intro/julia.svg",
                                          colorFilter: const ColorFilter.mode(
                                            Color(0xFF49454F),
                                            BlendMode.srcIn,
                                          ),
                                          height: 40,
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl:
                                            'https://learn.microsoft.com/en-us/dotnet/csharp/',
                                        icon: SvgPicture.asset(
                                          "images/intro/csharp.svg",
                                          height: 40,
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://www.terraform.io/',
                                        icon: SvgPicture.asset(
                                          "images/intro/terraform.svg",
                                          height: 40,
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://html5.org/',
                                        icon: Icon(
                                          FontAwesomeIcons.html5,
                                          size: cf['techStack'][_deviceType],
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl:
                                            'https://developer.mozilla.org/en-US/docs/Web/CSS',
                                        icon: Icon(
                                          FontAwesomeIcons.css3,
                                          size: cf['techStack'][_deviceType],
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://sass-lang.com/',
                                        icon: Icon(
                                          FontAwesomeIcons.sass,
                                          size: cf['techStack'][_deviceType],
                                        ),
                                        parentContext: context,
                                      ),
                                    ],
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      AnchorButton(
                                        destUrl:
                                            'https://www.djangoproject.com/',
                                        icon: SvgPicture.asset(
                                          "images/intro/django.svg",
                                          height: 40,
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://flutter.dev/',
                                        icon: SvgPicture.asset(
                                          "images/intro/flutter.svg",
                                          height: 40,
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://reactjs.org',
                                        icon: Icon(
                                          FontAwesomeIcons.react,
                                          size: cf['techStack'][_deviceType],
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://firebase.google.com/',
                                        icon: SvgPicture.asset(
                                          "images/intro/firebase.svg",
                                          height: 40,
                                        ),
                                        parentContext: context,
                                      ),
                                      AnchorButton(
                                        destUrl: 'https://aws.amazon.com/',
                                        icon: Icon(
                                          FontAwesomeIcons.aws,
                                          size: cf['techStack'][_deviceType],
                                        ),
                                        parentContext: context,
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
      },
    );
  }
}

class DividerPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(
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
      ..shader = const LinearGradient(
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
