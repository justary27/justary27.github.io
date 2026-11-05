import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:justary27_s_portfolio/src/models/blog.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../components/footer.dart';
import '../../constants/route.dart';
import '../../enums/device_type.dart';
import '../../models/screen.dart';
import '../../providers/screen.dart';
import '../../services/database.dart';
import 'detail_constraints.dart';

const Color _brandRed = Color(0xFFA81D13);

class BlogDetailsPage extends ConsumerStatefulWidget {
  final Blog? blog;
  final String? blogId;

  const BlogDetailsPage({super.key, this.blog, this.blogId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends ConsumerState<BlogDetailsPage> {
  Blog? _blog;
  bool _isLoading = false;

  final ScrollController _scrollController = ScrollController();
  double _readProgress = 0.0;
  bool _isHeroCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateOnScroll);
    _initializeBlog();
  }

  void _updateOnScroll() {
    final maxExtent = _scrollController.position.maxScrollExtent;
    final progress =
        maxExtent > 0
            ? (_scrollController.offset / maxExtent).clamp(0.0, 1.0)
            : 0.0;

    // FlexibleSpaceBar's own title-fade kicks in gradually well before the
    // bar is actually collapsed, so the sticky title is driven explicitly
    // off scroll offset instead: only shown once the hero has fully
    // scrolled behind the pinned toolbar.
    final screen = ref.read(screenProvider);
    final heroHeight = BDC.heroHeight[screen.deviceType]! * screen.height;
    final collapsed =
        _scrollController.offset >= heroHeight - kToolbarHeight - 1;

    if (progress != _readProgress || collapsed != _isHeroCollapsed) {
      setState(() {
        _readProgress = progress;
        _isHeroCollapsed = collapsed;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateOnScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeBlog() async {
    if (widget.blog != null) {
      _blog = widget.blog;
      return;
    }

    if (widget.blogId != null) {
      debugPrint("Fetching blog with ID: ${widget.blogId}");
      setState(() {
        _isLoading = true;
      });

      try {
        final blog = await Database.getBlog(widget.blogId!);
        setState(() {
          _blog = blog;
          _isLoading = false;
        });
      } catch (e) {
        if (mounted) {
          context.go('/404');
        }
      }
    } else {
      // Immediately redirect to page not found
      if (mounted) {
        context.go('/404');
      }
    }
  }

  void _goBackToBlog(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(RouteHandler.blogPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    Screen screen = ref.watch(screenProvider);
    DeviceType deviceType = screen.deviceType;

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: _brandRed),
      );
    }

    final blog = _blog!;

    return Container(
      color: const Color(0xFFFAFAFA),
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: _brandRed,
                foregroundColor: Colors.white,
                elevation: 2,
                expandedHeight: BDC.heroHeight[deviceType]! * screen.height,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  tooltip: "Back to Blog",
                  onPressed: () => _goBackToBlog(context),
                ),
                // Without an explicit (even empty) actions list, Flutter
                // auto-adds a hamburger button to open the Scaffold's
                // endDrawer — duplicating the one already in the site navbar.
                actions: const [],
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(
                    left: 56,
                    bottom: 16,
                    right: 16,
                  ),
                  title:
                      _isHeroCollapsed
                          ? Text(
                            blog.blogTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: "Ubuntu",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )
                          : null,
                  background: _HeroBackground(
                    blog: blog,
                    screen: screen,
                    deviceType: deviceType,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: _MetaBar(blog: blog, screen: screen)),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: BDC.contentWidth[deviceType]! * screen.width,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 0.06 * screen.height,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: MarkdownGenerator().buildWidgets(
                          blog.blogDescription,
                          config: _markdownConfig,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Footer(size: screen.getScreenSize()),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _ReadProgressBar(progress: _readProgress),
          ),
        ],
      ),
    );
  }
}

