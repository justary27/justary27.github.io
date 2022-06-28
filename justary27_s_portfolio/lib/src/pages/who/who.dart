import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/footer.dart';
import 'package:justary27_s_portfolio/src/components/page_components/promo_components.dart';
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
                                    fontSize: _cf['heading'][deviceType] *
                                        size.width)),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height,
                          child: Row(
                            children: [
                              Container(
                                width: 0.3 * size.width,
                                height: size.height,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.1 * size.width),
                                width: 0.6 * size.width,
                                height: size.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Present",
                                      style: GoogleFonts.caveatBrush(
                                          textStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  14, 43, 133, 1.0),
                                              fontSize: _cf['time']
                                                      [deviceType] *
                                                  size.width)),
                                    ),
                                    Text(
                                        "Having spent almost 3 semesters in IIT-R, quite a lot has happened since the time I joined. I have participated in several hackathons, also got good rankings in few of them like Syntax Error and Makers by SDS Labs IIT-R. Talking about the very present, I'm doing a project with PaAC IITR, working on developing an multi-facet app and also learning Game Dev and Machine Learning. I'm also a member of NSS IIT-R's Editorial Cell.",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.aBeeZee(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: _cf['timeDesc']
                                                        [deviceType] *
                                                    size.width))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height,
                          child: Row(
                            children: [
                              Container(
                                width: 0.3 * size.width,
                                height: size.height,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.1 * size.width),
                                width: 0.6 * size.width,
                                height: size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Future",
                                      style: GoogleFonts.caveatBrush(
                                          textStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  14, 43, 133, 1.0),
                                              fontSize: _cf['time']
                                                      [deviceType] *
                                                  size.width)),
                                    ),
                                    Text(
                                        "Even though I don't plan miles ahead, yet I have a few goals; which I wanna clear in da comin' time. The ultimate goal is to master everything that the vast field of computer science can provide. I have set milestones like clearing GsoC, getting 6 stars in CP; in order to stay focused and thus not stray from my goal. I know the path isn't gonna be easy, but nothin' worthwhile is. Isn't it? ",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.aBeeZee(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: _cf['timeDesc']
                                                        [deviceType] *
                                                    size.width))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height,
                          child: Row(
                            children: [
                              Container(
                                width: 0.3 * size.width,
                                height: size.height,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.1 * size.width),
                                width: 0.6 * size.width,
                                height: size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Past",
                                      style: GoogleFonts.caveatBrush(
                                          textStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  14, 43, 133, 1.0),
                                              fontSize: _cf['time']
                                                      [deviceType] *
                                                  size.width)),
                                    ),
                                    Text(
                                      "Before getting into IIT-R, I got AIR 3792 in Jee Advanced 2020, and AIR 1859 in Jee Mains 2020. The path was not always like a fine day at the ocean there were several ups but also several stormy days aka downs, despite all this I managed to stay on the path during the 4 years of my preparation. In these years I also cleared several important exams like NTSE stage-II, NSEJS, NSEP, NSEC, NSEA and PRMO. An achievement which I cherish from my 5th standard is getting AIR 1 in NAO, an astronomy olympiad.",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: _cf['timeDesc']
                                                    [deviceType] *
                                                size.width),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
