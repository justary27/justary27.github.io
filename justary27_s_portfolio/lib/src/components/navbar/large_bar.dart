import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/navbar/contact.dart';

import '../../routes/routing.dart';

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
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
      leading: Container(
        margin: EdgeInsets.only(left: 0.01 * widget.size.width),
        child: MaterialButton(
          elevation: 0,
          splashColor: Colors.white.withOpacity(0.5),
          child: SvgPicture.asset(
            "images/ar.svg",
            color: Colors.white.withOpacity(0.75),
          ),
          onPressed: () {
            if (RouteManager.currentRoute != "home") {
              RouteManager.navigateToHome(widget.navigatorKey);
            }
          },
          color: Colors.transparent,
        ),
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
