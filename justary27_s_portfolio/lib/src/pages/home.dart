import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/components/navbar.dart';
import 'package:justary27_s_portfolio/src/components/deviceDetector.dart';
import 'package:justary27_s_portfolio/src/routes/routing.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String deviceType = deviceDetector(size);
    RouteManager.size = size;
    RouteManager.deviceType = deviceType;
    return Scaffold(
      body: Stack(
        children: [
          Navigator(
            key: navigatorKey,
            initialRoute: RouteManager.homePage,
            onGenerateRoute: RouteManager.generateRoute,
          ),
          Navbar(
            navigatorKey: navigatorKey,
          ),
        ],
      ),
      extendBody: true,
    );
  }
}
