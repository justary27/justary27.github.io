import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../enums/device_type.dart';

/// Storage class for `PromoComponent` constraints
class PC {
  PC._();

  static const Map<DeviceType, double> taLine = {
    DeviceType.smallMobile: 0.0460,
    DeviceType.largeMobile: 0.0410,
    DeviceType.smallTablet: 0.0360,
    DeviceType.largeTablet: 0.0300,
    DeviceType.smallLaptop: 0.02,
    DeviceType.largeLaptop: 0.02,
    DeviceType.smallDesktop: 0.02,
  };

  static const Map<DeviceType, Map<String, double>> rotLine = {
    DeviceType.smallMobile: {'width': 0.02500, 'height': 0.01400},
    DeviceType.largeMobile: {'width': 0.02250, 'height': 0.01317},
    DeviceType.smallTablet: {'width': 0.02000, 'height': 0.01170},
    DeviceType.largeTablet: {'width': 0.01750, 'height': 0.01083},
    DeviceType.smallLaptop: {'width': 0.0150, 'height': 0.010},
    DeviceType.largeLaptop: {'width': 0.0150, 'height': 0.010},
    DeviceType.smallDesktop: {'width': 0.0150, 'height': 0.010},
  };
}

class PromoRedirector extends StatelessWidget {
  final Size size;
  final DeviceType deviceType;
  final String pageName;
  final String pageDescriptor;
  final TextButton button;
  final BoxDecoration? decoration;
  final CustomPainter? customPainter;
  const PromoRedirector({
    super.key,
    required this.size,
    required this.deviceType,
    required this.pageName,
    required this.pageDescriptor,
    required this.button,
    this.decoration,
    this.customPainter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: decoration,
      child: CustomPaint(
        painter: customPainter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.015 * size.height),
              child: Text(
                pageName,
                textAlign: TextAlign.center,
                style: GoogleFonts.abel(
                  textStyle: TextStyle(
                    // fontFamily: "Caveat",
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withValues(alpha: 0.5),
                    fontSize: PC.taLine[deviceType]! * size.width,
                  ),
                ),
              ),
            ),
            Transform.rotate(
              angle: -math.pi / 9,
              child: Container(
                width: PC.rotLine[deviceType]!['width']! * size.width,
                height: PC.rotLine[deviceType]!['height']! * size.height,
                color: const Color.fromRGBO(20, 62, 188, 1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.2 * size.width,
                vertical: 0.04 * size.height,
              ),
              child: Text(
                pageDescriptor,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSansCondensed(
                  textStyle: TextStyle(
                    // fontFamily: "Caveat",
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(14, 43, 133, 1.0),
                    fontSize: 0.05 * size.width,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.2 * size.width),
              child: button,
            ),
          ],
        ),
      ),
    );
  }
}
