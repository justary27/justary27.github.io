import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../components/app_link.dart';
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
const double _tileSize = 84;
const double _phoneTileSize = 56;
const double _tileGap = 16;
const double _tileRowGap = 20;
const int _tilesPerRow = 3;
// Tablet sets the tiles in one row above the card.
const int _tabletTilesPerRow = 5;
// Every organisation gets the same card, so switching never jumps the page.
const double _cardHeight = 440;
const Color _chipLine = Color(0xFFDCE3E3);
const Color _pointLine = Color(0xFFEEF1F1);

BrandInk _brand(Position p) =>
    Brands.positions[p.id] ??
    BrandInk(
      brand: p.primaryColor,
      dark: p.secondaryColor,
      soft: p.highlightColor,
      tint: Colors.white,
    );

class PositionsSection extends StatefulWidget {
  final List<Position> positions;
  final List<WorkExperience> projects;
  final double gutter;
  final ValueChanged<String> onLabel;
  // "in Experience ↑" chip: the Experience entry to show.
  final ValueChanged<String> onExperience;
  // "Led →" chip: the project to show in the Projects row.
  final ValueChanged<String> onProject;

  const PositionsSection({
    super.key,
    required this.positions,
    required this.projects,
    required this.gutter,
    required this.onLabel,
    required this.onExperience,
    required this.onProject,
  });

  @override
  State<PositionsSection> createState() => _PositionsSectionState();
}

class _PositionsSectionState extends State<PositionsSection> {
  int _current = 0;
  // Clicking a tile focuses the grid so arrow keys move the selection
  // instead of scrolling the page.
  final FocusNode _grid = FocusNode(debugLabel: "positions");
  // Index into the ladder (earlier roles, then the current one).
  late int _role = _ladder(widget.positions.first).length - 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _report());
  }

  @override
  void dispose() {
    _grid.dispose();
    super.dispose();
  }

  List<EarlierRole> _ladder(Position p) => [
    ...p.earlierRoles,
    EarlierRole(role: p.coreInfo.role, duration: p.coreInfo.duration),
  ];

  void _report() {
    if (!mounted) return;
    widget.onLabel(
      "${widget.positions[_current].organization.toUpperCase()} · "
      "${_current + 1} / ${widget.positions.length}",
    );
  }

  // Selection opens on the newest role.
  void _pick(int index) {
    if (index == _current) return;
    setState(() {
      _current = index;
      _role = _ladder(widget.positions[index]).length - 1;
    });
    _report();
  }

  int get _perRow => Layout.of(MediaQuery.sizeOf(context)).isCompact
      ? _tabletTilesPerRow
      : _tilesPerRow;

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final step = switch (event.logicalKey) {
      LogicalKeyboardKey.arrowRight => 1,
      LogicalKeyboardKey.arrowLeft => -1,
      LogicalKeyboardKey.arrowDown => _perRow,
      LogicalKeyboardKey.arrowUp => -_perRow,
      _ => 0,
    };
    if (step == 0) return KeyEventResult.ignored;
    _pick((_current + step).clamp(0, widget.positions.length - 1));
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final position = widget.positions[_current];
    final layout = Layout.of(MediaQuery.sizeOf(context));
    final compact = layout.isCompact;
    final phone = layout.isPhone;
    final tileSize = phone ? _phoneTileSize : _tileSize;
    final tileGap = phone ? 10.0 : _tileGap;
    final tiles = SizedBox(
      width: _perRow * tileSize + (_perRow - 1) * tileGap,
      child: Focus(
        focusNode: _grid,
        onKeyEvent: _onKey,
        child: Wrap(
          spacing: tileGap,
          runSpacing: phone ? 10 : _tileRowGap,
          children: [
            for (int i = 0; i < widget.positions.length; i++)
              _Tile(
                position: widget.positions[i],
                selected: i == _current,
                onTap: () {
                  _grid.requestFocus();
                  _pick(i);
                },
              ),
          ],
        ),
      ),
    );
    final card = AnimatedSwitcher(
      duration: Motion.swap,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(
            begin: const Offset(0.02, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: _Card(
        key: ValueKey(position.id),
        position: position,
        ladder: _ladder(position),
        role: _role,
        projects: [
          for (final id in position.linkedProjectIds)
            ...widget.projects.where((p) => p.id == id),
        ],
        onRole: (r) => setState(() => _role = r),
        onExperience: widget.onExperience,
        onProject: widget.onProject,
      ),
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(widget.gutter, 28, widget.gutter, 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152),
          child: compact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 28,
                  children: [tiles, card],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Space.s32,
                  children: [
                    tiles,
                    Expanded(child: card),
                  ],
                ),
        ),
      ),
    );
  }
}

