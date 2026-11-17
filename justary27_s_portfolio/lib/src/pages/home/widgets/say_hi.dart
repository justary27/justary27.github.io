import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

import '../../../components/app_link.dart';
import '../../../components/fill_in_field.dart';
import '../../../components/hand_note.dart';
import '../../../components/pill_button.dart';
import '../../../components/ruled_paper_painter.dart';
import '../../../components/tape_strip.dart';
import '../../../components/topic_chip.dart';
import '../../../constants/contact.dart';
import '../../../enums/layout.dart';
import '../../../themes/colors.dart';
import '../../../themes/dimens.dart';
import '../../../themes/motion.dart';
import '../../../themes/route_ink.dart';
import '../../../themes/typography.dart';
import '../data.dart';

const double _deg = pi / 180;

class SayHi extends StatelessWidget {
  // Below this the two columns would squeeze the letter, so they stack.
  static const double _sideBySideMinWidth = 1100;

  final Size size;

  const SayHi({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final sidePadding = max(Space.s16, 0.04 * size.width);
    final isSideBySide = size.width >= _sideBySideMinWidth;

    final vh = MediaQuery.sizeOf(context).height;
    // Tablet: one column, tighter around it so the letter fits the screen.
    final compact = Layout.of(MediaQuery.sizeOf(context)).isCompact;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        sidePadding,
        compact ? 40 : (0.05 * vh).clamp(24, 96),
        sidePadding,
        compact ? 48 : (0.06 * vh).clamp(32, 120),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152),
          child: isSideBySide
              ? const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 420, child: _Intro()),
                    SizedBox(width: 48),
                    Expanded(child: _LetterDesk()),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Intro(topPadding: compact ? 0 : Space.s40),
                    SizedBox(height: compact ? 12 : 48),
                    const _LetterDesk(),
                  ],
                ),
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  final double topPadding;

  const _Intro({this.topPadding = Space.s40});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Say hi.",
            style: AppText.h2.copyWith(
              fontSize: (0.04 * MediaQuery.sizeOf(context).width).clamp(
                28.0,
                40.0,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            SayHiData.pitch,
            style: AppText.bodyL.copyWith(
              color: AppColors.ink700,
              fontSize: Layout.of(MediaQuery.sizeOf(context)).isPhone
                  ? 17
                  : null,
            ),
          ),
          const SizedBox(height: 18),
          const _EmailLine(),
        ],
      ),
    );
  }
}

class _EmailLine extends StatefulWidget {
  const _EmailLine();

  @override
  State<_EmailLine> createState() => _EmailLineState();
}

class _EmailLineState extends State<_EmailLine> {
  bool _isCopied = false;
  Timer? _resetTimer;

