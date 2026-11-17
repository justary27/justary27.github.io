import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../../../components/app_link.dart';
import '../../../constants/contact.dart';
import '../../../enums/layout.dart';
import '../../../themes/colors.dart';
import '../../../themes/dimens.dart';
import '../../../themes/motion.dart';
import '../../../themes/route_ink.dart';
import '../../../themes/typography.dart';

const String _p = "<placeholder>";
const double _rowHeight = 210;
const double _gap = 16;
const double _tabletRowHeight = 236;
const double _tabletSketchHeight = 252;

class _Face {
  final String label;
  final String body;
  final String foot;
  // Overrides the tile's link while this face shows (Find me's handles).
  final String? url;
  // Find me's faces show the platform's icon, in the tile's Who ink.
  final FaIconData? icon;

  const _Face(
    this.label, {
    this.body = _p,
    this.foot = _p,
    this.url,
    this.icon,
  });
}

class _TileSpec {
  final String name;
  final String url;
  final Color background;
  final Color foreground;
  // Ruled paper for the reading tile.
  final bool paper;
  final List<_Face> faces;

  const _TileSpec({
    required this.name,
    required this.url,
    required this.background,
    required this.foreground,
    required this.faces,
    this.paper = false,
  });
}

// Labels and links from the Who prototype; what goes on each face is his,
// so it stays <placeholder> until the build-time pulls or his copy land.
const List<_TileSpec> _tiles = [
  _TileSpec(
    name: "Games and streams",
    url: ContactHandler.youtube,
    background: Color(0xFF0E2B85),
    foreground: Color(0xFFF5F0FA),
    faces: [
      _Face("Currently playing"),
      _Face("Latest stream"),
      _Face("On stream"),
    ],
  ),
  _TileSpec(
    name: "Music",
    url: ContactHandler.youtubeMusic,
    background: Color(0xFFB8C6FF),
    foreground: Color(0xFF0E2B85),
    faces: [_Face("On repeat"), _Face("This month")],
  ),
  _TileSpec(
    name: "What I'm reading",
    url: "https://arxiv.org/",
    background: AppColors.paper,
    foreground: Color(0xFF0E2B85),
    paper: true,
    faces: [_Face("On the reading shelf"), _Face("Highlighted")],
  ),
  _TileSpec(
    name: "Find me",
    url: ContactHandler.github,
    background: Colors.white,
    foreground: Color(0xFF0E2B85),
    faces: [
      // Board order: GitHub, Instagram, YouTube, X.
      _Face(
        "Find me",
        body: "github / justary27",
        foot: "",
        url: ContactHandler.github,
        icon: FontAwesomeIcons.github,
      ),
      _Face(
        "Find me",
        body: "instagram / justary27",
        foot: "",
        url: ContactHandler.instagram,
        icon: FontAwesomeIcons.instagram,
      ),
      _Face(
        "Find me",
        body: "youtube / justary27",
        foot: "",
        url: ContactHandler.youtube,
        icon: FontAwesomeIcons.youtube,
      ),
      _Face(
        "Find me",
        body: "x / JustAry27",
        foot: "",
        url: ContactHandler.x,
        icon: FontAwesomeIcons.xTwitter,
      ),
    ],
  ),
  _TileSpec(
    name: "Places and plates",
    url: ContactHandler.instagram,
    background: Colors.white,
    foreground: Color(0xFF0E2B85),
    faces: [_Face("Places & plates"), _Face("Places & plates")],
  ),
  _TileSpec(
    name: "Sketchbook",
    url: ContactHandler.instagram,
    background: Colors.white,
    foreground: Color(0xFF0E2B85),
    faces: [_Face("Sketchbook"), _Face("Sketchbook")],
  ),
];

// The "Off the clock" bento. One tile flips per cadence tick, taking turns;
// a hovered tile is skipped so its link never changes under the cursor.
class OffTheClock extends StatefulWidget {
  const OffTheClock({super.key});

  @override
  State<OffTheClock> createState() => _OffTheClockState();
}

