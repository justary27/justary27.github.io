import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justary27_s_portfolio/src/utils/helpers/screen_helper.dart';
import 'package:justary27_s_portfolio/src/routes/routing.dart';

import 'components/deviceDetector.dart';
import 'components/navbar.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

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
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSwatch(
            accentColor: RouteManager.currentColor
                .withOpacity(0.3), // but now it should be declared like this
          ),
        ),
        navigatorKey: navigator,
        initialRoute: RouteManager.homePage,
        onGenerateRoute: RouteManager.generateRoute,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: Navbar(navigatorKey: navigator),
            body: child!,
          );
          // return Material(
          //   color: Colors.transparent,
          //   child: Stack(
          //     children: [
          //       child!,
          //       Navbar(
          //         navigatorKey: navigator,
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}
