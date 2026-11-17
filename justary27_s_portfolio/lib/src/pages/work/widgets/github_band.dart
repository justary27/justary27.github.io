import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../../../components/app_link.dart';
import '../../../enums/layout.dart';
import '../../../themes/brand.dart';
import '../../../themes/colors.dart';
import '../../../themes/dimens.dart';
import '../../../themes/route_ink.dart';
import '../../../themes/typography.dart';

const String _placeholder = "<placeholder>";
const String _profile = "https://github.com/justary27";
// Five years of weeks, a column per week as on GitHub.
const int _years = 5;
const int _weeks = 52 * _years;
const Color _cardLine = Color(0x400B5E50);
const Color _emptyCell = Color(0xFFEBF1EE);

// A milestone pinned above the heatmap, placed by its date.
class _Pin {
  final String label;
  final DateTime date;
  final Color background;
  final Color foreground;

  const _Pin(this.label, this.date, this.background, this.foreground);
}

// Closes the Work page in Work mint. Its numbers are meant to be pulled from
// GitHub at build time; until that exists they show <placeholder>.
class GitHubBand extends StatelessWidget {
  final double gutter;
  // GitHub orgs the work data already links to, for "Merged into".
  final List<String> orgs;

  const GitHubBand({super.key, required this.gutter, required this.orgs});

  @override
  Widget build(BuildContext context) {
    final ink = RouteInk.work.ink;
    final layout = Layout.of(MediaQuery.sizeOf(context));
    final compact = layout.isCompact;
    final phone = layout.isPhone;
    final now = DateTime.now();
    final start = DateTime(now.year - _years + 1);
    // Dates from data.dart: GSoC '22 contributor and GSoC '23 mentor.
    final pins = [
      _Pin(
        "GSOC '22",
        DateTime(2022, 5),
        Brands.experience['gsoc22']!.brand,
        Brands.experience['gsoc22']!.dark,
      ),
      _Pin("MENTOR '23", DateTime(2023, 5), ink, Colors.white),
    ];

    return Container(
      margin: const EdgeInsets.only(top: Space.s96),
      color: RouteInk.work.navbar,
      padding: EdgeInsets.fromLTRB(gutter, 64, gutter, 72),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: ink),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 14,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Space.s8),
                  // Tablet stacks the profile pill under the line.
                  child: Flex(
                    direction: compact ? Axis.vertical : Axis.horizontal,
                    crossAxisAlignment: compact
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Flexible(
                        // Loose would still flex, which a stacked header can't.
                        flex: compact ? 0 : 1,
                        fit: compact ? FlexFit.loose : FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 6,
                          children: [
                            Text(
                              "More of it lives on GitHub.",
                              style: AppText.handLarge.copyWith(
                                fontSize: 44,
                                height: 1,
                                color: ink,
                              ),
                            ),
                            Text(
                              "Repos, experiments, the stuff that didn't make a section.",
                              style: AppText.body.copyWith(color: ink),
                            ),
                          ],
                        ),
                      ),
                      AppLink(
                        to: _profile,
                        label: "github.com/justary27",
                        builder: (context, _) => Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Space.s12,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: ink,
                            borderRadius: BorderRadius.circular(Radii.pill),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: Space.s8,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.github,
                                size: 16,
                                color: Colors.white,
                              ),
                              Text(
                                "github.com/justary27 ↗",
                                style: AppText.label.copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _Card(
                  child: _Heatmap(start: start, end: now, pins: pins),
                ),
                // Tablet: two stats side by side, then orgs, then languages.
                if (compact)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 14,
                    children: [
                      // Phone: every card on its own row.
                      if (phone) ...const [
                        _Stat(title: "Contributions", caption: _placeholder),
                        _Stat(title: "Longest streak", caption: _placeholder),
                      ] else
                        const IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 14,
                            children: [
                              Expanded(
                                child: _Stat(
                                  title: "Contributions",
                                  caption: _placeholder,
                                ),
                              ),
                              Expanded(
                                child: _Stat(
                                  title: "Longest streak",
                                  caption: _placeholder,
                                ),
                              ),
                            ],
                          ),
                        ),
                      _Orgs(orgs: orgs),
                      const _Languages(),
                    ],
                  )
                else
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const gap = 14.0;
                      final unit = (constraints.maxWidth - 2 * gap) / 3;
                      // Board columns .8fr .8fr 1.4fr.
                      final narrow = unit * 0.8;
                      final wide = constraints.maxWidth - 2 * narrow - 2 * gap;
                      // The tall card matches the two rows beside it.
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: gap,
                          children: [
                            SizedBox(
                              width: 2 * narrow + gap,
                              child: Column(
                                spacing: gap,
                                children: [
                                  Row(
                                    spacing: gap,
                                    children: [
                                      Expanded(
                                        child: _Stat(
                                          title: "Contributions",
                                          caption: _placeholder,
                                        ),
                                      ),
                                      Expanded(
                                        child: _Stat(
                                          title: "Longest streak",
                                          caption: _placeholder,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const _Languages(),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: wide,
                              child: _Orgs(orgs: orgs),
                            ),
                          ],
                        ),
                      );
                    },
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
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Radii.tile),
        border: Border.all(color: _cardLine),
      ),
      child: child,
    );
  }
}

