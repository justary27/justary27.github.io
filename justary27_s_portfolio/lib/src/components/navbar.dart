import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/components/navbar/large_bar.dart';
import 'package:justary27_s_portfolio/src/components/navbar/small_bar.dart';

class Navbar extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String deviceType;
  const Navbar({
    Key? key,
    required this.navigatorKey,
    required this.deviceType,
  }) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (widget.deviceType == 'mobiles390-' ||
        widget.deviceType == 'mobiles450-' ||
        widget.deviceType == 'tablets768-') {
      return SmallNavBar(
        navigatorKey: widget.navigatorKey,
        size: size,
        deviceType: widget.deviceType,
      );
    } else {
      return LargeNavBar(
        size: size,
        deviceType: widget.deviceType,
        navigatorKey: widget.navigatorKey,
      );
    }
  }
}
