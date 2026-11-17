import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../components/engraved_pencil.dart';
import '../../../components/navbar.dart';
import '../../../components/pinned_scroll.dart';
import '../../../constants/route.dart';
import '../../../enums/layout.dart';
import '../../../themes/colors.dart';
import '../../../themes/dimens.dart';
import '../../../themes/motion.dart';
import '../../../themes/route_ink.dart';
import '../../../themes/typography.dart';
import '../notes.dart';
import '../painters.dart';

const TextStyle _meta = TextStyle(
  fontFamily: AppFonts.text,
  fontSize: 13,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.82,
  color: AppColors.ink500,
);
const Color _screenLine = Color(0xFFE2E2E2);
const Color _rowLine = Color(0xFFECECEC);
const double _bezel = 18;
const double _sidebarWidth = 210;
const double _maxScreenHeight = 600;
const double _minScreenHeight = 420;
// The board's 96 px around the iPad, squeezed to 48 on short windows.
const double _minPadding = 48;
const double _tabletMaxScreenHeight = 840;
const double _tabletMinScreenHeight = 560;
const double _tabletMinPadding = 28;
const double _phoneBezel = 8;
const double _phoneMaxScreenHeight = 760;
const double _phoneMinScreenHeight = 480;
const double _phoneMinPadding = 18;

// The page holds the iPad still while the wheel scrolls the list inside it.
class NotesPad extends StatefulWidget {
  final List<Note> notes;
  final Size size;

  const NotesPad({super.key, required this.notes, required this.size});

  @override
  State<NotesPad> createState() => _NotesPadState();
}

class _NotesPadState extends State<NotesPad> {
  final ScrollController _list = ScrollController();
  final GlobalKey _screenKey = GlobalKey();
  bool _zooming = false;
  ValueListenable<double>? _travelled;
  String _filter = "all";
  String _query = "";
  double _overflow = 0;

  @override
  void dispose() {
    _travelled?.removeListener(_drive);
    _list.dispose();
    super.dispose();
  }

  void _drive() {
    if (!_list.hasClients) return;
    _list.jumpTo(_travelled!.value.clamp(0, _list.position.maxScrollExtent));
  }

  // The section's extra height is however far the list overflows its screen.
  void _measure() {
    if (!mounted || !_list.hasClients) return;
    final overflow = _list.position.maxScrollExtent;
    if (overflow != _overflow) setState(() => _overflow = overflow);
  }

