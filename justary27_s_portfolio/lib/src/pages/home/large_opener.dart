import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../enums/device_type.dart';
import '../../handlers/route_handler.dart';

import 'opener_constraints.dart';

class LargeOpenerPage extends StatelessWidget {
  final Size size;
  final DeviceType deviceType;
  const LargeOpenerPage({
    super.key,
    required this.size,
    required this.deviceType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 0.7 * size.width,
          height: size.height,
          padding: EdgeInsets.only(
            left: 0.05 * size.width,
            right: 0.125 * size.width,
            top: 0.1 * size.height,
            bottom: 0.1 * size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Work.",
                style: TextStyle(
                  fontFamily: "Allison",
                  color: const Color(0xFF0d0d0d),
                  fontWeight: FontWeight.bold,
                  fontSize: OC.name[deviceType]! * size.width,
                ),
              ),
              Text(
                "From humble beginnings with discord bots to working with large scale projects that impact a lot of users and working to develop cutting edge tech, it has been a long way, check out this journey of mine!",
                style: GoogleFonts.redHatDisplay(
                  color: const Color(0xFF737373),
                  fontSize: OC.taLine[deviceType]! * size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextButton.icon(
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () => context.push(RouteHandler.workPage),
                  label: Text(
                    "Work",
                    style: TextStyle(
                      fontFamily: "Ubuntu",
                      color: Colors.white,
                      fontSize: OC.taLine[deviceType]! * size.width,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      const Color(0xFF0d0d0d).withOpacity(0.75),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: 0.30 * size.width,
          height: size.height,
          alignment: Alignment.centerRight,
          // color: Colors.green,
          padding: EdgeInsets.symmetric(
            horizontal: 0.005 * size.width,
          ),
          child: SizedBox(
            width: 0.25 * size.width,
            height: 0.75 * size.height,
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
              ),
              items: [
                SvgPicture.asset(
                  "images/ar.svg",
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF0d0d0d),
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  "images/cdai.svg",
                  height: 0.2 * size.height,
                ),
                SvgPicture.asset(
                  "images/amazon.svg",
                  height: 0.2 * size.height,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF0d0d0d),
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  "images/img.svg",
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF0d0d0d),
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  "images/placement.svg",
                  height: 0.2 * size.height,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF0d0d0d),
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  "images/noticeboard.svg",
                  height: 0.2 * size.height,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF0d0d0d),
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  "images/lyf.svg",
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF0d0d0d),
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  "images/bugheist.svg",
                  height: 0.2 * size.height,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF0d0d0d),
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  "images/gsoc.svg",
                  // color: Colors.white.withOpacity(0.75),
                ),
                SvgPicture.asset(
                  "images/covbot.svg",
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF0d0d0d),
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  "images/jane.svg",
                  height: 0.5 * size.height,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF0d0d0d),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
