import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app.dart';
import '../../constants/page_constraints/opener_constraints.dart';
import '../../routes/routing.dart';

class SmallOpenerPage extends StatelessWidget {
  final Size size;
  final String deviceType;
  const SmallOpenerPage({
    Key? key,
    required this.size,
    required this.deviceType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 243, 248, 247)
                ]),
          ),
          child: Container(
            width: size.width,
            height: size.height,
          ),
        ),
        Container(
          width: size.width,
          height: size.height,
          color: Colors.black.withOpacity(0.3),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(0.1 * size.width),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aryan Ranjan",
                  style: TextStyle(
                    fontFamily: "Allison",
                    color: Color(0xFFDC4654),
                    fontSize:
                        openerConstraints['name'][deviceType] * size.width,
                  ),
                ),
                Text(
                  "IITR'24 | Codifyin' reality",
                  style: TextStyle(
                    fontFamily: "Caveat",
                    color: Color(0xFF737373),
                    fontSize:
                        openerConstraints['taLine'][deviceType] * size.width,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0.025 * size.height),
                  height: 50,
                  // width: size.width * 0.1,
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      RouteManager.navigateToIntro(navigator);
                    },
                    label: FittedBox(
                      child: Text(
                        "Intro",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Ubuntu",
                          fontSize: openerConstraints['taLine'][deviceType] *
                              size.width,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFFDC4654).withOpacity(0.75),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 0.4 * size.width,
            color: Color(0xFFDC4654),
            height: size.height,
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(0.075 * size.width),
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                ),
                items: [
                  SvgPicture.asset(
                    "images/ar.svg",
                    color: Colors.white.withOpacity(0.85),
                  ),
                  SvgPicture.asset(
                    "images/jane.svg",
                    height: 0.5 * size.height,
                    color: Colors.white.withOpacity(0.85),
                  ),
                  SvgPicture.asset(
                    "images/covbot.svg",
                    color: Colors.white.withOpacity(0.85),
                  ),
                  SvgPicture.asset(
                    "images/gsoc.svg",
                    // color: Colors.white.withOpacity(0.75),
                  ),
                  SvgPicture.asset(
                    "images/bugheist.svg",
                    height: 0.1 * size.height,
                    color: Colors.white.withOpacity(0.85),
                  ),
                  SvgPicture.asset(
                    "images/lyf.svg",
                    color: Colors.white.withOpacity(0.85),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
