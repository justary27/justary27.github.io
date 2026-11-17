import 'dart:math';

import 'package:material_ui/material_ui.dart';

import '../../../components/fit.dart';
import '../../../components/pill_button.dart';
import '../../../components/pinned_steps.dart';
import '../../../constants/route.dart';
import '../../../enums/layout.dart';
import '../../../models/outcome.dart';
import '../../../themes/colors.dart';
import '../../../themes/dimens.dart';
import '../../../themes/motion.dart';
import '../../../themes/typography.dart';
import '../data.dart';

// Stop spacing and width: laptop, then the tablet board's narrower track.
({double gap, double width, int before, double step}) _track(Layout layout) =>
    switch (layout) {
      // One stop per screen: the track moves a full stop every step.
      Layout.phone => (gap: 300, width: 270, before: 0, step: 300),
      Layout.tablet => (gap: 240, width: 216, before: 1, step: 240),
      Layout.large => (
        gap: 300,
        width: 260,
        before: _stopsBeforeScroll,
        step: _trackStepWidth,
      ),
    };
const double _trackHeight = 300;
// The first three stops fit, so the track only moves from the fourth on.
const int _stopsBeforeScroll = 2;
const double _trackStepWidth = 154;

class SelectedWork extends StatelessWidget {
  final Size size;

  const SelectedWork({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final sidePadding = max(Space.s16, 0.04 * size.width);

    return PinnedSteps(
      stepCount: SelectedWorkData.outcomes.length,
      pinnedHeight: Fit.room(context).clamp(520, 760),
      scrollHeight: 2800,
      builder: (context, step) {
        return SizedBox(
          width: size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sidePadding),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1152),
                child: _OutcomePath(step: step),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OutcomePath extends StatelessWidget {
  final int step;

  const _OutcomePath({required this.step});

  @override
  Widget build(BuildContext context) {
    final outcomes = SelectedWorkData.outcomes;
    final layout = Layout.of(MediaQuery.sizeOf(context));
    final track = _track(layout);
    final trackX = -max(0, step - track.before) * track.step;
    final moveDuration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : Motion.step;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "Selected work",
                  // The boards' section heading: clamp(28, 4vw, 40).
                  style: AppText.h2.copyWith(
                    fontSize: (0.04 * MediaQuery.sizeOf(context).width).clamp(
                      28.0,
                      40.0,
                    ),
                  ),
                ),
                Text(
                  "${step + 1} / ${outcomes.length}",
                  style: AppText.meta.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.82,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            ClipRect(
              clipper: const _BleedLeftClipper(),
              child: SizedBox(
                height: _trackHeight,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(end: trackX),
                  duration: moveDuration,
                  curve: MotionCurves.standard,
                  builder: (context, x, child) {
                    return Transform.translate(
                      offset: Offset(x, 0),
                      child: child,
                    );
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: -200,
                        top: 0,
                        child: RepaintBoundary(
                          child: CustomPaint(
                            size: const Size(1800, 120),
                            painter: _PathPainter(
                              step: step,
                              stopCount: outcomes.length,
                              stopGap: track.gap,
                            ),
                          ),
                        ),
                      ),
                      for (final (index, outcome) in outcomes.indexed)
                        Positioned(
                          left: index * track.gap,
                          top: 84,
                          width: track.width,
                          child: AnimatedOpacity(
                            opacity: index >= step ? 1 : 0.35,
                            duration: moveDuration,
                            child: _Stop(outcome: outcome),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: Space.s24),
            Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.deskLine)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    layout.isPhone
                        ? "Swipe to step through"
                        : layout.isTablet
                        ? "Swipe or scroll to step through"
                        : "Scroll to step through",
                    style: AppText.body.copyWith(
                      fontSize: 15,
                      color: AppColors.ink500,
                    ),
                  ),
                  const PillButton(
                    label: "All work →",
                    variant: PillVariant.filled,
                    color: AppColors.ink900,
                    to: RouteHandler.workPage,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _ReturnLinePainter()),
          ),
        ),
      ],
    );
  }
}

class _Stop extends StatelessWidget {
  final Outcome outcome;

  const _Stop({required this.outcome});

  @override
  Widget build(BuildContext context) {
    final stackStyle = AppText.meta.copyWith(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.82,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Scales rather than wraps, so every number keeps one baseline.
        SizedBox(
          height: 48,
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              outcome.number,
              style: AppText.stat.copyWith(fontSize: 48, letterSpacing: -0.96),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(outcome.project, style: AppText.label.copyWith(fontSize: 15)),
        const SizedBox(height: 6),
        Text(outcome.line, style: AppText.body.copyWith(height: 1.5)),
        const SizedBox(height: 6),
        Text(outcome.stack, style: stackStyle),
      ],
    );
  }
}

class _BleedLeftClipper extends CustomClipper<Rect> {
  const _BleedLeftClipper();

  @override
  Rect getClip(Size size) =>
      Rect.fromLTRB(-10000, -60, size.width, size.height + 60);

  @override
  bool shouldReclip(_BleedLeftClipper oldClipper) => false;
}

class _PathPainter extends CustomPainter {
  final int step;
  final int stopCount;

  final double stopGap;

  _PathPainter({
    required this.step,
    required this.stopCount,
    required this.stopGap,
  });

  static final Path _route = Path()
    ..moveTo(0, 40)
    ..cubicTo(100, 40, 140, 60, 200, 60)
    ..cubicTo(260, 60, 360, 30, 500, 60)
    ..cubicTo(640, 90, 700, 30, 800, 60)
    ..cubicTo(900, 90, 1000, 30, 1100, 60)
    ..cubicTo(1200, 90, 1300, 30, 1400, 60)
    ..cubicTo(1500, 90, 1600, 40, 1800, 50);

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = AppColors.ink900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (final metric in _route.computeMetrics()) {
      for (double d = 0; d < metric.length; d += 16) {
        canvas.drawPath(metric.extractPath(d, d + 8), line);
      }
    }

    final ring = Paint()
      ..color = AppColors.ink900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    for (var i = 0; i < stopCount; i++) {
      final center = Offset(200 + i * stopGap, 60);
      canvas.drawCircle(
        center,
        11,
        Paint()..color = i <= step ? AppColors.ink900 : AppColors.surface,
      );
      canvas.drawCircle(center, 11, ring);
    }
  }

  @override
  bool shouldRepaint(_PathPainter oldDelegate) =>
      oldDelegate.step != step || oldDelegate.stopGap != stopGap;
}

class _ReturnLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width, 0);
    final curve = Path()
      ..moveTo(0, 158)
      ..cubicTo(34, 160, 44, 200, 32, 248)
      ..cubicTo(20, 296, 40, 370, -44, 434);
    final dash = Paint()
      ..color = AppColors.ink900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (final metric in curve.computeMetrics()) {
      for (double d = 0; d < metric.length; d += 16) {
        canvas.drawPath(metric.extractPath(d, d + 8), dash);
      }
    }
    canvas.drawPath(
      Path()
        ..moveTo(-36, 424)
        ..lineTo(-46, 435)
        ..lineTo(-32, 441),
      Paint()
        ..color = AppColors.ink900
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_ReturnLinePainter oldDelegate) => false;
}
