import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/footer.dart';
import '../components/navbar.dart';
import '../utils/helpers/screen_helper.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

class ApplicationShell extends ConsumerWidget {
  final Widget child;

  const ApplicationShell({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.1 * logicalHeight),
        child: Navbar(
          navigatorKey: navigator,
        ),
      ),
      body: child,
      // bottomNavigationBar: Footer(size: logicalScreenSize),
    );
  }
}
