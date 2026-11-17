import 'dart:math';

import 'package:markdown_widget/markdown_widget.dart';
import 'package:material_ui/material_ui.dart';

import '../../components/app_link.dart';
import '../../components/contact_envelope.dart';
import '../../components/footer.dart';
import '../../components/navbar.dart';
import '../../components/pinned_steps.dart';
import '../../components/pill_button.dart';
import '../../constants/route.dart';
import '../../enums/layout.dart';
import '../../models/blog.dart';
import '../../services/database.dart';
import '../../themes/colors.dart';
import '../../themes/dimens.dart';
import '../../themes/route_ink.dart';
import '../../themes/typography.dart';
import 'notes.dart';
import 'painters.dart';

const double _contentWidth = 1032;
const double _articleWidth = 680;
const double _marginWidth = 280;
const double _skylineHeight = 150;
const Color _onRedMuted = Color(0xFFF7C9C4);
const Color _postGround = Color(0xFFFAFAFA);
const Color _cardLine = Color(0xFFE2E2E2);
const Color _readingLine = Color(0xFFF2C230);

const TextStyle _meta = TextStyle(
  fontFamily: AppFonts.text,
  fontSize: 13,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.82,
);

class BlogPost extends StatefulWidget {
  final Blog blog;
  final Size size;

  const BlogPost({super.key, required this.blog, required this.size});

  @override
  State<BlogPost> createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPost> {
  // Number and next note both need the whole list.
  late final Future<List<Note>> _notes = Database.getBlogs().then(buildNotes);
  final ScrollController _scroll = ScrollController();
  final GlobalKey _header = GlobalKey();
  final GlobalKey _article = GlobalKey();
  // How far through the article the reader is, 0–1, for the line under the bar.
  final ValueNotifier<double> _progress = ValueNotifier(0);

  // The navbar listens to [NavBar.reading] but isn't an ancestor, so it
  // can't be marked dirty mid-build; changes wait for the frame to end.
  static void _setReading(NavReading? Function(NavReading? now) next) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => NavBar.reading.value = next(NavBar.reading.value),
      );

  @override
  void initState() {
    super.initState();
    final title = widget.blog.title;
    _setReading((_) => NavReading(title: title));
    _scroll.addListener(_track);
  }