class _OffTheClockState extends State<OffTheClock> {
  final List<int> _faces = List.filled(_tiles.length, 0);
  final Set<int> _held = {};
  int _turn = 0;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer?.cancel();
    _timer = MediaQuery.disableAnimationsOf(context)
        ? null
        : Timer.periodic(Motion.cadence, (_) => _tick());
  }

  void _tick() {
    for (int a = 0; a < _tiles.length; a++) {
      final i = (_turn + a) % _tiles.length;
      if (_held.contains(i)) continue;
      _turn = (i + 1) % _tiles.length;
      setState(() => _faces[i] = (_faces[i] + 1) % _tiles[i].faces.length);
      return;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _tile(int i) => _Tile(
    spec: _tiles[i],
    face: _faces[i],
    onHold: (held) => held ? _held.add(i) : _held.remove(i),
  );

  @override
  Widget build(BuildContext context) {
    final ink = RouteInk.who.ink;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 18,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          spacing: 14,
          children: [
            Text(
              "AFTER HOURS",
              style: AppText.meta.copyWith(letterSpacing: 1.92, color: ink),
            ),
            Text(
              "Off the clock",
              style: AppText.handLarge.copyWith(height: 1, color: ink),
            ),
          ],
        ),
        // Tablet: two columns; games spans two rows, the sketchbook the
        // last full row.
        // Phone: one column; games tallest, the sketchbook a little taller.
        if (Layout.of(MediaQuery.sizeOf(context)).isPhone)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              for (int i = 0; i < 6; i++)
                SizedBox(
                  height: i == 0 ? 330 : (i == 5 ? 250 : 210),
                  child: _tile(i),
                ),
            ],
          )
        else if (Layout.of(MediaQuery.sizeOf(context)).isCompact)
          Column(
            spacing: _gap,
            children: [
              SizedBox(
                height: 2 * _tabletRowHeight + _gap,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: _gap,
                  children: [
                    Expanded(child: _tile(0)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: _gap,
                        children: [
                          Expanded(child: _tile(1)),
                          Expanded(child: _tile(2)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _tabletRowHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: _gap,
                  children: [
                    Expanded(child: _tile(3)),
                    Expanded(child: _tile(4)),
                  ],
                ),
              ),
              SizedBox(
                height: _tabletSketchHeight,
                width: double.infinity,
                child: _tile(5),
              ),
            ],
          )
        else
          // Board grid: 1.3fr 1fr 1fr 1fr over two 210 px rows; games spans
          // both rows and the sketchbook spans two columns.
          LayoutBuilder(
            builder: (context, constraints) {
              final unit = (constraints.maxWidth - 3 * _gap) / 4.3;
              final wide = 1.3 * unit;
              return SizedBox(
                height: 2 * _rowHeight + _gap,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: _gap,
                  children: [
                    SizedBox(width: wide, child: _tile(0)),
                    Expanded(
                      child: Column(
                        spacing: _gap,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: _gap,
                              children: [
                                Expanded(child: _tile(1)),
                                Expanded(child: _tile(2)),
                                Expanded(child: _tile(3)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: _gap,
                              children: [
                                Expanded(child: _tile(4)),
                                Expanded(flex: 2, child: _tile(5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

class _Tile extends StatefulWidget {
  final _TileSpec spec;
  final int face;
  final ValueChanged<bool> onHold;

  const _Tile({required this.spec, required this.face, required this.onHold});

  @override
  State<_Tile> createState() => _TileState();
}

class _TileState extends State<_Tile> {
  bool _hovered = false;
  bool _focused = false;

  void _hold({bool? hovered, bool? focused}) {
    setState(() {
      _hovered = hovered ?? _hovered;
      _focused = focused ?? _focused;
    });
    widget.onHold(_hovered || _focused);
  }

  @override
  Widget build(BuildContext context) {
    final spec = widget.spec;
    final face = widget.face;
    final current = spec.faces[face];
    final held = _hovered || _focused;
    return MouseRegion(
      onEnter: (_) => _hold(hovered: true),
      onExit: (_) => _hold(hovered: false),
      child: Focus(
        canRequestFocus: false,
        onFocusChange: (f) => _hold(focused: f),
        child: AppLink(
          to: current.url ?? spec.url,
          label: spec.name,
          fadeOnHover: false,
          builder: (context, _) => Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: spec.background,
              borderRadius: BorderRadius.circular(Radii.card),
              boxShadow: spec.paper
                  ? const [
                      BoxShadow(
                        color: Color(0x1F0E2B85),
                        offset: Offset(0, 1),
                        blurRadius: 3,
                      ),
                    ]
                  : null,
            ),
            child: CustomPaint(
              painter: spec.paper ? const _RuledPainter() : null,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedSwitcher(
                    duration: Motion.tileFlip,
                    switchInCurve: MotionCurves.standard,
                    switchOutCurve: MotionCurves.standard,
                    // Faces fill the tile instead of centring.
                    layoutBuilder: (current, previous) => Stack(
                      fit: StackFit.expand,
                      children: [...previous, ?current],
                    ),
                    // The old face leaves upward as the new one rises from
                    // below, as on the board.
                    transitionBuilder: (child, animation) {
                      final incoming = child.key == ValueKey(face);
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween(
                            begin: Offset(0, incoming ? 1 : -1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _FaceView(
                      key: ValueKey(face),
                      face: current,
                      color: spec.foreground,
                    ),
                  ),
                  // Which face is showing; makes way for the pause badge.
                  Positioned(
                    right: 16,
                    bottom: 14,
                    child: AnimatedOpacity(
                      duration: Motion.quick,
                      opacity: held ? 0 : 1,
                      child: Row(
                        spacing: 5,
                        children: [
                          for (int i = 0; i < spec.faces.length; i++)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: spec.foreground.withValues(
                                  alpha: i == face ? .9 : .3,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  // A held tile doesn't flip; the badge says so.
                  Positioned(
                    right: 12,
                    bottom: 7,
                    child: ExcludeSemantics(
                      child: AnimatedOpacity(
                        duration: Motion.quick,
                        opacity: held ? .75 : 0,
                        child: AnimatedScale(
                          duration: Motion.quick,
                          scale: held ? 1 : .8,
                          child: _PauseBadge(color: spec.foreground),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PauseBadge extends StatelessWidget {
  final Color color;

  const _PauseBadge({required this.color});

  @override
  Widget build(BuildContext context) {
    Widget bar() => Container(
      width: 3.5,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(1.2),
      ),
    );
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: .22),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 3,
        children: [bar(), bar()],
      ),
    );
  }
}

class _FaceView extends StatelessWidget {
  final _Face face;
  final Color color;

  const _FaceView({super.key, required this.face, required this.color});

  @override
  Widget build(BuildContext context) {
    final icon = face.icon;
    if (icon != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 22,
          horizontal: Space.s24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              face.label.toUpperCase(),
              style: AppText.label.copyWith(
                fontSize: 12,
                letterSpacing: 1.92,
                color: color,
              ),
            ),
            FaIcon(icon, size: 44, color: color),
            Text(
              "${face.body} ↗",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.label.copyWith(fontSize: 17, color: color),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: Space.s24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            face.label.toUpperCase(),
            style: AppText.label.copyWith(
              fontSize: 12,
              letterSpacing: 1.92,
              color: color,
            ),
          ),
          const Spacer(),
          Text(
            face.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppText.h3.copyWith(color: color),
          ),
          if (face.foot.isNotEmpty)
            Text(
              face.foot,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.body.copyWith(fontSize: 13, color: color),
            ),
        ],
      ),
    );
  }
}

class _RuledPainter extends CustomPainter {
  const _RuledPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x140E2B85);
    for (double y = 31; y < size.height; y += 32) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 1), paint);
    }
  }

  @override
  bool shouldRepaint(_RuledPainter oldDelegate) => false;
}