  Future<void> _copy() async {
    await Clipboard.setData(const ClipboardData(text: ContactHandler.email));
    if (!mounted) return;
    setState(() => _isCopied = true);
    _resetTimer?.cancel();
    _resetTimer = Timer(const Duration(milliseconds: 2400), () {
      setState(() => _isCopied = false);
    });
  }

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Space.s8,
      runSpacing: Space.s8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text("or email me at", style: AppText.body.copyWith(height: 1)),
        AppLink(
          to: ContactHandler.mailto,
          builder: (context, states) {
            return Text(
              ContactHandler.email,
              style: AppText.body.copyWith(
                height: 1,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.ink700,
              ),
            );
          },
        ),
        InkWell(
          onTap: _copy,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Space.s8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.ink300, width: 1.5),
            ),
            child: Text(
              _isCopied ? "Copied" : "Copy",
              style: AppText.label.copyWith(fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}

class _LetterDesk extends StatefulWidget {
  const _LetterDesk();

  @override
  State<_LetterDesk> createState() => _LetterDeskState();
}

class _LetterDeskState extends State<_LetterDesk> {
  bool get phone => Layout.of(MediaQuery.sizeOf(context)).isPhone;

  static final RegExp _emailPattern = RegExp(r'^\S+@\S+\.\S+$');

  final TextEditingController _name = TextEditingController();
  final TextEditingController _company = TextEditingController();
  final TextEditingController _message = TextEditingController();
  final TextEditingController _email = TextEditingController();
  int _topic = 0;
  String _error = "";
  bool _isSent = false;
  bool _isDelivered = false;
  Timer? _deliveryTimer;

  @override
  void dispose() {
    _deliveryTimer?.cancel();
    _name.dispose();
    _company.dispose();
    _message.dispose();
    _email.dispose();
    super.dispose();
  }

  void _clearError(String _) {
    if (_error.isNotEmpty) setState(() => _error = "");
  }

  void _send() {
    if (_isSent) return;
    if (_name.text.trim().isEmpty) {
      setState(() => _error = "Add your name first.");
      return;
    }
    if (!_emailPattern.hasMatch(_email.text.trim())) {
      setState(() => _error = "Add an email I can reply to.");
      return;
    }
    setState(() {
      _error = "";
      _isSent = true;
    });
    _deliveryTimer = Timer(_foldDuration, () {
      setState(() => _isDelivered = true);
    });
  }

  void _writeAnother() {
    _name.clear();
    _company.clear();
    _message.clear();
    _email.clear();
    setState(() {
      _topic = 0;
      _isSent = false;
      _isDelivered = false;
    });
  }

  Duration get _foldDuration =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : Motion.zoom;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final letterWidth = min(560.0, width);

        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: phone ? 470 : 540),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: phone ? 6 : 0,
                top: 0,
                width: phone ? 0.74 * width : min(440, 0.9 * width),
                child: const _Postcard(),
              ),
              // Phone tucks the letter higher, under a narrower postcard.
              Padding(
                padding: EdgeInsets.only(top: phone ? 64 : 96),
                child: _foldingLetter(letterWidth),
              ),
              if (_isDelivered)
                Positioned(
                  left: 0,
                  top: 170,
                  child: _Delivered(onWriteAnother: _writeAnother),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _foldingLetter(double width) {
    return IgnorePointer(
      ignoring: _isSent,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: _isSent ? 1 : 0),
        duration: _foldDuration,
        curve: MotionCurves.standard,
        builder: (context, fold, child) {
          final scale = 1 - 0.65 * fold;
          return Opacity(
            opacity: 1 - fold,
            child: Transform.translate(
              offset: Offset(0.4 * width * fold, -60 * fold),
              child: Transform.rotate(
                angle: (-2 + 6 * fold) * _deg,
                child: Transform.scale(scale: scale, child: child),
              ),
            ),
          );
        },
        child: SizedBox(width: width, child: _buildLetter()),
      ),
    );
  }

  Widget _buildLetter() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                color: Color(0x290D0D0D),
                blurRadius: 26,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CustomPaint(
              painter: const RuledPaperPainter(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: phone ? 20 : 36,
                  vertical: phone ? 22 : 30,
                ),
                child: _buildFields(),
              ),
            ),
          ),
        ),
        const Positioned(
          left: 220,
          top: -10,
          child: TapeStrip(angle: 3 * _deg),
        ),
      ],
    );
  }

  Widget _buildFields() {
    final bodyStyle = AppText.body.copyWith(height: 1.2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Hey Aryan,",
          style: AppText.handMedium.copyWith(
            fontSize: 34,
            height: 1,
            color: AppColors.ink900,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text("I'm", style: bodyStyle),
            const SizedBox(width: Space.s8),
            Expanded(
              child: FillInField(
                controller: _name,
                hint: "your name",
                label: "Your name",
                onChanged: _clearError,
              ),
            ),
            const SizedBox(width: Space.s8),
            Text("from", style: bodyStyle),
            const SizedBox(width: Space.s8),
            Expanded(
              child: FillInField(
                controller: _company,
                hint: "company",
                label: "Company",
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: Space.s8,
          runSpacing: Space.s8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("and I'd like to talk about", style: bodyStyle),
            for (final (index, topic) in SayHiData.topics.indexed)
              TopicChip(
                label: topic,
                isSelected: index == _topic,
                onTap: () => setState(() => _topic = index),
              ),
          ],
        ),
        const SizedBox(height: 14),
        FillInField(
          controller: _message,
          hint: "a few lines about it…",
          label: "Message",
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text("Reply to", style: bodyStyle),
            const SizedBox(width: Space.s8),
            Expanded(
              child: FillInField(
                controller: _email,
                hint: "your email",
                label: "Your email",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.send,
                onChanged: _clearError,
                onSubmitted: (_) => _send(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 18,
          child: Semantics(
            liveRegion: true,
            child: Text(
              _error,
              style: AppText.body.copyWith(
                fontSize: 13,
                height: 1.3,
                color: RouteInk.blog.ink,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            HandNote(
              "fold & send →",
              style: AppText.handSmall.copyWith(fontSize: 22),
              color: AppColors.ink500,
            ),
            const SizedBox(width: Space.s12),
            PillButton(
              label: "Send",
              icon: Icons.mail_outline,
              variant: PillVariant.filled,
              color: AppColors.ink900,
              onPressed: _send,
            ),
          ],
        ),
      ],
    );
  }
}

class _Delivered extends StatelessWidget {
  final VoidCallback onWriteAnother;

  const _Delivered({required this.onWriteAnother});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HandNote(
            "Delivered to Bengaluru.",
            style: AppText.handMedium.copyWith(fontSize: 34),
            color: AppColors.ink900,
          ),
          const SizedBox(height: 10),
          Text(
            SayHiData.deliveredNote,
            style: AppText.body.copyWith(color: AppColors.ink500),
          ),
          const SizedBox(height: 10),
          PillButton(
            label: "Write another",
            color: AppColors.ink900,
            onPressed: onWriteAnother,
          ),
        ],
      ),
    );
  }
}

