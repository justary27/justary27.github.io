import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/ar.dart';
import 'package:justary27_s_portfolio/src/components/rPainter.dart';
import 'package:justary27_s_portfolio/src/routes/routing.dart';

import 'deviceDetector.dart';

class Navbar extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const Navbar({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final navigator = widget.navigatorKey;
    final Size size = MediaQuery.of(context).size;
    final String deviceType = deviceDetector(size);

    if (deviceType == 'mobiles390-' ||
        deviceType == 'mobiles450-' ||
        deviceType == 'tablets768-') {
      return Container(
        width: size.width,
        height: 0.15 * size.height,
      );
    } else {
      return Container(
        width: size.width,
        height: 0.15 * size.height,
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.02 * size.width),
                child: MaterialButton(
                  elevation: 0,
                  child: CustomPaint(
                    size: Size(
                        40,
                        (40 * 1.572944297082228)
                            .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: ArPainter(Colors.white),
                  ),
                  onPressed: () {
                    if (RouteManager.currentRoute != "home") {
                      RouteManager.navigateToHome(navigator);
                      print(navigator.currentState!.restorationId);
                    }
                  },
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 0.15 * size.height,
                      width: 0.3 * size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MouseRegion(
                            onHover: (pointer) {},
                            child: MaterialButton(
                              onPressed: () {
                                if (RouteManager.currentRoute != "intro") {
                                  RouteManager.navigateToIntro(navigator);
                                }
                              },
                              child: Text(
                                "Intro",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (RouteManager.currentRoute != "who") {
                                RouteManager.navigateToWho(navigator);
                              }
                            },
                            child: Text(
                              "Who",
                              style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(color: Colors.white)),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (RouteManager.currentRoute != "work") {
                                RouteManager.navigateToWork(navigator);
                              }
                            },
                            child: Text(
                              "Work",
                              style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(color: Colors.white)),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (RouteManager.currentRoute != "blog") {
                                RouteManager.navigateToBlog(navigator);
                              }
                            },
                            child: Text(
                              "Blog",
                              style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.02 * size.width),
                child: MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => Dialog(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 0.75 * size.width,
                                      height: 0.8 * size.height,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Color.fromRGBO(
                                                  218, 224, 224, 1.0),
                                              Color.fromRGBO(
                                                  183, 193, 192, 1.0),
                                            ]),
                                      ),
                                      child: CustomPaint(
                                        painter: RoorkeePainter(
                                            RouteManager.currentColor,
                                            Color.fromRGBO(145, 155, 153, 1.0)
                                                .withOpacity(0.4)),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                    },
                    child: Text(
                      "Contact",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(color: Colors.white)),
                    )),
              )
            ],
          ),
        ),
      );
    }
  }
}
