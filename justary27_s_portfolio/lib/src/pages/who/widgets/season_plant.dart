import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:material_ui/material_ui.dart';

import '../../../themes/route_ink.dart';
import '../../../themes/typography.dart';

// A port of the Who prototype's seasons plant (esMount): line-art plants in
// the Who indigo, drawn on a 380 × 300 board, one per season. Strokes ink in,
// flowers pop, and ambient loops (sway, breathe, shimmer, falling petals)
// keep it alive. Same seeded generator as the board, so shapes match.

const Size _board = Size(380, 300);
const Color _ink = Color(0xFF0E2B85);
const Duration _drawTime = Duration(milliseconds: 900);
const Duration _popTime = Duration(milliseconds: 420);
const Curve _drawCurve = Cubic(.3, .7, .3, 1);
const Curve _popCurve = Cubic(.3, 1.6, .5, 1);

class _Season {
  final String caption;
  final void Function(_Scene scene) draw;

  const _Season(this.caption, this.draw);
}

final List<_Season> _seasons = [
  _Season("Bengaluru, every March", _bengaluru),
  _Season("Jaisalmer, every May", _jaisalmer),
  _Season("Kolkata, every October", _kolkata),
  _Season("Srinagar, every January", _srinagar),
];

// ---------------------------------------------------------------------------
// Scene graph
// ---------------------------------------------------------------------------

enum _Ambient { none, sway, breathe }

class _Fall {
  final double dx, dy, turn, seconds, delay;

  const _Fall(this.dx, this.dy, this.turn, this.seconds, this.delay);
}

abstract class _Node {
  Rect get bounds;
}

class _Group extends _Node {
  final Offset translate;
  final double rotate; // degrees
  final _Ambient ambient;
  // Pop-in: scale 0 → 1 around the content's centre after a delay.
  final int? popDelay;
  // Heat shimmer: drifts 6 px and brightens, from a delay in seconds.
  final double? shimmerDelay;
  final _Fall? fall;
  final List<_Node> children = [];

  _Group({
    this.translate = Offset.zero,
    this.rotate = 0,
    this.ambient = _Ambient.none,
    this.popDelay,
    this.shimmerDelay,
    this.fall,
  });

  @override
  Rect get bounds {
    Rect? r;
    for (final c in children) {
      final b = c.bounds;
      r = r == null ? b : r.expandToInclude(b);
    }
    return (r ?? Rect.zero).shift(translate);
  }
}

class _Shape extends _Node {
  final Path path;
  final Color? fill;
  final Color? stroke;
  final double width;
  // Inks the stroke in from its start after a delay.
  final int? drawDelay;

  _Shape(this.path, {this.fill, this.stroke, this.width = 1, this.drawDelay});

  @override
  Rect get bounds => path.getBounds();
}

class _Scene {
  final _Group root = _Group();
  int seed = 1;

  double r() {
    seed = (seed * 16807) % 2147483647;
    return seed / 2147483647;
  }

  _Group group(
    _Group parent, {
    Offset translate = Offset.zero,
    double rotate = 0,
    _Ambient ambient = _Ambient.none,
    int? pop,
    double? shimmer,
    _Fall? fall,
  }) {
    final g = _Group(
      translate: translate,
      rotate: rotate,
      ambient: ambient,
      popDelay: pop,
      shimmerDelay: shimmer,
      fall: fall,
    );
    parent.children.add(g);
    return g;
  }

  void shape(
    _Group parent,
    Path path, {
    Color? fill,
    Color? stroke,
    double width = 1,
    int? draw,
  }) => parent.children.add(
    _Shape(path, fill: fill, stroke: stroke, width: width, drawDelay: draw),
  );

  static Path ellipse(double cx, double cy, double rx, double ry) => Path()
    ..addOval(
      Rect.fromCenter(center: Offset(cx, cy), width: 2 * rx, height: 2 * ry),
    );

  static Path circle(double cx, double cy, double radius) =>
      ellipse(cx, cy, radius, radius);

  static Path rotated(Path p, double degrees) =>
      p.transform((Matrix4.identity()..rotateZ(degrees * pi / 180)).storage);

  // ---- board helpers (grow, tree, fl, faller, ground, chinar) -------------

