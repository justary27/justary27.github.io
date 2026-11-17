import 'dart:math';
import 'dart:ui';

import 'package:material_ui/material_ui.dart';

import '../../../components/app_link.dart';
import '../../../components/navbar.dart';
import '../../../components/pinned_steps.dart';
import '../../../constants/route.dart';
import '../../../enums/layout.dart';
import '../../../models/who.dart';
import '../../../themes/colors.dart';
import '../../../themes/dimens.dart';
import '../../../themes/motion.dart';
import '../../../themes/route_ink.dart';
import '../../../themes/typography.dart';

// Scroll distance per entry, from the board.
const double _stepDistance = 300;
// Month ruler spacing on each year's node.
const double _tick = 22;
const List<String> _months = [
  "",
  "JAN",
  "FEB",
  "MAR",
  "APR",
  "MAY",
  "JUN",
  "JUL",
  "AUG",
  "SEP",
  "OCT",
  "NOV",
  "DEC",
];

Color get _ink => RouteInk.who.ink;

class _Kind {
  final String label;
  final Color background;
  final Color foreground;

  const _Kind(this.label, this.background, this.foreground);
}

const Map<WhoKind, _Kind> _kinds = {
  WhoKind.work: _Kind("WORK", Color(0xFF82F6B0), Color(0xFF0B5E50)),
  WhoKind.code: _Kind("CODE", Color(0xFF0E2B85), Colors.white),
  WhoKind.life: _Kind("LIFE", Color(0xFFB8C6FF), Color(0xFF0E2B85)),
  WhoKind.trip: _Kind("TRIP", Color(0xFFFFECAA), Color(0xFF6B5C00)),
  WhoKind.writing: _Kind("WRITING", Color(0xFFF7C9C4), Color(0xFF7A140D)),
};

// Where up to three media sit in an entry's media column, from the board.
class _Slot {
  final double left, top, width, turn, tapeTurn;

  const _Slot(this.left, this.top, this.width, this.turn, this.tapeTurn);
}

const List<_Slot> _slots = [
  _Slot(0, 6, 200, -4, -7),
  _Slot(176, 64, 210, 4, 6),
  _Slot(40, 196, 190, -2, -4),
];

// The years pin under the navbar and the wheel walks them entry by entry:
// 300 ms within a year, 800 ms when the track slides to the next one.
class WhoTimeline extends StatelessWidget {
  final List<WhoYear> years;
  final double viewportHeight;

  const WhoTimeline({
    super.key,
    required this.years,
    required this.viewportHeight,
  });

  List<(int, int)> get _sequence => [
    for (int y = 0; y < years.length; y++)
      for (int e = 0; e < years[y].entries.length; e++) (y, e),
  ];

  @override
  Widget build(BuildContext context) {
    final sequence = _sequence;
    final double yearHeight = max(560, viewportHeight - NavBar.height);
    return PinnedSteps(
      stepCount: sequence.length,
      pinnedHeight: yearHeight,
      scrollHeight: yearHeight + (sequence.length - 1) * _stepDistance,
      stepDelay: (from, to) => sequence[from].$1 == sequence[to].$1
          ? Motion.step
          : Motion.glideBetweenYears,
      builder: (context, step) => _TimelineView(
        years: years,
        sequence: sequence,
        step: step,
        yearHeight: yearHeight,
      ),
    );
  }
}

class _TimelineView extends StatefulWidget {
  final List<WhoYear> years;
  final List<(int, int)> sequence;
  final int step;
  final double yearHeight;

  const _TimelineView({
    required this.years,
    required this.sequence,
    required this.step,
    required this.yearHeight,
  });

