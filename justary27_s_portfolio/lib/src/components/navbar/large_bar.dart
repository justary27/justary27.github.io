import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/navbar/contact.dart';

import '../../routes/routing.dart';
import '../ar.dart';

class LargeNavBar extends ConsumerStatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Size size;
  final String deviceType;

  const LargeNavBar({
    Key? key,
    required this.navigatorKey,
    required this.size,
    required this.deviceType,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LargeNavBarState();
}

class _LargeNavBarState extends ConsumerState<LargeNavBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 0.15 * widget.size.height,
      backgroundColor: Colors.transparent,
      leading: MaterialButton(
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
            RouteManager.navigateToHome(widget.navigatorKey);
          }
        },
        color: Colors.transparent,
      ),
      title: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onHover: (pointer) {},
            child: MaterialButton(
              onPressed: () {
                if (RouteManager.currentRoute != "intro") {
                  RouteManager.navigateToIntro(widget.navigatorKey);
                }
              },
              child: Text(
                "Intro",
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (RouteManager.currentRoute != "who") {
                RouteManager.navigateToWho(widget.navigatorKey);
              }
            },
            child: Text(
              "Who",
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (RouteManager.currentRoute != "work") {
                RouteManager.navigateToWork(widget.navigatorKey);
              }
            },
            child: Text(
              "Work",
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (RouteManager.currentRoute != "blog") {
                RouteManager.navigateToBlog(widget.navigatorKey);
              }
            },
            child: Text(
              "Blog",
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            showDialog(
              useRootNavigator: false,
              context: widget.navigatorKey.currentContext!,
              builder: (context) {
                return ContactCard(
                    size: widget.size, deviceType: widget.deviceType);
              },
            );
          },
          child: Text(
            "Contact",
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
