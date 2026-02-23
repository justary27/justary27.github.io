import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../roorkee_painter.dart';
import '../../routes/routing.dart';
import '../../enums/device_type.dart';
import '../../components/anchor.dart';

import 'navbar_constraints.dart';

class ContactCard extends ConsumerStatefulWidget {
  final Size size;
  final DeviceType deviceType;

  const ContactCard({super.key, required this.size, required this.deviceType});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactCardState();
}

class _ContactCardState extends ConsumerState<ContactCard> {
  Future<void> _launchLink(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.deviceType < DeviceType.largeTablet) {
      return buildSmallCard(widget.size, widget.deviceType);
    } else {
      return buildLargeCard(widget.size, widget.deviceType);
    }
  }

  buildSmallCard(Size size, DeviceType deviceType) {
    ValueNotifier<bool> isHovered = ValueNotifier(false);
    ValueNotifier<bool> tHovered = ValueNotifier(false);
    ValueNotifier<bool> gHovered = ValueNotifier(false);
    ValueNotifier<bool> lHovered = ValueNotifier(false);
    ValueNotifier<bool> textHovered = ValueNotifier(false);
    Color hoverColor = RouteManager.currentColor;
    return Dialog(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: 0.75 * size.width,
              height: 0.8 * size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(218, 224, 224, 1.0),
                    Color.fromRGBO(183, 193, 192, 1.0),
                  ],
                ),
              ),
              child: CustomPaint(
                painter: RoorkeePainter(
                  RouteManager.currentColor,
                  const Color.fromRGBO(
                    145,
                    155,
                    153,
                    1.0,
                  ).withValues(alpha: 0.4),
                ),
              ),
            ),
            SizedBox(
              width: 0.75 * size.width,
              height: 0.8 * size.height,
              child: Column(
                children: [
                  SizedBox(
                    width: 0.75 * size.width,
                    height: 0.56 * size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 0.1 * size.height),
                        Text(
                          "Contact Me",
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            fontSize: size.width * NC.taLine[deviceType]!,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0.025 * size.height),
                          child: TextButton(
                            onPressed:
                                () =>
                                    _launchLink("mailto:aryan_r@ch.iitr.ac.in"),
                            child: MouseRegion(
                              onEnter: (hover) {
                                if (hoverColor != Colors.black) {
                                  isHovered.value = true;
                                }
                              },
                              onExit: (hover) {
                                isHovered.value = false;
                              },
                              child: ValueListenableBuilder(
                                valueListenable: isHovered,
                                builder:
                                    (_, __, ___) => Text(
                                      "aryan_r@ch.iitr.ac.in",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        color:
                                            (isHovered.value)
                                                ? hoverColor
                                                : Colors.black,
                                        fontSize:
                                            size.width * NC.email[deviceType]!,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 0.75 * size.width,
                    height: 0.24 * size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MouseRegion(
                          onEnter: (hover) {
                            if (hoverColor !=
                                Colors.white.withValues(alpha: 0.7)) {
                              textHovered.value = true;
                            }
                          },
                          onExit: (hover) {
                            textHovered.value = false;
                          },
                          child: ValueListenableBuilder(
                            valueListenable: textHovered,
                            builder:
                                (_, __, ___) => Text(
                                  (textHovered.value)
                                      ? "Time is made, not found!"
                                      : "Time is made.",
                                  style: TextStyle(
                                    fontFamily: "Caveat",
                                    fontSize:
                                        size.width * NC.taLine[deviceType]!,
                                    color:
                                        (textHovered.value)
                                            ? hoverColor
                                            : Colors.white.withValues(
                                              alpha: 0.7,
                                            ),
                                  ),
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            0.025 * size.height,
                            0,
                            0.05 * size.height,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: MouseRegion(
                                  onEnter: (hover) {
                                    if (hoverColor !=
                                        Colors.white.withValues(alpha: 0.7)) {
                                      tHovered.value = true;
                                    }
                                  },
                                  onExit: (hover) {
                                    tHovered.value = false;
                                  },
                                  child: ValueListenableBuilder(
                                    valueListenable: tHovered,
                                    builder:
                                        (_, __, ___) => IconButton(
                                          onPressed:
                                              () => _launchLink(
                                                'https://twitter.com/JustAry27',
                                              ),
                                          icon: Icon(
                                            FontAwesomeIcons.xTwitter,
                                            size: NC.links[deviceType]!,
                                          ),
                                          color:
                                              (tHovered.value)
                                                  ? hoverColor
                                                  : Colors.white.withValues(
                                                    alpha: 0.7,
                                                  ),
                                        ),
                                  ),
                                ),
                              ),
                              MouseRegion(
                                onEnter: (hover) {
                                  if (hoverColor !=
                                      Colors.white.withValues(alpha: 0.7)) {
                                    gHovered.value = true;
                                  }
                                },
                                onExit: (hover) {
                                  gHovered.value = false;
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: gHovered,
                                  builder:
                                      (_, __, ___) => IconButton(
                                        onPressed:
                                            () => _launchLink(
                                              'https://github.com/justary27',
                                            ),
                                        icon: Icon(
                                          FontAwesomeIcons.github,
                                          size: NC.links[deviceType]!,
                                        ),
                                        color:
                                            (gHovered.value)
                                                ? hoverColor
                                                : Colors.white.withValues(
                                                  alpha: 0.7,
                                                ),
                                      ),
                                ),
                              ),
                              MouseRegion(
                                onEnter: (hover) {
                                  if (hoverColor !=
                                      Colors.white.withValues(alpha: 0.7)) {
                                    lHovered.value = true;
                                  }
                                },
                                onExit: (hover) {
                                  lHovered.value = false;
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: lHovered,
                                  builder:
                                      (_, __, ___) => IconButton(
                                        onPressed:
                                            () => _launchLink(
                                              'https://www.linkedin.com/in/aryan-ranjan27/',
                                            ),
                                        icon: Icon(
                                          FontAwesomeIcons.linkedin,
                                          size: NC.links[deviceType]!,
                                        ),
                                        color:
                                            (lHovered.value)
                                                ? hoverColor
                                                : Colors.white.withValues(
                                                  alpha: 0.7,
                                                ),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dialog buildLargeCard(Size size, DeviceType deviceType) {
    ValueNotifier<bool> isHovered = ValueNotifier(false);
    ValueNotifier<bool> tHovered = ValueNotifier(false);
    ValueNotifier<bool> gHovered = ValueNotifier(false);
    ValueNotifier<bool> lHovered = ValueNotifier(false);
    ValueNotifier<bool> textHovered = ValueNotifier(false);
    Color hoverColor = RouteManager.currentColor;
    return Dialog(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: 0.75 * size.width,
              height: 0.8 * size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(218, 224, 224, 1.0),
                    Color.fromRGBO(183, 193, 192, 1.0),
                  ],
                ),
              ),
              child: CustomPaint(
                painter: RoorkeePainter(
                  RouteManager.currentColor,
                  const Color.fromRGBO(
                    145,
                    155,
                    153,
                    1.0,
                  ).withValues(alpha: 0.4),
                ),
              ),
            ),
            SizedBox(
              width: 0.75 * size.width,
              height: 0.8 * size.height,
              child: Column(
                children: [
                  SizedBox(
                    width: 0.75 * size.width,
                    height: 0.56 * size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 0.1 * size.height),
                        Text(
                          "Contact Me",
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            fontSize: size.width * NC.taLine[deviceType]!,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0.025 * size.height),
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                            onPressed:
                                () =>
                                    _launchLink("mailto:aryan_r@ch.iitr.ac.in"),
                            child: MouseRegion(
                              onEnter: (hover) {
                                if (hoverColor != Colors.black) {
                                  isHovered.value = true;
                                }
                              },
                              onExit: (hover) {
                                isHovered.value = false;
                              },
                              child: ValueListenableBuilder(
                                valueListenable: isHovered,
                                builder:
                                    (_, __, ___) => Text(
                                      "aryan_r@ch.iitr.ac.in",
                                      style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        color:
                                            (isHovered.value)
                                                ? hoverColor
                                                : Colors.black,
                                        fontSize:
                                            size.width * NC.email[deviceType]!,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 0.75 * size.width,
                    height: 0.24 * size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MouseRegion(
                          onEnter: (hover) {
                            if (hoverColor !=
                                Colors.white.withValues(alpha: 0.7)) {
                              textHovered.value = true;
                            }
                          },
                          onExit: (hover) {
                            textHovered.value = false;
                          },
                          child: ValueListenableBuilder(
                            valueListenable: textHovered,
                            builder:
                                (_, __, ___) => Text(
                                  (textHovered.value)
                                      ? "Time is made, not found!"
                                      : "Time is made.",
                                  style: TextStyle(
                                    fontFamily: "Caveat",
                                    fontSize:
                                        size.width * NC.taLine[deviceType]!,
                                    color:
                                        (textHovered.value)
                                            ? hoverColor
                                            : Colors.white.withValues(
                                              alpha: 0.7,
                                            ),
                                  ),
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            0.025 * size.height,
                            0,
                            0.05 * size.height,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MouseRegion(
                                onEnter: (hover) {
                                  if (hoverColor !=
                                      Colors.white.withValues(alpha: 0.7)) {
                                    tHovered.value = true;
                                  }
                                },
                                onExit: (hover) {
                                  tHovered.value = false;
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: tHovered,
                                  builder:
                                      (_, __, ___) => AnchorButton(
                                        destUrl:
                                            'https://twitter.com/JustAry27',
                                        icon: Icon(
                                          FontAwesomeIcons.xTwitter,
                                          size: NC.links[deviceType]!,
                                        ),
                                        color:
                                            (tHovered.value)
                                                ? hoverColor
                                                : Colors.white.withValues(
                                                  alpha: 0.7,
                                                ),
                                        parentContext: context,
                                      ),
                                ),
                              ),
                              MouseRegion(
                                onEnter: (hover) {
                                  if (hoverColor !=
                                      Colors.white.withValues(alpha: 0.7)) {
                                    gHovered.value = true;
                                  }
                                },
                                onExit: (hover) {
                                  gHovered.value = false;
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: gHovered,
                                  builder:
                                      (_, __, ___) => AnchorButton(
                                        destUrl: 'https://github.com/justary27',
                                        icon: Icon(
                                          FontAwesomeIcons.github,
                                          size: NC.links[deviceType]!,
                                        ),
                                        color:
                                            (gHovered.value)
                                                ? hoverColor
                                                : Colors.white.withValues(
                                                  alpha: 0.7,
                                                ),
                                        parentContext: context,
                                      ),
                                ),
                              ),
                              MouseRegion(
                                onEnter: (hover) {
                                  if (hoverColor !=
                                      Colors.white.withValues(alpha: 0.7)) {
                                    lHovered.value = true;
                                  }
                                },
                                onExit: (hover) {
                                  lHovered.value = false;
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: lHovered,
                                  builder:
                                      (_, __, ___) => AnchorButton(
                                        destUrl:
                                            'https://www.linkedin.com/in/aryan-ranjan27/',
                                        icon: Icon(
                                          FontAwesomeIcons.linkedin,
                                          size: NC.links[deviceType]!,
                                        ),
                                        color:
                                            (lHovered.value)
                                                ? hoverColor
                                                : Colors.white.withValues(
                                                  alpha: 0.7,
                                                ),
                                        parentContext: context,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
