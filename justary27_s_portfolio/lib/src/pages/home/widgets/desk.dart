import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

import '../../../components/app_link.dart';
import '../../../components/engraved_pencil.dart';
import '../../../components/fit.dart';
import '../../../components/hand_note.dart';
import '../../../components/landing.dart';
import '../../../components/ink_on_view.dart';
import '../../../components/polaroid.dart';
import '../../../components/tape_strip.dart';
import '../../../constants/route.dart';
import '../../../enums/layout.dart';
import '../../../models/desk.dart';
import '../../../themes/colors.dart';
import '../../../themes/dimens.dart';
import '../../../themes/motion.dart';
import '../../../themes/route_ink.dart';
import '../../../themes/typography.dart';
import '../data.dart';
import 'desk_art.dart';
import 'desk_painters.dart';

const Size _deskStage = Size(1280, 720);
// Portrait tablets get a taller desk with the objects rearranged.
const Size _tabletStage = Size(768, 1040);
const double _tabletMaxScale = 1.25;
const double _deg = pi / 180;
const Duration _objectLift = Duration(milliseconds: 160);

class Desk extends StatefulWidget {
  final Size size;

  const Desk({super.key, required this.size});

  @override
  State<Desk> createState() => _DeskState();
}

class _DeskState extends State<Desk> {
  static const int _sipsToEmpty = 5;

  final FocusNode _focusNode = FocusNode(debugLabel: "Desk");
  DeskPeek? _peek;
  int _sips = 0;
  bool _showCoffeeNote = false;
  Timer? _refillTimer;

