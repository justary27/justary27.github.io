import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:justary27_s_portfolio/src/models/blog.dart';

import '../../models/screen.dart';
import '../../providers/screen.dart';
import '../../services/database.dart';
import 'post.dart';

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

  @override
  void initState() {
    super.initState();
    _initializeBlog();
  }

  // The route reuses this page when only the post id changes (Next note),
  // so reload instead of keeping the previous post.
  @override
  void didUpdateWidget(BlogDetailsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.blogId != widget.blogId) _initializeBlog();
  }

  void _initializeBlog() async {
    if (widget.blog != null) {
      _blog = widget.blog;
      return;
    }

    if (widget.blogId != null) {
      debugPrint("Fetching blog with ID: ${widget.blogId}");
      // Only the first load blanks the page; moving to another note keeps
      // the current one (and its header row) until the next one arrives.
      if (_blog == null) setState(() => _isLoading = true);

      final requested = widget.blogId;
      try {
        final blog = await Database.getBlog(requested!);
        // A quicker click on another note may have replaced this request.
        if (!mounted || requested != widget.blogId) return;
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

  @override
  Widget build(BuildContext context) {
    Screen screen = ref.watch(screenProvider);

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: _brandRed),
      );
    }

    // The post reflows per Layout.
    return BlogPost(blog: _blog!, size: screen.getScreenSize());
  }
}
