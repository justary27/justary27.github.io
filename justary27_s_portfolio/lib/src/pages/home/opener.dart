import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../components/anchor.dart';
import '../../models/screen_model.dart';
import 'large_opener.dart';
import 'small_opener.dart';

import '../../providers/screen_provider.dart';
import '../../enums/device_type.dart';
import 'opener_constraints.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    Screen screen = ref.watch(screenProvider);
    DeviceType deviceType = screen.deviceType;

    if (deviceType < DeviceType.largeTablet) {
      return SmallOpenerPage(
        size: screen.getScreenSize(),
        deviceType: deviceType,
      );
    }

    // return LargeOpenerPage(
    //   size: screen.getScreenSize(),
    //   deviceType: deviceType,
    // );

    return Scaffold(
      backgroundColor: const Color(0xFFf2f2f2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screen.height,
              width: screen.width,
              child: CarouselWidget(
                size: screen.getScreenSize(),
              ),
            ),
            SizedBox(
              child: IntroDetailed(
                size: screen.getScreenSize(),
                deviceType: deviceType,
              ),
            ),
            SizedBox(
              height: screen.height,
              width: screen.width,
              child: WorkBrief(
                size: screen.getScreenSize(),
                deviceType: deviceType,
              ),
            ),
            SizedBox(
              height: screen.height,
              width: screen.width,
            ),
            SizedBox(
              height: screen.height,
              width: screen.width,
              child: IntroBrief(
                size: screen.getScreenSize(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselWidget extends StatefulWidget {
  final Size size;
  const CarouselWidget({
    super.key,
    required this.size,
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget>
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double radius = (widget.size.width > widget.size.height)
        ? 0.4 * widget.size.width
        : 0.4 * widget.size.height;

    return AnimatedBuilder(
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
    );
  }
}

class IntroBrief extends StatefulWidget {
  final Size size;

  const IntroBrief({super.key, required this.size});

  @override
  State<IntroBrief> createState() => _IntroBriefState();
}

class _IntroBriefState extends State<IntroBrief>
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

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: widget.size,
        painter: PathPainter(_animation),
      ),
    );
  }
}

class WorkBrief extends StatefulWidget {
  final Size size;
  final DeviceType deviceType;

  const WorkBrief({super.key, required this.size, required this.deviceType});

  @override
  State<WorkBrief> createState() => _WorkPaintState();
}

class _WorkPaintState extends State<WorkBrief>
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double radius = 0.4 * widget.size.width;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              // top: 0.075 * widget.size.height,
              right: -radius,
              child: Transform.rotate(
                angle: _controller.value * 2.0 * pi,
                child: CustomPaint(
                  painter: SemiCirclePainter(),
                  child: SizedBox(
                    width: radius * 2,
                    height: radius * 2,
                  ),
                ),
              ),
            ),
            LargeOpenerPage(
              size: widget.size,
              deviceType: widget.deviceType,
            )
          ],
        );
      },
    );
  }
}

class CarouselPainter extends CustomPainter {
  final double angle;
  final double radius;
  final Paint sectorPaint = Paint()
    ..color = const Color(0xFF0d0d0d).withOpacity(0.2)
    ..style = PaintingStyle.fill;

  final Paint borderPaint = Paint()
    ..color = const Color(0xFF0d0d0d)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  final Paint smallBorderPaint = Paint()
    ..color = Colors.black87
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  CarouselPainter({required this.angle, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final double startAngle = angle * (pi / 180);
    const double sweepAngle = 60 * (pi / 180);
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawCircle(center, 0.25 * radius, smallBorderPaint);

    for (int i = 0; i < 3; i++) {
      final double sectorStartAngle = startAngle + i * 2 * sweepAngle;
      canvas.drawArc(
          rect, 2 * sectorStartAngle, 0.35 * sweepAngle, true, sectorPaint);
      canvas.drawArc(rect, sectorStartAngle, sweepAngle, true, sectorPaint);
      canvas.drawArc(rect, sectorStartAngle, sweepAngle, true, borderPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class SemiCirclePainter extends CustomPainter {
  final Paint painter = Paint()
    ..color = const Color(0xFF0d0d0d)
    ..strokeWidth = 4
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    double circumference = 2 * pi * radius;
    double dashWidth = 30.0;
    double dashSpace = 20.0;
    double dashCount = circumference / (dashWidth + dashSpace);

    Path path = Path();
    for (int i = 0; i < dashCount; i++) {
      double startAngle = (i * (dashWidth + dashSpace)) / radius;
      double endAngle = startAngle + (dashWidth / radius);
      path.addArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        endAngle - startAngle,
      );
    }
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PathPainter extends CustomPainter {
  final Animation<double> animation;

  PathPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = const Color(0xFF0d0d0d).withOpacity(0.5);

    Path path = Path();

    path.moveTo(0, 0.65 * size.height);
    path.lineTo(0.1 * size.width, 0.65 * size.height);
    path.lineTo(0.1 * size.width, 0.7 * size.height);

    path.lineTo(0.35 * size.width, 0.7 * size.height);
    path.lineTo(0.35 * size.width, 0.65 * size.height);
    path.lineTo(0.375 * size.width, 0.65 * size.height);

    path.arcTo(
      Rect.fromCenter(
        center: Offset(size.width / 2, 0.65 * size.height),
        height: 0.20 * size.width,
        width: 0.25 * size.width,
      ),
      pi,
      pi,
      false,
    );

    path.lineTo(0.65 * size.width, 0.65 * size.height);
    path.lineTo(0.65 * size.width, 0.7 * size.height);

    path.lineTo(0.9 * size.width, 0.7 * size.height);
    path.lineTo(0.9 * size.width, 0.65 * size.height);
    path.lineTo(size.width, 0.65 * size.height);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    final PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      final Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * animation.value,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

class IntroDetailed extends StatefulWidget {
  final DeviceType deviceType;
  final Size size;
  const IntroDetailed({
    super.key,
    required this.deviceType,
    required this.size,
  });

  @override
  State<IntroDetailed> createState() => _IntroDetailedState();
}

class _IntroDetailedState extends State<IntroDetailed>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 0.045),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  ));

  @override
  void initState() {
    super.initState();
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 0.45 * widget.size.width,
          height: 1.2 * widget.size.height,
          padding: EdgeInsets.symmetric(
            horizontal: 0.05 * widget.size.width,
            vertical: 0.1 * widget.size.height,
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
                      angle: -pi / 9,
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
          width: 0.55 * widget.size.width,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(
            horizontal: 0.05 * widget.size.width,
            vertical: 0.05 * widget.size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Transform.rotate(
                    angle: -pi / 9,
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
                      // style: TextStyle(fontFamily: "Ubuntu"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 0.55 * widget.size.width,
                height: 1.1 * widget.size.height,
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
    );
  }
}

class WhoBlogBrief extends StatefulWidget {
  const WhoBlogBrief({super.key});

  @override
  State<WhoBlogBrief> createState() => _WhoBlogBriefState();
}

class _WhoBlogBriefState extends State<WhoBlogBrief> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
