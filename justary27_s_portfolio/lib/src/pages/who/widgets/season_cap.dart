import 'dart:math';

import 'package:material_ui/material_ui.dart';

import '../../../enums/layout.dart';
import '../../../themes/route_ink.dart';
import '../../../themes/typography.dart';
import 'season_plant.dart';

const double _trailLength = 96;

// The timeline's end: its line carries on as a dotted trail into "still being
// written…", beside the seasons plant.
class SeasonCap extends StatelessWidget {
  final double gutter;
  // Which side the timeline's last year sits on; the trail continues there.
  final bool endsOnLeft;

  const SeasonCap({super.key, required this.gutter, required this.endsOnLeft});

  @override
  Widget build(BuildContext context) {
    final ink = RouteInk.who.ink;
    // Phone: the plant drops under the trail's label, a little smaller.
    final phone = Layout.of(MediaQuery.sizeOf(context)).isPhone;
    return SizedBox(
      height: phone ? 470 : 320,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          // Same x as the timeline's nodes (6% / 94% of the page).
          final x = endsOnLeft ? 0.06 * width : 0.94 * width;
          final label = Text(
            "still being written…",
            softWrap: false,
            style: AppText.handLarge.copyWith(fontSize: 30, color: ink),
          );
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: gutter,
                top: phone ? 150 : 0,
                child: Transform.scale(
                  scale: phone ? 0.8 : 1,
                  alignment: Alignment.topRight,
                  child: const SeasonPlant(),
                ),
              ),
              Positioned(
                left: x - 3,
                top: 0,
                width: 6,
                height: _trailLength,
                child: CustomPaint(painter: _TrailPainter(ink: ink)),
              ),
              // The label hangs off the trail's end, reading toward the centre.
              if (phone)
                Positioned(
                  left: (x - 8).clamp(16.0, max(16.0, width - 236)),
                  top: _trailLength + 8,
                  child: label,
                )
              else if (endsOnLeft)
                Positioned(left: x - 24, top: _trailLength + 8, child: label)
              else
                Positioned(
                  right: width - x - 24,
                  top: _trailLength + 8,
                  child: label,
                ),
            ],
          );
        },
      ),
    );
  }
}

// Round dots in the timeline's stroke: 2 px dashes, 16 px gaps, round caps.
class _TrailPainter extends CustomPainter {
  final Color ink;

  const _TrailPainter({required this.ink});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ink.withValues(alpha: 0.3)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final x = size.width / 2;
    for (double y = 0; y < size.height; y += 18) {
      canvas.drawLine(Offset(x, y), Offset(x, y + 2), paint);
    }
  }

  @override
  bool shouldRepaint(_TrailPainter oldDelegate) => oldDelegate.ink != ink;
}
