import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justary27_s_portfolio/src/components/navbar/drawer.dart';
import 'package:justary27_s_portfolio/src/utils/helpers/screen_helper.dart';
import 'package:justary27_s_portfolio/src/routes/routing.dart';

import 'components/deviceDetector.dart';
import 'components/navbar.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  final Size size = logicalScreenSize;
  final String deviceType = deviceDetector(logicalScreenSize);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'justary27 | Aryan Ranjan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSwatch(
            accentColor: RouteManager.currentColor.withOpacity(0.3),
          ),
        ),
        navigatorKey: navigator,
        initialRoute: RouteManager.homePage,
        onGenerateRoute: RouteManager.generateRoute,
        builder: (context, child) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0.1 * logicalHeight),
              child: Navbar(
                navigatorKey: navigator,
                deviceType: deviceType,
              ),
            ),
            body: child!,
            endDrawer: (deviceType == 'mobiles390-' ||
                    deviceType == 'mobiles450-' ||
                    deviceType == 'tablets768-')
                ? SmallDrawer(
                    navigator: navigator,
                    deviceType: deviceType,
                    size: size,
                  )
                : null,
          );
        },
      ),
    );
  }
}
