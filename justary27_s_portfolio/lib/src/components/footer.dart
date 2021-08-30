import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/link.dart';

class NavBar extends StatefulWidget {
  final TabController tabController;

  final Size size;
  const NavBar({Key? key, required this.size, required this.tabController})
      : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    Size size = widget.size;
    TabController _tabController = widget.tabController;

    return Stack(
      children: [
        Container(
          width: size.width,
          height: 0.3 * size.height,
          color: Color.fromRGBO(134, 149, 179, 1.0),
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
                    // Text(
                    //   "Made with ♥ by ",
                    //   style: GoogleFonts.aBeeZee(
                    //       textStyle: TextStyle(
                    //     color: Colors.white.withOpacity(0.7),
                    //   )),
                    // ),
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
                width: 0.1 * size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          _tabController.animateTo(0);
                        },
                        child: Text(
                          "Intro",
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(color: Colors.white)),
                        )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.01 * size.height),
                      child: MaterialButton(
                          onPressed: () {
                            _tabController.animateTo(1);
                          },
                          child: Text(
                            "Who",
                            style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(color: Colors.white)),
                          )),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.01 * size.height),
                      child: MaterialButton(
                          onPressed: () {
                            _tabController.animateTo(2);
                          },
                          child: Text(
                            "Work",
                            style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(color: Colors.white)),
                          )),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.01 * size.height),
                      child: MaterialButton(
                          onPressed: () {
                            _tabController.animateTo(3);
                          },
                          child: Text(
                            "Blog",
                            style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(color: Colors.white)),
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                width: 0.3 * size.width,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.alternate_email_rounded),
                          color: Colors.white.withOpacity(0.7),
                        )),
                    Material(
                      color: Colors.transparent,
                      child: Link(
                          uri: Uri.parse("https://twitter.com/JustAry27"),
                          target: LinkTarget.blank,
                          builder: (context, openLink) {
                            return IconButton(
                              onPressed: () {
                                openLink;
                              },
                              icon: Icon(FontAwesomeIcons.twitter),
                              color: Colors.white.withOpacity(0.7),
                            );
                          }),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Link(
                          uri: Uri.parse("https://github.com/just-ary27"),
                          target: LinkTarget.blank,
                          builder: (context, openLink) {
                            return IconButton(
                              onPressed: () {
                                openLink;
                              },
                              icon: Icon(FontAwesomeIcons.github),
                              color: Colors.white.withOpacity(0.7),
                            );
                          }),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Link(
                          uri: Uri.parse(
                              "https://www.linkedin.com/in/aryan-ranjan-672899205/"),
                          target: LinkTarget.blank,
                          builder: (context, openLink) {
                            return IconButton(
                              onPressed: () {},
                              icon: Icon(FontAwesomeIcons.linkedin),
                              color: Colors.white.withOpacity(0.7),
                            );
                          }),
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
    return true;
  }
}