  @override
  void dispose() {
    _refillTimer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _togglePeek(DeskPeek peek) {
    setState(() => _peek = _peek == peek ? null : peek);
    if (_peek != null) _focusNode.requestFocus();
  }

  void _closePeek() {
    if (_peek != null) setState(() => _peek = null);
  }

  void _sip() {
    final sips = _sips + 1;
    setState(() {
      _peek = null;
      _sips = min(sips, _sipsToEmpty);
      _showCoffeeNote = sips >= _sipsToEmpty;
    });
    if (sips >= _sipsToEmpty) {
      _refillTimer?.cancel();
      _refillTimer = Timer(const Duration(milliseconds: 2200), () {
        setState(() {
          _sips = 0;
          _showCoffeeNote = false;
        });
      });
    }
  }

  double _liftFor(DeskPeek peek) => _peek == peek ? -8 : 0;

  @override
  Widget build(BuildContext context) {
    final sidePadding = max(Space.s16, 0.04 * widget.size.width);
    // The stage gives up height first so the desk, its heading included,
    // fits under the navbar; never below 0.6 so the objects stay tappable.
    final stage = _stage;
    final scale = min(
      min(_compact ? _tabletMaxScale : 1.0, widget.size.width / stage.width),
      max(0.6, (Fit.room(context) - 150) / stage.height),
    );
    _scale = scale;
    final ink = RouteInk.of(context);

    return TapRegion(
      onTapOutside: (_) => _closePeek(),
      child: Padding(
        padding: const EdgeInsets.only(top: 64),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sidePadding),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1152),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "On my desk",
                        style: AppText.h2.copyWith(
                          color: ink.ink,
                          fontSize: (0.04 * widget.size.width).clamp(
                            28.0,
                            40.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("Pick something up.", style: AppText.body),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: widget.size.width,
              height: stage.height * scale,
              child: Stack(
                children: [
                  Positioned.fill(child: _buildBackdrop(scale)),
                  Center(
                    child: SizedBox(
                      width: stage.width * scale,
                      height: stage.height * scale,
                      child: FittedBox(
                        child: Focus(
                          focusNode: _focusNode,
                          onKeyEvent: (node, event) {
                            if (event is KeyDownEvent &&
                                event.logicalKey == LogicalKeyboardKey.escape &&
                                _peek != null) {
                              _closePeek();
                              return KeyEventResult.handled;
                            }
                            return KeyEventResult.ignored;
                          },
                          child: SizedBox(
                            width: stage.width,
                            height: stage.height,
                            child: _buildStage(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Runs edge to edge; only the objects stay in the centred stage.
  Widget _buildBackdrop(double scale) {
    final margin = (widget.size.width / scale - _stage.width) / 2;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _closePeek,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 240 * scale,
            child: InkOnView(
              duration: Motion.skylineDraw,
              curve: Curves.easeOut,
              viewportFraction: 0.85,
              builder: (context, ink) {
                return CustomPaint(
                  painter: SkylinePainter(
                    progress: ink,
                    margin: margin,
                    scale: scale,
                    stageWidth: _stage.width,
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 234 * scale,
            bottom: 0,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.deskLine)),
              ),
              child: CustomPaint(painter: DeskGridPainter(scale: scale)),
            ),
          ),
        ],
      ),
    );
  }

  // Tablet and phone share the tall desk; phone scales it down further.
  bool get _compact => Layout.of(MediaQuery.sizeOf(context)).isCompact;
  bool get _phone => Layout.of(MediaQuery.sizeOf(context)).isPhone;
  // The stage's scale from the last build, for the phone's peek card.
  double _scale = 1;
  Size get _stage => _compact ? _tabletStage : _deskStage;

  Offset _peekFrom(DeskPeek p) =>
      _compact ? p.tabletFrom : Offset(p.fromX, p.fromY);
  Offset _peekCard(DeskPeek p) =>
      _compact ? p.tabletCard : Offset(p.cardX, 262);

  Widget _buildStage() {
    final peek = _peek;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _closePeek,
          ),
        ),
        ..._buildPersonalObjects(),
        if (peek != null) ...[
          // A phone has no room for the dashed link; its card sits at the
          // left edge instead, scaled back up to a readable size.
          if (!_phone)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: PeekLinkPainter(
                    from: _peekFrom(peek),
                    to: Offset(
                      _peekCard(peek).dx +
                          (_peekFrom(peek).dx <
                                  (_compact ? _peekCard(peek).dx : 600)
                              ? 0
                              : _PeekCard.width),
                      _peekCard(peek).dy + 68,
                    ),
                  ),
                ),
              ),
            ),
        ],
        ..._buildPageObjects(),
        // Last, so the open card sits over every object on the desk.
        if (peek != null)
          Positioned(
            left: _phone ? 24 : _peekCard(peek).dx,
            top: _peekCard(peek).dy,
            child: Transform.scale(
              scale: _phone ? 1 / _scale : 1,
              alignment: Alignment.topLeft,
              child: _PeekCard(
                key: ValueKey(peek),
                peek: peek,
                onClose: _closePeek,
              ),
            ),
          ),
      ],
    );
  }

  // Desk coordinates, or the tablet board's for the same object.
  double at(double desk, double compact) => _compact ? compact : desk;

  List<Widget> _buildPersonalObjects() {
    return [
      _DeskObject(
        left: at(96, 290),
        top: at(260, 318),
        angle: -4,
        label: "Coffee",
        onTap: _sip,
        child: SvgPicture.string(DeskArt.coffee(_sips), width: 96, height: 150),
      ),
      if (_showCoffeeNote)
        Positioned(
          left: at(40, 230),
          top: at(430, 486),
          child: const HandNote(
            "that's enough caffeine for today",
            style: AppText.handMedium,
            angle: -4 * _deg,
          ),
        ),
      _DeskObject(
        left: at(222, 84),
        top: at(280, 852),
        angle: -14,
        lift: _liftFor(DeskData.music),
        label: "Headphones: on repeat",
        onTap: () => _togglePeek(DeskData.music),
        child: SvgPicture.string(DeskArt.headphones, width: 120, height: 110),
      ),
      _Caption("on repeat", left: at(236, 100), top: at(398, 968)),
      _DeskObject(
        left: at(56, 300),
        top: at(496, 862),
        angle: -10,
        lift: _liftFor(DeskData.game),
        label: "Controller: currently playing",
        onTap: () => _togglePeek(DeskData.game),
        child: SvgPicture.string(DeskArt.controller, width: 150, height: 110),
      ),
      _Caption("playing", left: at(92, 340), top: at(610, 980)),
      _DeskObject(
        left: at(224, 504),
        top: at(472, 840),
        angle: -3,
        lift: _liftFor(DeskData.sketch),
        label: "Sketchbook",
        onTap: () => _togglePeek(DeskData.sketch),
        child: const _Sketchbook(),
      ),
      _Caption("sketchbook", left: at(270, 552), top: at(632, 998)),
      _DeskObject(
        left: at(776, 84),
        top: at(502, 590),
        angle: 5,
        lift: _liftFor(DeskData.places),
        label: "Polaroid: places and plates",
        onTap: () => _togglePeek(DeskData.places),
        child: const Polaroid(caption: "Roorkee"),
      ),
      _DeskObject(
        left: at(892, 204),
        top: at(520, 608),
        angle: -4,
        lift: _liftFor(DeskData.places),
        label: "Polaroid: places and plates",
        onTap: () => _togglePeek(DeskData.places),
        child: const Polaroid(caption: "Bengaluru"),
      ),
      Positioned(
        left: at(912, 226),
        top: at(510, 598),
        child: const IgnorePointer(child: TapeStrip(angle: -12 * _deg)),
      ),
      _Caption("places & plates", left: at(690, 150), top: at(676, 796)),
    ];
  }

  List<Widget> _buildPageObjects() {
    return [
      _DeskObject(
        left: at(760, 70),
        top: at(256, 272),
        angle: -7,
        label: "Notebook: Who",
        to: "${RouteHandler.whoPage}#${Landing.who}",
        child: const _Notebook(),
      ),
      _PagePill(
        label: "Who →",
        left: at(772, 82),
        top: at(246, 262),
        to: "${RouteHandler.whoPage}#${Landing.who}",
      ),
      _DeskObject(
        left: at(948, 404),
        top: at(260, 290),
        angle: 2,
        label: "Laptop: Work",
        to: "${RouteHandler.workPage}#${Landing.work}",
        child: const _Laptop(),
      ),
      _PagePill(
        label: "Work →",
        left: at(1130, 586),
        top: at(246, 276),
        to: "${RouteHandler.workPage}#${Landing.work}",
      ),
      _DeskObject(
        left: at(1052, 446),
        top: at(506, 590),
        angle: 6,
        label: "iPad: Blog",
        to: "${RouteHandler.blogPage}#${Landing.blog}",
        child: const _DeskIpad(),
      ),
      _PagePill(
        label: "Blog →",
        left: at(1182, 576),
        top: at(498, 582),
        to: "${RouteHandler.blogPage}#${Landing.blog}",
      ),
    ];
  }
}

class _DeskObject extends StatefulWidget {
  final double left;
  final double top;
  final double angle;
  final double lift;
  final String label;
  final VoidCallback? onTap;
  final String? to;
  final Widget child;