  void _pick(String filter) {
    setState(() => _filter = filter);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  List<Note> get _visible {
    Iterable<Note> notes = widget.notes;
    if (_filter == "top") {
      notes = notes.where((n) => n.isTop);
    } else if (_filter == "series") {
      notes = notes.where((n) => n.isSeries);
    } else if (int.tryParse(_filter) != null) {
      notes = notes.where((n) => n.year.toString() == _filter);
    }
    final q = _query.trim().toLowerCase();
    if (q.isNotEmpty) {
      notes = notes.where((n) => n.title.toLowerCase().contains(q));
    }
    return notes.toList();
  }

  @override
  Widget build(BuildContext context) {
    final double room = widget.size.height - NavBar.height;
    // Portrait tablets get a taller screen: list under a row of filters.
    final layout = Layout.of(widget.size);
    final compact = layout.isCompact;
    final phone = layout.isPhone;
    // Phone: a slim bezel and a screen that takes nearly all the room.
    final double bezel = phone ? _phoneBezel : _bezel;
    final double minPadding = phone
        ? _phoneMinPadding
        : compact
        ? _tabletMinPadding
        : _minPadding;
    final double screenHeight = (room - 2 * bezel - 2 * minPadding).clamp(
      phone
          ? _phoneMinScreenHeight
          : compact
          ? _tabletMinScreenHeight
          : _minScreenHeight,
      phone
          ? _phoneMaxScreenHeight
          : compact
          ? _tabletMaxScreenHeight
          : _maxScreenHeight,
    );
    final double padding = ((room - screenHeight - 2 * bezel) / 2).clamp(
      minPadding,
      Space.s96,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());

    return PinnedScroll(
      pinnedHeight: screenHeight + 2 * bezel + 2 * padding,
      travel: _overflow,
      builder: (context, travelled) {
        if (_travelled != travelled) {
          _travelled?.removeListener(_drive);
          _travelled = travelled..addListener(_drive);
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding,
            horizontal: phone
                ? 12
                : (0.04 * widget.size.width).clamp(Space.s16, double.infinity),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: _Bezel(
                pencilOnSide: compact,
                phone: phone,
                child: SizedBox(
                  key: _screenKey,
                  height: screenHeight,
                  child: Flex(
                    direction: compact ? Axis.vertical : Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Sidebar(
                        filter: _filter,
                        years: {for (final n in widget.notes) n.year}.toList()
                          ..sort((a, b) => b.compareTo(a)),
                        horizontal: compact,
                        onPick: _pick,
                      ),
                      Expanded(child: _buildList()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // The screen grows into the post's red header, then the post opens under it.
  void open(Note note) {
    if (_zooming) return;
    final path = RouteHandler.blogDetailsPage(note.opens.id);
    final box = _screenKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || MediaQuery.disableAnimationsOf(context)) {
      context.push(path, extra: note.opens);
      return;
    }
    _zooming = true;
    late final OverlayEntry cover;
    cover = OverlayEntry(
      builder: (_) => _ZoomCover(
        from: box.localToGlobal(Offset.zero) & box.size,
        onCovered: () {
          if (mounted) context.push(path, extra: ZoomedOpen(note.opens));
          // Two frames: the post page builds under the cover before it lifts.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cover.remove();
              _zooming = false;
            });
          });
        },
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(cover);
  }

  Widget _buildList() {
    final notes = _visible;
    final showTops =
        _filter == "all" && _query.trim().isEmpty && notes.any((n) => n.isTop);
    final heading = switch (_filter) {
      "all" => "All notes",
      "top" => "Top",
      "series" => "Series",
      _ => _filter,
    };

    final List<Widget> rows = [];
    int? year;
    for (final note in notes) {
      if (note.year != year) {
        year = note.year;
        rows.add(
          Padding(
            padding: const EdgeInsets.only(top: 26, bottom: Space.s4),
            child: Text("$year", style: _meta),
          ),
        );
      }
      rows.add(_NoteRow(note: note));
    }

    return CustomPaint(
      painter: const DotPaperPainter(),
      child: SingleChildScrollView(
        controller: _list,
        // The page's wheel drives this list through the pin, never the list.
        physics: const NeverScrollableScrollPhysics(),
        padding: Layout.of(widget.size).isPhone
            ? const EdgeInsets.fromLTRB(16, 18, 16, 40)
            : const EdgeInsets.fromLTRB(34, 26, 34, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    heading,
                    style: AppText.h2.copyWith(fontSize: 28, height: 1.2),
                  ),
                ),
                const SizedBox(width: Space.s16),
                _SearchField(
                  onChanged: (q) {
                    setState(() => _query = q);
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _measure(),
                    );
                  },
                ),
              ],
            ),
            if (showTops) ...[
              const Padding(
                padding: EdgeInsets.only(top: Space.s24, bottom: Space.s12),
                child: Text("★ TOP", style: _meta),
              ),
              _TopRow(notes: notes.where((n) => n.isTop).toList()),
            ],
            ...rows,
            if (notes.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: Space.s32),
                child: Text(
                  "No notes match that. Try another word or clear the search.",
                  style: AppText.body.copyWith(color: AppColors.ink500),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Bezel extends StatelessWidget {
  final Widget child;
  // Tablet: the Pencil hangs down the right edge instead of along the top.
  final bool pencilOnSide;
  // Phone: thin bezel, tighter corners, no Pencil.
  final bool phone;

  const _Bezel({
    required this.child,
    required this.pencilOnSide,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double pencilWidth = 0.47 * constraints.maxWidth;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.ipadBezel,
                borderRadius: BorderRadius.circular(phone ? 30 : 34),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x2E0D0D0D),
                    offset: Offset(0, 24),
                    blurRadius: 50,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(phone ? _phoneBezel : _bezel),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(phone ? 22 : Radii.tile),
                  child: ColoredBox(color: Colors.white, child: child),
                ),
              ),
            ),
            if (phone)
              const SizedBox.shrink()
            else if (pencilOnSide)
              Positioned(
                left: constraints.maxWidth - 2,
                top: 0.2 * constraints.maxHeight,
                child: const RotatedBox(
                  quarterTurns: 1,
                  child: EngravedPencil(width: 420),
                ),
              )
            else
              // Attached to the top edge, as on the desk iPad.
              Positioned(
                left: 0.26 * constraints.maxWidth,
                top: -pencilWidth / EngravedPencil.aspectRatio + 2,
                child: EngravedPencil(width: pencilWidth),
              ),
          ],
        );
      },
    );
  }
}

