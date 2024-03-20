import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justary27_s_portfolio/src/components/deviceDetector.dart';

// import '../components/footer.dart';
import '../components/navbar.dart';
import '../components/navbar/drawer.dart';
import '../utils/helpers/screen_helper.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class ApplicationShell extends ConsumerWidget {
  final Widget child;

  const ApplicationShell({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    String _deviceType = deviceDetector(size.width);

    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.1 * logicalHeight),
        child: Navbar(
          navigatorKey: scaffoldKey,
        ),
      ),
      body: child,
      endDrawer: (_deviceType == 'mobiles390-' ||
              _deviceType == 'mobiles450-' ||
              _deviceType == 'tablets768-')
          ? SmallDrawer(
              navigator: scaffoldKey,
              size: logicalScreenSize,
              deviceType: _deviceType,
            )
          : null,
      // bottomNavigationBar: Footer(size: logicalScreenSize),
    );
  }
}