  void _grow(
    double x,
    double y,
    double a,
    double len,
    double w,
    int d,
    List<Offset> tips,
    List<_Seg> segs,
    double spread,
  ) {
    final x2 = x + cos(a) * len, y2 = y - sin(a) * len;
    final mx = (x + x2) / 2 + (r() - .5) * len * .3;
    final my = (y + y2) / 2 + (r() - .5) * len * .2;
    segs.add(_Seg(x, y, x2, y2, mx, my, w, d));
    if (d == 0) {
      tips.add(Offset(x2, y2));
      return;
    }
    final n = d > 3 ? 2 : 2 + (r() < .45 ? 1 : 0);
    for (int i = 0; i < n; i++) {
      final angle =
          a + (i - (n - 1) / 2) * spread * (1 + r() * .5) + (r() - .5) * .25;
      final next = len * (.68 + r() * .12);
      _grow(x2, y2, angle, next, w * .64, d - 1, tips, segs, spread);
    }
  }

  List<Offset> tree(
    _Group g,
    double x,
    double y,
    double len,
    double w,
    int d,
    double spread,
    int s0,
  ) {
    seed = s0;
    final tips = <Offset>[];
    final segs = <_Seg>[];
    _grow(x, y, pi / 2 + .04, len, w, d, tips, segs, spread);
    // Trunk first, then each fork level 170 ms later.
    // Deepest first; ties keep growth order, as the board's stable sort does.
    final ordered = [for (int i = 0; i < segs.length; i++) (i, segs[i])]
      ..sort((a, b) {
        final byDepth = b.$2.d.compareTo(a.$2.d);
        return byDepth != 0 ? byDepth : a.$1.compareTo(b.$1);
      });
    for (final (_, q) in ordered) {
      shape(
        g,
        Path()
          ..moveTo(q.x, q.y)
          ..quadraticBezierTo(q.mx, q.my, q.x2, q.y2),
        stroke: _ink,
        width: max(1.1, q.w),
        draw: (d - q.d) * 170,
      );
    }
    return tips;
  }

  void flower(
    _Group g,
    double x,
    double y,
    double rad,
    Color col,
    Color core,
    int n,
    int delay,
  ) {
    final h = group(group(g, translate: Offset(x, y)), pop: delay);
    for (int i = 0; i < n; i++) {
      shape(
        h,
        rotated(ellipse(0, -rad * .55, rad * .42, rad * .6), i * 360 / n),
        fill: col,
        stroke: _ink,
        width: .8,
      );
    }
    shape(h, circle(0, 0, rad * .24), fill: core);
  }

  void faller(
    _Group g,
    void Function(_Group f) make,
    int n,
    double x0,
    double x1,
    double y0,
    double y1,
    double dy,
    double dur,
  ) {
    for (int i = 0; i < n; i++) {
      final at = Offset(x0 + r() * (x1 - x0), y0 + r() * (y1 - y0));
      final w = group(g, translate: at);
      final fall = _Fall(
        -30 - r() * 50,
        dy + r() * 40,
        (r() - .5) * 500,
        dur + r() * dur * .7,
        -r() * dur * 2,
      );
      make(group(w, fall: fall));
    }
  }

  void ground(_Group g, double x0, double x1) => shape(
    g,
    Path()
      ..moveTo(x0, 252)
      ..lineTo(x1, 252),
    stroke: _ink,
    width: 2,
    draw: 0,
  );

  void chinar(_Group f) {
    const pts = [
      [0, -7],
      [2, -3],
      [6, -4.5],
      [4.5, -.5],
      [7.5, 1.5],
      [3.5, 2.5],
      [4, 6.5],
      [0, 4],
      [-4, 6.5],
      [-3.5, 2.5],
      [-7.5, 1.5],
      [-4.5, -.5],
      [-6, -4.5],
      [-2, -3],
    ];
    final p = Path()..moveTo(0, -7);
    for (final q in pts.skip(1)) {
      p.lineTo(q[0].toDouble(), q[1].toDouble());
    }
    shape(
      f,
      p..close(),
      fill: const Color(0xFFD2463A),
      stroke: _ink,
      width: .7,
    );
  }
}

class _Seg {
  final double x, y, x2, y2, mx, my, w;
  final int d;

  const _Seg(
    this.x,
    this.y,
    this.x2,
    this.y2,
    this.mx,
    this.my,
    this.w,
    this.d,
  );
}

// ---------------------------------------------------------------------------
// The four seasons, as on the board
// ---------------------------------------------------------------------------

