import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/routing.dart';

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Aryan Ranjan | justary27',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
