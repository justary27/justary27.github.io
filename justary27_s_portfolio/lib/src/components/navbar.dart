import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/components/navbar/large_bar.dart';
import 'package:justary27_s_portfolio/src/components/navbar/small_bar.dart';

import '../enums/device_type.dart';

class Navbar extends StatefulWidget {
  final GlobalKey<ScaffoldState> navigatorKey;
  const Navbar({super.key, required this.navigatorKey});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DeviceType deviceType = DeviceType.getDeviceType(size.width);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (deviceType < DeviceType.largeTablet) {
          return SmallNavBar(
            navigatorKey: widget.navigatorKey,
            size: size,
            deviceType: deviceType,
          );
        } else {
          return LargeNavBar(size: size, deviceType: deviceType);
        }
      },
    );
  }
}
