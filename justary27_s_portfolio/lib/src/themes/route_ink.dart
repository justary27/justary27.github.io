import 'package:material_ui/material_ui.dart';

const LinearGradient _pageGround = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFFF1F5F5), Color(0xFFDAE0E0)],
);

class RouteInk {
  final Color navbar;
  final Color onNavbar;
  final Color ink;
  final LinearGradient hero;
  // Null on Home: Foundations defines no page ground for it.
  final LinearGradient? ground;
  final Color envelopePaper;
  final Color envelopeBody;

  const RouteInk({
    required this.navbar,
    required this.onNavbar,
    required this.ink,
    required this.hero,
    required this.ground,
    required this.envelopePaper,
    required this.envelopeBody,
  });

  static const RouteInk home = RouteInk(
    navbar: Color(0xFFF2F2F2),
    onNavbar: Color(0xFF0D0D0D),
    ink: Color(0xFF0D0D0D),
    hero: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFFFFFFF), Color(0xFFF2F2F2), Color(0xFFE2E6E6)],
    ),
    ground: null,
    envelopePaper: Color(0xFFFBF8F1),
    envelopeBody: Color(0xFFE9E2D2),
  );

  static const RouteInk work = RouteInk(
    navbar: Color(0xFF82F6B0),
    onNavbar: Color(0xFF0B5E50),
    ink: Color(0xFF0B5E50),
    hero: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xFF82F6B0), Color(0xFF5BFA9A)],
    ),
    ground: _pageGround,
    envelopePaper: Color(0xFFF1FBF5),
    envelopeBody: Color(0xFFD3ECDF),
  );

  static const RouteInk who = RouteInk(
    navbar: Color(0xFFC6C5FF),
    onNavbar: Color(0xFF0E2B85),
    ink: Color(0xFF0E2B85),
    hero: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFC6C5FF), Color(0xFF8582EA)],
    ),
    ground: _pageGround,
    envelopePaper: Color(0xFFF6F5FF),
    envelopeBody: Color(0xFFDCDDF5),
  );

  static const RouteInk blog = RouteInk(
    navbar: Color(0xFFA81D13),
    onNavbar: Color(0xFFFFFFFF),
    ink: Color(0xFFA81D13),
    hero: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFCE2D21), Color(0xFFA81D13)],
    ),
    ground: _pageGround,
    envelopePaper: Color(0xFFFDF3F1),
    envelopeBody: Color(0xFFEED6D2),
  );
}