class _Sidebar extends StatelessWidget {
  final String filter;
  final List<int> years;
  // Tablet: one scrolling row across the top of the screen.
  final bool horizontal;
  final ValueChanged<String> onPick;

  const _Sidebar({
    required this.filter,
    required this.years,
    required this.horizontal,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    Widget item(String value, String label) => _SideItem(
      label: label,
      selected: filter == value,
      onTap: () => onPick(value),
    );

    if (horizontal) {
      return Container(
        padding: Layout.of(MediaQuery.sizeOf(context)).isPhone
            ? const EdgeInsets.symmetric(vertical: 10, horizontal: 12)
            : const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(bottom: BorderSide(color: _screenLine)),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: Space.s4,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 12, 0),
                child: Text("Notes", style: AppText.h3.copyWith(fontSize: 20)),
              ),
              item("all", "All"),
              item("top", "★ Top"),
              item("series", "Series"),
              for (final year in years) item("$year", "$year"),
            ],
          ),
        ),
      );
    }
    return Container(
      width: _sidebarWidth,
      padding: const EdgeInsets.symmetric(vertical: Space.s24, horizontal: 14),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: _screenLine)),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 2,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, Space.s16),
              child: Text("Notes", style: AppText.h3),
            ),
            item("all", "All"),
            item("top", "★ Top"),
            item("series", "Series"),
            if (years.isNotEmpty)
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 20, 14, 6),
                child: Text("YEARS", style: _meta),
              ),
            for (final year in years) item("$year", "$year"),
          ],
        ),
      ),
    );
  }
}

class _SideItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SideItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(Radii.chip),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Radii.chip),
          splashFactory: NoSplash.splashFactory,
          hoverColor: AppColors.ink900.withValues(alpha: 0.04),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 14),
            child: Text(
              label,
              style: AppText.label.copyWith(
                fontSize: 15,
                color: selected ? AppColors.ink900 : AppColors.ink700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Radii.pill),
      borderSide: const BorderSide(color: AppColors.deskLine),
    );
    return SizedBox(
      width: Layout.of(MediaQuery.sizeOf(context)).isPhone ? 132 : 200,
      child: TextField(
        onChanged: onChanged,
        style: AppText.body.copyWith(fontSize: 14, color: AppColors.ink900),
        cursorColor: AppColors.ink900,
        decoration: InputDecoration(
          isDense: true,
          hintText: "Search notes",
          hintStyle: AppText.body.copyWith(
            fontSize: 14,
            color: AppColors.ink300,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 18,
          ),
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: AppColors.ink900),
          ),
        ),
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  final List<Note> notes;

  const _TopRow({required this.notes});

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = [
      for (int i = 0; i < notes.length; i++)
        Expanded(
          child: _TopCard(note: notes[i], highlighted: i == 0),
        ),
    ];
    // Phone: one per row.
    if (Layout.of(MediaQuery.sizeOf(context)).isPhone) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          for (int i = 0; i < notes.length; i++)
            _TopCard(note: notes[i], highlighted: i == 0),
        ],
      );
    }
    // Two per row, as on the board; a lone card keeps half the width.
    if (cards.length.isOdd) cards.add(const Expanded(child: SizedBox()));
    return Column(
      spacing: Space.s16,
      children: [
        for (int i = 0; i < cards.length; i += 2)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: Space.s16,
              children: cards.sublist(i, i + 2),
            ),
          ),
      ],
    );
  }
}

class _TopCard extends StatelessWidget {
  final Note note;
  final bool highlighted;

  const _TopCard({required this.note, required this.highlighted});

