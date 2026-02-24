import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/components/large_bar.dart';
import 'package:justary27_s_portfolio/src/components/small_bar.dart';

import '../enums/device_type.dart';

/// Storage class for Navbar constraints.
class NC {
  NC._();

  static const Map<DeviceType, double> email = {
    DeviceType.smallMobile: 0.110,
    DeviceType.largeMobile: 0.0975,
    DeviceType.smallTablet: 0.075,
    DeviceType.largeTablet: 0.0625,
    DeviceType.smallLaptop: 0.05,
    DeviceType.largeLaptop: 0.045,
    DeviceType.smallDesktop: 0.045,
  };

  static const Map<DeviceType, double> links = {
    DeviceType.smallMobile: 16,
    DeviceType.largeMobile: 17.5,
    DeviceType.smallTablet: 19.5,
    DeviceType.largeTablet: 21,
    DeviceType.smallLaptop: 24,
    DeviceType.largeLaptop: 27,
    DeviceType.smallDesktop: 27,
  };

  static const Map<DeviceType, double> taLine = {
    DeviceType.smallMobile: 0.0460,
    DeviceType.largeMobile: 0.0410,
    DeviceType.smallTablet: 0.0360,
    DeviceType.largeTablet: 0.0300,
    DeviceType.smallLaptop: 0.02,
    DeviceType.largeLaptop: 0.02,
    DeviceType.smallDesktop: 0.02,
  };
}

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