class _Postcard extends StatelessWidget {
  const _Postcard();

  static const double _width = 440;
  static const double _height = 280;

  static const String _skyline = '''
<svg viewBox="0 0 440 280" xmlns="http://www.w3.org/2000/svg">
  <path d="M0 200 H110 V214 H270 V200 H290 A60 48 0 0 1 410 200 H420 V214 H440 V280 H0 Z" fill="#9E9E9E" fill-opacity=".55"/>
</svg>
''';

  static const String _stamp = '''
<svg viewBox="0 0 54 64" xmlns="http://www.w3.org/2000/svg">
  <rect x="1.5" y="1.5" width="51" height="61" fill="#FFFFFF" stroke="#0D0D0D" stroke-width="3" stroke-dasharray="0.1 6" stroke-linecap="round"/>
  <g transform="translate(14 12) scale(.1793)">
    <path d="M5 136.779C5 136.779 5 101.044 5 78.1474M68.2689 136.779V78.1474M68.2689 136.779C68.2689 136.779 115.452 146.61 127.963 136.779C140.474 126.947 136.721 85.1189 127.963 78.1474C119.206 71.1759 91.581 64.4049 68.2689 78.1474M68.2689 136.779C68.2689 136.779 71.3072 193.086 59.69 214M68.2689 136.779C90.2448 169.485 117.101 196.474 142 214M68.2689 78.1474V19.5162C42.0092 0.795776 28.0523 -0.463039 5 19.5162C5 19.5162 5 55.2505 5 78.1474M68.2689 78.1474C43.5609 88.4444 29.708 86.85 5 78.1474" fill="none" stroke="#0D0D0D" stroke-width="12" stroke-linecap="round" stroke-linejoin="round"/>
  </g>
</svg>
''';

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Transform.rotate(
        angle: 5 * _deg,
        child: AspectRatio(
          aspectRatio: _width / _height,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x290D0D0D),
                  blurRadius: 24,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.7],
                    colors: [Colors.white, Color(0xFFE9E9E9)],
                  ),
                ),
                child: FittedBox(
                  child: SizedBox(
                    width: _width,
                    height: _height,
                    child: Stack(
                      children: [
                        Positioned.fill(child: SvgPicture.string(_skyline)),
                        Positioned(
                          left: 0.05 * _width,
                          top: 0.06 * _height,
                          child: Text(
                            "From the desk of Aryan",
                            style: AppText.handLarge.copyWith(
                              fontSize: 32,
                              color: AppColors.ink900,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0.04 * _width,
                          top: 0.06 * _height,
                          child: Transform.rotate(
                            angle: 4 * _deg,
                            child: SvgPicture.string(
                              _stamp,
                              width: 54,
                              height: 64,
                            ),
                          ),
                        ),
                      ],
                    ),
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
