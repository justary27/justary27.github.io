import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/routing.dart';
import 'components/deviceDetector.dart';
import 'utils/helpers/screen_helper.dart';

class MyPortfolio extends StatelessWidget {
  final Size size = logicalScreenSize;
  final String deviceType = deviceDetector(logicalScreenSize.width);

  MyPortfolio({super.key});

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