  const _DeskObject({
    required this.left,
    required this.top,
    required this.angle,
    required this.label,
    required this.child,
    this.onTap,
    this.to,
    this.lift = 0,
  });

  @override
  State<_DeskObject> createState() => _DeskObjectState();
}

class _DeskObjectState extends State<_DeskObject> {
  bool _isHovered = false;
  bool _isFocused = false;

  Widget _buildFace({required bool isRaised}) {
    return ExcludeSemantics(
      child: _DropShadow(raised: isRaised, child: widget.child),
    );
  }

  Widget _buildObject() {
    final to = widget.to;
    if (to != null) {
      return AppLink(
        to: to,
        label: widget.label,
        fadeOnHover: false,
        builder: (context, states) {
          return _buildFace(
            isRaised:
                states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused),
          );
        },
      );
    }

    return Semantics(
      button: true,
      label: widget.label,
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onTap!();
              return null;
            },
          ),
        },
        onShowHoverHighlight: (value) => setState(() => _isHovered = value),
        onShowFocusHighlight: (value) => setState(() => _isFocused = value),
        child: GestureDetector(
          onTap: widget.onTap,
          child: _buildFace(isRaised: _isHovered || _isFocused),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: Transform.rotate(
        angle: widget.angle * _deg,
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: widget.lift),
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : _objectLift,
          curve: Curves.easeOut,
          builder: (context, lift, child) {
            return Transform.translate(offset: Offset(0, lift), child: child);
          },
          child: _buildObject(),
        ),
      ),
    );
  }
}

// CSS drop-shadow follows an object's outline, which BoxShadow can't do.
class _DropShadow extends StatelessWidget {
  final bool raised;
  final Widget child;

  const _DropShadow({required this.raised, required this.child});

