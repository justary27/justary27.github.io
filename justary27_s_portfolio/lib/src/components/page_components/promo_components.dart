import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import '../../constants/component_constraints/promo_constraints.dart';

class PromoRedirector extends StatelessWidget {
  final Size size;
  final String deviceType;
  final String pageName;
  final String pageDescriptor;
  final TextButton button;
  const PromoRedirector({
    Key? key,
    required this.size,
    required this.deviceType,
    required this.pageName,
    required this.pageDescriptor,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.015 * size.height),
            child: Text(
              pageName,
              textAlign: TextAlign.center,
              style: GoogleFonts.caveatBrush(
                textStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize:
                      promoConstraints['taLine']![deviceType] * size.width,
                ),
              ),
            ),
          ),
          Transform.rotate(
            angle: -math.pi / 9,
            child: Container(
              width: promoConstraints['rotLine']![deviceType]['width'] *
                  size.width,
              height: promoConstraints['rotLine']![deviceType]['height'] *
                  size.height,
              color: Color.fromRGBO(20, 62, 188, 1),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 0.2 * size.width, vertical: 0.04 * size.height),
            child: Text(
              pageDescriptor,
              textAlign: TextAlign.center,
              style: GoogleFonts.caveatBrush(
                textStyle: TextStyle(
                  color: Color.fromRGBO(14, 43, 133, 1.0),
                  fontSize: 0.05 * size.width,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.2 * size.width),
            child: button,
          )
        ],
      ),
    );
  }
}
