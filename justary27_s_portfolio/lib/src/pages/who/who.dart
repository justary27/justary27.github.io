import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/footer.dart';
import 'dart:math' as math;
import 'whoConstraints.dart';
import 'package:justary27_s_portfolio/src/components/rPainter.dart';

const Map _cf = ConstraintFactors;

class WhoPage extends StatefulWidget {
  final Size size;
  final TabController;
  final deviceType;

  const WhoPage(
      {Key? key,
      required this.size,
      required this.TabController,
      required this.deviceType})
      : super(key: key);

  @override
  _WhoPageState createState() => _WhoPageState();
}

class _WhoPageState extends State<WhoPage> {
  @override
  Widget build(BuildContext context) {
    Size size = widget.size;
    TabController _tabController = widget.TabController;
    String deviceType = widget.deviceType;

    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.up,
      color: Color.fromRGBO(198, 197, 255, 1.0).withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: 4 * size.height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromRGBO(198, 197, 255, 1.0),
                                Color.fromRGBO(133, 130, 234, 1.0),
                              ]),
                        ),
                      ),
                      Container(
                        height: size.height,
                        width: size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromRGBO(232, 236, 236, 1.0),
                                Color.fromRGBO(218, 224, 224, 1.0),
                              ]),
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
                              Color.fromRGBO(14, 43, 133, 1.0),
                              Color.fromRGBO(184, 194, 215, 1.0)),
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
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height,
                        alignment: Alignment.center,
                        child: Text(
                          "Who?",
                          style: GoogleFonts.coveredByYourGrace(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(14, 43, 133, 1.0),
                                  fontSize:
                                      _cf['heading'][deviceType] * size.width)),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: size.width,
                            height: size.height,
                          ),
                        ],
                      ),
                      Container(
                        width: size.width,
                        height: size.height,
                      ),
                      Container(
                        width: size.width,
                        height: size.height,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width,
                          height: size.height,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.02 * size.height),
                                  child: Text("Work",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.caveatBrush(
                                          textStyle: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: _cf['taLine']
                                                      [deviceType] *
                                                  size.width))),
                                ),
                                Transform.rotate(
                                  angle: -math.pi / 9,
                                  child: Container(
                                    width: _cf['rotLine'][deviceType]['width'] *
                                        size.width,
                                    height: _cf['rotLine'][deviceType]
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
                                    "Check out all of my work!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.caveatBrush(
                                        textStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                14, 43, 133, 1.0),
                                            fontSize: 0.05 * size.width)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.2 * size.width),
                                  child: MaterialButton(
                                    onPressed: () {
                                      _tabController.animateTo(2);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 0.065 * size.width,
                                      height: 0.05 * size.height,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                          ),
                                          Text(
                                            "Work",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: size.width,
                        height: size.height,
                      ),
                      NavBar(size: size, tabController: _tabController),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class RoorkeePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..style = PaintingStyle.fill
//       ..shader = LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomLeft,
//           colors: [
//             Color.fromRGBO(14, 43, 133, 1.0),
//             Color.fromRGBO(184, 194, 215, 1.0)
//           ]).createShader(Offset.zero & size);
//     ;
//     Path path = Path();
//
//     // path.lineTo(size.width, size.height);
//
//     path.moveTo(size.width, 0.48 * size.height);
//     path.quadraticBezierTo(
//       0.9 * size.width,
//       0.5 * size.height,
//       0.9 * size.width,
//       0.7 * size.height,
//     );
//     path.lineTo(0.12 * size.width, 0.7 * size.height);
//     path.lineTo(0.12 * size.width, 0.65 * size.height);
//     path.lineTo(0, 0.65 * size.height);
//     path.lineTo(0, size.height);
//     path.lineTo(size.width, size.height);
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
