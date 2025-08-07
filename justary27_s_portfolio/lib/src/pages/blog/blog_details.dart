import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:justary27_s_portfolio/src/models/blog_model.dart';
import 'package:markdown_widget/config/markdown_generator.dart';

import '../../models/screen_model.dart';
import '../../providers/screen_provider.dart';
import '../../services/database.dart';

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

  @override
  Widget build(BuildContext context) {
    Screen screen = ref.watch(screenProvider);

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFA81D13)),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: screen.width * 0.2,
        vertical: screen.height * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _blog!.blogTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            _blog!.blogTagLine,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: screen.height * 0.02),
            width: screen.width * 0.6,
            child: Image.network(
              _blog!.blogLink,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: const Color(0xFFA81D13));
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(color: const Color(0xFFA81D13));
              },
            ),
          ),
          ...MarkdownGenerator().buildWidgets(_blog!.blogDescription),
        ],
      ),
    );
  }
}