void _bengaluru(_Scene s) {
  final g = s.root;
  s.ground(g, 190, 330);
  final t = s.group(g, ambient: _Ambient.sway);
  final tips = s.tree(t, 262, 252, 60, 13, 5, .55, 11);
  for (int i = 0; i < tips.length; i++) {
    for (int k = 0; k < 3; k++) {
      final x = tips[i].dx + (s.r() - .5) * 30;
      final y = tips[i].dy + (s.r() - .5) * 22;
      final rad = 6 + s.r() * 4;
      final col = s.r() < .5
          ? const Color(0xFFF4A9CB)
          : const Color(0xFFEC8DB8);
      s.flower(
        t,
        x,
        y,
        rad,
        col,
        const Color(0xFFFFECAA),
        5,
        900 + i * 25 + k * 40,
      );
    }
  }
  s.faller(
    g,
    (f) => s.shape(
      f,
      _Scene.ellipse(0, 0, 3.4, 2.1),
      fill: const Color(0xFFF4A9CB),
    ),
    18,
    170,
    350,
    40,
    120,
    190,
    7,
  );
}

void _jaisalmer(_Scene s) {
  final g = s.root;
  s.ground(g, 180, 340);
  final sun = s.group(
    s.group(g, translate: const Offset(330, 60)),
    ambient: _Ambient.breathe,
  );
  for (int i = 0; i < 12; i++) {
    s.shape(
      sun,
      _Scene.rotated(
        Path()
          ..moveTo(0, -24)
          ..lineTo(0, -32),
        i * 30,
      ),
      stroke: const Color(0xFFE8A900),
      width: 2,
    );
  }
  s.shape(
    sun,
    _Scene.circle(0, 0, 16),
    fill: const Color(0xFFFFE38A),
    stroke: _ink,
    width: 1.4,
  );
  for (final (i, y) in [200.0, 230.0].indexed) {
    final x = 190.0 + i * 30;
    final wave = Path()
      ..moveTo(x, y)
      ..relativeQuadraticBezierTo(10, -5, 20, 0)
      ..relativeQuadraticBezierTo(10, 5, 20, 0)
      ..relativeQuadraticBezierTo(10, -5, 20, 0);
    s.shape(s.group(g, shimmer: i * .8), wave, stroke: _ink, width: 1.2);
  }
  const pads = [
    [262.0, 214.0, 24.0, 34.0, -3.0, 0],
    [232.0, 160.0, 18.0, 26.0, -26.0, 1],
    [292.0, 158.0, 18.0, 26.0, 24.0, 1],
    [214.0, 116.0, 13.0, 18.0, -42.0, 2],
    [262.0, 118.0, 14.0, 20.0, 2.0, 2],
    [306.0, 114.0, 13.0, 18.0, 36.0, 2],
  ];
  for (final p in pads) {
    final rx = p[2].toDouble(), ry = p[3].toDouble();
    final lv = p[5].toInt();
    final t = s.group(
      g,
      translate: Offset(p[0].toDouble(), p[1].toDouble()),
      rotate: p[4].toDouble(),
    );
    final pad = Path()
      ..moveTo(0, -ry)
      ..cubicTo(rx, -ry, rx * 1.05, ry, 0, ry)
      ..cubicTo(-rx * 1.05, ry, -rx, -ry, 0, -ry)
      ..close();
    s.shape(
      t,
      pad,
      fill: const Color(0xFFE6EFE2),
      stroke: _ink,
      width: 1.8,
      draw: lv * 260,
    );
    for (int k = 0; k < 5; k++) {
      final cx = (s.r() - .5) * rx, cy = (s.r() - .5) * ry * 1.3;
      s.shape(
        s.group(t, translate: Offset(cx, cy), pop: 600 + lv * 260 + k * 40),
        _Scene.circle(0, 0, 1.1),
        fill: _ink,
      );
    }
  }
  const blooms = [
    [214.0, 96.0],
    [262.0, 96.0],
    [306.0, 94.0],
    [226.0, 140.0],
    [300.0, 138.0],
  ];
  for (final (i, b) in blooms.indexed) {
    s.flower(
      g,
      b[0],
      b[1],
      8.5,
      const Color(0xFFF6C445),
      const Color(0xFFE77FB0),
      8,
      1300 + i * 160,
    );
  }
}

