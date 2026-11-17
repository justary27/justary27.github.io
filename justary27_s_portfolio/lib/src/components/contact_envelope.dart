import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../constants/contact.dart';
import '../pages/home/data.dart';
import '../themes/colors.dart';
import '../themes/dimens.dart';
import '../themes/motion.dart';
import '../themes/route_ink.dart';
import '../themes/typography.dart';
import 'app_link.dart';
import 'ar_mark_painter.dart';
import 'fill_in_field.dart';
import 'topic_chip.dart';

// The navbar's Contact, from the Route Ink prototypes: an airmail envelope
// lands, flips over, its seal pops, the flap opens and a letter rises with
// the same fields as Say hi. Send folds it back and flies it off.
// [aboutPost] (a post's title) adds a topic for that post, picked by default.
Future<void> showContactEnvelope(BuildContext context, {String? aboutPost}) {
  // Opened over the whole app, so take the page's tint before leaving it.
  final ink = RouteInk.of(context);
  return showGeneralDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    transitionDuration: Duration.zero,
    pageBuilder: (context, _, _) =>
        ContactEnvelope(ink: ink, aboutPost: aboutPost),
  );
}

const Size _stage = Size(560, 320);
// How far the risen letter reaches above the envelope's top edge.
const double _letterRise = 236 - 10;
const double _fitMargin = 16;

double _fit(Size screen) => min(
  1,
  min(
    (screen.width - 2 * _fitMargin) / _stage.width,
    (screen.height - 2 * _fitMargin) / (_letterRise + _stage.height),
  ),
);
const Color _seal = Color(0xFF262626);

// When each stage starts after opening, from the prototype.
const _dropAt = Duration(milliseconds: 60);
const _turnAt = Duration(milliseconds: 760);
const _breakAt = Duration(milliseconds: 1400);
const _openAt = Duration(milliseconds: 1600);
const _outAt = Duration(milliseconds: 2000);
const _doneAt = Duration(milliseconds: 2800);

class _Sticker {
  final String label;
  final String url;
  final FaIconData icon;
  final Color color;
  final double turn;

  const _Sticker(this.label, this.url, this.icon, this.color, this.turn);
}

const List<_Sticker> _stickers = [
  _Sticker(
    "Email",
    ContactHandler.mailto,
    FontAwesomeIcons.envelope,
    Color(0xFFA81D13),
    -8,
  ),
  _Sticker(
    "LinkedIn",
    ContactHandler.linkedin,
    FontAwesomeIcons.linkedin,
    Color(0xFF0A66C2),
    -4,
  ),
  _Sticker(
    "GitHub",
    ContactHandler.github,
    FontAwesomeIcons.github,
    AppColors.ink900,
    6,
  ),
  _Sticker(
    "X",
    ContactHandler.x,
    FontAwesomeIcons.xTwitter,
    AppColors.ink900,
    9,
  ),
  _Sticker(
    "Instagram",
    ContactHandler.instagram,
    FontAwesomeIcons.instagram,
    Color(0xFFC13584),
    -10,
  ),
  _Sticker(
    "YouTube",
    ContactHandler.youtube,
    FontAwesomeIcons.youtube,
    Color(0xFFFF0000),
    5,
  ),
];

class ContactEnvelope extends StatefulWidget {
  final RouteInk ink;
  // The post a "Write back" came from; goes out with the message once the
  // contact endpoint lands.
  final String? aboutPost;

  const ContactEnvelope({super.key, required this.ink, this.aboutPost});

  @override
  State<ContactEnvelope> createState() => _ContactEnvelopeState();
}

class _ContactEnvelopeState extends State<ContactEnvelope> {
  static final RegExp _emailPattern = RegExp(r'^\S+@\S+\.\S+$');

  final TextEditingController _name = TextEditingController();
  final TextEditingController _company = TextEditingController();
  final TextEditingController _email = TextEditingController();
  // Undecided copy for the post's own topic.
  late final List<String> _topics = [
    if (widget.aboutPost != null) "<placeholder>",
    ...SayHiData.topics,
  ];
  int _topic = 0;
  String _error = "";

  bool _drop = false;
  bool _turned = false;
  bool _broke = false;
  bool _open = false;
  // The flap passes behind the letter 220 ms into opening (and back again).
  bool _flapBehind = false;
  bool _out = false;
  bool _done = false;
  bool _sent = false;
  bool _flyAway = false;
  bool _thanks = false;
  final List<Timer> _timers = [];

