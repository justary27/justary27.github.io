import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../components/app_link.dart';
import '../../../components/pinned_steps.dart';
import '../../../enums/layout.dart';
import '../../../enums/work.dart';
import '../../../models/work.dart';
import '../../../themes/brand.dart';
import '../../../themes/colors.dart';
import '../../../themes/dimens.dart';
import '../../../themes/motion.dart';
import '../../../themes/typography.dart';

const String _placeholder = "<placeholder>";
// Scroll distance per step, from the board.
const double _stepDistance = 420;
const double _railWidth = 72;
const double _summaryWidth = 400;
const Color _panelLine = Color(0xFFDCE3E3);

// One stop in the pinned sequence: a company's summary (chapter -1), the
// opening of a role chapter (companies with a promotion), or a point with a
// figure in that chapter. Text-only points are listed but get no stop.
class _Step {
  final int company;
  final int chapter;
  final int? point;

  const _Step(this.company, this.chapter, {this.point});

  bool get summary => chapter < 0;
  bool get opensChapter => chapter >= 0 && point == null;
  // The role the summary column shows; the summary shows the newest.
  int get role => max(0, chapter);
}

List<_Step> _sequence(List<WorkExperience> companies) => [
  for (int c = 0; c < companies.length; c++) ...[
    _Step(c, -1),
    for (int r = 0; r < companies[c].roleChapters.length; r++) ...[
      if (companies[c].roleChapters.length > 1) _Step(c, r),
      for (int p = 0; p < companies[c].roleChapters[r].points.length; p++)
        if (companies[c].roleChapters[r].points[p].hasFigure)
          _Step(c, r, point: p),
    ],
  ],
];

// The entry's colours from the Route Ink brand scope.
BrandInk _brand(WorkExperience c) =>
    Brands.experience[c.id] ??
    BrandInk(
      brand: c.primaryColor,
      dark: c.secondaryColor,
      soft: c.highlightColor,
      tint: c.cardBackgroundColor,
    );

// Brand dark: text, rules and figure ink inside the entry.
Color _ink(WorkExperience c) => _brand(c).dark;

String _monogram(WorkExperience c) => c.company.characters.first.toUpperCase();

class ExperienceSection extends StatefulWidget {
  final List<WorkExperience> companies;
  final double viewportHeight;
  final double gutter;
  // Space above the pinned area: navbar plus the docked pill bar.
  final double pinTop;
  final ValueChanged<String> onStepLabel;

  const ExperienceSection({
    super.key,
    required this.companies,
    required this.viewportHeight,
    required this.gutter,
    required this.pinTop,
    required this.onStepLabel,
  });

  @override
  State<ExperienceSection> createState() => ExperienceSectionState();
}

class ExperienceSectionState extends State<ExperienceSection> {
  late List<_Step> _steps = _sequence(widget.companies);

