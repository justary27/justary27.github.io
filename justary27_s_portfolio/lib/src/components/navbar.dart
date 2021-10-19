import 'dart:html';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/ar.dart';
import 'package:justary27_s_portfolio/src/components/rPainter.dart';
import 'package:justary27_s_portfolio/src/routes/routing.dart';

import 'deviceDetector.dart';

Map _cf = {
  'email': {
    'mobiles390-': 0.110,
    'mobiles450-': 0.0975,
    'tablets768-': 0.075,
    'tablets1024-': 0.0625,
    'laptops1536-': 0.05,
    'laptops1920-': 0.045,
  },
  'Links': {
    'mobiles390-': 16,
    'mobiles450-': 17.5,
    'tablets768-': 19.5,
    'tablets1024-': 21,
    'laptops1536-': 24,
    'laptops1920-': 27,
  },
  'taLine': {
    'mobiles390-': 0.0460,
    'mobiles450-': 0.0410,
    'tablets768-': 0.0360,
    'tablets1024-': 0.0300,
    'laptops1536-': 0.02,
    'laptops1920-': 0.02,
  },
};

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Positioned(
                            right: 0,
                            child: Dialog(
                              child: Container(
                                height: size.height,
                                width: 0.3 * size.width,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: size.height,
                                      width: 0.3 * size.width,
                                    ),
                                    Container(
                                      height: size.height,
                                      width: 0.3 * size.width,
                                      child: ListView(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              "Intro",
                                              style: GoogleFonts.aBeeZee(
                                                  textStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            onTap: () {
                                              if (RouteManager.currentRoute !=
                                                  "intro") {
                                                RouteManager.navigateToIntro(
                                                    navigator);
                                              }
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Who",
                                              style: GoogleFonts.aBeeZee(
                                                  textStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Who",
                                              style: GoogleFonts.aBeeZee(
                                                  textStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Blog",
                                              style: GoogleFonts.aBeeZee(
                                                  textStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Contact",
                                              style: GoogleFonts.aBeeZee(
                                                  textStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    ValueNotifier<bool>
                                                        isHovered =
                                                        ValueNotifier(false);
                                                    ValueNotifier<bool>
                                                        tHovered =
                                                        ValueNotifier(false);
                                                    ValueNotifier<bool>
                                                        gHovered =
                                                        ValueNotifier(false);
                                                    ValueNotifier<bool>
                                                        lHovered =
                                                        ValueNotifier(false);
                                                    ValueNotifier<bool>
                                                        dHovered =
                                                        ValueNotifier(false);
                                                    ValueNotifier<bool>
                                                        fHovered =
                                                        ValueNotifier(false);
                                                    ValueNotifier<bool>
                                                        textHovered =
                                                        ValueNotifier(false);
                                                    Color _hoverColor =
                                                        RouteManager
                                                            .currentColor;
                                                    return Dialog(
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            width: 0.75 *
                                                                size.width,
                                                            height: 0.8 *
                                                                size.height,
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomLeft,
                                                                  colors: [
                                                                    Color.fromRGBO(
                                                                        218,
                                                                        224,
                                                                        224,
                                                                        1.0),
                                                                    Color.fromRGBO(
                                                                        183,
                                                                        193,
                                                                        192,
                                                                        1.0),
                                                                  ]),
                                                            ),
                                                            child: CustomPaint(
                                                              painter: RoorkeePainter(
                                                                  RouteManager
                                                                      .currentColor,
                                                                  Color.fromRGBO(
                                                                          145,
                                                                          155,
                                                                          153,
                                                                          1.0)
                                                                      .withOpacity(
                                                                          0.4)),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 0.75 *
                                                                size.width,
                                                            height: 0.8 *
                                                                size.height,
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  width: 0.75 *
                                                                      size.width,
                                                                  height: 0.56 *
                                                                      size.height,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        height: 0.1 *
                                                                            size.height,
                                                                      ),
                                                                      Text(
                                                                        "Contact Me",
                                                                        style: GoogleFonts.aBeeZee(
                                                                            textStyle:
                                                                                TextStyle(fontSize: size.width * _cf['taLine'][deviceType])),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(0.025 *
                                                                                size.height),
                                                                        child: MaterialButton(
                                                                            elevation: 0,
                                                                            color: Colors.transparent,
                                                                            highlightColor: Colors.transparent,
                                                                            hoverColor: Colors.transparent,
                                                                            splashColor: Colors.transparent,
                                                                            focusColor: Colors.transparent,
                                                                            onPressed: () {
                                                                              window.open("mailto:aryan_r@ch.iitr.ac.in", "New Tab");
                                                                            },
                                                                            child: MouseRegion(
                                                                              onEnter: (hover) {
                                                                                if (_hoverColor != Colors.black) {
                                                                                  isHovered.value = true;
                                                                                }
                                                                              },
                                                                              onExit: (hover) {
                                                                                isHovered.value = false;
                                                                              },
                                                                              child: ValueListenableBuilder(
                                                                                valueListenable: isHovered,
                                                                                builder: (_, __, ___) => Text(
                                                                                  "aryan_r@ch.iitr.ac.in",
                                                                                  style: GoogleFonts.ubuntu(
                                                                                    textStyle: TextStyle(color: (isHovered.value) ? _hoverColor : Colors.black, fontSize: size.width * _cf['email'][deviceType]),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 0.75 *
                                                                      size.width,
                                                                  height: 0.24 *
                                                                      size.height,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      MouseRegion(
                                                                        onEnter:
                                                                            (hover) {
                                                                          if (_hoverColor !=
                                                                              Colors.white.withOpacity(0.7)) {
                                                                            textHovered.value =
                                                                                true;
                                                                          }
                                                                        },
                                                                        onExit:
                                                                            (hover) {
                                                                          textHovered.value =
                                                                              false;
                                                                        },
                                                                        child: ValueListenableBuilder(
                                                                            valueListenable: textHovered,
                                                                            builder: (_, __, ___) => Text(
                                                                                  (textHovered.value) ? "Time is made, not found!" : "Time is made.",
                                                                                  style: GoogleFonts.caveat(textStyle: TextStyle(fontSize: size.width * _cf['taLine'][deviceType], color: (textHovered.value) ? _hoverColor : Colors.white.withOpacity(0.7))),
                                                                                )),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            0,
                                                                            0.025 *
                                                                                size.height,
                                                                            0,
                                                                            0.05 * size.height),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Material(
                                                                              color: Colors.transparent,
                                                                              child: MouseRegion(
                                                                                onEnter: (hover) {
                                                                                  if (_hoverColor != Colors.white.withOpacity(0.7)) {
                                                                                    tHovered.value = true;
                                                                                  }
                                                                                },
                                                                                onExit: (hover) {
                                                                                  tHovered.value = false;
                                                                                },
                                                                                child: ValueListenableBuilder(
                                                                                  valueListenable: tHovered,
                                                                                  builder: (_, __, ___) => IconButton(
                                                                                    onPressed: () {
                                                                                      window.open('https://twitter.com/JustAry27', 'New Tab');
                                                                                    },
                                                                                    icon: Icon(
                                                                                      FontAwesomeIcons.twitter,
                                                                                      size: _cf['Links'][deviceType],
                                                                                    ),
                                                                                    color: (tHovered.value) ? _hoverColor : Colors.white.withOpacity(0.7),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Material(
                                                                              color: Colors.transparent,
                                                                              child: MouseRegion(
                                                                                onEnter: (hover) {
                                                                                  if (_hoverColor != Colors.white.withOpacity(0.7)) {
                                                                                    gHovered.value = true;
                                                                                  }
                                                                                },
                                                                                onExit: (hover) {
                                                                                  gHovered.value = false;
                                                                                },
                                                                                child: ValueListenableBuilder(
                                                                                  valueListenable: gHovered,
                                                                                  builder: (_, __, ___) => IconButton(
                                                                                    onPressed: () {
                                                                                      window.open('https://github.com/just-ary27', 'New Tab');
                                                                                    },
                                                                                    icon: Icon(
                                                                                      FontAwesomeIcons.github,
                                                                                      size: _cf['Links'][deviceType],
                                                                                    ),
                                                                                    color: (gHovered.value) ? _hoverColor : Colors.white.withOpacity(0.7),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Material(
                                                                              color: Colors.transparent,
                                                                              child: MouseRegion(
                                                                                onEnter: (hover) {
                                                                                  if (_hoverColor != Colors.white.withOpacity(0.7)) {
                                                                                    lHovered.value = true;
                                                                                  }
                                                                                },
                                                                                onExit: (hover) {
                                                                                  lHovered.value = false;
                                                                                },
                                                                                child: ValueListenableBuilder(
                                                                                  valueListenable: lHovered,
                                                                                  builder: (_, __, ___) => IconButton(
                                                                                    onPressed: () {},
                                                                                    icon: Icon(
                                                                                      FontAwesomeIcons.linkedin,
                                                                                      size: _cf['Links'][deviceType],
                                                                                    ),
                                                                                    color: (lHovered.value) ? _hoverColor : Colors.white.withOpacity(0.7),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              // child: Link(
                                                                              //     uri: Uri.parse(
                                                                              //         "https://www.linkedin.com/in/aryan-ranjan-672899205/"),
                                                                              //     target: LinkTarget.blank,
                                                                              //     builder: (context, openLink) {
                                                                              //       return IconButton(
                                                                              //         onPressed: () {},
                                                                              //         icon: Icon(FontAwesomeIcons.linkedin),
                                                                              //         color: Colors.white.withOpacity(0.7),
                                                                              //       );
                                                                              //     }),
                                                                            ),
                                                                            Material(
                                                                              color: Colors.transparent,
                                                                              child: MouseRegion(
                                                                                onEnter: (hover) {
                                                                                  if (_hoverColor != Colors.white.withOpacity(0.7)) {
                                                                                    dHovered.value = true;
                                                                                  }
                                                                                },
                                                                                onExit: (hover) {
                                                                                  dHovered.value = false;
                                                                                },
                                                                                child: ValueListenableBuilder(
                                                                                  valueListenable: dHovered,
                                                                                  builder: (_, __, ___) => IconButton(
                                                                                    onPressed: () {},
                                                                                    icon: Icon(
                                                                                      FontAwesomeIcons.discord,
                                                                                      size: _cf['Links'][deviceType],
                                                                                    ),
                                                                                    color: (dHovered.value) ? _hoverColor : Colors.white.withOpacity(0.7),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              // child: Link(
                                                                              //     uri: Uri.parse(
                                                                              //         "https://www.linkedin.com/in/aryan-ranjan-672899205/"),
                                                                              //     target: LinkTarget.blank,
                                                                              //     builder: (context, openLink) {
                                                                              //       return IconButton(
                                                                              //         onPressed: () {},
                                                                              //         icon: Icon(FontAwesomeIcons.linkedin),
                                                                              //         color: Colors.white.withOpacity(0.7),
                                                                              //       );
                                                                              //     }),
                                                                            ),
                                                                            Material(
                                                                              color: Colors.transparent,
                                                                              child: MouseRegion(
                                                                                onEnter: (hover) {
                                                                                  if (_hoverColor != Colors.white.withOpacity(0.7)) {
                                                                                    fHovered.value = true;
                                                                                  }
                                                                                },
                                                                                onExit: (hover) {
                                                                                  fHovered.value = false;
                                                                                },
                                                                                child: ValueListenableBuilder(
                                                                                  valueListenable: fHovered,
                                                                                  builder: (_, __, ___) => IconButton(
                                                                                    onPressed: () {},
                                                                                    icon: Icon(
                                                                                      FontAwesomeIcons.facebook,
                                                                                      size: _cf['Links'][deviceType],
                                                                                    ),
                                                                                    color: (fHovered.value) ? _hoverColor : Colors.white.withOpacity(0.7),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              // child: Link(
                                                                              //     uri: Uri.parse(
                                                                              //         "https://www.linkedin.com/in/aryan-ranjan-672899205/"),
                                                                              //     target: LinkTarget.blank,
                                                                              //     builder: (context, openLink) {
                                                                              //       return IconButton(
                                                                              //         onPressed: () {},
                                                                              //         icon: Icon(FontAwesomeIcons.linkedin),
                                                                              //         color: Colors.white.withOpacity(0.7),
                                                                              //       );
                                                                              //     }),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      });
                },
                icon: Icon(Icons.menu))
          ],
        ),
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
                          builder: (context) {
                            ValueNotifier<bool> isHovered =
                                ValueNotifier(false);
                            ValueNotifier<bool> tHovered = ValueNotifier(false);
                            ValueNotifier<bool> gHovered = ValueNotifier(false);
                            ValueNotifier<bool> lHovered = ValueNotifier(false);
                            ValueNotifier<bool> dHovered = ValueNotifier(false);
                            ValueNotifier<bool> fHovered = ValueNotifier(false);
                            ValueNotifier<bool> textHovered =
                                ValueNotifier(false);
                            Color _hoverColor = RouteManager.currentColor;
                            return Dialog(
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
                                            Color.fromRGBO(218, 224, 224, 1.0),
                                            Color.fromRGBO(183, 193, 192, 1.0),
                                          ]),
                                    ),
                                    child: CustomPaint(
                                      painter: RoorkeePainter(
                                          RouteManager.currentColor,
                                          Color.fromRGBO(145, 155, 153, 1.0)
                                              .withOpacity(0.4)),
                                    ),
                                  ),
                                  Container(
                                    width: 0.75 * size.width,
                                    height: 0.8 * size.height,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 0.75 * size.width,
                                          height: 0.56 * size.height,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 0.1 * size.height,
                                              ),
                                              Text(
                                                "Contact Me",
                                                style: GoogleFonts.aBeeZee(
                                                    textStyle: TextStyle(
                                                        fontSize: size.width *
                                                            _cf['taLine']
                                                                [deviceType])),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    0.025 * size.height),
                                                child: MaterialButton(
                                                    elevation: 0,
                                                    color: Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    onPressed: () {
                                                      window.open(
                                                          "mailto:aryan_r@ch.iitr.ac.in",
                                                          "New Tab");
                                                    },
                                                    child: MouseRegion(
                                                      onEnter: (hover) {
                                                        if (_hoverColor !=
                                                            Colors.black) {
                                                          isHovered.value =
                                                              true;
                                                        }
                                                      },
                                                      onExit: (hover) {
                                                        isHovered.value = false;
                                                      },
                                                      child:
                                                          ValueListenableBuilder(
                                                        valueListenable:
                                                            isHovered,
                                                        builder: (_, __, ___) =>
                                                            Text(
                                                          "aryan_r@ch.iitr.ac.in",
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                            textStyle: TextStyle(
                                                                color: (isHovered
                                                                        .value)
                                                                    ? _hoverColor
                                                                    : Colors
                                                                        .black,
                                                                fontSize: size
                                                                        .width *
                                                                    _cf['email']
                                                                        [
                                                                        deviceType]),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 0.75 * size.width,
                                          height: 0.24 * size.height,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MouseRegion(
                                                onEnter: (hover) {
                                                  if (_hoverColor !=
                                                      Colors.white
                                                          .withOpacity(0.7)) {
                                                    textHovered.value = true;
                                                  }
                                                },
                                                onExit: (hover) {
                                                  textHovered.value = false;
                                                },
                                                child: ValueListenableBuilder(
                                                    valueListenable:
                                                        textHovered,
                                                    builder:
                                                        (_, __, ___) => Text(
                                                              (textHovered
                                                                      .value)
                                                                  ? "Time is made, not found!"
                                                                  : "Time is made.",
                                                              style: GoogleFonts.caveat(
                                                                  textStyle: TextStyle(
                                                                      fontSize: size
                                                                              .width *
                                                                          _cf['taLine']
                                                                              [
                                                                              deviceType],
                                                                      color: (textHovered
                                                                              .value)
                                                                          ? _hoverColor
                                                                          : Colors
                                                                              .white
                                                                              .withOpacity(0.7))),
                                                            )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0,
                                                    0.025 * size.height,
                                                    0,
                                                    0.05 * size.height),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: MouseRegion(
                                                        onEnter: (hover) {
                                                          if (_hoverColor !=
                                                              Colors.white
                                                                  .withOpacity(
                                                                      0.7)) {
                                                            tHovered.value =
                                                                true;
                                                          }
                                                        },
                                                        onExit: (hover) {
                                                          tHovered.value =
                                                              false;
                                                        },
                                                        child:
                                                            ValueListenableBuilder(
                                                          valueListenable:
                                                              tHovered,
                                                          builder:
                                                              (_, __, ___) =>
                                                                  IconButton(
                                                            onPressed: () {
                                                              window.open(
                                                                  'https://twitter.com/JustAry27',
                                                                  'New Tab');
                                                            },
                                                            icon: Icon(
                                                              FontAwesomeIcons
                                                                  .twitter,
                                                              size: _cf['Links']
                                                                  [deviceType],
                                                            ),
                                                            color: (tHovered
                                                                    .value)
                                                                ? _hoverColor
                                                                : Colors.white
                                                                    .withOpacity(
                                                                        0.7),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: MouseRegion(
                                                        onEnter: (hover) {
                                                          if (_hoverColor !=
                                                              Colors.white
                                                                  .withOpacity(
                                                                      0.7)) {
                                                            gHovered.value =
                                                                true;
                                                          }
                                                        },
                                                        onExit: (hover) {
                                                          gHovered.value =
                                                              false;
                                                        },
                                                        child:
                                                            ValueListenableBuilder(
                                                          valueListenable:
                                                              gHovered,
                                                          builder:
                                                              (_, __, ___) =>
                                                                  IconButton(
                                                            onPressed: () {
                                                              window.open(
                                                                  'https://github.com/just-ary27',
                                                                  'New Tab');
                                                            },
                                                            icon: Icon(
                                                              FontAwesomeIcons
                                                                  .github,
                                                              size: _cf['Links']
                                                                  [deviceType],
                                                            ),
                                                            color: (gHovered
                                                                    .value)
                                                                ? _hoverColor
                                                                : Colors.white
                                                                    .withOpacity(
                                                                        0.7),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: MouseRegion(
                                                        onEnter: (hover) {
                                                          if (_hoverColor !=
                                                              Colors.white
                                                                  .withOpacity(
                                                                      0.7)) {
                                                            lHovered.value =
                                                                true;
                                                          }
                                                        },
                                                        onExit: (hover) {
                                                          lHovered.value =
                                                              false;
                                                        },
                                                        child:
                                                            ValueListenableBuilder(
                                                          valueListenable:
                                                              lHovered,
                                                          builder:
                                                              (_, __, ___) =>
                                                                  IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              FontAwesomeIcons
                                                                  .linkedin,
                                                              size: _cf['Links']
                                                                  [deviceType],
                                                            ),
                                                            color: (lHovered
                                                                    .value)
                                                                ? _hoverColor
                                                                : Colors.white
                                                                    .withOpacity(
                                                                        0.7),
                                                          ),
                                                        ),
                                                      ),
                                                      // child: Link(
                                                      //     uri: Uri.parse(
                                                      //         "https://www.linkedin.com/in/aryan-ranjan-672899205/"),
                                                      //     target: LinkTarget.blank,
                                                      //     builder: (context, openLink) {
                                                      //       return IconButton(
                                                      //         onPressed: () {},
                                                      //         icon: Icon(FontAwesomeIcons.linkedin),
                                                      //         color: Colors.white.withOpacity(0.7),
                                                      //       );
                                                      //     }),
                                                    ),
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: MouseRegion(
                                                        onEnter: (hover) {
                                                          if (_hoverColor !=
                                                              Colors.white
                                                                  .withOpacity(
                                                                      0.7)) {
                                                            dHovered.value =
                                                                true;
                                                          }
                                                        },
                                                        onExit: (hover) {
                                                          dHovered.value =
                                                              false;
                                                        },
                                                        child:
                                                            ValueListenableBuilder(
                                                          valueListenable:
                                                              dHovered,
                                                          builder:
                                                              (_, __, ___) =>
                                                                  IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              FontAwesomeIcons
                                                                  .discord,
                                                              size: _cf['Links']
                                                                  [deviceType],
                                                            ),
                                                            color: (dHovered
                                                                    .value)
                                                                ? _hoverColor
                                                                : Colors.white
                                                                    .withOpacity(
                                                                        0.7),
                                                          ),
                                                        ),
                                                      ),
                                                      // child: Link(
                                                      //     uri: Uri.parse(
                                                      //         "https://www.linkedin.com/in/aryan-ranjan-672899205/"),
                                                      //     target: LinkTarget.blank,
                                                      //     builder: (context, openLink) {
                                                      //       return IconButton(
                                                      //         onPressed: () {},
                                                      //         icon: Icon(FontAwesomeIcons.linkedin),
                                                      //         color: Colors.white.withOpacity(0.7),
                                                      //       );
                                                      //     }),
                                                    ),
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: MouseRegion(
                                                        onEnter: (hover) {
                                                          if (_hoverColor !=
                                                              Colors.white
                                                                  .withOpacity(
                                                                      0.7)) {
                                                            fHovered.value =
                                                                true;
                                                          }
                                                        },
                                                        onExit: (hover) {
                                                          fHovered.value =
                                                              false;
                                                        },
                                                        child:
                                                            ValueListenableBuilder(
                                                          valueListenable:
                                                              fHovered,
                                                          builder:
                                                              (_, __, ___) =>
                                                                  IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              FontAwesomeIcons
                                                                  .facebook,
                                                              size: _cf['Links']
                                                                  [deviceType],
                                                            ),
                                                            color: (fHovered
                                                                    .value)
                                                                ? _hoverColor
                                                                : Colors.white
                                                                    .withOpacity(
                                                                        0.7),
                                                          ),
                                                        ),
                                                      ),
                                                      // child: Link(
                                                      //     uri: Uri.parse(
                                                      //         "https://www.linkedin.com/in/aryan-ranjan-672899205/"),
                                                      //     target: LinkTarget.blank,
                                                      //     builder: (context, openLink) {
                                                      //       return IconButton(
                                                      //         onPressed: () {},
                                                      //         icon: Icon(FontAwesomeIcons.linkedin),
                                                      //         color: Colors.white.withOpacity(0.7),
                                                      //       );
                                                      //     }),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
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