TextStyle get _cardTitle =>
    AppText.label.copyWith(fontSize: 13, color: RouteInk.work.ink);

class _Stat extends StatelessWidget {
  final String title;
  final String caption;

  const _Stat({required this.title, required this.caption});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _cardTitle),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                _placeholder,
                style: AppText.stat.copyWith(
                  fontSize: 34,
                  height: 1.1,
                  color: RouteInk.work.ink,
                ),
              ),
            ),
          ),
          Text(
            caption,
            style: AppText.body.copyWith(fontSize: 12, color: AppColors.ink500),
          ),
        ],
      ),
    );
  }
}

class _Languages extends StatelessWidget {
  const _Languages();

  @override
  Widget build(BuildContext context) {
    // Phone stacks the share bar under the heading.
    final phone = Layout.of(MediaQuery.sizeOf(context)).isPhone;
    return _Card(
      child: Flex(
        direction: phone ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: phone
            ? CrossAxisAlignment.stretch
            : CrossAxisAlignment.center,
        spacing: phone ? 12 : 20,
        children: [
          Flexible(
            flex: phone ? 0 : 1,
            fit: phone ? FlexFit.loose : FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Space.s4,
              children: [
                Text("Top languages", style: _cardTitle),
                Text(
                  _placeholder,
                  style: AppText.body.copyWith(
                    fontSize: 13,
                    color: AppColors.ink700,
                  ),
                ),
              ],
            ),
          ),
          // Share bar; empty until the build-time pull fills it.
          Flexible(
            flex: phone ? 0 : 1,
            fit: phone ? FlexFit.loose : FlexFit.tight,
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                color: _emptyCell,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Orgs extends StatelessWidget {
  final List<String> orgs;

  const _Orgs({required this.orgs});

  @override
  Widget build(BuildContext context) {
    final ink = RouteInk.work.ink;
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Space.s16,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text("Merged into", style: _cardTitle),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final org in orgs)
                    AppLink(
                      to: "https://github.com/$org",
                      label: org,
                      builder: (context, _) => Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: Space.s12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: ink, width: 1.5),
                          borderRadius: BorderRadius.circular(Radii.pill),
                        ),
                        child: Text(
                          org,
                          style: AppText.label.copyWith(
                            fontSize: 13,
                            color: ink,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 14),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE3ECE8))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Text("Most-starred I've shipped to", style: _cardTitle),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  spacing: Space.s12,
                  children: [
                    Expanded(
                      child: Text(
                        _placeholder,
                        style: AppText.h3.copyWith(fontSize: 18),
                      ),
                    ),
                    Text(
                      "★ $_placeholder",
                      style: AppText.statCard.copyWith(
                        fontSize: 26,
                        color: ink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Heatmap extends StatelessWidget {
  final DateTime start;
  final DateTime end;
  final List<_Pin> pins;

  const _Heatmap({required this.start, required this.end, required this.pins});

  @override
  Widget build(BuildContext context) {
    final span = end.difference(start).inDays;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 34,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (final pin in pins)
                    if (!pin.date.isBefore(start) && pin.date.isBefore(end))
                      Positioned(
                        left: width * pin.date.difference(start).inDays / span,
                        top: 0,
                        child: FractionalTranslation(
                          translation: const Offset(-0.5, 0),
                          child: _PinLabel(pin: pin),
                        ),
                      ),
                ],
              ),
            ),
            SizedBox(
              height: 7 * 7 + 6 * 1.5,
              child: CustomPaint(painter: const _EmptyGridPainter()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Space.s8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int y = start.year; y <= end.year; y++)
                    Text(
                      "$y",
                      style: AppText.body.copyWith(
                        fontSize: 12,
                        color: AppColors.ink500,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PinLabel extends StatelessWidget {
  final _Pin pin;

  const _PinLabel({required this.pin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
          decoration: BoxDecoration(
            color: pin.background,
            borderRadius: BorderRadius.circular(Radii.pill),
          ),
          child: Text(
            pin.label,
            style: AppText.meta.copyWith(
              fontSize: 11,
              letterSpacing: 0.88,
              color: pin.foreground,
            ),
          ),
        ),
        Container(width: 1.5, height: 12, color: RouteInk.work.ink),
      ],
    );
  }
}

// Seven rows of day cells, one column per week, all empty until real counts.
class _EmptyGridPainter extends CustomPainter {
  const _EmptyGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const gap = 1.5;
    final cellW = (size.width - (_weeks - 1) * gap) / _weeks;
    final cellH = (size.height - 6 * gap) / 7;
    final paint = Paint()..color = _emptyCell;
    for (int w = 0; w < _weeks; w++) {
      for (int d = 0; d < 7; d++) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(w * (cellW + gap), d * (cellH + gap), cellW, cellH),
            const Radius.circular(1.5),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_EmptyGridPainter oldDelegate) => false;
}
