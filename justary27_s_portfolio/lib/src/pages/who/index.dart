import 'package:material_ui/material_ui.dart';

import '../../components/fit.dart';
import '../../components/footer.dart';
import '../../components/landing.dart';
import '../../components/navbar.dart';
import '../../themes/dimens.dart';
import '../../themes/route_ink.dart';
import '../../themes/typography.dart';
import 'timeline_data.dart';
import 'widgets/off_the_clock.dart';
import 'widgets/season_cap.dart';
import 'widgets/who_timeline.dart';

const double _contentWidth = 1152;

// Hero → one line about him → Off the clock → the timeline → its end cap.
class WhoPage extends StatefulWidget {
  final Size size;

  const WhoPage({super.key, required this.size});

  @override
  State<WhoPage> createState() => _WhoPageState();
}

class _WhoPageState extends State<WhoPage> {
  final ScrollController _scroll = ScrollController();
  final GlobalKey _offTheClock = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && Landing.of(context) == Landing.who) {
        Landing.glide(context, _scroll, _offTheClock);
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final ink = RouteInk.who;
    final double gutter = (0.04 * size.width).clamp(16, double.infinity);
    return SingleChildScrollView(
      controller: _scroll,
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: ink.ground),
        child: Column(
          children: [
            // The navbar overlays the body, so the hero starts under it.
            RouteHero(
              title: "Who?",
              gradient: ink.hero,
              color: ink.ink,
              width: size.width,
              inset: NavBar.height,
            ),
            Padding(
              key: _offTheClock,
              padding: EdgeInsets.fromLTRB(gutter, 56, gutter, 80),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _contentWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 18,
                    children: [
                      // One line about him as a person, in his words.
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 760),
                        child: Text(
                          "<placeholder>",
                          style: AppText.h3.copyWith(
                            fontSize: (0.024 * size.width).clamp(22, 30),
                            fontWeight: FontWeight.w700,
                            height: 1.35,
                          ),
                        ),
                      ),
                      const SizedBox(height: Space.s4),
                      const OffTheClock(),
                    ],
                  ),
                ),
              ),
            ),
            WhoTimeline(
              years: WhoTimelineData.years,
              viewportHeight: size.height,
            ),
            SeasonCap(
              gutter: gutter,
              // Year nodes alternate from the left, so an odd count ends there.
              endsOnLeft: WhoTimelineData.years.length.isOdd,
            ),
            Footer(size: size),
          ],
        ),
      ),
    );
  }
}
