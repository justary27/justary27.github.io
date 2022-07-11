// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/component_constraints/navbar_constraints.dart';
import '../../routes/routing.dart';
import '../rPainter.dart';

class ContactCard extends ConsumerStatefulWidget {
  final Size size;
  final String deviceType;

  const ContactCard({
    Key? key,
    required this.size,
    required this.deviceType,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactCardState();
}

class _ContactCardState extends ConsumerState<ContactCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.deviceType == 'mobiles390-' ||
        widget.deviceType == 'mobiles450-' ||
        widget.deviceType == 'tablets768-') {
      return buildSmallCard(widget.size, widget.deviceType);
    } else {
      return buildLargeCard(widget.size, widget.deviceType);
    }
  }

  buildSmallCard(Size size, String deviceType) {
    ValueNotifier<bool> isHovered = ValueNotifier(false);
    ValueNotifier<bool> tHovered = ValueNotifier(false);
    ValueNotifier<bool> gHovered = ValueNotifier(false);
    ValueNotifier<bool> lHovered = ValueNotifier(false);
    ValueNotifier<bool> dHovered = ValueNotifier(false);
    ValueNotifier<bool> fHovered = ValueNotifier(false);
    ValueNotifier<bool> textHovered = ValueNotifier(false);
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
              painter: RoorkeePainter(RouteManager.currentColor,
                  Color.fromRGBO(145, 155, 153, 1.0).withOpacity(0.4)),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 0.1 * size.height,
                      ),
                      Text(
                        "Contact Me",
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: size.width *
                                navConstraints['taLine'][deviceType],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.025 * size.height),
                        child: MaterialButton(
                            elevation: 0,
                            color: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onPressed: () {
                              window.open(
                                  "mailto:aryan_r@ch.iitr.ac.in", "New Tab");
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
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                        color: (isHovered.value)
                                            ? _hoverColor
                                            : Colors.black,
                                        fontSize: size.width *
                                            navConstraints['email']
                                                [deviceType]),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        onEnter: (hover) {
                          if (_hoverColor != Colors.white.withOpacity(0.7)) {
                            textHovered.value = true;
                          }
                        },
                        onExit: (hover) {
                          textHovered.value = false;
                        },
                        child: ValueListenableBuilder(
                            valueListenable: textHovered,
                            builder: (_, __, ___) => Text(
                                  (textHovered.value)
                                      ? "Time is made, not found!"
                                      : "Time is made.",
                                  style: GoogleFonts.caveat(
                                      textStyle: TextStyle(
                                          fontSize: size.width *
                                              navConstraints['taLine']
                                                  [deviceType],
                                          color: (textHovered.value)
                                              ? _hoverColor
                                              : Colors.white.withOpacity(0.7))),
                                )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, 0.025 * size.height, 0, 0.05 * size.height),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: MouseRegion(
                                onEnter: (hover) {
                                  if (_hoverColor !=
                                      Colors.white.withOpacity(0.7)) {
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
                                      window.open(
                                          'https://twitter.com/JustAry27',
                                          'New Tab');
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.twitter,
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (tHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: MouseRegion(
                                onEnter: (hover) {
                                  if (_hoverColor !=
                                      Colors.white.withOpacity(0.7)) {
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
                                      window.open(
                                          'https://github.com/just-ary27',
                                          'New Tab');
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.github,
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (gHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: MouseRegion(
                                onEnter: (hover) {
                                  if (_hoverColor !=
                                      Colors.white.withOpacity(0.7)) {
                                    lHovered.value = true;
                                  }
                                },
                                onExit: (hover) {
                                  lHovered.value = false;
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: lHovered,
                                  builder: (_, __, ___) => IconButton(
                                    onPressed: () {
                                      window.open(
                                        'https://www.linkedin.com/in/aryan-ranjan27/',
                                        'New Tab',
                                      );
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.linkedin,
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (lHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
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
                                      Colors.white.withOpacity(0.7)) {
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
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (dHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
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
                                      Colors.white.withOpacity(0.7)) {
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
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (fHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
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
  }

  Dialog buildLargeCard(Size size, String deviceType) {
    ValueNotifier<bool> isHovered = ValueNotifier(false);
    ValueNotifier<bool> tHovered = ValueNotifier(false);
    ValueNotifier<bool> gHovered = ValueNotifier(false);
    ValueNotifier<bool> lHovered = ValueNotifier(false);
    ValueNotifier<bool> dHovered = ValueNotifier(false);
    ValueNotifier<bool> fHovered = ValueNotifier(false);
    ValueNotifier<bool> textHovered = ValueNotifier(false);
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
              painter: RoorkeePainter(RouteManager.currentColor,
                  Color.fromRGBO(145, 155, 153, 1.0).withOpacity(0.4)),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 0.1 * size.height,
                      ),
                      Text(
                        "Contact Me",
                        style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                                fontSize: size.width *
                                    navConstraints['taLine'][deviceType])),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.025 * size.height),
                        child: MaterialButton(
                          elevation: 0,
                          color: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onPressed: () {
                            window.open(
                                "mailto:aryan_r@ch.iitr.ac.in", "New Tab");
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
                                  textStyle: TextStyle(
                                      color: (isHovered.value)
                                          ? _hoverColor
                                          : Colors.black,
                                      fontSize: size.width *
                                          navConstraints['email'][deviceType]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 0.75 * size.width,
                  height: 0.24 * size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        onEnter: (hover) {
                          if (_hoverColor != Colors.white.withOpacity(0.7)) {
                            textHovered.value = true;
                          }
                        },
                        onExit: (hover) {
                          textHovered.value = false;
                        },
                        child: ValueListenableBuilder(
                            valueListenable: textHovered,
                            builder: (_, __, ___) => Text(
                                  (textHovered.value)
                                      ? "Time is made, not found!"
                                      : "Time is made.",
                                  style: GoogleFonts.caveat(
                                      textStyle: TextStyle(
                                          fontSize: size.width *
                                              navConstraints['taLine']
                                                  [deviceType],
                                          color: (textHovered.value)
                                              ? _hoverColor
                                              : Colors.white.withOpacity(0.7))),
                                )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, 0.025 * size.height, 0, 0.05 * size.height),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: MouseRegion(
                                onEnter: (hover) {
                                  if (_hoverColor !=
                                      Colors.white.withOpacity(0.7)) {
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
                                      window.open(
                                          'https://twitter.com/JustAry27',
                                          'New Tab');
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.twitter,
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (tHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: MouseRegion(
                                onEnter: (hover) {
                                  if (_hoverColor !=
                                      Colors.white.withOpacity(0.7)) {
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
                                      window.open(
                                          'https://github.com/just-ary27',
                                          'New Tab');
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.github,
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (gHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: MouseRegion(
                                onEnter: (hover) {
                                  if (_hoverColor !=
                                      Colors.white.withOpacity(0.7)) {
                                    lHovered.value = true;
                                  }
                                },
                                onExit: (hover) {
                                  lHovered.value = false;
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: lHovered,
                                  builder: (_, __, ___) => IconButton(
                                    onPressed: () {
                                      window.open(
                                        'https://www.linkedin.com/in/aryan-ranjan27/',
                                        'New Tab',
                                      );
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.linkedin,
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (lHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: MouseRegion(
                                onEnter: (hover) {
                                  if (_hoverColor !=
                                      Colors.white.withOpacity(0.7)) {
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
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (dHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: MouseRegion(
                                onEnter: (hover) {
                                  if (_hoverColor !=
                                      Colors.white.withOpacity(0.7)) {
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
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (fHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ),
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
  }
}