class _Tile extends StatefulWidget {
  final Position position;
  final bool selected;
  final VoidCallback onTap;

  const _Tile({
    required this.position,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_Tile> createState() => _TileState();
}

class _TileState extends State<_Tile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final small = Layout.of(MediaQuery.sizeOf(context)).isPhone;
    // Selection is page chrome, so Work green, never the brand.
    final ink = RouteInk.work.ink;
    final logo = widget.position.logoSvgPath;
    return Semantics(
      button: true,
      selected: widget.selected,
      label: widget.position.organization,
      child: Tooltip(
        message: widget.position.organization,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedContainer(
                  duration: Motion.swap,
                  width: small ? _phoneTileSize : _tileSize,
                  height: small ? _phoneTileSize : _tileSize,
                  padding: EdgeInsets.all(small ? 12 : 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(small ? 14 : 18),
                    border: Border.all(
                      color: widget.selected || _hovered ? ink : _chipLine,
                      width: widget.selected ? 2.5 : 1.5,
                    ),
                    boxShadow: widget.selected
                        ? const [
                            BoxShadow(
                              color: AppColors.selectionHalo,
                              spreadRadius: 5,
                            ),
                          ]
                        : null,
                  ),
                  child: logo == null
                      ? FittedBox(
                          child: Text(
                            widget.position.organization.characters.first,
                            style: AppText.label.copyWith(
                              color: _brand(widget.position).dark,
                            ),
                          ),
                        )
                      : SvgPicture.asset("assets/$logo"),
                ),
                Positioned(
                  bottom: -13,
                  child: AnimatedOpacity(
                    duration: Motion.quick,
                    opacity: widget.selected ? 1 : 0,
                    child: Container(
                      width: 32,
                      height: 5,
                      decoration: BoxDecoration(
                        color: ink,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
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

class _Card extends StatelessWidget {
  final Position position;
  final List<EarlierRole> ladder;
  final int role;
  final List<WorkExperience> projects;
  final ValueChanged<int> onRole;
  final ValueChanged<String> onExperience;
  final ValueChanged<String> onProject;

  const _Card({
    super.key,
    required this.position,
    required this.ladder,
    required this.role,
    required this.projects,
    required this.onRole,
    required this.onExperience,
    required this.onProject,
  });

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(MediaQuery.sizeOf(context));
    final phone = layout.isPhone;
    final compact = layout.isCompact;
    final brand = _brand(position);
    // Phone stacks the stat under the points.
    final body = Flex(
      direction: phone ? Axis.vertical : Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: phone ? Space.s12 : Space.s24,
      children: [
        // Numbered points, as on the board; none are written yet.
        Flexible(
          flex: phone ? 0 : 1,
          fit: phone ? FlexFit.loose : FlexFit.tight,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: _pointLine)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Space.s16,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: Space.s4),
                  child: Text(
                    "01",
                    style: AppText.label.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: brand.dark,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    _placeholder,
                    style: AppText.body.copyWith(
                      fontSize: 16,
                      height: 1.5,
                      color: AppColors.ink700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: phone ? double.infinity : 200,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: brand.soft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              _placeholder,
              style: AppText.statCard.copyWith(fontSize: 22, color: brand.dark),
            ),
          ),
        ),
      ],
    );
    return Container(
      // Board: tablet keeps the 440 as a floor, phone drops it.
      height: compact ? null : _cardHeight,
      constraints: compact && !phone
          ? const BoxConstraints(minHeight: _cardHeight)
          : null,
      padding: phone
          ? const EdgeInsets.symmetric(vertical: 22, horizontal: 18)
          : const EdgeInsets.symmetric(vertical: 26, horizontal: 30),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Radii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Space.s24,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 14,
                  children: [
                    Text(
                      position.organization,
                      style: AppText.title.copyWith(fontSize: 30),
                    ),
                    Wrap(
                      spacing: Space.s8,
                      runSpacing: Space.s8,
                      children: [
                        for (final link in position.links)
                          _LinkPill(link: link, ink: brand.dark),
                      ],
                    ),
                  ],
                ),
              ),
              _Coin(position: position),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: Space.s16),
            child: Wrap(
              spacing: 10,
              runSpacing: Space.s8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (position.earlierInExperience != null) ...[
                  _Chip(
                    title: position.earlierInExperience!,
                    subtitle: "in Experience ↑",
                    dashed: true,
                    onTap: position.experienceId == null
                        ? null
                        : () => onExperience(position.experienceId!),
                  ),
                  const _ChipArrow(),
                ],
                // Oldest → newest, newest selected by default.
                for (int r = 0; r < ladder.length; r++) ...[
                  _Chip(
                    title: ladder[r].role,
                    subtitle: ladder[r].duration,
                    selected: r == role,
                    brand: _brand(position),
                    onTap: () => onRole(r),
                  ),
                  if (r < ladder.length - 1) const _ChipArrow(),
                ],
              ],
            ),
          ),
          // Compact cards grow to fit; the wider card's fixed height clips.
          if (compact) body else Expanded(child: ClipRect(child: body)),
          if (projects.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Wrap(
                spacing: Space.s8,
                runSpacing: Space.s8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "LED →",
                    style: AppText.meta.copyWith(letterSpacing: 1.68),
                  ),
                  for (final project in projects)
                    _LedChip(
                      label: project.company,
                      brand: brand,
                      onTap: () => onProject(project.id),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final bool dashed;
  // The selected role is inside the card, so it takes the organisation's
  // colours; without one it falls back to the page chrome.
  final BrandInk? brand;
  final VoidCallback? onTap;

  const _Chip({
    required this.title,
    required this.subtitle,
    this.selected = false,
    this.dashed = false,
    this.brand,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ink = RouteInk.work.ink;
    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: Space.s8, horizontal: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2,
        children: [
          Text(
            title,
            style: AppText.label.copyWith(
              fontWeight: selected || dashed
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: dashed ? AppColors.ink500 : AppColors.ink900,
            ),
          ),
          Text(
            subtitle,
            style: AppText.body.copyWith(
              fontSize: 12,
              height: 1.3,
              fontWeight: dashed ? FontWeight.w700 : FontWeight.w400,
              color: dashed ? ink : AppColors.ink500,
            ),
          ),
        ],
      ),
    );
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? brand?.soft ?? AppColors.selectionHalo : Colors.white,
        shape: dashed
            ? _DashedBorder(color: AppColors.line)
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Radii.chip),
                side: BorderSide(
                  color: selected ? brand?.dark ?? ink : _chipLine,
                  width: 1.5,
                ),
              ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Radii.chip),
          splashFactory: NoSplash.splashFactory,
          child: AnimatedSize(duration: Motion.swap, child: content),
        ),
      ),
    );
  }
}

