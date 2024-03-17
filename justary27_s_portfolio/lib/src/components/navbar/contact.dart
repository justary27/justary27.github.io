// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justary27_s_portfolio/src/components/anchor.dart';

import '../rPainter.dart';
import '../../routes/routing.dart';
import '../../constants/component_constraints/navbar_constraints.dart';

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
    ValueNotifier<bool> fHovered = ValueNotifier(false);
    ValueNotifier<bool> textHovered = ValueNotifier(false);
    Color _hoverColor = RouteManager.currentColor;
    return Dialog(
      child: Material(
        color: Colors.transparent,
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
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            fontSize: size.width *
                                navConstraints['taLine'][deviceType],
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
                                  style: TextStyle(
                                    fontFamily: "Ubuntu",
                                    color: (isHovered.value)
                                        ? _hoverColor
                                        : Colors.black,
                                    fontSize: size.width *
                                        navConstraints['email'][deviceType],
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
                              style: TextStyle(
                                fontFamily: "Caveat",
                                fontSize: size.width *
                                    navConstraints['taLine'][deviceType],
                                color: (textHovered.value)
                                    ? _hoverColor
                                    : Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
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
                                        size: navConstraints['Links']
                                            [deviceType],
                                      ),
                                      color: (tHovered.value)
                                          ? _hoverColor
                                          : Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                              MouseRegion(
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
                              MouseRegion(
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
                              MouseRegion(
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
      ),
    );
  }

  Dialog buildLargeCard(Size size, String deviceType) {
    ValueNotifier<bool> isHovered = ValueNotifier(false);
    ValueNotifier<bool> tHovered = ValueNotifier(false);
    ValueNotifier<bool> gHovered = ValueNotifier(false);
    ValueNotifier<bool> lHovered = ValueNotifier(false);
    ValueNotifier<bool> fHovered = ValueNotifier(false);
    ValueNotifier<bool> textHovered = ValueNotifier(false);
    Color _hoverColor = RouteManager.currentColor;
    return Dialog(
      child: Material(
        color: Colors.transparent,
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
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            fontSize: size.width *
                                navConstraints['taLine'][deviceType],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0.025 * size.height),
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
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
                                  style: TextStyle(
                                    fontFamily: "Ubuntu",
                                    color: (isHovered.value)
                                        ? _hoverColor
                                        : Colors.black,
                                    fontSize: size.width *
                                        navConstraints['email'][deviceType],
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
                              style: TextStyle(
                                fontFamily: "Caveat",
                                fontSize: size.width *
                                    navConstraints['taLine'][deviceType],
                                color: (textHovered.value)
                                    ? _hoverColor
                                    : Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, 0.025 * size.height, 0, 0.05 * size.height),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MouseRegion(
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
                                  builder: (_, __, ___) => AnchorButton(
                                    destUrl: 'https://twitter.com/JustAry27',
                                    icon: Icon(
                                      FontAwesomeIcons.twitter,
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (tHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                    parentContext: context,
                                  ),
                                ),
                              ),
                              MouseRegion(
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
                                  builder: (_, __, ___) => AnchorButton(
                                    destUrl: 'https://github.com/just-ary27',
                                    icon: Icon(
                                      FontAwesomeIcons.github,
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (gHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                    parentContext: context,
                                  ),
                                ),
                              ),
                              MouseRegion(
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
                                  builder: (_, __, ___) => AnchorButton(
                                    destUrl:
                                        'https://www.linkedin.com/in/aryan-ranjan27/',
                                    icon: Icon(
                                      FontAwesomeIcons.linkedin,
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (lHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                    parentContext: context,
                                  ),
                                ),
                              ),
                              MouseRegion(
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
                                  builder: (_, __, ___) => AnchorButton(
                                    destUrl: "",
                                    icon: Icon(
                                      FontAwesomeIcons.facebook,
                                      size: navConstraints['Links'][deviceType],
                                    ),
                                    color: (fHovered.value)
                                        ? _hoverColor
                                        : Colors.white.withOpacity(0.7),
                                    parentContext: context,
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
      ),
    );
  }
}