void _kolkata(_Scene s) {
  final g = s.root;
  s.ground(g, 190, 330);
  final t = s.group(g, ambient: _Ambient.sway);
  final tips = s.tree(t, 262, 252, 56, 12, 5, .6, 23);
  final leaf = Path()
    ..moveTo(0, -9)
    ..cubicTo(5, -4, 5, 4, 0, 9)
    ..cubicTo(-5, 4, -5, -4, 0, -9)
    ..close();
  for (int i = 0; i < tips.length; i++) {
    for (int k = 0; k < 2; k++) {
      final x = tips[i].dx + (s.r() - .5) * 26;
      final y = tips[i].dy + (s.r() - .5) * 18;
      final turn = s.r() * 180;
      s.shape(
        s.group(t, translate: Offset(x, y), rotate: turn, pop: 900 + i * 20),
        leaf,
        fill: const Color(0xFFDDE8D2),
        stroke: _ink,
        width: .9,
      );
    }
    if (i.isEven) {
      s.flower(
        t,
        tips[i].dx,
        tips[i].dy - 4,
        6,
        Colors.white,
        const Color(0xFFF08A3C),
        6,
        1200 + i * 30,
      );
    }
  }
  for (int i = 0; i < 9; i++) {
    final x = 196 + i * 15 + s.r() * 6, y = 256 + s.r() * 6;
    s.flower(
      g,
      x,
      y,
      4.2,
      Colors.white,
      const Color(0xFFF08A3C),
      6,
      1500 + i * 60,
    );
  }
  s.faller(
    g,
    (f) {
      for (int i = 0; i < 6; i++) {
        s.shape(
          f,
          _Scene.rotated(_Scene.ellipse(0, -2.6, 1.8, 2.8), i * 60.0),
          fill: Colors.white,
          stroke: _ink,
          width: .4,
        );
      }
      s.shape(f, _Scene.circle(0, 0, 1.2), fill: const Color(0xFFF08A3C));
    },
    12,
    180,
    350,
    50,
    130,
    170,
    9,
  );
}

void _srinagar(_Scene s) {
  final g = s.root;
  s.shape(
    g,
    Path()
      ..moveTo(180, 252)
      ..cubicTo(230, 244, 280, 246, 340, 250),
    stroke: _ink,
    width: 2,
    draw: 0,
  );
  final t = s.group(g);
  final tips = s.tree(t, 262, 252, 58, 13, 4, .7, 7);
  for (int i = 0; i < tips.length; i++) {
    final x = tips[i].dx, y = tips[i].dy;
    final cap = Path()
      ..moveTo(x - 8, y + 1)
      ..relativeQuadraticBezierTo(8, -7, 16, 0)
      ..close();
    s.shape(
      s.group(t, pop: 800 + i * 30),
      cap,
      fill: Colors.white,
      stroke: _ink,
      width: .9,
    );
  }
  for (final p in const [
    [212.0, 256.0, -20.0],
    [300.0, 254.0, 30.0],
  ]) {
    s.chinar(
      s.group(
        s.group(g, translate: Offset(p[0], p[1]), rotate: p[2]),
        pop: 1100,
      ),
    );
  }
  s.faller(g, s.chinar, 2, 230, 320, 40, 90, 200, 9);
  s.faller(
    g,
    (f) => s.shape(
      f,
      _Scene.circle(0, 0, 1.6 + s.r() * 1.2),
      fill: Colors.white,
      stroke: _ink,
      width: .4,
    ),
    30,
    150,
    370,
    -10,
    150,
    250,
    8,
  );
}

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

// Clicking advances the season (never on its own); each one inks in afresh.
class SeasonPlant extends StatefulWidget {
  const SeasonPlant({super.key});

  @override
  State<SeasonPlant> createState() => _SeasonPlantState();
}

