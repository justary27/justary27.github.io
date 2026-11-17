import 'dart:math';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../components/app_link.dart';
import '../../../components/fit.dart';
import '../../../components/ink_on_view.dart';
import '../../../components/tape_strip.dart';
import '../../../enums/layout.dart';
import '../../../enums/work.dart';
import '../../../models/work.dart';
import '../../../themes/brand.dart';
import '../../../themes/colors.dart';
import '../../../themes/dimens.dart';
import '../../../themes/motion.dart';
import '../../../themes/route_ink.dart';
import '../../../themes/typography.dart';

const String _placeholder = "<placeholder>";
// The board's card: 88% of the row so the next one peeks, 20 px apart.
const double _cardFraction = 0.88;
const double _phoneCardFraction = 0.92;
const double _cardGap = 20;
// Card chrome around the stage: paddings, header, the gap.
const double _cardChrome = 194;
// Section padding, heading and the gap above the row, under the docked bar.
const double _aboveCard = 173;
// Board stage grid the note slots and arrows are drawn on.
const Size _stageGrid = Size(1152, 420);
const List<double> _noteTurns = [-3, 2.5, 2, -2.5];

enum _Slot { tl, tr, bl, br }

// Corners used for 1–4 notes, from the board.
const Map<int, List<_Slot>> _slotOrder = {
  1: [_Slot.tl],
  2: [_Slot.tl, _Slot.br],
  3: [_Slot.tl, _Slot.tr, _Slot.bl],
  4: [_Slot.tl, _Slot.tr, _Slot.bl, _Slot.br],
};

// Each arrow arcs from its note and stops short of the logo (board cubics).
const Map<_Slot, List<double>> _arrows = {
  _Slot.tl: [272, 64, 380, 26, 458, 74, 478, 148],
  _Slot.tr: [880, 72, 772, 34, 694, 82, 674, 148],
  _Slot.bl: [272, 352, 380, 390, 458, 340, 478, 272],
  _Slot.br: [880, 344, 772, 384, 694, 336, 674, 272],
};

BrandInk _brand(WorkExperience p) =>
    Brands.projects[p.id] ??
    BrandInk(
      brand: p.primaryColor,
      dark: p.secondaryColor,
      soft: p.highlightColor,
      tint: p.cardBackgroundColor,
    );

String _monogram(WorkExperience p) => p.company.characters.first.toUpperCase();

// Shared by the section's ← → buttons, the row and the logo strip.
class ProjectRowController {
  PageController pages = PageController(viewportFraction: _cardFraction);
  final ValueNotifier<int> current = ValueNotifier(0);
  // Known up front so the arrows are right on their first build.
  final int count;

  ProjectRowController({required this.count}) {
    pages.addListener(_follow);
  }

  void _follow() {
    if (!pages.hasClients || pages.page == null) return;
    current.value = pages.page!.round().clamp(0, max(0, count - 1));
  }

  // A page's width is fixed per controller, so a phone (92%) swaps in a new
  // one on the current card; the old one goes once the row has let go.
  void fitFraction(double fraction) {
    if (pages.viewportFraction == fraction) return;
    final old = pages;
    pages = PageController(
      viewportFraction: fraction,
      initialPage: current.value,
    )..addListener(_follow);
    old.removeListener(_follow);
    WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
  }

  void go(BuildContext context, int index) {
    if (!pages.hasClients || count == 0) return;
    final target = index.clamp(0, count - 1);
    if (MediaQuery.disableAnimationsOf(context)) {
      pages.jumpToPage(target);
    } else {
      pages.animateToPage(
        target,
        duration: Motion.glideBetweenYears,
        curve: MotionCurves.standard,
      );
    }
  }

  void dispose() {
    pages.dispose();
    current.dispose();
  }
}

// Previous, the project picker, next: one cluster at the heading's right.
class ProjectArrows extends StatelessWidget {
  final ProjectRowController controller;
  final List<WorkExperience> projects;

