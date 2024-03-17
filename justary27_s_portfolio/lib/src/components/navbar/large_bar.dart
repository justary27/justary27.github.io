import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:justary27_s_portfolio/src/components/navbar/contact.dart';
import 'package:justary27_s_portfolio/src/utils/handlers/route_handler.dart';

class LargeNavBar extends StatefulWidget {
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
  State<LargeNavBar> createState() => _LargeNavBarState();
}

class _LargeNavBarState extends State<LargeNavBar> {
  void _handleRouteNavigation(String destination) {
    if (GoRouterState.of(context).uri.path != destination) {
      context.push(destination);
    }
  }

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
        child: IconButton(
          splashColor: Colors.white.withOpacity(0.5),
          icon: SvgPicture.asset(
            "images/ar.svg",
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.75),
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => _handleRouteNavigation(
            RouteHandler.homePage,
          ),
          color: Colors.transparent,
        ),
      ),
      title: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onHover: (pointer) {},
            child: MaterialButton(
              onPressed: () => _handleRouteNavigation(
                RouteHandler.introPage,
              ),
              child: Text(
                "Intro",
                style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => _handleRouteNavigation(
              RouteHandler.whoPage,
            ),
            child: Text(
              "Who",
              style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: () => _handleRouteNavigation(
              RouteHandler.workPage,
            ),
            child: Text(
              "Work",
              style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: () => _handleRouteNavigation(
              RouteHandler.blogPage,
            ),
            child: Text(
              "Blog",
              style: TextStyle(
                fontFamily: "ABeeZee",
                color: Colors.white,
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
              context: context,
              builder: (context) {
                return ContactCard(
                    size: widget.size, deviceType: widget.deviceType);
              },
            );
          },
          child: Text(
            "Contact",
            style: TextStyle(
              fontFamily: "ABeeZee",
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