  @override
  void didUpdateWidget(ExperienceSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.companies != widget.companies) {
      _steps = _sequence(widget.companies);
    }
  }

  double get _pinnedHeight => widget.viewportHeight - widget.pinTop;
  double get _travel => (_steps.length - 1) * _stepDistance;

  // Scrolls the page so the walk lands on step `index`.
  void _goTo(int index) {
    final position = Scrollable.maybeOf(context)?.position;
    final box = context.findRenderObject() as RenderBox?;
    if (position == null || box == null) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final perStep = _travel / _steps.length;
    final target =
        (position.pixels + top - widget.pinTop + (index + 0.5) * perStep).clamp(
          0.0,
          position.maxScrollExtent,
        );
    position.animateTo(
      target,
      duration: Motion.glideBetweenYears,
      curve: MotionCurves.standard,
    );
  }

  // For links from elsewhere on the page (Positions' "in Experience" chip).
  void showCompany(String id) {
    final c = widget.companies.indexWhere((e) => e.id == id);
    if (c >= 0) _goTo(_steps.indexWhere((s) => s.company == c));
  }

  String _label(_Step step) {
    final company = widget.companies[step.company];
    final name = company.company.toUpperCase();
    if (step.summary) return "$name · SUMMARY";
    final chapters = company.roleChapters;
    final chapter = chapters[step.chapter];
    final head = chapters.length > 1 ? "$name · ${chapter.short}" : name;
    if (step.opensChapter) return head;
    final figures = [
      for (int p = 0; p < chapter.points.length; p++)
        if (chapter.points[p].hasFigure) p,
    ];
    return "$head · POINT ${figures.indexOf(step.point!) + 1} OF ${figures.length}";
  }

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(MediaQuery.sizeOf(context));
    final compact = layout.isCompact;
    final phone = layout.isPhone;
    return PinnedSteps(
      stepCount: _steps.length,
      pinnedHeight: _pinnedHeight,
      scrollHeight: _pinnedHeight + _travel,
      pinTop: widget.pinTop,
      builder: (context, index) {
        final step = _steps[index];
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => widget.onStepLabel(_label(step)),
        );
        final company = widget.companies[step.company];
        final summary = _Summary(
          company: company,
          step: step,
          onPoint: (p) => _goTo(
            _steps.indexWhere(
              (s) =>
                  s.company == step.company &&
                  s.chapter == step.role &&
                  s.point == p,
            ),
          ),
        );
        final media = _MediaPanel(company: company, step: step);
        final rail = _Rail(
          companies: widget.companies,
          current: step.company,
          chapter: step.chapter,
          horizontal: compact,
          onPick: (c) => _goTo(_steps.indexWhere((s) => s.company == c)),
          onPickChapter: (c, r) => _goTo(
            _steps.indexWhere(
              (s) => s.company == c && s.opensChapter && s.chapter == r,
            ),
          ),
        );
        return Padding(
          padding: EdgeInsets.fromLTRB(
            widget.gutter,
            Space.s24,
            widget.gutter,
            Space.s24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1152),
              // Tablet stacks the three: companies across the top, the media
              // in about a third, the summary and points below.
              child: compact
                  ? LayoutBuilder(
                      builder: (context, box) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: phone ? 10 : 14,
                        children: [
                          rail,
                          SizedBox(
                            height: (phone ? 0.24 : 0.31) * box.maxHeight,
                            child: media,
                          ),
                          Expanded(child: summary),
                        ],
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: Space.s32,
                      children: [
                        SizedBox(width: _summaryWidth, child: summary),
                        Expanded(child: media),
                        SizedBox(width: _railWidth, child: rail),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _Summary extends StatefulWidget {
  final WorkExperience company;
  final _Step step;
  final ValueChanged<int> onPoint;

  const _Summary({
    required this.company,
    required this.step,
    required this.onPoint,
  });

  @override
  State<_Summary> createState() => _SummaryState();
}

// The points list is taller than the room under the summary on most
// laptops, so it follows the walk: back to the top for a summary, the
// current point kept in view.
class _SummaryState extends State<_Summary> {
  final ScrollController _scroll = ScrollController();
  final Map<int, GlobalKey> _pointKeys = {};
  // A text-only point has no step to walk to, so a click just marks it.
  int? _marked;

  @override
  void initState() {
    super.initState();
    _follow();
  }

  @override
  void didUpdateWidget(_Summary oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.step != widget.step) _follow();
    if (oldWidget.step.company != widget.step.company ||
        oldWidget.step.role != widget.step.role) {
      _marked = null;
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _follow() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      final duration = MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : Motion.swap;
      final point = widget.step.point;
      final row = (point == null ? null : _pointKeys[point]?.currentContext)
          ?.findRenderObject();
      // Only this column moves; ensureVisible would scroll the page too.
      final offset = row == null
          ? 0.0
          : RenderAbstractViewport.of(row).getOffsetToReveal(row, 0.5).offset;
      _scroll.animateTo(
        offset.clamp(0.0, _scroll.position.maxScrollExtent),
        duration: duration,
        curve: MotionCurves.standard,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final company = widget.company;
    final step = widget.step;
    final ink = _ink(company);
    final chapters = company.roleChapters;
    // The role being walked is large; the others sit small and grey.
    final active = step.role;
    final role = chapters[active];

    // The summary stays put; only the points list below it scrolls. On short
    // windows the summary takes at most 70% and clips, so points keep room.
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 14,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 0.7 * constraints.maxHeight),
            child: ClipRect(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 14,
                  children: [
                    Row(
                      spacing: Space.s12,
                      children: [
                        _LogoMark(company: company, size: 36),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: _brand(company).brand,
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Text(
                              company.company,
                              style: AppText.h3.copyWith(fontSize: 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: Space.s8,
                      children: [
                        for (int i = 0; i < chapters.length; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 2,
                            children: [
                              if (i > 0)
                                Text(
                                  "↑ PROMOTED FROM",
                                  style: AppText.meta.copyWith(
                                    fontSize: 11,
                                    color: ink,
                                  ),
                                ),
                              AnimatedDefaultTextStyle(
                                duration: Motion.step,
                                style: AppText.body.copyWith(
                                  fontSize: i == active ? 20 : 15,
                                  fontWeight: i == active
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  height: 1.3,
                                  color: i == active
                                      ? AppColors.ink900
                                      : AppColors.ink500,
                                ),
                                child: Text(chapters[i].role),
                              ),
                              Text(
                                chapters[i].duration,
                                style: AppText.body.copyWith(
                                  fontSize: 14,
                                  height: 1.3,
                                  color: AppColors.ink500,
                                ),
                              ),
                            ],
                          ),
                        Text(
                          company.stack ?? _placeholder,
                          style: AppText.meta.copyWith(
                            fontWeight: FontWeight.w700,
                            color: ink,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        spacing: Space.s12,
                        children: [
                          // Big numbers shrink to fit the column instead of overflowing.
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                // A role's own number, else the company's.
                                role.headline ??
                                    company.headline ??
                                    _placeholder,
                                style: AppText.stat.copyWith(
                                  fontSize:
                                      Layout.of(MediaQuery.sizeOf(context))
                                          .isPhone
                                      ? 32
                                      : 44,
                                  letterSpacing: -0.88,
                                  color: ink,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              role.headline != null
                                  ? role.headlineCaption ?? _placeholder
                                  : company.headlineCaption ?? _placeholder,
                              style: AppText.body.copyWith(
                                fontSize: 14,
                                height: 1.4,
                                color: AppColors.ink700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // A phone keeps the points; the overview won't fit too.
                    if (!Layout.of(MediaQuery.sizeOf(context)).isPhone)
                      Text(
                        company.coreInfo.overview,
                        style: AppText.body.copyWith(
                          fontSize: 15,
                          height: 1.55,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Moved by the walk, never by the wheel, which drives the steps.
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: _panelLine)),
              ),
              child: _EdgeFade(
                child: SingleChildScrollView(
                  controller: _scroll,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int p = 0; p < role.points.length; p++)
                        _PointRow(
                          key: _pointKeys.putIfAbsent(p, GlobalKey.new),
                          number: p + 1,
                          text: role.points[p].text,
                          figure: role.points[p].hasFigure,
                          current: step.point == p || _marked == p,
                          ink: ink,
                          brand: _brand(company).brand,
                          onTap: () => role.points[p].hasFigure
                              ? widget.onPoint(p)
                              : setState(
                                  () => _marked = _marked == p ? null : p,
                                ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Fades whichever edge has more points past it, so a clipped row reads as
// "more this way". No scrollbar: the wheel can't move this list.
class _EdgeFade extends StatefulWidget {
  static const double _fade = 28;

  final Widget child;

  const _EdgeFade({required this.child});

  @override
  State<_EdgeFade> createState() => _EdgeFadeState();
}

class _EdgeFadeState extends State<_EdgeFade> {
  bool _above = false;
  bool _below = false;

  bool _onMetrics(ScrollMetrics m) {
    final above = m.pixels > 0.5;
    final below = m.pixels < m.maxScrollExtent - 0.5;
    if (above != _above || below != _below) {
      setState(() {
        _above = above;
        _below = below;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (n) => _onMetrics(n.metrics),
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (n) => _onMetrics(n.metrics),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stop = min(0.5, _EdgeFade._fade / constraints.maxHeight);
            return ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (rect) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, stop, 1 - stop, 1],
                colors: [
                  _above ? Colors.transparent : Colors.black,
                  Colors.black,
                  Colors.black,
                  _below ? Colors.transparent : Colors.black,
                ],
              ).createShader(rect),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context)
                    .copyWith(scrollbars: false),
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PointRow extends StatelessWidget {
  final int number;
  final String text;
  // Points with a figure step carry a small chart mark.
  final bool figure;
  final bool current;
  final Color ink;
  final Color brand;
  final VoidCallback onTap;

  const _PointRow({
    super.key,
    required this.number,
    required this.text,
    required this.figure,
    required this.current,
    required this.ink,
    required this.brand,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = current ? ink : AppColors.ink700;
    return Semantics(
      button: true,
      selected: current,
      child: InkWell(
        onTap: onTap,
        splashFactory: NoSplash.splashFactory,
        hoverColor: brand.withValues(alpha: 0.06),
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            Space.s12,
            Space.s12,
            0,
            Space.s12,
          ),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: current ? brand : Colors.transparent,
                width: 3,
              ),
              bottom: const BorderSide(color: _panelLine),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Space.s8,
            children: [
              SizedBox(
                width: 34,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        number.toString().padLeft(2, "0"),
                        style: AppText.meta.copyWith(
                          letterSpacing: 1.2,
                          color: color,
                        ),
                      ),
                      if (figure)
                        Icon(
                          Icons.insert_chart_outlined,
                          size: 14,
                          color: color,
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: AppText.body.copyWith(
                    fontSize: 15,
                    height: 1.45,
                    fontWeight: current ? FontWeight.w700 : FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MediaPanel extends StatelessWidget {
  final WorkExperience company;
  final _Step step;

  const _MediaPanel({required this.company, required this.step});

  @override
  Widget build(BuildContext context) {
    final ink = _ink(company);
    final layout = Layout.of(MediaQuery.sizeOf(context));
    final Widget figure;
    if (step.summary) {
      figure = _Logo3d(key: ValueKey("logo-${company.id}"), company: company);
    } else if (step.opensChapter) {
      figure = _PromotionFigure(
        key: ValueKey("promo-${company.id}-${step.chapter}"),
        company: company,
        active: step.chapter,
      );
    } else {
      final point = company.roleChapters[step.chapter].points[step.point!];
      // Figures are designed later; the panel only marks where each one goes.
      figure = Column(
        key: ValueKey("fig-${company.id}-${step.chapter}-${step.point}"),
        mainAxisSize: MainAxisSize.min,
        spacing: Space.s8,
        children: [
          Text(
            "FIGURE · ${(point.graphic.description ?? "").toUpperCase()}",
            style: AppText.meta.copyWith(color: ink),
          ),
          Text(_placeholder, style: AppText.h3.copyWith(color: ink)),
        ],
      );
    }

    final graphic = company.coreGraphic;
    final showsModel =
        step.summary &&
        graphic.type == GraphicType.animation &&
        graphic.path.isNotEmpty;

    // Figure captions are copy still to be written; the logo's names its file.
    final caption = showsModel
        ? "3D logo · ${graphic.path.split('/').last}"
        : _placeholder;

    return AnimatedContainer(
      duration: Motion.swap,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _brand(company).tint,
        border: Border.all(color: _panelLine),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: CustomPaint(painter: _DotGridPainter())),
          // Compact panels keep the figure clear of the link pills above it.
          Positioned.fill(
            top: switch (layout) {
              Layout.phone => 36,
              Layout.tablet => 44,
              Layout.large => 0,
            },
            child: AnimatedSwitcher(
              duration: Motion.swap,
              child: Center(
                key: figure.key,
                // Phone draws the figure at half size: laid out on a panel
                // twice as big, then scaled down into this one.
                child: layout.isPhone
                    ? LayoutBuilder(
                        builder: (context, box) => OverflowBox(
                          minWidth: 2 * box.maxWidth,
                          maxWidth: 2 * box.maxWidth,
                          minHeight: 2 * box.maxHeight,
                          maxHeight: 2 * box.maxHeight,
                          child: Transform.scale(scale: 0.5, child: figure),
                        ),
                      )
                    : figure,
              ),
            ),
          ),
          if (!layout.isPhone)
            Positioned(
              left: 22,
              bottom: Space.s16,
              child: AnimatedSwitcher(
                duration: Motion.swap,
                child: Text(
                  caption,
                  key: ValueKey(caption),
                  style: AppText.handMedium.copyWith(fontSize: 20, color: ink),
                ),
              ),
            ),
          if (company.links.isNotEmpty)
            // Bounded on both sides so the pills wrap from the right edge.
            Positioned(
              top: Space.s16,
              left: Space.s16,
              right: Space.s16,
              child: Wrap(
                alignment: WrapAlignment.end,
                spacing: Space.s8,
                runSpacing: Space.s8,
                children: [
                  for (final link in company.links)
                    _LinkPill(link: link, ink: ink),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// The panel's 22 px dot grid, the same under every step.
class _DotGridPainter extends CustomPainter {
  const _DotGridPainter();

  static const double _gap = 22;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x73BDBDBD);
    for (double y = 2; y < size.height; y += _gap) {
      for (double x = 2; x < size.width; x += _gap) {
        canvas.drawCircle(Offset(x, y), 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotGridPainter oldDelegate) => false;
}

class _LinkPill extends StatelessWidget {
  final WorkLink link;
  final Color ink;

  const _LinkPill({required this.link, required this.ink});

  @override
  Widget build(BuildContext context) {
    // Phones show just the icon; the label stays as the link's name.
    if (Layout.of(MediaQuery.sizeOf(context)).isPhone) {
      return AppLink(
        to: link.url,
        label: link.label,
        builder: (context, states) => Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: ink, width: 1.5),
          ),
          child: FaIcon(link.icon, size: 15, color: ink),
        ),
      );
    }
    return AppLink(
      to: link.url,
      label: link.label,
      builder: (context, states) => Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: Space.s12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ink, width: 1.5),
          borderRadius: BorderRadius.circular(Radii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            FaIcon(link.icon, size: 13, color: ink),
            Text(
              link.label,
              style: AppText.label.copyWith(fontSize: 13, color: ink),
            ),
          ],
        ),
      ),
    );
  }
}

// The company's 3D logo when it has one; otherwise its monogram coin.
class _Logo3d extends StatelessWidget {
  final WorkExperience company;

  const _Logo3d({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final graphic = company.coreGraphic;
    if (graphic.type == GraphicType.animation && graphic.path.isNotEmpty) {
      return SizedBox.square(
        dimension: 320,
        child: ModelViewer(
          src: graphic.path,
          alt: "${company.company} logo",
          ar: false,
          autoRotate: true,
          cameraControls: false,
          disableZoom: true,
          interactionPrompt: InteractionPrompt.none,
          backgroundColor: Colors.transparent,
        ),
      );
    }
    return _Monogram(company: company, size: 230);
  }
}

// The two newest roles as cards, the new one over the old, joined by an inked
// curve; the card for the role being walked is filled with the brand's soft tone.
class _PromotionFigure extends StatefulWidget {
  final WorkExperience company;
  final int active;

  const _PromotionFigure({
    super.key,
    required this.company,
    required this.active,
  });

  @override
  State<_PromotionFigure> createState() => _PromotionFigureState();
}

class _PromotionFigureState extends State<_PromotionFigure>
    with SingleTickerProviderStateMixin {
  // 0–480 ms draws the curve; the label pops in 300–600 ms.
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  )..forward();

  late final Animation<double> _draw = CurvedAnimation(
    parent: _intro,
    curve: const Interval(0, 0.8, curve: Curves.easeOut),
  );
  late final Animation<double> _pop = CurvedAnimation(
    parent: _intro,
    curve: const Interval(0.5, 1, curve: Curves.easeOut),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) _intro.value = 1;
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final company = widget.company;
    final active = widget.active;
    final ink = _ink(company);
    final soft = _brand(company).soft;
    final newer = company.roleChapters[0];
    final earlier = company.roleChapters[1];

    Widget card(
      String when,
      String role, {
      required double size,
      required EdgeInsets padding,
      required Color bg,
      required BoxShadow shadow,
    }) => AnimatedContainer(
      duration: Motion.step,
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: ink, width: 2),
        borderRadius: BorderRadius.circular(Radii.tile),
        boxShadow: [shadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Text(
            when.toUpperCase(),
            style: AppText.meta.copyWith(fontSize: 11, color: ink),
          ),
          Text(
            role,
            style: AppText.h3.copyWith(fontSize: size, height: 1.2, color: ink),
          ),
        ],
      ),
    );

    final label = AnimatedBuilder(
      animation: _pop,
      builder: (context, child) => Opacity(
        opacity: _pop.value,
        child: Transform.translate(
          offset: Offset(0, 8 * (1 - _pop.value)),
          child: child,
        ),
      ),
      child: Transform.rotate(
        angle: -0.14,
        child: Text(
          "promoted ↑",
          style: AppText.handMedium.copyWith(fontSize: 30, color: ink),
        ),
      ),
    );

    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.64,
      child: Center(
        child: ConstrainedBox(
          // On tall panels the cards would drift apart and the curve go slack.
          constraints: const BoxConstraints(maxHeight: 400),
          child: CustomMultiChildLayout(
            delegate: _PromotionLayout(),
            children: [
              LayoutId(
                id: _PromotionPart.curve,
                child: CustomPaint(
                  painter: _PromotionCurvePainter(progress: _draw, ink: ink),
                ),
              ),
              LayoutId(
                id: _PromotionPart.earlier,
                child: card(
                  earlier.duration,
                  earlier.role,
                  size: 20,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 22,
                  ),
                  bg: active == 1 ? soft : Colors.white,
                  shadow: const BoxShadow(
                    color: Color(0x590D0D0D),
                    offset: Offset(0, 10),
                    blurRadius: 24,
                    spreadRadius: -14,
                  ),
                ),
              ),
              LayoutId(
                id: _PromotionPart.newer,
                child: card(
                  newer.duration,
                  newer.role,
                  size: 24,
                  padding: const EdgeInsets.symmetric(
                    vertical: 22,
                    horizontal: 24,
                  ),
                  bg: active == 0 ? soft : Colors.white,
                  shadow: const BoxShadow(
                    color: Color(0x660D0D0D),
                    offset: Offset(0, 14),
                    blurRadius: 30,
                    spreadRadius: -14,
                  ),
                ),
              ),
              LayoutId(id: _PromotionPart.label, child: label),
            ],
          ),
        ),
      ),
    );
  }
}

// From the old card's top up to the new card's bottom, inked in as it appears.
enum _PromotionPart { curve, earlier, newer, label }

// Old card bottom-left, new card top-right; the curve spans the gap between
// the old card's top and the new card's bottom, so it always meets both.
class _PromotionLayout extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    final w = size.width, h = size.height;
    final earlier = layoutChild(
      _PromotionPart.earlier,
      BoxConstraints.tightFor(width: 0.56 * w),
    );
    final newer = layoutChild(
      _PromotionPart.newer,
      BoxConstraints.tightFor(width: 0.6 * w),
    );
    positionChild(_PromotionPart.earlier, Offset(0, h - earlier.height));
    positionChild(_PromotionPart.newer, Offset(w - newer.width, 0));

    final gap = max(0.0, h - earlier.height - newer.height);
    layoutChild(
      _PromotionPart.curve,
      BoxConstraints.tight(Size(0.28 * w, gap)),
    );
    positionChild(_PromotionPart.curve, Offset(0.30 * w, newer.height));

    layoutChild(_PromotionPart.label, BoxConstraints.loose(size));
    positionChild(_PromotionPart.label, Offset(0.08 * w, 0.18 * h));
  }

  @override
  bool shouldRelayout(_PromotionLayout oldDelegate) => false;
}

// Rises from the bottom-left corner of its box and lands flat at the top-right.
class _PromotionCurvePainter extends CustomPainter {
  final Animation<double> progress;
  final Color ink;

  _PromotionCurvePainter({required this.progress, required this.ink})
    : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final curve = Path()
      ..moveTo(0, h)
      ..cubicTo(0, 0.2 * h, 0.5 * w, 0, w, 0);
    final drawn = Path();
    for (final metric in curve.computeMetrics()) {
      drawn.addPath(
        metric.extractPath(0, metric.length * progress.value),
        Offset.zero,
      );
    }
    canvas.drawPath(
      drawn,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = ink,
    );
  }

  @override
  bool shouldRepaint(_PromotionCurvePainter old) => old.ink != ink;
}

// The company's logo file where there is one, else its monogram coin.
class _LogoMark extends StatelessWidget {
  final WorkExperience company;
  final double size;

  const _LogoMark({required this.company, required this.size});

  @override
  Widget build(BuildContext context) {
    final logo = company.logoSvgPath;
    if (logo == null) return _Monogram(company: company, size: size);
    final brand = _brand(company);
    final tint = brand.logoTint;
    final picture = SvgPicture.asset(
      "assets/$logo",
      semanticsLabel: "${company.company} logo",
      colorFilter: tint == null
          ? null
          : ColorFilter.mode(tint, BlendMode.srcIn),
    );
    return SizedBox.square(
      dimension: size,
      child: brand.logoIsTile ? ClipOval(child: picture) : picture,
    );
  }
}

class _Monogram extends StatelessWidget {
  final WorkExperience company;
  final double size;

  const _Monogram({required this.company, required this.size});

  @override
  Widget build(BuildContext context) {
    final brand = _brand(company).brand;
    // Text on a brand surface uses the brand's dark.
    final onBrand = _brand(company).dark;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: brand, shape: BoxShape.circle),
      child: Text(
        _monogram(company),
        style: AppText.stat.copyWith(fontSize: size * 0.38, color: onBrand),
      ),
    );
  }
}

class _Rail extends StatelessWidget {
  final List<WorkExperience> companies;
  final int current;
  // The chapter being walked in the current company (-1 on its summary).
  final int chapter;
  final ValueChanged<int> onPick;
  final void Function(int company, int chapter) onPickChapter;
  // Tablet lays the stops out in a row above the media, without the hint.
  final bool horizontal;

  const _Rail({
    required this.companies,
    required this.current,
    required this.chapter,
    required this.horizontal,
    required this.onPick,
    required this.onPickChapter,
  });

  @override
  Widget build(BuildContext context) {
    final stops = [
      for (int c = 0; c < companies.length; c++)
        _RailStop(
          company: companies[c],
          current: c == current,
          chapter: c == current ? chapter : -1,
          onTap: () => onPick(c),
          onTapChapter: (r) => onPickChapter(c, r),
        ),
    ];
    if (horizontal) {
      return CustomPaint(
        painter: const _DashedRulePainter(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: Space.s12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Layout.of(MediaQuery.sizeOf(context)).isPhone ? 10 : 14,
            children: stops,
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.only(top: Space.s4),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.line)),
      ),
      child: Column(
        children: [
          // Clips instead of overflowing when the window is short.
          Expanded(
            child: ClipRect(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(spacing: 14, children: stops),
              ),
            ),
          ),
          if (current < companies.length - 1)
            Padding(
              padding: const EdgeInsets.only(bottom: Space.s8),
              child: InkWell(
                onTap: () => onPick(current + 1),
                splashFactory: NoSplash.splashFactory,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    "NEXT COMPANY ↓",
                    style: AppText.meta.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                      color: _ink(companies[current]),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// The tablet rail's dashed bottom edge.
class _DashedRulePainter extends CustomPainter {
  const _DashedRulePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.line
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 8) {
      canvas.drawLine(
        Offset(x, size.height - 0.5),
        Offset(x + 4, size.height - 0.5),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashedRulePainter oldDelegate) => false;
}

class _RailStop extends StatelessWidget {
  final WorkExperience company;
  final bool current;
  final int chapter;
  final VoidCallback onTap;
  final ValueChanged<int> onTapChapter;

  const _RailStop({
    required this.company,
    required this.current,
    required this.chapter,
    required this.onTap,
    required this.onTapChapter,
  });

  @override
  Widget build(BuildContext context) {
    // Phone shrinks the stops so all five fit across 360.
    final small = Layout.of(MediaQuery.sizeOf(context)).isPhone;
    final chapters = company.roleChapters;
    final roles = chapters.length;
    final logo = company.logoSvgPath;
    return Semantics(
      button: true,
      selected: current,
      label: company.company,
      child: Tooltip(
        message: company.company,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          splashFactory: NoSplash.splashFactory,
          child: Column(
            spacing: 6,
            children: [
              AnimatedContainer(
                duration: Motion.swap,
                width: small ? 40 : 48,
                height: small ? 40 : 48,
                // A square icon fills the ring; other logos sit inside it.
                padding: _brand(company).logoIsTile
                    ? const EdgeInsets.all(1)
                    : const EdgeInsets.all(Space.s8),
                decoration: BoxDecoration(
                  // Logos sit on the page inside the ring; monograms keep a disc.
                  color: logo == null ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: current ? _brand(company).brand : _panelLine,
                    width: 3,
                  ),
                ),
                child: logo == null
                    ? FittedBox(
                        child: Text(
                          _monogram(company),
                          style: AppText.label.copyWith(color: _ink(company)),
                        ),
                      )
                    : _LogoMark(
                        company: company,
                        size: _brand(company).logoIsTile
                            ? (small ? 32 : 40)
                            : (small ? 26 : 32),
                      ),
              ),
              // One tick per role, for companies with a promotion.
              if (roles > 1)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [
                    // Filled while that role's chapter is being walked.
                    for (int r = 0; r < roles; r++)
                      Semantics(
                        button: true,
                        label: "${company.company} · ${chapters[r].role}",
                        child: Tooltip(
                          message: chapters[r].role,
                          child: GestureDetector(
                            onTap: () => onTapChapter(r),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: AnimatedContainer(
                                duration: Motion.swap,
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: chapter == r
                                      ? _ink(company)
                                      : Colors.white,
                                  border: Border.all(color: _ink(company)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
