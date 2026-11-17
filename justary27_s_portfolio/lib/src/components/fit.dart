import 'package:material_ui/material_ui.dart';

import '../enums/layout.dart';
import '../themes/typography.dart';
import 'navbar.dart';

// Foundations · Fit: one unit, one screen. Units size from the viewport left
// under the navbar (and a docked section bar), floored so short screens crop
// at the bottom instead of shrinking text.
abstract final class Fit {
  static const double sectionBar = 64;
  static const double heroMin = 560;
  // Home's tablet hero keeps room for the name over the ring.
  static const double tabletHomeHeroMin = 640;
  static const double heroMax = 900;

  static double room(BuildContext context, {bool docked = false}) =>
      MediaQuery.sizeOf(context).height -
      NavBar.height -
      (docked ? sectionBar : 0);

  // Portrait tablets are taller than the 900 cap allows for, so their hero
  // fills the room under the navbar.
  static double hero(BuildContext context) => room(context).clamp(
    heroMin,
    Layout.of(MediaQuery.sizeOf(context)).isCompact ? double.infinity : heroMax,
  );
}

// The route title hero: full height under the navbar, title centred a touch
// high (the board's translateY(-58%)).
class RouteHero extends StatelessWidget {
  final String title;
  final Gradient gradient;
  final Color color;
  final double width;
  // Space above the hero that it paints behind, e.g. the navbar.
  final double inset;

  const RouteHero({
    super.key,
    required this.title,
    required this.gradient,
    required this.color,
    required this.width,
    this.inset = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: inset + Fit.hero(context),
      width: double.infinity,
      decoration: BoxDecoration(gradient: gradient),
      padding: EdgeInsets.only(top: inset),
      alignment: Alignment.center,
      child: FractionalTranslation(
        translation: const Offset(0, -0.08),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppText.route.copyWith(
            color: color,
            // Phones scale the title with the width, down to 104.
            fontSize: Layout.of(MediaQuery.sizeOf(context)).isPhone
                ? (0.34 * width).clamp(104.0, AppText.routeMaxSize)
                : (0.22 * width).clamp(
                    AppText.routeMinSize,
                    AppText.routeMaxSize,
                  ),
          ),
        ),
      ),
    );
  }
}
