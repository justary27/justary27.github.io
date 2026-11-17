import 'package:material_ui/material_ui.dart';

import '../../components/fit.dart';
import '../../components/footer.dart';
import '../../components/navbar.dart';
import '../../components/pill_button.dart';
import '../../constants/contact.dart';
import '../../enums/device_type.dart';
import '../../enums/layout.dart';

import '../../themes/colors.dart';
import '../../themes/dimens.dart';
import '../../themes/route_ink.dart';
import '../../themes/typography.dart';
import 'painters.dart';
import 'widgets/desk.dart';
import 'widgets/say_hi.dart';
import 'widgets/selected_work.dart';

class HomePage extends StatelessWidget {
  final Size size;
  final DeviceType deviceType;
  const HomePage({
    super.key,
    required this.size,
    required this.deviceType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: BoxDecoration(gradient: RouteInk.home.hero),
          child: Column(
            children: [
              IntroWelcome(size: size),
              SelectedWork(size: size),
              SayHi(size: size),
              Desk(size: size),
              Footer(size: size),
            ],
          ),
        ),
      ),
    );
  }
}

class IntroWelcome extends StatefulWidget {
  final Size size;
  const IntroWelcome({super.key, required this.size});

  @override
  State<IntroWelcome> createState() => _IntroWelcomeState();
}

const TextStyle _ringStyle = TextStyle(
  fontFamily: AppFonts.text,
  fontSize: 15,
  fontWeight: FontWeight.w700,
  color: AppColors.ink500,
);
// The old ring's slots, 120° apart; newest first reading left to right.
const List<(String, double)> _milestones = [
  ("Repello AI/Founding Engineer'24", 150),
  ("IIT Roorkee'24", -90),
  ("OWASP Foundation/GSoC'22", 30),
];

class _IntroWelcomeState extends State<IntroWelcome>
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
    double radius =
        (widget.size.width > widget.size.height)
            ? 0.4 * widget.size.width
            : 0.4 * widget.size.height;

    // The navbar overlays the body, so the hero starts under it.
    final height =
        NavBar.height +
        (Layout.of(widget.size).isCompact
            ? Fit.room(context).clamp(Fit.tabletHomeHeroMin, double.infinity)
            : Fit.hero(context));
    final phone = Layout.of(widget.size).isPhone;
    final block = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Aryan Ranjan",
          textAlign: TextAlign.center,
          // Natural line height: Allison's descenders overrun
          // anything tighter and collide with the tagline.
          style: TextStyle(
            fontFamily: AppFonts.signature,
            color: AppColors.ink900,
            fontWeight: FontWeight.bold,
            fontSize: Layout.of(widget.size).isPhone
                ? (0.18 * widget.size.width).clamp(56.0, 84.0)
                : 0.15 * widget.size.width,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.s24,
          ),
          child: Text(
            "Codifyin' reality as a Senior FullStack AI Engineer @8club",
            textAlign: TextAlign.center,
            style: AppText.bodyL.copyWith(
              color: AppColors.ink700,
              height: null,
            ),
          ),
        ),
        const SizedBox(height: Space.s12),
        PillButton(
          label: "Résumé ↓",
          variant: PillVariant.filled,
          color: AppColors.ink900,
          to: ContactHandler.resumeUrl,
        ),
      ],
    );
    return SizedBox(
      height: height,
      width: widget.size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: -radius * 1,
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => CustomPaint(
                  painter: CarouselPainter(
                    angle: _controller.value * 360,
                    radius: radius,
                  ),
                  child: child,
                ),
                child: SizedBox(width: radius * 2, height: radius * 2),
              ),
            ),
          ),
          Positioned(
            bottom: -radius,
            child: RepaintBoundary(
              child: CustomPaint(
                painter: MilestoneRingPainter(
                  labels: _milestones,
                  radius: 1.07625 * radius,
                  turn: _controller,
                  style: _ringStyle,
                ),
                size: Size.square(radius * 2),
              ),
            ),
          ),
          // Phones wrap the tagline, so the block sits above the ring's
          // labels instead of centred over them.
          if (phone)
            Positioned(
              left: 0,
              right: 0,
              bottom: 1.07625 * radius + Space.s40,
              child: block,
            )
          else
            // Shifted by the hub's 10% shrink (0.025 × radius) to keep the gap.
            Transform.translate(
              offset: Offset(0, 0.025 * radius),
              // Short windows crop the block at the bottom, never the top.
              child: OverflowBox(
                alignment: Alignment.topCenter,
                maxHeight: double.infinity,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: height),
                  child: block,
                ),
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
