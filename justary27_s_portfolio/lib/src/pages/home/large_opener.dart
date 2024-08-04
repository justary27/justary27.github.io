import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pdfrx/pdfrx.dart';

import './painters/who_painter.dart';
import '../../components/anchor.dart';
import '../../enums/device_type.dart';
import './painters/path_painter.dart';
import './painters/carousel_painter.dart';
import '../../handlers/route_handler.dart';
import './painters/semi_circle_painter.dart';

import 'home_constants.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFf2f2f2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LargeIntroWelcome(
              size: size,
            ),
            LargeIntroDetailed(
              size: size,
              deviceType: deviceType,
            ),
            LargeIntroWork(
              size: size,
              deviceType: deviceType,
            ),
            LargeWhoBlogBrief(
              size: size,
              deviceType: deviceType,
            ),
            SizedBox(
              height: size.height,
              width: size.width,
              child: LargeIntroBrief(
                size: size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LargeIntroWelcome extends StatefulWidget {
  final Size size;
  const LargeIntroWelcome({
    super.key,
    required this.size,
  });

  @override
  State<LargeIntroWelcome> createState() => _LargeIntroWelcomeState();
}

class _LargeIntroWelcomeState extends State<LargeIntroWelcome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 5),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    double radius = (widget.size.width > widget.size.height)
        ? 0.4 * widget.size.width
        : 0.4 * widget.size.height;

    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: -radius * 1,
                child: CustomPaint(
                  painter: CarouselPainter(
                    angle: _controller.value * 360,
                    radius: radius,
                  ),
                  child: SizedBox(
                    width: radius * 2,
                    height: radius * 2,
                  ),
                ),
              ),
              Positioned(
                bottom: -radius,
                child: CircularText(
                  children: [
                    TextItem(
                      text: Text(
                        "IIT Roorkee'24".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 28,
                          color: Color(0xFF0d0d0d),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      space: 5,
                      startAngle: -90 + _controller.value * 360,
                      startAngleAlignment: StartAngleAlignment.center,
                      direction: CircularTextDirection.clockwise,
                    ),
                    TextItem(
                      text: Text(
                        "Open Source Enthusisast".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFF0d0d0d),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      space: 2.5,
                      startAngle: 30 + _controller.value * 360,
                      startAngleAlignment: StartAngleAlignment.center,
                      direction: CircularTextDirection.anticlockwise,
                    ),
                    TextItem(
                      text: Text(
                        "Software Developer".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 28,
                          color: Color(0xFF0d0d0d),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      space: 3.5,
                      startAngle: 150 + _controller.value * 360,
                      startAngleAlignment: StartAngleAlignment.center,
                      direction: CircularTextDirection.clockwise,
                    ),
                  ],
                  radius: 1.025 * radius,
                  position: CircularTextPosition.outside,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Aryan Ranjan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Allison",
                      color: const Color(0xFF0d0d0d),
                      fontWeight: FontWeight.bold,
                      fontSize: 0.15 * widget.size.width,
                    ),
                  ),
                  Text(
                    "I'm a software developer & open-source enthusiast.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.redHatDisplay(
                      textStyle: const TextStyle(
                        // fontFamily: "ABeeZee",
                        color: Color(0xFF0d0d0d),
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LargeIntroDetailed extends StatefulWidget {
  final DeviceType deviceType;
  final Size size;
  const LargeIntroDetailed({
    super.key,
    required this.deviceType,
    required this.size,
  });

  @override
  State<LargeIntroDetailed> createState() => _LargeIntroDetailedState();
}

class _LargeIntroDetailedState extends State<LargeIntroDetailed>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0.045),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.4 * widget.size.height,
      width: widget.size.width,
      child: Row(
        children: [
          Container(
            width: 0.45 * widget.size.width,
            height: widget.size.height,
            padding: EdgeInsets.symmetric(
              horizontal: 0.05 * widget.size.width,
              // vertical: 0.1 * widget.size.height,
            ),
            child: SlideTransition(
              position: _offsetAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Transform.rotate(
                        angle: -math.pi / 9,
                        child: Container(
                          width: OC.rotLine[widget.deviceType]!['width']! *
                              widget.size.width,
                          height: OC.rotLine[widget.deviceType]!['height']! *
                              widget.size.width,
                          color: const Color(0xFF0d0d0d),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Tech Stack",
                          style: GoogleFonts.abel(
                            textStyle: const TextStyle(
                              // fontFamily: "Caveat",
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0d0d0d),
                              fontSize: 50,
                            ),
                          ),
                          // style: TextStyle(fontFamily: "Ubuntu"),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 8,
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8.0,
                      // alignment: MainAxisAlignment.center,
                      children: [
                        AnchorButton(
                          destUrl: 'https://python.org',
                          icon: Icon(
                            FontAwesomeIcons.python,
                            size: OC.techStack[widget.deviceType],
                            color: const Color(0xFF0d0d0d),
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://dart.dev/',
                          icon: SvgPicture.asset(
                            "images/intro/dart.svg",
                            height: 40,
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://www.javascript.com/',
                          icon: Icon(
                            FontAwesomeIcons.js,
                            size: OC.techStack[widget.deviceType],
                            color: const Color(0xFF0d0d0d),
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://www.typescriptlang.org/',
                          icon: SvgPicture.asset(
                            "images/intro/ts.svg",
                            height: OC.techStack[widget.deviceType],
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://isocpp.org/',
                          icon: SvgPicture.asset(
                            "images/intro/cpp.svg",
                            height: OC.techStack[widget.deviceType],
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://go.dev/',
                          icon: Icon(
                            FontAwesomeIcons.golang,
                            size: OC.techStack[widget.deviceType],
                            color: const Color(0xFF0d0d0d),
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://www.java.com/en/',
                          icon: Icon(
                            FontAwesomeIcons.java,
                            size: OC.techStack[widget.deviceType],
                            color: const Color(0xFF0d0d0d),
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://julialang.org/',
                          icon: SvgPicture.asset(
                            "images/intro/julia.svg",
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF0d0d0d),
                              BlendMode.srcIn,
                            ),
                            height: OC.techStack[widget.deviceType],
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl:
                              'https://learn.microsoft.com/en-us/dotnet/csharp/',
                          icon: SvgPicture.asset(
                            "images/intro/csharp.svg",
                            height: OC.techStack[widget.deviceType],
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://www.terraform.io/',
                          icon: SvgPicture.asset(
                            "images/intro/terraform.svg",
                            height: OC.techStack[widget.deviceType],
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://html5.org/',
                          icon: Icon(
                            FontAwesomeIcons.html5,
                            size: OC.techStack[widget.deviceType],
                            color: const Color(0xFF0d0d0d),
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl:
                              'https://developer.mozilla.org/en-US/docs/Web/CSS',
                          icon: Icon(
                            FontAwesomeIcons.css3,
                            size: OC.techStack[widget.deviceType],
                            color: const Color(0xFF0d0d0d),
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://sass-lang.com/',
                          icon: Icon(
                            FontAwesomeIcons.sass,
                            size: OC.techStack[widget.deviceType],
                            color: const Color(0xFF0d0d0d),
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://www.djangoproject.com/',
                          icon: SvgPicture.asset(
                            "images/intro/django.svg",
                            height: OC.techStack[widget.deviceType],
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://flutter.dev/',
                          icon: SvgPicture.asset(
                            "images/intro/flutter.svg",
                            height: OC.techStack[widget.deviceType],
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://reactjs.org',
                          icon: Icon(
                            FontAwesomeIcons.react,
                            size: OC.techStack[widget.deviceType],
                            color: const Color(0xFF0d0d0d),
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://firebase.google.com/',
                          icon: SvgPicture.asset(
                            "images/intro/firebase.svg",
                            height: OC.techStack[widget.deviceType],
                          ),
                          parentContext: context,
                        ),
                        AnchorButton(
                          destUrl: 'https://aws.amazon.com/',
                          icon: Icon(
                            FontAwesomeIcons.aws,
                            size: OC.techStack[widget.deviceType],
                            color: const Color(0xFF0d0d0d),
                          ),
                          parentContext: context,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            // color: Colors.red,
            width: 0.55 * widget.size.width,
            height: 1.4 * widget.size.height,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              horizontal: 0.05 * widget.size.width,
              vertical: 0.05 * widget.size.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Transform.rotate(
                      angle: -math.pi / 9,
                      child: Container(
                        width: OC.rotLine[widget.deviceType]!['width']! *
                            widget.size.width,
                        height: OC.rotLine[widget.deviceType]!['height']! *
                            widget.size.width,
                        color: const Color(0xFF0d0d0d),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Resume",
                        style: GoogleFonts.abel(
                          textStyle: const TextStyle(
                            // fontFamily: "Caveat",
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0d0d0d),
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1.1 * widget.size.height,
                  width: 0.55 * widget.size.width,
                  color: Colors.red,
                  child: PdfViewer.asset(
                    'resume.pdf',
                    params: PdfViewerParams(
                      enableTextSelection: true,
                      loadingBannerBuilder: (
                        context,
                        bytesDownloaded,
                        totalBytes,
                      ) {
                        return Center(
                          child: CircularProgressIndicator(
                            value: totalBytes != null
                                ? bytesDownloaded / totalBytes
                                : null,
                            backgroundColor: const Color(0xFF0d0d0d),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LargeIntroWork extends StatefulWidget {
  final Size size;
  final DeviceType deviceType;

  const LargeIntroWork(
      {super.key, required this.size, required this.deviceType});

  @override
  State<LargeIntroWork> createState() => _LargeIntroWorkState();
}

class _LargeIntroWorkState extends State<LargeIntroWork>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 5),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    double radius = 0.4 * widget.size.width;
    Size size = widget.size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: -radius,
                child: Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: CustomPaint(
                    painter: SemiCirclePainter(),
                    child: SizedBox(
                      width: radius * 2,
                      height: radius * 2,
                    ),
                  ),
                ),
              ),
              Row(
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
                            fontSize: OC.name[widget.deviceType]! * size.width,
                          ),
                        ),
                        Text(
                          "From humble beginnings with discord bots to working with large scale projects that impact a lot of users and working to develop cutting edge tech, it has been a long way, check out this journey of mine!",
                          style: GoogleFonts.redHatDisplay(
                            color: const Color(0xFF0d0d0d),
                            fontSize:
                                OC.aboutMe[widget.deviceType]! * size.width,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: TextButton.icon(
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                context.push(RouteHandler.workPage),
                            label: Text(
                              "Work",
                              style: TextStyle(
                                fontFamily: "Ubuntu",
                                color: Colors.white,
                                fontSize:
                                    OC.taLine[widget.deviceType]! * size.width,
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
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LargeWhoBlogBrief extends StatefulWidget {
  final Size size;
  final DeviceType deviceType;

  const LargeWhoBlogBrief({
    super.key,
    required this.size,
    required this.deviceType,
  });

  @override
  State<LargeWhoBlogBrief> createState() => _LargeWhoBlogBriefState();
}

class _LargeWhoBlogBriefState extends State<LargeWhoBlogBrief>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = widget.size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: MouseRegion(
        onEnter: (event) => _controller.forward(),
        onExit: (event) => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: WhoPainter(progress: _controller.value),
              child: Container(
                width: 0.7 * size.width,
                height: size.height,
                padding: EdgeInsets.only(
                  left: 0.05 * size.width,
                  right: 0.125 * size.width,
                  top: 0.1 * size.height,
                  bottom: 0.1 * size.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Know More About Me!",
                      style: TextStyle(
                        fontFamily: "Allison",
                        color: const Color(0xFF0d0d0d),
                        fontWeight: FontWeight.bold,
                        fontSize: OC.name[widget.deviceType]! * size.width,
                      ),
                      // style: TextStyle(fontFamily: "Ubuntu"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selfDesc,
                        style: GoogleFonts.redHatDisplay(
                          textStyle: TextStyle(
                            // fontFamily: "ABeeZee",
                            color: const Color(0xFF0d0d0d),
                            fontSize:
                                OC.aboutMe[widget.deviceType]! * size.width,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Wrap(
                        spacing: 16.0,
                        children: [
                          TextButton(
                            onPressed: () => context.push(RouteHandler.whoPage),
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color(0xFF0d0d0d).withOpacity(0.75),
                              ),
                            ),
                            child: Text(
                              "Who?",
                              style: TextStyle(
                                fontFamily: "Ubuntu",
                                color: Colors.white,
                                fontSize:
                                    OC.taLine[widget.deviceType]! * size.width,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                context.push(RouteHandler.blogPage),
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color(0xFF0d0d0d).withOpacity(0.75),
                              ),
                            ),
                            child: Text(
                              "Blog.",
                              style: TextStyle(
                                fontFamily: "Ubuntu",
                                color: Colors.white,
                                fontSize:
                                    OC.taLine[widget.deviceType]! * size.width,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LargeIntroBrief extends StatefulWidget {
  final Size size;

  const LargeIntroBrief({super.key, required this.size});

  @override
  State<LargeIntroBrief> createState() => _LargeIntroBriefState();
}

class _LargeIntroBriefState extends State<LargeIntroBrief>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _controller.forward(),
      onExit: (event) => _controller.reverse(),
      child: CustomPaint(
        size: widget.size,
        painter: PathPainter(_animation),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
