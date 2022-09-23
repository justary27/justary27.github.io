import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/components/footer.dart';
import 'package:justary27_s_portfolio/src/components/page_components/promo_components.dart';
import 'package:justary27_s_portfolio/src/constants/page_constants/who_constants.dart';
import 'package:justary27_s_portfolio/src/routes/routing.dart';
import '../../app.dart';
import 'whoConstraints.dart';
import 'package:justary27_s_portfolio/src/components/rPainter.dart';

const Map _cf = ConstraintFactors;

class WhoPage extends StatefulWidget {
  final Size size;
  final String deviceType;
  const WhoPage({
    Key? key,
    required this.size,
    required this.deviceType,
  }) : super(key: key);

  @override
  _WhoPageState createState() => _WhoPageState();
}

class _WhoPageState extends State<WhoPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    final String deviceType = widget.deviceType;

    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.up,
      color: Color.fromRGBO(198, 197, 255, 1.0).withOpacity(0.3),
      child: Material(
        elevation: 0,
        color: Colors.transparent,
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
                          height: 5.5 * size.height,
                          decoration: BoxDecoration(
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
                            style: TextStyle(
                              fontFamily: "CoveredByYourGrace",
                              color: Color.fromRGBO(14, 43, 133, 1.0),
                              fontSize: _cf['heading'][deviceType] * size.width,
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 1.5 * size.height,
                          child: Row(
                            children: [
                              Container(
                                width: 0.25 * size.width,
                                height: 1.5 * size.height,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.1 * size.width),
                                width: 0.7 * size.width,
                                height: 1.5 * size.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Present",
                                      style: TextStyle(
                                          fontFamily: "Caveat",
                                          color:
                                              Color.fromRGBO(14, 43, 133, 1.0),
                                          fontSize: _cf['time'][deviceType] *
                                              size.width,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      presentDesc.replaceAll("\n", ""),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: "ABeeZee",
                                        color: Colors.black,
                                        fontSize: _cf['timeDesc'][deviceType] *
                                            size.width,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 1.5 * size.height,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.1 * size.width),
                                width: 0.7 * size.width,
                                height: 1.5 * size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Future",
                                      style: TextStyle(
                                        fontFamily: "Caveat",
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(14, 43, 133, 1.0),
                                        fontSize: _cf['time'][deviceType] *
                                            size.width,
                                      ),
                                    ),
                                    Text(
                                      futureDesc.replaceAll("\n", ""),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: "ABeeZee",
                                        color: Colors.black,
                                        fontSize: _cf['timeDesc'][deviceType] *
                                            size.width,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 0.25 * size.width,
                                height: 1.5 * size.height,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 1.5 * size.height,
                          child: Row(
                            children: [
                              Container(
                                width: 0.25 * size.width,
                                height: 1.5 * size.height,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.1 * size.width),
                                width: 0.7 * size.width,
                                height: 1.5 * size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Past",
                                      style: TextStyle(
                                          fontFamily: "Caveat",
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(14, 43, 133, 1.0),
                                          fontSize: _cf['time'][deviceType] *
                                              size.width),
                                    ),
                                    Text(
                                      pastDesc.replaceAll("\n", ""),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: "ABeeZee",
                                        color: Colors.black,
                                        fontSize: _cf['timeDesc'][deviceType] *
                                            size.width,
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
                          deviceType: deviceType,
                          pageName: "Blog",
                          pageDescriptor: "Know more 'bout me!",
                          button: TextButton.icon(
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            onPressed: () {
                              if (RouteManager.currentRoute != "blog") {
                                RouteManager.navigateToBlog(navigator);
                              }
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
                        NavBar(
                          size: size,
                          deviceType: deviceType,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WhoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(14, 43, 133, 1.0)
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