class _SeasonPlantState extends State<SeasonPlant>
    with SingleTickerProviderStateMixin {
  int _season = 0;
  late _Scene _scene = _build(0);
  late final Ticker _ticker = createTicker(_onTick);
  final ValueNotifier<Duration> _clock = ValueNotifier(Duration.zero);
  Duration _seasonStart = Duration.zero;

  _Scene _build(int i) {
    // The board reseeds to 99 before every draw.
    final scene = _Scene()..seed = 99;
    _seasons[i].draw(scene);
    return scene;
  }

  void _onTick(Duration elapsed) => _clock.value = elapsed;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _ticker.stop();
    } else if (!_ticker.isActive) {
      _ticker.start();
    }
  }

  void _next() {
    setState(() {
      _season = (_season + 1) % _seasons.length;
      _scene = _build(_season);
      _seasonStart = _clock.value;
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ink = RouteInk.who.ink;
    final still = MediaQuery.disableAnimationsOf(context);
    return Semantics(
      button: true,
      label: "${_seasons[_season].caption}. Next season",
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _next,
          child: SizedBox.fromSize(
            size: _board,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: _PlantPainter(
                        scene: _scene,
                        clock: _clock,
                        start: _seasonStart,
                        still: still,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 262,
                  child: Row(
                    spacing: 14,
                    children: [
                      Transform.rotate(
                        angle: -3 * pi / 180,
                        child: Text(
                          _seasons[_season].caption,
                          style: AppText.handSmall.copyWith(
                            fontSize: 22,
                            color: ink,
                          ),
                        ),
                      ),
                      Row(
                        spacing: 6,
                        children: [
                          for (int i = 0; i < _seasons.length; i++)
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: i == _season ? .9 : .25,
                              child: Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: ink,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlantPainter extends CustomPainter {
  final _Scene scene;
  final ValueNotifier<Duration> clock;
  final Duration start;
  // Reduced motion: everything drawn, nothing moving.
  final bool still;

  _PlantPainter({
    required this.scene,
    required this.clock,
    required this.start,
    required this.still,
  }) : super(repaint: clock);

  // Milliseconds since this season appeared, and seconds of ambient time.
  late double _ms;
  late double _sec;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / _board.width, size.height / _board.height);
    _ms = still ? 1e9 : (clock.value - start).inMicroseconds / 1000;
    _sec = still ? 0 : clock.value.inMicroseconds / 1e6;
    _paintNode(canvas, scene.root, 1);
  }

  static double _pingPong(double t, double period) {
    final p = (t % (2 * period)) / period;
    return Curves.easeInOut.transform(p <= 1 ? p : 2 - p);
  }

  void _paintNode(Canvas canvas, _Node node, double alpha) {
    if (node is _Shape) {
      _paintShape(canvas, node, alpha);
      return;
    }
    final g = node as _Group;
    canvas.save();
    canvas.translate(g.translate.dx, g.translate.dy);
    if (g.rotate != 0) canvas.rotate(g.rotate * pi / 180);
    double a = alpha;

    if (g.popDelay != null) {
      final p = ((_ms - g.popDelay!) / _popTime.inMilliseconds).clamp(0.0, 1.0);
      if (p <= 0) {
        canvas.restore();
        return;
      }
      final c = _localBounds(g).center;
      canvas
        ..translate(c.dx, c.dy)
        ..scale(_popCurve.transform(p))
        ..translate(-c.dx, -c.dy);
    }
    if (!still && g.ambient == _Ambient.sway) {
      final b = _localBounds(g);
      final turn = (-1.2 + 2.4 * _pingPong(_sec, 4)) * pi / 180;
      canvas
        ..translate(b.center.dx, b.bottom)
        ..rotate(turn)
        ..translate(-b.center.dx, -b.bottom);
    }
    if (!still && g.ambient == _Ambient.breathe) {
      final c = _localBounds(g).center;
      final k = .88 + .18 * _pingPong(_sec, 2.8);
      canvas
        ..translate(c.dx, c.dy)
        ..scale(k)
        ..translate(-c.dx, -c.dy);
    }
    if (g.shimmerDelay != null) {
      if (still) {
        a *= .25;
      } else {
        final p = ((_sec - g.shimmerDelay!) % 3) / 3;
        final k = Curves.easeInOut.transform(p < .5 ? p * 2 : 2 - p * 2);
        canvas.translate(6 * k, 0);
        a *= .25 + .3 * k;
      }
    }
    if (g.fall != null) {
      final f = g.fall!;
      if (still) {
        a *= .8;
      } else {
        final p = ((_sec - f.delay) % f.seconds) / f.seconds;
        canvas
          ..translate(f.dx * p, f.dy * p)
          ..rotate(f.turn * p * pi / 180);
        a *= p < .08 ? p / .08 : (p > .85 ? (1 - p) / .15 : 1);
      }
    }
    for (final c in g.children) {
      _paintNode(canvas, c, a);
    }
    canvas.restore();
  }

  final Map<_Group, Rect> _boundsCache = {};

  Rect _localBounds(_Group g) => _boundsCache.putIfAbsent(g, () {
    Rect? r;
    for (final c in g.children) {
      final b = c.bounds;
      r = r == null ? b : r.expandToInclude(b);
    }
    return r ?? Rect.zero;
  });

  void _paintShape(Canvas canvas, _Shape s, double alpha) {
    if (s.fill != null) {
      canvas.drawPath(
        s.path,
        Paint()..color = s.fill!.withValues(alpha: s.fill!.a * alpha),
      );
    }
    if (s.stroke == null) return;
    final paint = Paint()
      ..color = s.stroke!.withValues(alpha: s.stroke!.a * alpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = s.width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    if (s.drawDelay == null) {
      canvas.drawPath(s.path, paint);
      return;
    }
    final p = _drawCurve.transform(
      ((_ms - s.drawDelay!) / _drawTime.inMilliseconds).clamp(0.0, 1.0),
    );
    if (p <= 0) return;
    if (p >= 1) {
      canvas.drawPath(s.path, paint);
      return;
    }
    for (final m in s.path.computeMetrics()) {
      canvas.drawPath(m.extractPath(0, m.length * p), paint);
    }
  }

  @override
  bool shouldRepaint(_PlantPainter old) =>
      old.scene != scene || old.start != start || old.still != still;
}
