import 'package:material_ui/material_ui.dart';

import '../../components/fit.dart';
import '../../components/footer.dart';
import '../../components/landing.dart';
import '../../components/navbar.dart';
import '../../models/blog.dart';
import '../../services/database.dart';
import '../../themes/colors.dart';
import '../../themes/route_ink.dart';
import '../../themes/typography.dart';
import 'notes.dart';
import 'widgets/notes_pad.dart';

const double _contentWidth = 1152;

class BlogPage extends StatefulWidget {
  final Size size;

  const BlogPage({super.key, required this.size});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late final Future<List<Blog>> _blogs = Database.getBlogs();
  final ScrollController _scroll = ScrollController();
  final GlobalKey _stories = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && Landing.of(context) == Landing.blog) {
        Landing.glide(context, _scroll, _stories);
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double gutter = (0.04 * widget.size.width).clamp(16, double.infinity);

    return SingleChildScrollView(
      controller: _scroll,
      child: Column(
        children: [
          // The navbar overlays the body, so the hero starts under it.
          RouteHero(
            title: "Blog.",
            gradient: RouteInk.blog.hero,
            color: Colors.white,
            width: widget.size.width,
            inset: NavBar.height,
          ),
          DecoratedBox(
            decoration: BoxDecoration(gradient: RouteInk.blog.ground),
            child: Column(
              children: [
                _Intro(key: _stories, gutter: gutter, width: widget.size.width),
                FutureBuilder<List<Blog>>(
                  future: _blogs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return NotesPad(
                        notes: buildNotes(snapshot.data!),
                        size: widget.size,
                      );
                    }
                    return SizedBox(
                      height: 600,
                      child: Center(
                        child: snapshot.hasError
                            ? Text(
                                "Couldn't load the notes. Try again in a bit.",
                                style: AppText.body,
                              )
                            : CircularProgressIndicator(
                                color: RouteInk.blog.ink,
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Footer(size: widget.size),
        ],
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  final double gutter;
  final double width;

  const _Intro({super.key, required this.gutter, required this.width});

  @override
  Widget build(BuildContext context) {
    // Left edge lines up with the board's 1152 px content column.
    final double inset = ((width - 2 * gutter - _contentWidth) / 2).clamp(
      0,
      double.infinity,
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(gutter + inset, 96, gutter, 48),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            placeholder,
            style: AppText.bodyL.copyWith(color: AppColors.ink700),
          ),
        ),
      ),
    );
  }
}