/// Hero image + gradient scrim + large title/tagline shown while the
/// [SliverAppBar] is expanded; scrolls/fades away as it collapses, at which
/// point [FlexibleSpaceBar.title] takes over as the pinned sticky title.
class _HeroBackground extends StatelessWidget {
  final Blog blog;
  final Screen screen;
  final DeviceType deviceType;

  const _HeroBackground({
    required this.blog,
    required this.screen,
    required this.deviceType,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalInset = 0.06 * screen.width;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (blog.blogLink.isNotEmpty)
          Image.network(
            blog.blogLink,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: _brandRed);
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(color: _brandRed);
            },
          )
        else
          Container(color: _brandRed),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.35, 1.0],
              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
            ),
          ),
        ),
        Positioned(
          left: horizontalInset,
          right: horizontalInset,
          bottom: 0.05 * screen.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                blog.blogTitle,
                style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: BDC.heroTitle[deviceType]! * screen.width,
                ),
              ),
              SizedBox(height: 0.01 * screen.height),
              Text(
                blog.blogTagLine,
                style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontStyle: FontStyle.italic,
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 0.5 * BDC.heroTitle[deviceType]! * screen.width,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Thin pinned bar at the very top of the viewport showing scroll progress
/// through the article, independent of the [SliverAppBar]'s own pinning.
class _ReadProgressBar extends StatelessWidget {
  final double progress;

  const _ReadProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      color: Colors.black.withValues(alpha: 0.15),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(color: Colors.white),
      ),
    );
  }
}

class _MetaBar extends StatelessWidget {
  final Blog blog;
  final Screen screen;

  const _MetaBar({required this.blog, required this.screen});

  @override
  Widget build(BuildContext context) {
    final metaStyle = TextStyle(
      fontFamily: "Ubuntu",
      color: Colors.white.withValues(alpha: 0.9),
      fontSize: 13,
    );

    return Container(
      width: double.infinity,
      color: _brandRed,
      padding: EdgeInsets.symmetric(
        horizontal: 0.06 * screen.width,
        vertical: 0.015 * screen.height,
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 8,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.date_range_outlined,
                color: Colors.white.withValues(alpha: 0.9),
                size: 15,
              ),
              const SizedBox(width: 6),
              Text(blog.blogCreatedOn, style: metaStyle),
              if (blog.blogMinRead.isNotEmpty) ...[
                const SizedBox(width: 18),
                Icon(
                  Icons.schedule_rounded,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 15,
                ),
                const SizedBox(width: 6),
                Text(blog.blogMinRead, style: metaStyle),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

MarkdownConfig get _markdownConfig => MarkdownConfig(
  configs: [
    const PConfig(
      textStyle: TextStyle(
        fontFamily: "ABeeZee",
        fontSize: 16,
        height: 1.6,
        color: Colors.black87,
      ),
    ),
    const H1Config(
      style: TextStyle(
        fontFamily: "Ubuntu",
        fontSize: 28,
        height: 1.3,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    const H2Config(
      style: TextStyle(
        fontFamily: "Ubuntu",
        fontSize: 24,
        height: 1.3,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    const H3Config(
      style: TextStyle(
        fontFamily: "Ubuntu",
        fontSize: 20,
        height: 1.3,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    const H4Config(
      style: TextStyle(
        fontFamily: "Ubuntu",
        fontSize: 18,
        height: 1.3,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    const BlockquoteConfig(
      sideColor: _brandRed,
      textColor: Colors.black54,
      sideWith: 4,
      padding: EdgeInsets.fromLTRB(16, 4, 0, 4),
      margin: EdgeInsets.symmetric(vertical: 8),
    ),
    const CodeConfig(
      style: TextStyle(
        fontFamily: "monospace",
        backgroundColor: Color(0xFFEFF1F3),
        color: _brandRed,
      ),
    ),
    PreConfig(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: const TextStyle(fontFamily: "monospace", fontSize: 14),
    ),
    const LinkConfig(
      style: TextStyle(
        color: _brandRed,
        decoration: TextDecoration.underline,
        decorationColor: _brandRed,
      ),
    ),
  ],
);