  bool get _still => MediaQuery.disableAnimationsOf(context);

  Duration _d(int ms) => _still ? Duration.zero : Duration(milliseconds: ms);

  void _at(Duration when, VoidCallback step) =>
      _timers.add(Timer(when, () => mounted ? setState(step) : null));

  @override
  void initState() {
    super.initState();
    _at(_dropAt, () => _drop = true);
    _at(_turnAt, () => _turned = true);
    _at(_breakAt, () => _broke = true);
    _at(_openAt, () => _setOpen(true));
    _at(_outAt, () => _out = true);
    _at(_doneAt, () => _done = true);
  }

  void _setOpen(bool open) {
    _open = open;
    _timers.add(
      Timer(const Duration(milliseconds: 220), () {
        if (mounted) setState(() => _flapBehind = open);
      }),
    );
  }

  @override
  void dispose() {
    for (final t in _timers) {
      t.cancel();
    }
    _name.dispose();
    _company.dispose();
    _email.dispose();
    super.dispose();
  }

  void _close() => Navigator.of(context).pop();

  void _send() {
    if (_sent) return;
    if (_name.text.trim().isEmpty) {
      setState(() => _error = "Add your name first.");
      return;
    }
    if (!_emailPattern.hasMatch(_email.text.trim())) {
      setState(() => _error = "Add an email I can reply to.");
      return;
    }
    // Letter back in, flap shut, seal back on, then off it goes.
    setState(() {
      _error = "";
      _sent = true;
      _done = false;
      _out = false;
    });
    _at(const Duration(milliseconds: 450), () => _setOpen(false));
    _at(const Duration(milliseconds: 800), () => _broke = false);
    _at(const Duration(milliseconds: 900), () => _flyAway = true);
    _at(const Duration(milliseconds: 1500), () => _thanks = true);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return CallbackShortcuts(
      bindings: {const SingleActivator(LogicalKeyboardKey.escape): _close},
      child: Focus(
        autofocus: true,
        child: Semantics(
          scopesRoute: true,
          explicitChildNodes: true,
          label: "Contact Aryan",
          child: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _close,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: _d(300),
                      builder: (context, a, _) => BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2 * a, sigmaY: 2 * a),
                        child: ColoredBox(
                          color: AppColors.ink900.withValues(alpha: .45 * a),
                        ),
                      ),
                    ),
                  ),
                ),
                // The envelope and the letter risen out of it are centred
                // together, and scaled down when the window can't fit them.
                // Loose and unbounded so the window never resizes the stage before
                // it's scaled, which would pull it off centre.
                Positioned.fill(
                  child: OverflowBox(
                    minWidth: 0,
                    minHeight: 0,
                    maxWidth: double.infinity,
                    maxHeight: double.infinity,
                    child: Transform.scale(
                      scale: _fit(size),
                      child: SizedBox(
                        width: _stage.width,
                        height: _letterRise + _stage.height,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 0,
                              top: _letterRise,
                              width: _stage.width,
                              height: _stage.height,
                              child: _envelope(size),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: size.height * .44,
                  child: _thanksNote(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Lands from below with a bounce; after sending, flies off up and right.
  Widget _envelope(Size screen) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: _drop ? 1 : 0),
      duration: _d(560),
      curve: const Cubic(.3, 1.35, .5, 1),
      builder: (context, p, child) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: _flyAway ? 1 : 0),
        duration: _d(700),
        curve: const Cubic(.6, -.2, .7, .6),
        builder: (context, q, child) {
          final dx = q * .7 * screen.width;
          final dy = (1 - p) * 1.1 * screen.height - q * .9 * screen.height;
          final turn = lerpDouble(lerpDouble(-14, -2, p)!, 28, q)!;
          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.rotate(angle: turn * pi / 180, child: child),
          );
        },
        child: child,
      ),
      // The front squeezes shut, then the back opens out.
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: _turned ? 1 : 0),
        duration: _d(520),
        builder: (context, t, _) {
          final front = 1 - Curves.easeIn.transform(min(1, t * 2));
          final back = Curves.easeIn.transform(max(0, t * 2 - 1));
          return Stack(
            clipBehavior: Clip.none,
            children: [
              if (front > 0)
                Positioned.fill(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.diagonal3Values(front, 1, 1),
                    child: _Front(ink: widget.ink),
                  ),
                ),
              Positioned.fill(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.diagonal3Values(back, 1, 1),
                  child: IgnorePointer(ignoring: back < 1, child: _back()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _back() {
    final ink = widget.ink;
    final pocket = Positioned.fill(child: _Pocket(ink: ink));
    final stickers = Positioned(
      left: 22,
      bottom: 18,
      child: Row(
        spacing: 10,
        children: [
          for (int i = 0; i < _stickers.length; i++)
            _StickerView(
              sticker: _stickers[i],
              shown: _done,
              delay: i * 60,
              still: _still,
            ),
        ],
      ),
    );
    final flap = Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: .6 * _stage.height,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: _open ? 1 : 0),
        duration: _d(450),
        curve: Curves.ease,
        builder: (context, a, child) => Transform(
          alignment: Alignment.topCenter,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 1 / 900)
            ..rotateX(pi * a),
          child: child,
        ),
        child: ClipPath(
          clipper: _FlapClipper(),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ink.envelopeFlap, ink.envelopeFlapShade],
              ),
            ),
          ),
        ),
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ink.envelopeBody,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        if (_flapBehind) flap,
        // Once the letter is out it rests over the pocket and stickers.
        if (_done) ...[pocket, stickers],
        Positioned(
          left: 28,
          right: 28,
          top: 10,
          height: 330,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: _out ? 1 : 0),
            duration: _d(_sent ? 500 : 800),
            curve: const Cubic(.25, 1.3, .5, 1),
            builder: (context, a, child) => Transform.translate(
              offset: Offset(0, -236 * a),
              child: Transform.rotate(angle: -2 * a * pi / 180, child: child),
            ),
            child: _letter(),
          ),
        ),
        if (!_done) ...[pocket, stickers],
        if (!_flapBehind) flap,
        Positioned(
          left: _stage.width / 2 - 32,
          top: .6 * _stage.height - 36,
          child: _Seal(broke: _broke, paper: ink.envelopePaper, d: _d),
        ),
      ],
    );
  }

  Widget _letter() {
    final ink = widget.ink;
    final body = AppText.body.copyWith(fontSize: 15, color: AppColors.ink700);
    return AnimatedContainer(
      duration: _d(200),
      decoration: BoxDecoration(
        color: ink.envelopeLetter,
        border: Border.all(color: const Color(0xFFE6DFCE)),
        boxShadow: _done
            ? const [
                BoxShadow(
                  color: Color(0x730D0D0D),
                  offset: Offset(0, 18),
                  blurRadius: 30,
                  spreadRadius: -16,
                ),
              ]
            : null,
      ),
      child: CustomPaint(
        painter: const _LetterPainter(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "Hey Aryan,",
                    style: AppText.handLarge.copyWith(
                      fontSize: 32,
                      height: 1,
                      color: AppColors.ink900,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    spacing: Space.s8,
                    children: [
                      Text("I'm", style: body),
                      Expanded(
                        child: FillInField(
                          controller: _name,
                          hint: "your name",
                          label: "Your name",
                          onChanged: (_) => _clearError(),
                        ),
                      ),
                      Text("from", style: body),
                      Expanded(
                        child: FillInField(
                          controller: _company,
                          hint: "company",
                          label: "Company",
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text("and I'd like to talk about", style: body),
                      for (int i = 0; i < _topics.length; i++)
                        TopicChip(
                          label: _topics[i],
                          isSelected: i == _topic,
                          onTap: () => setState(() => _topic = i),
                          compact: true,
                        ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    spacing: Space.s8,
                    children: [
                      Text("Reply to", style: body),
                      Expanded(
                        child: FillInField(
                          controller: _email,
                          hint: "your email",
                          label: "Your email",
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.send,
                          onChanged: (_) => _clearError(),
                          onSubmitted: (_) => _send(),
                        ),
                      ),
                    ],
                  ),
                  Semantics(
                    liveRegion: true,
                    child: SizedBox(
                      height: 16,
                      child: Text(
                        _error,
                        style: AppText.body.copyWith(
                          fontSize: 12,
                          color: RouteInk.blog.ink,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 10,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: _TimeQuote(color: ink.ink, still: _still),
                      ),
                      const Spacer(),
                      Text(
                        "fold & send →",
                        style: AppText.handSmall.copyWith(
                          fontSize: 19,
                          color: AppColors.ink500,
                        ),
                      ),
                      _Pill(label: "Send", dark: true, onTap: _send),
                    ],
                  ),
                ],
              ),
            ),
            // Tape on top and a coffee ring, as on the prototype's letter.
            Positioned(
              top: -11,
              left: 0,
              right: 0,
              child: Center(
                child: Transform.rotate(
                  angle: -4 * pi / 180,
                  child: Container(
                    width: 92,
                    height: 22,
                    color: AppColors.tape.withValues(alpha: .88),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 18,
              bottom: 12,
              child: IgnorePointer(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0x298B5E34),
                      width: 3,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Semantics(
                button: true,
                label: "Close",
                child: Tooltip(
                  message: "Close",
                  child: Material(
                    color: ink.envelopeLetter,
                    shape: const CircleBorder(
                      side: BorderSide(color: AppColors.ink900, width: 1.5),
                    ),
                    child: InkWell(
                      onTap: _close,
                      customBorder: const CircleBorder(),
                      child: const SizedBox.square(
                        dimension: 36,
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: AppColors.ink900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearError() {
    if (_error.isNotEmpty) setState(() => _error = "");
  }

  Widget _thanksNote() {
    return IgnorePointer(
      ignoring: !_thanks,
      child: AnimatedOpacity(
        duration: _d(400),
        opacity: _thanks ? 1 : 0,
        child: AnimatedSlide(
          duration: _d(400),
          offset: _thanks ? Offset.zero : const Offset(0, .1),
          child: Column(
            children: [
              Text(
                "Sent. I'll write back soon.",
                style: AppText.handLarge.copyWith(
                  fontSize: 44,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  SayHiData.deliveredNote,
                  style: AppText.body.copyWith(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: .85),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _Pill(label: "Close", dark: false, onTap: _close),
            ],
          ),
        ),
      ),
    );
  }
}

// "Time is made." in his hand, in the page's ink; hovering finishes it
// (", not found!") and drops the full stop. Without a mouse it reads in full.
class _TimeQuote extends StatefulWidget {
  final Color color;
  final bool still;

  const _TimeQuote({required this.color, required this.still});

  @override
  State<_TimeQuote> createState() => _TimeQuoteState();
}

class _TimeQuoteState extends State<_TimeQuote> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final style = AppText.handSmall.copyWith(
      fontSize: 23,
      height: 1,
      color: widget.color,
    );
    final hasMouse = RendererBinding.instance.mouseTracker.mouseIsConnected;
    final open = _hovered || !hasMouse;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Transform.rotate(
        angle: -3 * pi / 180,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: open ? 1 : 0),
          duration: widget.still
              ? Duration.zero
              : const Duration(milliseconds: 480),
          curve: MotionCurves.standard,
          builder: (context, reveal, _) => Text.rich(
            TextSpan(
              text: "Time is made",
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: reveal,
                      child: Text(", not found!", style: style),
                    ),
                  ),
                ),
                // The full stop comes back only once the rest has folded away.
                if (!open && reveal == 0) const TextSpan(text: "."),
              ],
            ),
            style: style,
            maxLines: 1,
            softWrap: false,
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final bool dark;
  final VoidCallback onTap;

  const _Pill({required this.label, required this.dark, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: dark ? AppColors.ink900 : Colors.white,
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            label,
            style: AppText.label.copyWith(
              color: dark ? Colors.white : AppColors.ink900,
            ),
          ),
        ),
      ),
    );
  }
}

class _Seal extends StatelessWidget {
  final bool broke;
  final Color paper;
  final Duration Function(int ms) d;

  const _Seal({required this.broke, required this.paper, required this.d});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: d(300),
      opacity: broke ? 0 : 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: broke ? 1 : 0),
        duration: d(380),
        curve: const Cubic(.3, 1.6, .5, 1),
        builder: (context, a, child) => Transform.translate(
          offset: Offset(90 * a, -170 * a),
          child: Transform.rotate(
            angle: 40 * a * pi / 180,
            child: Transform.scale(scale: 1 - .3 * a, child: child),
          ),
        ),
        // A slightly uneven wax blob with the AR mark pressed in.
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.elliptical(30, 33),
              topRight: Radius.elliptical(34, 31),
              bottomRight: Radius.elliptical(32, 33),
              bottomLeft: Radius.elliptical(32, 31),
            ),
            gradient: const RadialGradient(
              center: Alignment(-.28, -.36),
              colors: [Color(0xFF5A5A5A), _seal, AppColors.ink900],
              stops: [0, .55, 1],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x59000000),
                offset: Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: 22,
            height: 34,
            child: CustomPaint(
              painter: ArMarkPainter(
                progress: const AlwaysStoppedAnimation(1),
                color: paper,
                strokeWidth: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StickerView extends StatelessWidget {
  final _Sticker sticker;
  final bool shown;
  final int delay;
  final bool still;

  const _StickerView({
    required this.sticker,
    required this.shown,
    required this.delay,
    required this.still,
  });

  @override
  Widget build(BuildContext context) {
    // Staggered 60 ms apart by delaying each one's start.
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: shown ? 1 : 0),
      duration: still ? Duration.zero : Duration(milliseconds: 400 + delay),
      curve: Interval(
        still ? 0 : delay / (400 + delay),
        1,
        curve: const Cubic(.3, 1.7, .5, 1),
      ),
      builder: (context, s, child) => Transform.rotate(
        angle: sticker.turn * pi / 180,
        child: Transform.scale(scale: max(0, s), child: child),
      ),
      child: AppLink(
        to: sticker.url,
        label: sticker.label,
        builder: (context, _) => Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 3),
              BoxShadow(
                color: Color(0x400D0D0D),
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: FaIcon(sticker.icon, size: 20, color: sticker.color),
        ),
      ),
    );
  }
}

class _FlapClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..lineTo(size.width, 0)
    ..lineTo(size.width / 2, size.height)
    ..close();

  @override
  bool shouldReclip(_FlapClipper oldClipper) => false;
}

// The front pocket, cut to a V under the flap, with its two fold creases.
class _Pocket extends StatelessWidget {
  final RouteInk ink;

  const _Pocket({required this.ink});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _PocketClipper(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            begin: const Alignment(-.34, -.94),
            end: const Alignment(.34, .94),
            colors: [ink.envelopePaper, ink.envelopePaper, ink.envelopePocket],
            stops: const [0, .55, 1],
          ),
        ),
        child: CustomPaint(
          painter: const _CreasePainter(),
          child: Stack(
            children: [
              Positioned(
                left: 24,
                bottom: 72,
                child: Text(
                  "or find me here ↓",
                  style: AppText.handSmall.copyWith(
                    fontSize: 19,
                    color: AppColors.ink500,
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

class _PocketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..lineTo(size.width / 2, size.height * .54)
    ..lineTo(size.width, 0)
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..close();

  @override
  bool shouldReclip(_PocketClipper oldClipper) => false;
}

class _CreasePainter extends CustomPainter {
  const _CreasePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x140D0D0D)
      ..strokeWidth = 1;
    canvas
      ..drawLine(Offset.zero, Offset(size.width, size.height), paint)
      ..drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(_CreasePainter oldDelegate) => false;
}

class _LetterPainter extends CustomPainter {
  const _LetterPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x0F0D0D0D);
    for (double y = 29; y < size.height; y += 30) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 1), paint);
    }
  }

  @override
  bool shouldRepaint(_LetterPainter oldDelegate) => false;
}

// The address side: airmail stripes in the three route inks, a Roorkee
// clock-tower stamp, a Bengaluru postmark with today's date, the address.
class _Front extends StatelessWidget {
  final RouteInk ink;

  const _Front({required this.ink});

  static const List<String> _months = [
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

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date =
        "${now.day.toString().padLeft(2, "0")} ${_months[now.month - 1]} "
        "${(now.year % 100).toString().padLeft(2, "0")}";
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ink.envelopePaper,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x800D0D0D),
                  offset: Offset(0, 24),
                  blurRadius: 40,
                  spreadRadius: -18,
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _AirmailPainter(paper: ink.envelopePaper),
          ),
        ),
        Positioned(
          right: 30,
          top: 28,
          child: Transform.rotate(
            angle: 4 * pi / 180,
            child: CustomPaint(
              foregroundPainter: _PerforationPainter(color: ink.envelopePaper),
              child: Container(
                width: 76,
                height: 92,
                color: AppColors.whoAccentSoft,
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 56,
                      height: 42,
                      child: CustomPaint(painter: _ClockTowerPainter()),
                    ),
                    Text(
                      "ROORKEE",
                      style: AppText.meta.copyWith(
                        fontSize: 9,
                        letterSpacing: .9,
                        color: RouteInk.who.ink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 78,
          top: 46,
          child: Opacity(
            opacity: .75,
            child: SizedBox(
              width: 150,
              height: 86,
              child: CustomPaint(painter: _PostmarkPainter(date: date)),
            ),
          ),
        ),
        Positioned(
          left: 150,
          top: 168,
          child: Text.rich(
            TextSpan(
              text: "Aryan Ranjan\n",
              children: [
                TextSpan(
                  text: "Bengaluru, India",
                  style: AppText.handMedium.copyWith(
                    fontSize: 24,
                    color: AppColors.ink500,
                  ),
                ),
              ],
            ),
            style: AppText.handLarge.copyWith(
              fontSize: 36,
              height: 1.1,
              color: AppColors.ink900,
            ),
          ),
        ),
      ],
    );
  }
}

// Diagonal stripes red, indigo, teal (Blog, Who, Work) in a 12 px border.
class _AirmailPainter extends CustomPainter {
  final Color paper;

  const _AirmailPainter({required this.paper});

  @override
  void paint(Canvas canvas, Size size) {
    final outer = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(6),
    );
    final ring = Path()
      ..fillType = PathFillType.evenOdd
      ..addRRect(outer)
      ..addRect((Offset.zero & size).deflate(12));
    canvas
      ..save()
      ..clipPath(ring);
    final inks = [RouteInk.blog.ink, RouteInk.who.ink, RouteInk.work.ink];
    // A -45° repeating gradient: 16 px of ink then 10 px of paper, cycled.
    canvas.rotate(pi / 4);
    final span = size.width + size.height;
    canvas.drawRect(
      Rect.fromLTWH(-span, -span, 3 * span, 3 * span),
      Paint()..color = paper,
    );
    int band = 0;
    for (double x = -span; x < 2 * span; x += 26) {
      canvas.drawRect(
        Rect.fromLTWH(x, -span, 16, 3 * span),
        Paint()..color = inks[band++ % 3],
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_AirmailPainter old) => old.paper != paper;
}

// Stamp perforations: paper-coloured dots around the edge.
class _PerforationPainter extends CustomPainter {
  final Color color;

  const _PerforationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const step = 6.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas
        ..drawCircle(Offset(x, 0), 1.6, paint)
        ..drawCircle(Offset(x, size.height), 1.6, paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas
        ..drawCircle(Offset(0, y), 1.6, paint)
        ..drawCircle(Offset(size.width, y), 1.6, paint);
    }
  }

  @override
  bool shouldRepaint(_PerforationPainter old) => old.color != color;
}

class _ClockTowerPainter extends CustomPainter {
  const _ClockTowerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 44, size.height / 34);
    final ink = RouteInk.who.ink;
    final outline = Path()
      ..moveTo(2, 32)
      ..lineTo(10, 32)
      ..lineTo(10, 24)
      ..lineTo(14, 24)
      ..lineTo(14, 16)
      ..lineTo(18, 16)
      ..arcToPoint(const Offset(26, 16), radius: const Radius.circular(4))
      ..lineTo(30, 16)
      ..lineTo(30, 24)
      ..lineTo(34, 24)
      ..lineTo(34, 32)
      ..lineTo(42, 32);
    canvas.drawPath(
      outline,
      Paint()
        ..color = ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawPath(
      Path()
        ..moveTo(18, 16)
        ..arcToPoint(const Offset(26, 16), radius: const Radius.circular(4))
        ..close(),
      Paint()..color = ink,
    );
  }

  @override
  bool shouldRepaint(_ClockTowerPainter oldDelegate) => false;
}

class _PostmarkPainter extends CustomPainter {
  final String date;

  const _PostmarkPainter({required this.date});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 120, size.height / 70);
    const ink = Color(0xFF3A3A3A);
    final line = Paint()
      ..color = ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.drawCircle(const Offset(40, 35), 27, line);
    void text(String s, double y, FontWeight w) {
      final tp = TextPainter(
        text: TextSpan(
          text: s,
          style: TextStyle(
            fontFamily: AppFonts.text,
            fontSize: 7,
            fontWeight: w,
            color: ink,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(40 - tp.width / 2, y - tp.height + 1.5));
    }

    text("BENGALURU", 31, FontWeight.w900);
    text(date, 43, FontWeight.w400);
    // Cancellation waves to the right of the ring.
    for (final y in [22.0, 34.0, 46.0]) {
      final wave = Path()..moveTo(70, y);
      for (int i = 0; i < 3; i++) {
        final x = 70.0 + i * 16;
        wave
          ..cubicTo(x + 8 / 3 * 1, y - 5, x + 8 / 3 * 2, y - 5, x + 8, y)
          ..cubicTo(x + 8 + 8 / 3, y + 5, x + 8 + 16 / 3, y + 5, x + 16, y);
      }
      canvas.drawPath(wave, line);
    }
  }

  @override
  bool shouldRepaint(_PostmarkPainter old) => old.date != date;
}
