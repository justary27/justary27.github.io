import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/components/deviceDetector.dart';
import 'package:justary27_s_portfolio/src/components/navbar/large_bar.dart';
import 'package:justary27_s_portfolio/src/components/navbar/small_bar.dart';

class Navbar extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const Navbar({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        String _deviceType = deviceDetector(constraints.maxWidth);
        if (_deviceType == 'mobiles390-' ||
            _deviceType == 'mobiles450-' ||
            _deviceType == 'tablets768-') {
          return SmallNavBar(
            navigatorKey: widget.navigatorKey,
            size: size,
            deviceType: _deviceType,
          );
        } else {
          return LargeNavBar(
            size: size,
            deviceType: _deviceType,
            navigatorKey: widget.navigatorKey,
          );
        }
      },
    );
  }
}