  const ProjectArrows({
    super.key,
    required this.controller,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    final phone = Layout.of(MediaQuery.sizeOf(context)).isPhone;
    return ValueListenableBuilder<int>(
      valueListenable: controller.current,
      builder: (context, index, _) => Row(
        mainAxisSize: MainAxisSize.min,
        spacing: Space.s8,
        children: [
          // A phone swipes between cards, so only the picker stays.
          if (!phone)
            _RoundButton(
              label: "Previous project",
              icon: Icons.arrow_back,
              onTap: index > 0 ? () => controller.go(context, index - 1) : null,
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: phone ? 0 : 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: Space.s8,
              children: [
                for (int i = 0; i < projects.length; i++)
                  _StripStop(
                    project: projects[i],
                    current: i == index,
                    onTap: () => controller.go(context, i),
                  ),
              ],
            ),
          ),
          if (!phone)
            _RoundButton(
              label: "Next project",
              icon: Icons.arrow_forward,
              onTap: index < controller.count - 1
                  ? () => controller.go(context, index + 1)
                  : null,
            ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _RoundButton({required this.label, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final ink = RouteInk.work.ink;
    final enabled = onTap != null;
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: Opacity(
        opacity: enabled ? 1 : 0.4,
        child: Material(
          color: Colors.white,
          shape: CircleBorder(side: BorderSide(color: ink, width: 1.5)),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            splashFactory: NoSplash.splashFactory,
            child: SizedBox.square(
              dimension: 44,
              child: Icon(icon, size: 20, color: ink),
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectsSection extends StatefulWidget {
  final List<WorkExperience> projects;
  final ProjectRowController controller;
  final double gutter;
  final ValueChanged<String> onLabel;

  const ProjectsSection({
    super.key,
    required this.projects,
    required this.controller,
    required this.gutter,
    required this.onLabel,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  @override
  void initState() {
    super.initState();
    widget.controller.current.addListener(_report);
    WidgetsBinding.instance.addPostFrameCallback((_) => _report());
  }

  @override
  void dispose() {
    widget.controller.current.removeListener(_report);
    super.dispose();
  }

  void _report() {
    if (!mounted || widget.projects.isEmpty) return;
    final i = widget.controller.current.value;
    widget.onLabel(
      "${widget.projects[i].company.toUpperCase()} · ${i + 1} / ${widget.projects.length}",
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(MediaQuery.sizeOf(context));
    final compact = layout.isCompact;
    widget.controller.fitFraction(
      layout.isPhone ? _phoneCardFraction : _cardFraction,
    );
    return Padding(
      padding: EdgeInsets.only(
        top: 28,
        left: widget.gutter,
        right: widget.gutter,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152),
          child: Column(
            children: [
              // Arrows draw in once the row has scrolled into view, then per
              // card as each one becomes current.
              InkOnView(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOut,
                // The board draws them once the row is 40% up the window.
                viewportFraction: 0.4,
                builder: (context, rowInk) => _RowHeight(
                  // Fit: the card fills what's left under the docked bar; its
                  // stage gives up height first, 420 down to 280.
                  height: compact
                      ? null
                      : (Fit.room(context, docked: true) - _aboveCard).clamp(
                          _cardChrome + 280,
                          _cardChrome + 420,
                        ),
                  // Compact cards grow to fit their notes, all as tall as the
                  // tallest (the board's height: auto).
                  cardFraction: layout.isPhone
                      ? _phoneCardFraction
                      : _cardFraction,
                  measures: [
                    for (final p in widget.projects)
                      _ProjectCard(project: p, seen: false, measure: true),
                  ],
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      rowInk,
                      widget.controller.current,
                    ]),
                    builder: (context, _) => PageView.builder(
                      controller: widget.controller.pages,
                      padEnds: false,
                      itemCount: widget.projects.length,
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.only(right: _cardGap),
                        child: _ProjectCard(
                          project: widget.projects[i],
                          seen:
                              rowInk.value > 0 &&
                              i == widget.controller.current.value,
                        ),
                      ),
                    ),
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

// A fixed height, or the tallest of [measures] laid out at a card's width.
class _RowHeight extends StatelessWidget {
  final double? height;
  final double cardFraction;
  final List<Widget> measures;
  final Widget child;

  const _RowHeight({
    required this.height,
    required this.cardFraction,
    required this.measures,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (height != null) return SizedBox(height: height, child: child);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Stack(
          children: [
            SizedBox(width: width),
            for (final m in measures)
              IgnorePointer(
                child: ExcludeSemantics(
                  child: Opacity(
                    opacity: 0,
                    child: SizedBox(
                      width: cardFraction * width - _cardGap,
                      child: m,
                    ),
                  ),
                ),
              ),
            Positioned.fill(child: child),
          ],
        );
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final WorkExperience project;
  final bool seen;
  // An invisible copy laid out at its natural height to size the row.
  final bool measure;

  const _ProjectCard({
    required this.project,
    required this.seen,
    this.measure = false,
  });

  @override
  Widget build(BuildContext context) {
    final brand = _brand(project);
    final core = project.coreInfo;
    final layout = Layout.of(MediaQuery.sizeOf(context));
    final compact = layout.isCompact;
    final phone = layout.isPhone;
    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        Text(
          "${core.role} · ${core.duration}".toUpperCase(),
          style: AppText.meta.copyWith(color: brand.dark),
        ),
        Text(project.company, style: AppText.title.copyWith(fontSize: 34)),
        // Only projects whose own text gives a number get one.
        if (project.headline != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            spacing: 10,
            children: [
              // Big numbers shrink to fit the column instead of overflowing.
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    project.headline!,
                    style: AppText.title.copyWith(
                      fontSize: 34,
                      letterSpacing: -0.68,
                      color: brand.dark,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  project.headlineCaption ?? _placeholder,
                  style: AppText.body.copyWith(
                    fontSize: 15,
                    color: AppColors.ink700,
                  ),
                ),
              ),
            ],
          ),
        Text(
          project.stack ?? _placeholder,
          style: AppText.meta.copyWith(
            fontWeight: FontWeight.w700,
            color: brand.dark,
          ),
        ),
      ],
    );
    Widget links(WrapAlignment alignment) => Wrap(
      alignment: alignment,
      spacing: Space.s8,
      runSpacing: Space.s8,
      children: [
        for (final link in project.links)
          _LinkPill(link: link, ink: brand.dark),
      ],
    );
    final stage = _Stage(
      project: project,
      brand: brand,
      seen: seen,
      compact: compact,
      phone: phone,
      measure: measure,
    );
    final card = Container(
      padding: phone
          ? const EdgeInsets.fromLTRB(20, 22, 20, 22)
          : const EdgeInsets.fromLTRB(36, 28, 36, 28),
      decoration: BoxDecoration(
        color: brand.tint,
        borderRadius: BorderRadius.circular(Radii.card),
      ),
      child: Column(
        mainAxisSize: measure ? MainAxisSize.min : MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tablet stacks the links under the name, left-aligned.
          if (compact) ...[
            // Phone keeps the name clear of the coin in the corner.
            Padding(
              padding: EdgeInsets.only(right: phone ? 70 : 0),
              child: info,
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerLeft,
              child: links(WrapAlignment.start),
            ),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                Expanded(child: info),
                // Links hug the card's right edge and wrap leftwards.
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: Space.s4),
                      child: links(WrapAlignment.end),
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: Space.s12),
          // Takes what the header leaves, so a long header can't overflow.
          if (measure) stage else Expanded(child: stage),
        ],
      ),
    );
    if (!phone || measure) return card;
    // Phone: the coin moves to the card's top-right corner.
    return Stack(
      children: [
        card,
        Positioned(
          right: 18,
          top: 20,
          child: _Logo3d(project: project, brand: brand, size: 60),
        ),
      ],
    );
  }
}

class _Stage extends StatefulWidget {
  final WorkExperience project;
  final BrandInk brand;
  final bool seen;
  // Tablet: the coin on top, the notes in a grid under it, no arrows.
  final bool compact;
  // Phone: the notes alone, one per row; the coin sits on the card.
  final bool phone;
  final bool measure;

  const _Stage({
    required this.project,
    required this.brand,
    required this.seen,
    required this.compact,
    required this.phone,
    required this.measure,
  });

  @override
  State<_Stage> createState() => _StageState();
}

class _StageState extends State<_Stage> with SingleTickerProviderStateMixin {
  // Arrows draw over 700 ms; heads follow at 650–900 ms; notes fade in.
  late final AnimationController _draw = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void initState() {
    super.initState();
    if (widget.seen) _start();
  }

  @override
  void didUpdateWidget(_Stage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.seen && !_draw.isAnimating && _draw.value == 0) _start();
  }

  void _start() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        _draw.value = 1;
      } else {
        _draw.forward();
      }
    });
  }

  @override
  void dispose() {
    _draw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final points = widget.project.scrollablePoints.take(4).toList();
    final slots = _slotOrder[max(1, points.length)]!;
    if (widget.compact) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final columns = widget.phone
              ? 1
              : max(1, ((width + 16) / (150 + 16)).floor());
          final cell = (width - 16 * (columns - 1)) / columns;
          final content = AnimatedBuilder(
            animation: _draw,
            builder: (context, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!widget.phone)
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 36),
                    child: Center(
                      child: _Logo3d(
                        project: widget.project,
                        brand: widget.brand,
                        size: 120,
                        stub: widget.measure,
                      ),
                    ),
                  ),
                Wrap(
                  spacing: 16,
                  runSpacing: widget.phone ? 18 : 26,
                  children: [
                    for (int j = 0; j < points.length; j++)
                      SizedBox(width: cell, child: _note(j, points[j].text)),
                  ],
                ),
              ],
            ),
          );
          // Measured copies grow the row; the shown card clips what's left.
          if (widget.measure) return content;
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: content,
          );
        },
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return AnimatedBuilder(
          animation: _draw,
          builder: (context, _) => Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _ArrowPainter(
                    slots: slots.take(points.length).toList(),
                    color: widget.brand.dark,
                    progress: _draw.value,
                  ),
                ),
              ),
              Center(
                child: _Logo3d(project: widget.project, brand: widget.brand),
              ),
              for (int j = 0; j < points.length; j++)
                _placed(slots[j], size, _note(j, points[j].text)),
            ],
          ),
        );
      },
    );
  }

  Widget _placed(_Slot slot, Size size, Widget note) {
    final left = slot == _Slot.tl || slot == _Slot.bl;
    final top = slot == _Slot.tl || slot == _Slot.tr;
    return Positioned(
      left: left ? 0 : null,
      right: left ? null : 0,
      top: top ? (slot == _Slot.tl ? 12 : 20) : null,
      bottom: top ? null : (slot == _Slot.bl ? 16 : 24),
      width: 0.24 * size.width,
      child: note,
    );
  }

  Widget _note(int j, String text) {
    // Staggered 120 ms after the arrows start, like the board.
    final fade = ((_draw.value * 900 - (200 + j * 120)) / 400).clamp(0.0, 1.0);
    return Opacity(
      opacity: fade,
      child: Transform.rotate(
        angle: _noteTurns[j] * pi / 180,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              padding: widget.phone
                  ? const EdgeInsets.fromLTRB(14, 16, 14, 12)
                  : const EdgeInsets.fromLTRB(18, 20, 18, 16),
              decoration: const BoxDecoration(
                color: AppColors.paper,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x730D0D0D),
                    offset: Offset(0, 12),
                    blurRadius: 22,
                    spreadRadius: -14,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Space.s4,
                children: [
                  Text(
                    (j + 1).toString().padLeft(2, "0"),
                    style: AppText.meta.copyWith(
                      fontSize: 11,
                      letterSpacing: 1.1,
                      color: widget.brand.dark,
                    ),
                  ),
                  Text(
                    text,
                    style: AppText.body.copyWith(
                      fontSize: widget.phone ? 14 : 15,
                      height: 1.5,
                      color: AppColors.ink700,
                    ),
                  ),
                ],
              ),
            ),
            // Brand washi, alternating with butter tape.
            Positioned(
              top: -11,
              child: TapeStrip(
                width: 86,
                height: 22,
                angle: (j.isOdd ? 5 : -5) * pi / 180,
                color: j.isOdd
                    ? AppColors.tapeSheer
                    // Brand at low alpha: projects' soft equals the card tint.
                    : widget.brand.brand.withValues(alpha: 0.35),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final List<_Slot> slots;
  final Color color;
  final double progress;

  const _ArrowPainter({
    required this.slots,
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / _stageGrid.width;
    final sy = size.height / _stageGrid.height;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final stroke = (progress * 900 / 700).clamp(0.0, 1.0);
    // Round caps would leave a dot at each start before the draw begins.
    if (stroke == 0) return;
    final head = ((progress * 900 - 650) / 250).clamp(0.0, 1.0);

    for (final slot in slots) {
      final a = _arrows[slot]!;
      Offset p(int i) => Offset(a[i] * sx, a[i + 1] * sy);
      final path = Path()
        ..moveTo(p(0).dx, p(0).dy)
        ..cubicTo(p(2).dx, p(2).dy, p(4).dx, p(4).dy, p(6).dx, p(6).dy);
      for (final metric in path.computeMetrics()) {
        canvas.drawPath(metric.extractPath(0, metric.length * stroke), paint);
      }
      if (head > 0) {
        // Open head along the curve's last tangent.
        final tip = p(6);
        final dir = (tip - p(4));
        final angle = atan2(dir.dy, dir.dx);
        final len = 16 * head;
        for (final side in [-1, 1]) {
          final back = angle + pi - side * 0.5;
          canvas.drawLine(tip, tip + Offset(cos(back), sin(back)) * len, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_ArrowPainter old) =>
      old.progress != progress || old.color != color || old.slots != slots;
}

class _Logo3d extends StatelessWidget {
  final WorkExperience project;
  final BrandInk brand;
  // The coin's diameter; the model gets a quarter more room to turn in.
  final double size;

  // Takes the logo's room without starting a model viewer.
  final bool stub;

  const _Logo3d({
    required this.project,
    required this.brand,
    this.size = 160,
    this.stub = false,
  });

  @override
  Widget build(BuildContext context) {
    final graphic = project.coreGraphic;
    if (graphic.type == GraphicType.animation && graphic.path.isNotEmpty) {
      if (stub) return SizedBox.square(dimension: 1.25 * size);
      return SizedBox.square(
        dimension: 1.25 * size,
        child: ModelViewer(
          src: graphic.path,
          alt: "${project.company} logo",
          ar: false,
          autoRotate: true,
          cameraControls: false,
          disableZoom: true,
          interactionPrompt: InteractionPrompt.none,
          backgroundColor: Colors.transparent,
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: brand.brand, shape: BoxShape.circle),
      child: Text(
        _monogram(project),
        style: AppText.stat.copyWith(fontSize: 0.36 * size, color: brand.dark),
      ),
    );
  }
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
              "${link.label} ↗",
              style: AppText.label.copyWith(fontSize: 13, color: ink),
            ),
          ],
        ),
      ),
    );
  }
}

class _StripStop extends StatelessWidget {
  final WorkExperience project;
  final bool current;
  final VoidCallback onTap;

  const _StripStop({
    required this.project,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brand = _brand(project);
    final logo = project.logoSvgPath;
    return Semantics(
      button: true,
      selected: current,
      label: project.company,
      child: Tooltip(
        message: project.company,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          splashFactory: NoSplash.splashFactory,
          child: AnimatedScale(
            duration: Motion.swap,
            scale: current ? 1.12 : 1,
            child: AnimatedOpacity(
              duration: Motion.swap,
              opacity: current ? 1 : 0.6,
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  // Logos sit on the page inside the ring, as on the rail.
                  color: logo == null ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: current ? brand.dark : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: logo == null
                    ? FittedBox(
                        child: Text(
                          _monogram(project),
                          style: AppText.label.copyWith(color: brand.dark),
                        ),
                      )
                    : SvgPicture.asset(
                        "assets/$logo",
                        colorFilter: brand.logoTint == null
                            ? null
                            : ColorFilter.mode(
                                brand.logoTint!,
                                BlendMode.srcIn,
                              ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