  @override
  State<_TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<_TimelineView>
    with SingleTickerProviderStateMixin {
  // The dot moves along the trail, not in a straight line.
  late final AnimationController _dot = AnimationController(vsync: this);
  double _fromLength = 0;
  double _toLength = 0;
  _Snake? _snake;

  int get _year => widget.sequence[widget.step].$1;
  int get _entry => widget.sequence[widget.step].$2;

  @override
  void didUpdateWidget(_TimelineView old) {
    super.didUpdateWidget(old);
    if (old.step != widget.step) {
      final crossesYear =
          widget.sequence[old.step].$1 != widget.sequence[widget.step].$1;
      _glide(crossesYear ? Motion.glideBetweenYears : Motion.glideWithinYear);
    }
  }

  void _glide(Duration duration) {
    final snake = _snake;
    if (snake == null) return;
    _fromLength = _currentLength;
    _toLength = snake.lengthForEntry(widget.years, _year, _entry);
    if (MediaQuery.disableAnimationsOf(context)) {
      _dot.value = 1;
      return;
    }
    _dot
      ..duration = duration
      ..forward(from: 0);
  }

  double get _currentLength => lerpDouble(
    _fromLength,
    _toLength,
    Curves.easeInOutCubic.transform(_dot.value),
  )!;

  @override
  void dispose() {
    _dot.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final year = widget.years[_year];
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final snake = _Snake(
          width: width,
          yearHeight: widget.yearHeight,
          years: widget.years.length,
        );
        if (_snake?.width != width || _snake?.yearHeight != widget.yearHeight) {
          _snake = snake;
          _fromLength = _toLength = snake.lengthForEntry(
            widget.years,
            _year,
            _entry,
          );
          _dot.value = 1;
        }
        return ClipRect(
          child: Stack(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(end: -_year * widget.yearHeight),
                duration: MediaQuery.disableAnimationsOf(context)
                    ? Duration.zero
                    : Motion.glideBetweenYears,
                curve: MotionCurves.step,
                builder: (context, y, child) =>
                    Transform.translate(offset: Offset(0, y), child: child),
                child: SizedBox(
                  width: width,
                  height: widget.years.length * widget.yearHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (int y = 0; y < widget.years.length; y++)
                        Positioned(
                          top: y * widget.yearHeight,
                          left: 0,
                          right: 0,
                          height: widget.yearHeight,
                          child: ColoredBox(
                            color: y.isEven
                                ? AppColors.whoYearBlue
                                : AppColors.whoYearViolet,
                            child: _YearSpread(
                              entry: widget
                                  .years[y]
                                  .entries[y == _year ? _entry : 0],
                              nodeOnLeft: y.isEven,
                              current: y == _year,
                            ),
                          ),
                        ),
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _SnakePainter(
                              snake: snake,
                              years: widget.years,
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _dot,
                        builder: (context, _) {
                          final at = snake.pointAt(_currentLength);
                          return Positioned(
                            left: at.dx - 16,
                            top: at.dy - 16,
                            child: const _Dot(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: (0.04 * width).clamp(16, double.infinity),
                top: 18,
                child: Text(
                  "HOW I GOT HERE · ${year.year} · "
                  "${_entry + 1} / ${year.entries.length}",
                  style: AppText.meta.copyWith(color: _ink),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// The trail: nodes alternate sides, one per year at its middle, joined by
// curves through the page's centre line.
class _Snake {
  final double width;
  final double yearHeight;
  final int years;
  late final Path path = _build();
  late final PathMetric _metric = path.computeMetrics().first;

  _Snake({required this.width, required this.yearHeight, required this.years});

  Offset node(int i) => Offset(
    i.isEven ? width * 0.06 : width * 0.94,
    i * yearHeight + yearHeight / 2,
  );

  bool nodeOnLeft(int i) => i.isEven;

  Path _build() {
    final first = node(0);
    final p = Path()
      ..moveTo(first.dx, 0)
      ..lineTo(first.dx, first.dy + 150);
    for (int i = 0; i < years - 1; i++) {
      final a = node(i), b = node(i + 1);
      final my = (a.dy + b.dy) / 2;
      p
        ..quadraticBezierTo(a.dx, my, width / 2, my)
        ..quadraticBezierTo(b.dx, my, b.dx, b.dy - 150)
        ..lineTo(b.dx, b.dy + 150);
    }
    final last = node(years - 1);
    p.lineTo(last.dx, years * yearHeight);
    return p;
  }

  double tickY(int year, int month) => node(year).dy + (month - 6.5) * _tick;

  // The trail's y only grows, so a binary search on length finds a height.
  double lengthAtY(double y) {
    double lo = 0, hi = _metric.length;
    for (int i = 0; i < 30; i++) {
      final mid = (lo + hi) / 2;
      if (_metric.getTangentForOffset(mid)!.position.dy < y) {
        lo = mid;
      } else {
        hi = mid;
      }
    }
    return hi;
  }

  double lengthForEntry(List<WhoYear> data, int year, int entry) =>
      lengthAtY(tickY(year, data[year].entries[entry].month));

  Offset pointAt(double length) =>
      _metric.getTangentForOffset(length.clamp(0, _metric.length))!.position;
}

class _SnakePainter extends CustomPainter {
  final _Snake snake;
  final List<WhoYear> years;

  const _SnakePainter({required this.snake, required this.years});

  @override
  void paint(Canvas canvas, Size size) {
    final ink = _ink;
    canvas.drawPath(
      snake.path,
      Paint()
        ..color = ink.withValues(alpha: 0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round,
    );
    final off = Paint()
      ..color = ink.withValues(alpha: 0.3)
      ..strokeWidth = 2;
    final on = Paint()
      ..color = ink.withValues(alpha: 0.85)
      ..strokeWidth = 2.5;

    for (int y = 0; y < years.length; y++) {
      final node = snake.node(y);
      final left = snake.nodeOnLeft(y);
      for (int m = 1; m <= 12; m++) {
        final ty = snake.tickY(y, m);
        final has = years[y].entries.any((e) => e.month == m);
        final half = has ? 10.0 : 5.0;
        canvas.drawLine(
          Offset(node.dx - half, ty),
          Offset(node.dx + half, ty),
          has ? on : off,
        );
        if (has) _label(canvas, _months[m], node, ty - 6, left, 11, 1.32);
      }
      _label(
        canvas,
        years[y].year,
        node,
        node.dy - 6.5 * _tick - 56,
        left,
        40,
        -0.4,
      );
    }
  }

  void _label(
    Canvas canvas,
    String text,
    Offset node,
    double top,
    bool left,
    double size,
    double spacing,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: AppFonts.text,
          fontSize: size,
          fontWeight: FontWeight.w900,
          letterSpacing: spacing,
          height: 1,
          color: _ink,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final x = left ? node.dx + 18 : node.dx - 18 - tp.width;
    tp.paint(canvas, Offset(x, top));
  }

  @override
  bool shouldRepaint(_SnakePainter old) =>
      old.snake.width != snake.width ||
      old.snake.yearHeight != snake.yearHeight ||
      old.years != years;
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 32,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: _ink.withValues(alpha: 0.7), width: 3),
        ),
        child: Center(
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: _ink, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}

// One entry as a spread beside its year's node: text on one side, up to
// three taped media on the other. Years other than the current one dim.
class _YearSpread extends StatelessWidget {
  final WhoEntry entry;
  final bool nodeOnLeft;
  final bool current;

  const _YearSpread({
    required this.entry,
    required this.nodeOnLeft,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final kind = _kinds[entry.kind]!;
    final muted = current ? null : AppColors.ink500;
    final screen = MediaQuery.sizeOf(context);
    final compact = Layout.of(screen).isCompact;
    final phone = Layout.of(screen).isPhone;
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final Widget text = Column(
          mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Space.s12,
          children: [
            Row(
              spacing: Space.s8,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: kind.background,
                    borderRadius: BorderRadius.circular(Radii.pill),
                  ),
                  child: Text(
                    kind.label,
                    style: AppText.meta.copyWith(
                      fontSize: 11,
                      letterSpacing: 1.32,
                      color: kind.foreground,
                    ),
                  ),
                ),
                Text(entry.when, style: AppText.meta),
              ],
            ),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 400),
              style: AppText.title.copyWith(
                fontSize: (0.026 * w).clamp(24, 34),
                height: 1.15,
                color: muted ?? AppColors.ink900,
              ),
              child: Text(entry.title),
            ),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 400),
              style: AppText.body.copyWith(
                fontSize: phone ? 16 : 17,
                height: 1.7,
                color: muted ?? AppColors.ink700,
              ),
              child: Text(entry.text),
            ),
            if (entry.workId != null)
              _MarginNote(
                child: AppLink(
                  to: RouteHandler.workPage,
                  label: "On Work",
                  builder: (context, _) => Text(
                    "on Work →",
                    style: AppText.handSmall.copyWith(color: AppColors.ink900),
                  ),
                ),
              )
            else if (entry.note != null)
              _MarginNote(child: Text(entry.note!, style: AppText.handSmall)),
          ],
        );
        final Widget media = AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: current ? 1 : 0.4,
          child: SizedBox(
            height: 340,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (int i = 0; i < min(3, entry.media.length); i++)
                  Positioned(
                    left: _slots[i].left,
                    top: _slots[i].top,
                    width: _slots[i].width,
                    child: Transform.rotate(
                      angle: _slots[i].turn * pi / 180,
                      child: _MediaItem(
                        media: entry.media[i],
                        tapeTurn: _slots[i].tapeTurn,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
        return Padding(
          // Tablet hangs the entry from just under the year label (which
          // sits 199 above the node), as on the board: node − 132.
          padding: EdgeInsets.fromLTRB(
            // Phone gives the node's side more room: its ruler is wider
            // than 14% of a narrow screen.
            w * (nodeOnLeft ? (phone ? 0.21 : 0.14) : (phone ? 0.04 : 0.05)),
            compact ? max(64.0, constraints.maxHeight / 2 - 132) : 64,
            w * (nodeOnLeft ? (phone ? 0.04 : 0.05) : (phone ? 0.21 : 0.14)),
            compact ? 40 : 56,
          ),
          child: AnimatedSwitcher(
            duration: Motion.swap,
            // Tablet stacks the text over the media, which shrinks to fit
            // half the window.
            child: compact
                ? Column(
                    key: ValueKey(entry),
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 22,
                    children: [
                      text,
                      // The board's zoom, from the room under the navbar;
                      // the media also gives up height before the text does.
                      Flexible(
                        child: LayoutBuilder(
                          builder: (context, box) {
                            final zoom = min(
                              ((constraints.maxHeight / 2 - 170) / 340).clamp(
                                0.45,
                                1.0,
                              ),
                              box.maxHeight / 340,
                            );
                            return SizedBox(
                              height: 340 * zoom,
                              child: OverflowBox(
                                alignment: Alignment.topLeft,
                                maxHeight: 340,
                                child: Transform.scale(
                                  scale: zoom,
                                  alignment: Alignment.topLeft,
                                  child: media,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Row(
                    key: ValueKey(entry),
                    spacing: 40,
                    children: [
                      Expanded(child: text),
                      Expanded(child: media),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _MarginNote extends StatelessWidget {
  final Widget child;

  const _MarginNote({required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -1.5 * pi / 180,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Space.s8, horizontal: 14),
        decoration: const BoxDecoration(
          color: AppColors.marginNote,
          boxShadow: [
            BoxShadow(
              color: Color(0x730D0D0D),
              offset: Offset(0, 8),
              blurRadius: 14,
              spreadRadius: -10,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class _LinkLook {
  final String label;
  final Color labelColor;
  // Link kinds with a thumbnail strip above the title.
  final Color? thumb;
  final bool play;

  const _LinkLook(this.label, this.labelColor, {this.thumb, this.play = false});
}

const Map<WhoLinkKind, _LinkLook> _links = {
  WhoLinkKind.youtube: _LinkLook(
    "YOUTUBE · STREAM",
    Color(0xFFFF0000),
    thumb: AppColors.ipadBezel,
    play: true,
  ),
  WhoLinkKind.x: _LinkLook("𝕏 POST · @JUSTARY27", AppColors.ink900),
  WhoLinkKind.instagram: _LinkLook(
    "INSTAGRAM · POST",
    Color(0xFFC13584),
    thumb: Color(0xFFE6D9F2),
  ),
  WhoLinkKind.medium: _LinkLook("MEDIUM · POST", AppColors.ink900),
  WhoLinkKind.github: _LinkLook("GITHUB · REPO", AppColors.ink900),
  WhoLinkKind.news: _LinkLook("IN THE NEWS", Color(0xFF0E2B85)),
};

class _MediaItem extends StatelessWidget {
  final WhoMedia media;
  final double tapeTurn;

  const _MediaItem({required this.media, required this.tapeTurn});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        media.isPhoto ? _photo() : _link(),
        Positioned(
          top: -9,
          child: Transform.rotate(
            angle: tapeTurn * pi / 180,
            child: Container(
              width: 70,
              height: 18,
              color: AppColors.tape.withValues(alpha: 0.9),
            ),
          ),
        ),
      ],
    );
  }

  static const List<BoxShadow> _shadow = [
    BoxShadow(
      color: Color(0x660D0D0D),
      offset: Offset(0, 12),
      blurRadius: 22,
      spreadRadius: -10,
    ),
  ];

  Widget _photo() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 30),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: _shadow),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 120,
            alignment: Alignment.center,
            color: const Color(0xFFDDE0EE),
            child: media.image == null
                ? Text(
                    "PHOTO",
                    style: AppText.label.copyWith(
                      fontSize: 11,
                      color: const Color(0xFF8C90A8),
                    ),
                  )
                : Image.asset(media.image!, fit: BoxFit.cover),
          ),
          Positioned(
            left: 2,
            bottom: -26,
            right: 2,
            child: Text(
              media.caption ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.handSmall.copyWith(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  Widget _link() {
    final look = _links[media.link]!;
    return AppLink(
      to: media.url!,
      label: "${look.label}: ${media.title}",
      builder: (context, _) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Radii.chip),
          boxShadow: _shadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (look.thumb != null)
              Container(
                height: 112,
                color: look.thumb,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (media.live)
                      Positioned(
                        left: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF0000),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "LIVE",
                            style: AppText.meta.copyWith(
                              fontSize: 10,
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if (look.play)
                      Container(
                        width: 52,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF0000),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    look.label,
                    style: AppText.meta.copyWith(
                      fontSize: 10,
                      letterSpacing: 1,
                      color: look.labelColor,
                    ),
                  ),
                  Text(
                    media.title!,
                    style: AppText.label.copyWith(fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
