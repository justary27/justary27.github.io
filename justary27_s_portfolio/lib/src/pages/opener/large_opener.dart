import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../utils/handlers/route_handler.dart';
import '../../constants/page_constraints/opener_constraints.dart';

class LargeOpenerPage extends StatelessWidget {
  final Size size;
  final String deviceType;
  const LargeOpenerPage({
    Key? key,
    required this.size,
    required this.deviceType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FittedBox(
        // width: size.width,
        // height: size.height,
        fit: BoxFit.fill,
        child: Row(
          children: [
            Container(
              width: 0.7 * size.width,
              height: size.height,
              padding: EdgeInsets.symmetric(
                horizontal: 0.1 * size.width,
                vertical: 0.1 * size.height,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 239, 242, 242),
                    Color.fromRGBO(183, 193, 192, 1.0),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aryan Ranjan",
                    style: TextStyle(
                      fontFamily: "Allison",
                      color: Color(0xFFDC4654).withOpacity(0.75),
                      fontWeight: FontWeight.bold,
                      fontSize:
                          openerConstraints['name'][deviceType] * size.width,
                    ),
                  ),
                  Text(
                    "IITR'24 | Codifyin' reality",
                    style: TextStyle(
                      fontFamily: "Caveat",
                      color: Color(0xFF737373),
                      fontWeight: FontWeight.bold,
                      fontSize:
                          openerConstraints['taLine'][deviceType] * size.width,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0.025 * size.height),
                    height: 50,
                    width: size.width * 0.1,
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        bool? res =
                            await context.push<bool>(RouteHandler.introPage);
                        print(res);
                      },
                      label: FittedBox(
                        child: Text(
                          "Intro",
                          style: TextStyle(
                            fontFamily: "Ubuntu",
                            color: Colors.white,
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
            Container(
              width: 0.3 * size.width,
              height: size.height,
              padding: EdgeInsets.symmetric(
                vertical: 0.05 * size.height,
                horizontal: 0.05 * size.width,
              ),
              color: Color(0xFFDC4654),
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                ),
                items: [
                  SvgPicture.asset(
                    "images/ar.svg",
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.75),
                      BlendMode.srcIn,
                    ),
                  ),
                  SvgPicture.asset(
                    "images/jane.svg",
                    height: 0.5 * size.height,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.75),
                      BlendMode.srcIn,
                    ),
                  ),
                  SvgPicture.asset(
                    "images/covbot.svg",
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.75),
                      BlendMode.srcIn,
                    ),
                  ),
                  SvgPicture.asset(
                    "images/gsoc.svg",
                    // color: Colors.white.withOpacity(0.75),
                  ),
                  SvgPicture.asset(
                    "images/bugheist.svg",
                    height: 0.1 * size.height,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.75),
                      BlendMode.srcIn,
                    ),
                  ),
                  SvgPicture.asset(
                    "images/lyf.svg",
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.75),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