  @override
  Widget build(BuildContext context) {
    final blur = raised ? 9.0 : 7.0;

    return RepaintBoundary(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // A second copy of the object, so it must stay invisible to input.
          IgnorePointer(
            child: ExcludeSemantics(
              child: Transform.translate(
                offset: Offset(0, raised ? 16 : 10),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      AppColors.ink900.withValues(alpha: raised ? 0.22 : 0.18),
                      BlendMode.srcIn,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  final String text;
  final double left;
  final double top;

  const _Caption(this.text, {required this.left, required this.top});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: IgnorePointer(
        child: HandNote(
          text,
          style: AppText.handSmall.copyWith(fontSize: 22),
          color: AppColors.ink500,
        ),
      ),
    );
  }
}

class _PagePill extends StatelessWidget {
  final String label;
  final double left;
  final double top;
  final String to;

  const _PagePill({
    required this.label,
    required this.left,
    required this.top,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: AppLink(
        to: to,
        builder: (context, states) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.ink900,
              borderRadius: BorderRadius.circular(Radii.pill),
            ),
            child: Text(
              label,
              style: AppText.label.copyWith(fontSize: 13, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

class _PeekCard extends StatelessWidget {
  static const double width = 260;

  final DeskPeek peek;
  final VoidCallback onClose;

  const _PeekCard({super.key, required this.peek, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 160),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 6 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Radii.chip),
          border: Border.all(color: AppColors.deskLine),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F0D0D0D),
              blurRadius: 28,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    peek.eyebrow.toUpperCase(),
                    style: AppText.meta.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: Space.s8),
                Text(peek.title, style: AppText.h3.copyWith(height: 1.15)),
                const SizedBox(height: Space.s8),
                Text(
                  peek.body,
                  style: AppText.body.copyWith(fontSize: 15, height: 1.4),
                ),
                if (peek.linkLabel != null) ...[
                  const SizedBox(height: Space.s8),
                  AppLink(
                    to: peek.linkUrl!,
                    builder: (context, states) {
                      return Text(
                        peek.linkLabel!,
                        style: AppText.label.copyWith(fontSize: 15),
                      );
                    },
                  ),
                ],
              ],
            ),
            Positioned(
              right: -12,
              top: -12,
              child: InkWell(
                onTap: onClose,
                customBorder: const CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, size: 18, color: AppColors.ink500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Sketchbook extends StatelessWidget {
  const _Sketchbook();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: 196,
        height: 148,
        child: Stack(
          children: [
            const Positioned.fill(child: ColoredBox(color: AppColors.paper)),
            const Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 14,
              child: ColoredBox(color: Color(0xFFDADADA)),
            ),
            Positioned.fill(child: SvgPicture.string(DeskArt.sketchbook)),
          ],
        ),
      ),
    );
  }
}

class _Notebook extends StatelessWidget {
  const _Notebook();

  static const Color _cover = AppColors.whoAccentSoft;
  static const Color _spine = Color(0xFF8FA2EE);

  @override
  Widget build(BuildContext context) {
    final ink = RouteInk.who.ink;

    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(6),
        right: Radius.circular(14),
      ),
      child: SizedBox(
        width: 196,
        height: 256,
        child: Stack(
          children: [
            const Positioned.fill(child: ColoredBox(color: _cover)),
            const Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 12,
              child: ColoredBox(color: _spine),
            ),
            Positioned(
              left: 32,
              top: 28,
              child: Text(
                "Who?",
                style: AppText.handLarge.copyWith(color: ink),
              ),
            ),
            Positioned(
              left: 32,
              top: 82,
              child: Text(
                "field notes · 2020 →",
                style: AppText.label.copyWith(fontSize: 12, color: ink),
              ),
            ),
            Positioned(
              left: 32,
              right: 22,
              bottom: 28,
              height: 44,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "ARYAN R.",
                  style: AppText.label.copyWith(fontSize: 11, color: ink),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Laptop extends StatelessWidget {
  const _Laptop();

  @override
  Widget build(BuildContext context) {
    final ink = RouteInk.work.ink;

    return SizedBox(
      width: 290,
      height: 188,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: RouteInk.work.navbar,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Work.",
                    style: AppText.handLarge.copyWith(
                      fontSize: 42,
                      height: 1,
                      color: ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "8club · Repello · Amazon · GSoC",
                    style: AppText.label.copyWith(fontSize: 11, color: ink),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -16,
            right: -16,
            bottom: -14,
            height: 16,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF3A3A3A),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeskIpad extends StatelessWidget {
  const _DeskIpad();

  static const double _width = 196;

  @override
  Widget build(BuildContext context) {
    final red = RouteInk.blog.ink;

    return SizedBox(
      width: _width,
      height: 144,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0.06 * _width,
            bottom: 143,
            child: const EngravedPencil(width: 0.6 * _width),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(18),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: ColoredBox(
                color: const Color(0xFFF5F8F8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 46,
                      color: red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Blog.",
                        style: AppText.handMedium.copyWith(
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LATEST POST",
                            style: AppText.label.copyWith(
                              fontSize: 8,
                              letterSpacing: 0.96,
                              color: red,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            DeskData.latestPostTitle,
                            style: AppText.label.copyWith(
                              fontSize: 12,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            DeskData.latestPostMeta,
                            style: AppText.body.copyWith(
                              fontSize: 9,
                              height: 1.2,
                              color: AppColors.ink500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
