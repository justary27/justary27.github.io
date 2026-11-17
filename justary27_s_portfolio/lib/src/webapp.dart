import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/routing.dart';
import 'themes/theme.dart';

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.light,
        title: 'Aryan Ranjan | justary27',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