  @override
  void didUpdateWidget(BlogPost oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.blog.id != widget.blog.id) {
      final title = widget.blog.title;
      _setReading((_) => NavReading(title: title));
      _progress.value = 0;
      if (_scroll.hasClients) _scroll.jumpTo(0);
    }
  }

  // Past the red header the navbar swaps in the title; the line tracks the
  // article from its top reaching the bar to its end reaching the fold.
  void _track() {
    if (!_scroll.hasClients) return;
    final position = _scroll.position;
    final header = _header.currentContext?.findRenderObject() as RenderBox?;
    final article = _article.currentContext?.findRenderObject() as RenderBox?;
    if (header == null || article == null) return;
    if (!header.attached || !article.attached) return;

    final headerBottom = scrolledTopOf(header, position) + header.size.height;
    final titleOn = headerBottom < NavBar.height;
    final reading = NavBar.reading.value;
    if (reading?.titleOn != titleOn) {
      NavBar.reading.value = NavReading(
        title: widget.blog.title,
        titleOn: titleOn,
      );
    }

    final top = scrolledTopOf(article, position);
    final span =
        article.size.height - position.viewportDimension + NavBar.height;
    _progress.value = ((NavBar.height - top) / max(1, span)).clamp(
      0.0,
      1.0,
    );
  }

  @override
  void dispose() {
    _scroll.removeListener(_track);
    _scroll.dispose();
    _progress.dispose();
    // Only clears what this page set, so a newer post page keeps its title.
    final title = widget.blog.title;
    _setReading((now) => now?.title == title ? null : now);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double gutter = (0.04 * widget.size.width).clamp(16, double.infinity);
    final blog = widget.blog;

    return FutureBuilder<List<Note>>(
      future: _notes,
      builder: (context, snapshot) {
        final notes = snapshot.data ?? const <Note>[];
        final int index = notes.indexWhere((n) => n.opens.id == blog.id);
        final String number = numberFor(blog, notes);
        final Note? next = notes.length > 1 && index >= 0
            ? notes[(index + 1) % notes.length]
            : null;

        return Stack(
          children: [
            ColoredBox(
              color: _postGround,
              child: SingleChildScrollView(
                controller: _scroll,
                child: Column(
                  children: [
                    _PostHeader(
                      key: _header,
                      blog: blog,
                      number: number,
                      gutter: gutter,
                      width: widget.size.width,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: gutter),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: _contentWidth,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: Space.s96,
                                  bottom: Space.s40 + Space.s8,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxWidth: _articleWidth,
                                        ),
                                        child: _Article(
                                          key: _article,
                                          markdown: blog.description,
                                        ),
                                      ),
                                    ),
                                    // Margin embeds land here once posts carry them;
                                    // tablet puts them in a grid under the body.
                                    if (!Layout.of(widget.size).isCompact)
                                      const SizedBox(width: 64 + _marginWidth),
                                  ],
                                ),
                              ),
                              _EndBand(next: next, about: blog.title),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Footer(size: widget.size),
                  ],
                ),
              ),
            ),
            // The yellow reading line, just under the navbar's hairline.
            Positioned(
              top: NavBar.height + 1,
              left: 0,
              height: 3,
              width: widget.size.width,
              child: ValueListenableBuilder<double>(
                valueListenable: _progress,
                builder: (context, progress, _) => Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: 1,
                  child: FractionallySizedBox(
                    widthFactor: progress,
                    heightFactor: 1,
                    child: const ColoredBox(color: _readingLine),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Stored as "9 min read" on some posts and "9 min" on others.
String _readTime(Blog blog) {
  final read = blog.minRead.trim();
  final lower = read.toLowerCase();
  return lower.endsWith("read") || !lower.contains("min") ? read : "$read read";
}

String numberFor(Blog blog, List<Note> notes) {
  for (final note in notes) {
    if (note.opens.id == blog.id) return note.number;
  }
  return placeholder;
}

class _PostHeader extends StatelessWidget {
  final Blog blog;
  final String number;
  final double gutter;
  final double width;

  const _PostHeader({
    super.key,
    required this.blog,
    required this.number,
    required this.gutter,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final titleSize = Layout.of(MediaQuery.sizeOf(context)).isPhone
        ? (0.09 * width).clamp(32.0, 64.0)
        : (0.05 * width).clamp(40.0, 64.0);
    final red = RouteInk.blog.ink;
    return ColoredBox(
      color: red,
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: _skylineHeight,
            // The dome overruns the band's top edge; the board's SVG clips it.
            child: ClipRect(child: CustomPaint(painter: PostSkylinePainter())),
          ),
          Padding(
            // The navbar overlays the body, so the header starts under it.
            padding: EdgeInsets.fromLTRB(
              gutter,
              NavBar.height + 40,
              gutter,
              _skylineHeight,
            ),
            child: Column(
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _contentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 28),
                          child: AppLink(
                            to: RouteHandler.blogPage,
                            label: "All notes",
                            fadeOnHover: false,
                            builder: (context, states) => Text(
                              "← All notes",
                              style: AppText.label.copyWith(
                                fontSize: 15,
                                color: Colors.white,
                                decoration: states.contains(WidgetState.hovered)
                                    ? TextDecoration.underline
                                    : null,
                                decorationColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "NO. $number · ",
                              style: _meta.copyWith(color: _onRedMuted),
                            ),
                            _SourceLabel(blog: blog),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 820),
                            child: Text(
                              blog.title,
                              style: TextStyle(
                                fontFamily: AppFonts.text,
                                fontSize: titleSize,
                                fontWeight: FontWeight.w900,
                                height: 1.05,
                                letterSpacing: -0.02 * titleSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          blog.tagLine,
                          style: TextStyle(
                            fontFamily: AppFonts.text,
                            fontSize: (0.02 * width).clamp(18, 24),
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: _onRedMuted,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Text(
                            "${noteDate(blog.createdOn)} · ${_readTime(blog)}"
                                .toUpperCase(),
                            style: _meta.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceLabel extends StatelessWidget {
  final Blog blog;

  const _SourceLabel({required this.blog});

  @override
  Widget build(BuildContext context) {
    final style = _meta.copyWith(color: _onRedMuted);
    switch (blog.source) {
      case BlogSource.site:
        return Text("ONLY HERE ✎", style: style);
      case BlogSource.medium:
        final url = blog.mediumUrl;
        if (url == null) return Text("ALSO ON MEDIUM", style: style);
        return AppLink(
          to: url,
          label: "Also on Medium",
          builder: (context, _) => Text("ALSO ON MEDIUM →", style: style),
        );
      case null:
        return Text(placeholder, style: style);
    }
  }
}

class _Article extends StatelessWidget {
  final String markdown;

  const _Article({super.key, required this.markdown});

  @override
  Widget build(BuildContext context) {
    // Phone steps the post's type down: body 18, headings 30, quotes 20.
    final phone = Layout.of(MediaQuery.sizeOf(context)).isPhone;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: MarkdownGenerator(
        linesMargin: const EdgeInsets.only(bottom: 28),
        generators: [phone ? _phoneQuoteGenerator : _quoteGenerator],
      ).buildWidgets(markdown, config: phone ? _phoneMarkdown : _postMarkdown),
    );
  }
}

const TextStyle _body = TextStyle(
  fontFamily: AppFonts.text,
  fontSize: 20,
  height: 1.6,
  color: AppColors.ink900,
);
const TextStyle _heading = TextStyle(
  fontFamily: AppFonts.text,
  fontSize: 40,
  fontWeight: FontWeight.w700,
  height: 1.15,
  color: AppColors.ink900,
);

// The board's pull quote: 24 px italic, larger than the body around it.
// Paragraphs inside take their parent's style, so this wins over PConfig.
class _QuoteNode extends BlockquoteNode {
  final double size;

  _QuoteNode(super.config, super.visitor, {this.size = 24});

  @override
  TextStyle? get style => (parentStyle ?? const TextStyle()).merge(
    TextStyle(
      fontFamily: AppFonts.text,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
      height: 1.5,
      color: AppColors.ink700,
    ),
  );
}

final SpanNodeGeneratorWithTag _quoteGenerator = SpanNodeGeneratorWithTag(
  tag: MarkdownTag.blockquote.name,
  generator: (element, config, visitor) =>
      _QuoteNode(config.blockquote, visitor),
);
final SpanNodeGeneratorWithTag _phoneQuoteGenerator = SpanNodeGeneratorWithTag(
  tag: MarkdownTag.blockquote.name,
  generator: (element, config, visitor) =>
      _QuoteNode(config.blockquote, visitor, size: 20),
);

// Post headings sit on the type scale with no rule under them.
class _PostH1 extends H1Config {
  const _PostH1({super.style = _heading});
  @override
  HeadingDivider? get divider => null;
  @override
  EdgeInsets get padding => const EdgeInsets.only(top: 20);
}

class _PostH2 extends H2Config {
  const _PostH2({super.style = _heading});
  @override
  HeadingDivider? get divider => null;
  @override
  EdgeInsets get padding => const EdgeInsets.only(top: 20);
}

class _PostH3 extends H3Config {
  const _PostH3()
    : super(
        style: const TextStyle(
          fontFamily: AppFonts.text,
          fontSize: 22,
          fontWeight: FontWeight.w900,
          height: 1.3,
          color: AppColors.ink900,
        ),
      );
  @override
  HeadingDivider? get divider => null;
  @override
  EdgeInsets get padding => const EdgeInsets.only(top: 12);
}

final MarkdownConfig _postMarkdown = _markdown(_body, _heading);
final MarkdownConfig _phoneMarkdown = _markdown(
  _body.copyWith(fontSize: 18),
  _heading.copyWith(fontSize: 30),
);

MarkdownConfig _markdown(TextStyle body, TextStyle heading) => MarkdownConfig(
  configs: [
    PConfig(textStyle: body),
    _PostH1(style: heading),
    _PostH2(style: heading),
    const _PostH3(),
    BlockquoteConfig(
      sideColor: RouteInk.blog.ink,
      textColor: AppColors.ink700,
      sideWith: 3,
      padding: const EdgeInsets.fromLTRB(24, 4, 0, 4),
      margin: EdgeInsets.zero,
    ),
    const CodeConfig(
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 16,
        backgroundColor: AppColors.codeBackground,
        color: AppColors.ink900,
      ),
    ),
    PreConfig(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: AppColors.codeBackground,
        borderRadius: BorderRadius.circular(Radii.chip),
      ),
      textStyle: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 14,
        height: 1.6,
      ),
      // Plain ink like the board, no syntax colours.
      theme: const {},
    ),
    LinkConfig(
      style: TextStyle(
        color: RouteInk.blog.ink,
        decoration: TextDecoration.underline,
        decorationColor: RouteInk.blog.ink,
      ),
    ),
  ],
);

class _EndBand extends StatelessWidget {
  final Note? next;
  // This post's title, handed to the envelope by "Write back".
  final String about;

  const _EndBand({required this.next, required this.about});

  @override
  Widget build(BuildContext context) {
    final compact = Layout.of(MediaQuery.sizeOf(context)).isCompact;
    final phone = Layout.of(MediaQuery.sizeOf(context)).isPhone;
    final Widget? nextNote = next == null
        ? null
        : Align(
            alignment: Alignment.topLeft,
            child: AppLink(
              to: RouteHandler.blogDetailsPage(next!.opens.id),
              label: "Next note: ${next!.title}",
              builder: (context, states) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Space.s8,
                children: [
                  Text(
                    "NEXT NOTE",
                    style: _meta.copyWith(color: AppColors.ink500),
                  ),
                  Text(
                    "${next!.title} →",
                    style: AppText.h2.copyWith(
                      fontSize: 28,
                      height: 1.2,
                      decoration: states.contains(WidgetState.hovered)
                          ? TextDecoration.underline
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          );
    final Widget card = Container(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: Space.s24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _cardLine),
        borderRadius: BorderRadius.circular(Radii.chip),
      ),
      // Phone lets the button wrap under the greeting.
      child: Flex(
        direction: phone ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: phone
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        spacing: phone ? 14 : 20,
        children: [
          Flexible(
            flex: phone ? 0 : 1,
            fit: phone ? FlexFit.loose : FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Text(
                  "Hey Aryan,",
                  style: AppText.handSmall.copyWith(
                    fontSize: 30,
                    height: 1,
                    color: RouteInk.blog.ink,
                  ),
                ),
                Text(
                  "Something here made you think?",
                  style: AppText.body.copyWith(color: AppColors.ink500),
                ),
              ],
            ),
          ),
          PillButton(
            label: "Write back",
            variant: PillVariant.filled,
            color: AppColors.ink900,
            onPressed: () => showContactEnvelope(context, aboutPost: about),
          ),
        ],
      ),
    );
    return Container(
      padding: const EdgeInsets.only(top: Space.s32, bottom: Space.s96),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.ink900, width: 2)),
      ),
      // Tablet stacks "Next note" over the Write back card.
      child: compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: Space.s32,
              children: [?nextNote, card],
            )
          : IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: Space.s32,
                children: [
                  Expanded(child: nextNote ?? const SizedBox()),
                  Expanded(child: card),
                ],
              ),
            ),
    );
  }
}