  @override
  Widget build(BuildContext context) {
    return _Hoverable(
      onTap: () => _open(context, note),
      label: note.title,
      builder: (hovered) => Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _screenLine),
          borderRadius: BorderRadius.circular(Radii.chip),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: highlighted ? AppColors.tape : null,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Text(note.title, style: _titleStyle(hovered)),
              ),
            ),
            Text(
              "${noteDate(note.date)} · ${note.read}".toUpperCase(),
              style: _meta,
            ),
            Padding(
              padding: const EdgeInsets.only(top: Space.s4),
              child: Text(
                note.topNote ?? placeholder,
                style: AppText.handSmall.copyWith(
                  fontSize: 22,
                  height: 1,
                  color: RouteInk.blog.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteRow extends StatelessWidget {
  final Note note;

  const _NoteRow({required this.note});

  @override
  Widget build(BuildContext context) {
    // Phone drops the thumbnail and narrows the number column.
    final phone = Layout.of(MediaQuery.sizeOf(context)).isPhone;
    return _Hoverable(
      onTap: () => _open(context, note),
      label: note.title,
      builder: (hovered) => Container(
        padding: const EdgeInsets.symmetric(vertical: Space.s16),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: _rowLine)),
        ),
        child: Row(
          spacing: phone ? 10 : 20,
          children: [
            SizedBox(
              width: phone ? 64 : 72,
              child: Text(
                "NO. ${note.number}",
                style: _meta.copyWith(
                  color: note.onlyHere ? RouteInk.blog.ink : AppColors.ink500,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: note.title, style: _titleStyle(hovered)),
                        if (note.onlyHere)
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "only here ✎",
                                style: AppText.handSmall.copyWith(
                                  color: RouteInk.blog.ink,
                                ),
                              ),
                            ),
                          ),
                        if (note.isSeries)
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: _SeriesChip(parts: note.seriesParts),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(note.read.toUpperCase(), style: _meta),
                  ),
                ],
              ),
            ),
            if (!phone) _Thumb(keyword: note.keyword),
          ],
        ),
      ),
    );
  }
}

class _SeriesChip extends StatelessWidget {
  final int parts;

  const _SeriesChip({required this.parts});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: Space.s8),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: Space.s8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.deskLine),
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Text(
        "SERIES · $parts",
        style: _meta.copyWith(fontSize: 11, letterSpacing: 1.32),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  final String keyword;

  const _Thumb({required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 76,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _screenLine),
        borderRadius: BorderRadius.circular(Radii.chip),
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(painter: SkylineThumbPainter()),
          ),
          Positioned(
            left: 10,
            top: 6,
            right: 6,
            child: Text(
              keyword,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: AppText.handSmall.copyWith(color: RouteInk.blog.ink),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hoverable extends StatefulWidget {
  final VoidCallback onTap;
  final String label;
  final Widget Function(bool hovered) builder;

  const _Hoverable({
    required this.onTap,
    required this.label,
    required this.builder,
  });

  @override
  State<_Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<_Hoverable> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.label,
      excludeSemantics: true,
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowHoverHighlight: (h) => setState(() => _hovered = h),
        onShowFocusHighlight: (f) => setState(() => _hovered = f),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onTap();
              return null;
            },
          ),
        },
        child: GestureDetector(
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: widget.builder(_hovered),
        ),
      ),
    );
  }
}

TextStyle _titleStyle(bool hovered) => AppText.bodyL.copyWith(
  fontWeight: FontWeight.w700,
  height: 1.25,
  decoration: hovered ? TextDecoration.underline : null,
);

void _open(BuildContext context, Note note) =>
    context.findAncestorStateOfType<_NotesPadState>()!.open(note);

class _ZoomCover extends StatefulWidget {
  final Rect from;
  final VoidCallback onCovered;

  const _ZoomCover({required this.from, required this.onCovered});

  @override
  State<_ZoomCover> createState() => _ZoomCoverState();
}

class _ZoomCoverState extends State<_ZoomCover>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Motion.zoom,
  );
  late final Animation<double> _t = CurvedAnimation(
    parent: _controller,
    curve: MotionCurves.standard,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward().whenComplete(widget.onCovered);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Rect to = Offset.zero & constraints.biggest;
        return AnimatedBuilder(
          animation: _t,
          builder: (context, _) {
            final rect = Rect.lerp(widget.from, to, _t.value)!;
            return Stack(
              children: [
                Positioned.fromRect(
                  rect: rect,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: RouteInk.blog.ink,
                      borderRadius: BorderRadius.circular(
                        Radii.tile * (1 - _t.value),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
