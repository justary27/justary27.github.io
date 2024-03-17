import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/routing.dart';
import 'components/deviceDetector.dart';
import 'utils/helpers/screen_helper.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class MyPortfolio extends StatelessWidget {
  final Size size = logicalScreenSize;
  final String deviceType = deviceDetector(logicalScreenSize.width);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        title: 'justary27 | Aryan Ranjan',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