class _ChipArrow extends StatelessWidget {
  const _ChipArrow();

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Text(
      "›",
      style: AppText.body.copyWith(fontSize: 20, color: AppColors.ink300),
    ),
  );
}

// Rounded rectangle outline drawn in dashes, for the "told in Experience" chip.
class _DashedBorder extends ShapeBorder {
  final Color color;

  const _DashedBorder({required this.color});

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(1.5);

  Path _shape(Rect rect) => Path()
    ..addRRect(
      RRect.fromRectAndRadius(
        rect.deflate(0.75),
        const Radius.circular(Radii.chip),
      ),
    );

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => _shape(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => _shape(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (final metric in _shape(rect).computeMetrics()) {
      for (double d = 0; d < metric.length; d += 9) {
        canvas.drawPath(metric.extractPath(d, d + 5), paint);
      }
    }
  }

  @override
  ShapeBorder scale(double t) => this;
}

class _LedChip extends StatelessWidget {
  final String label;
  final BrandInk brand;
  final VoidCallback onTap;

  const _LedChip({
    required this.label,
    required this.brand,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: "$label, in Projects",
      excludeSemantics: true,
      child: Material(
        color: brand.soft,
        shape: const StadiumBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          splashFactory: NoSplash.splashFactory,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            child: Text(
              "$label →",
              style: AppText.label.copyWith(color: brand.dark),
            ),
          ),
        ),
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

// The 96 px tilting 3D logo; a dashed ring where there's no model yet.
class _Coin extends StatelessWidget {
  final Position position;

  const _Coin({required this.position});

  @override
  Widget build(BuildContext context) {
    final graphic = position.coreGraphic;
    if (graphic.type == GraphicType.animation && graphic.path.isNotEmpty) {
      return SizedBox.square(
        dimension: 96,
        child: ModelViewer(
          src: graphic.path,
          alt: "${position.organization} logo",
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
      width: 96,
      height: 96,
      alignment: Alignment.center,
      decoration: const ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(color: AppColors.line, width: 1.5),
        ),
      ),
      child: Text(
        "3D MODEL\nNEEDED",
        textAlign: TextAlign.center,
        style: AppText.meta.copyWith(fontSize: 11, color: AppColors.ink300),
      ),
    );
  }
}
