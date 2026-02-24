import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/footer.dart';
import '../../models/blog.dart';
import '../../services/database.dart';
import '../../enums/device_type.dart';
import '../../models/screen.dart';
import '../../constants/route.dart';
import '../../constants/scroll.dart';
import '../../providers/screen.dart';
import '../../components/roorkee_painter.dart';
import '../../components/promo.dart';

import 'constraints.dart';

class BlogPage extends ConsumerStatefulWidget {
  const BlogPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlogPageState();
}

class _BlogPageState extends ConsumerState<BlogPage> {
  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();

    _carouselController = CarouselController(initialItem: 1);
  }

  @override
  Widget build(BuildContext context) {
    Screen screen = ref.watch(screenProvider);
    DeviceType deviceType = screen.deviceType;

    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.up,
      color: const Color(0xFFA81D13).withValues(alpha: 0.3),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: screen.width,
                      height: screen.height,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            // Color.fromRGBO(252, 220, 102, 1.0),
                            Color.fromARGB(255, 206, 45, 33),
                            Color(0xFFA81D13),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: screen.width,
                      height: 1.5 * screen.height,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(241, 245, 245, 1.0),
                            Color.fromRGBO(218, 224, 224, 1.0),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: screen.width,
                      height: screen.height,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(218, 224, 224, 1.0),
                            Color.fromRGBO(183, 193, 192, 1.0),
                          ],
                        ),
                      ),
                      child: CustomPaint(
                        painter: RoorkeePainter(
                          const Color(0xFFA81D13),
                          const Color.fromRGBO(
                            145,
                            155,
                            153,
                            1.0,
                          ).withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: screen.width,
                      height: screen.height,
                      child: Text(
                        "Blog.",
                        style: TextStyle(
                          fontFamily: "CoveredByYourGrace",
                          color: const Color.fromRGBO(247, 250, 249, 1.0),
                          fontSize: BC.heading[deviceType]! * screen.width,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screen.width,
                      height: 1.4 * screen.height,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 0.025 * screen.height,
                          left: 0.05 * screen.width,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Checkout the latest blogs!",
                              style: TextStyle(
                                fontFamily: "Itim",
                                color: const Color(0xFFA81D13),
                                fontSize:
                                    BC.blogList[deviceType]! * screen.width,
                              ),
                            ),
                            Container(
                              width: screen.width,
                              height: 0.7 * screen.height,
                              padding: EdgeInsets.symmetric(
                                vertical: 0.05 * screen.height,
                              ),

                              child: FeaturedBlogsCarousel(
                                screen: screen,
                                controller: _carouselController,
                              ),
                            ),
                            Text(
                              "More blogs",
                              style: TextStyle(
                                fontFamily: "Itim",
                                color: const Color(0xFFA81D13),
                                fontSize:
                                    BC.blogList[deviceType]! * screen.width / 2,
                              ),
                            ),
                            Container(
                              width: screen.width,
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.symmetric(
                                vertical: 0.02 * screen.height,
                              ),
                              height: 0.4 * screen.height,
                              child: MoreBlogsGrid(screen: screen),
                            ),
                          ],
                        ),
                      ),
                    ),

                    PromoRedirector(
                      size: screen.getScreenSize(),
                      deviceType: deviceType,
                      pageName: "Work",
                      pageDescriptor: "Check out all of my work!",
                      button: TextButton.icon(
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color.fromRGBO(20, 62, 188, 1),
                        ),
                        onPressed: () {
                          context.push(RouteHandler.workPage);
                        },
                        label: const Text(
                          "Work",
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            color: Color.fromRGBO(20, 62, 188, 1),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Footer(size: screen.getScreenSize()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }
}

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: width * 7 / 8,
              height: double.infinity,
              color: _getColorFromTitle(blog.blogTitle),
            ),
          ),
          if (blog.blogLink.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: width * 7 / 8,
                height: double.infinity,
                child: Image.network(
                  blog.blogLink,
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
            ),

          Container(
            width: width,
            color: Colors.black.withValues(alpha: 0.7),
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    blog.blogCreatedOn,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Ubuntu",
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  blog.blogTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontFamily: "Ubuntu",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  blog.blogTagLine,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontFamily: "Ubuntu",
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

class FeaturedBlogsCarousel extends StatelessWidget {
  final Screen screen;
  final CarouselController controller;

  const FeaturedBlogsCarousel({
    super.key,
    required this.screen,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double height = screen.height;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height / 2),
      child: ScrollConfiguration(
        behavior: DragScrollBehavior(),
        child: FutureBuilder<List<Blog>>(
          future: Database.getBlogs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFA81D13)),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No blogs found",
                  style: TextStyle(
                    fontFamily: "Ubuntu",
                    color: Color(0xFFA81D13),
                  ),
                ),
              );
            }

            // Get only the top 4 blogs for carousel
            final featuredBlogs = snapshot.data!.take(3).toList();

            return ClipRect(
              child: CarouselView.weighted(
                controller: controller,
                itemSnapping: true,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                flexWeights: const <int>[1, 3, 1],
                onTap: (value) {
                  context.push(
                    RouteHandler.blogDetailsPage(featuredBlogs[value].id),
                    extra: featuredBlogs[value],
                  );
                },
                children:
                    featuredBlogs.map((blog) {
                      return BlogCard(blog: blog);
                    }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Generate a consistent color based on the blog title
Color _getColorFromTitle(String title) {
  // Simple hash function to generate a color
  int hash = 0;
  for (var i = 0; i < title.length; i++) {
    hash = title.codeUnitAt(i) + ((hash << 5) - hash);
  }

  // Mix with the brand color to maintain consistency
  final int r = ((hash & 0xFF0000) >> 16);
  final int g = ((hash & 0x00FF00) >> 8);
  final int b = (hash & 0x0000FF);

  return Color.fromRGBO(
    (r + 0xA8) ~/ 2, // Mix with brand red (0xA8)
    (g + 0x1D) ~/ 2, // Mix with brand green (0x1D)
    (b + 0x13) ~/ 2, // Mix with brand blue (0x13)
    1.0,
  );
}

class MoreBlogsGrid extends StatelessWidget {
  final Screen screen;

  const MoreBlogsGrid({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Blog>>(
      future: Database.getBlogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFA81D13)),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        // Skip the first 3 blogs (those shown in carousel)
        final moreBlogs =
            snapshot.data!.length > 3 ? snapshot.data!.sublist(3) : <Blog>[];

        if (moreBlogs.isEmpty) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: Text(
                "No more articles to show",
                style: TextStyle(fontFamily: "Ubuntu", color: Colors.grey),
              ),
            ),
          );
        }

        return ScrollConfiguration(
          behavior: DragScrollBehavior(),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: moreBlogs.length,

            itemBuilder: (context, index) {
              final blog = moreBlogs[index];
              return BlogGridItem(blog: blog, screen: screen);
            },
          ),
        );
      },
    );
  }
}

class BlogGridItem extends StatelessWidget {
  final Blog blog;
  final Screen screen;

  const BlogGridItem({super.key, required this.blog, required this.screen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () =>
              context.push(RouteHandler.blogDetailsPage(blog.id), extra: blog),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: screen.width * 0.3,
          height: screen.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background color - always visible
              Container(color: _getColorFromTitle(blog.blogTitle)),

              // Background image - only if link is not empty
              if (blog.blogLink.isNotEmpty)
                Image.network(
                  blog.blogLink,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: const Color(0xFFA81D13));
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(color: const Color(0xFFA81D13));
                  },
                ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date and blog tag row
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        blog.blogCreatedOn,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Ubuntu",
                        ),
                      ),
                    ),

                    // Spacer to push title to bottom

                    // Blog title
                    Text(
                      blog.blogTitle,
                      style: const TextStyle(
                        fontFamily: "Ubuntu",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      blog.blogTagLine,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Generate a consistent color based on the blog title
  Color _getColorFromTitle(String title) {
    int hash = 0;
    for (var i = 0; i < title.length; i++) {
      hash = title.codeUnitAt(i) + ((hash << 5) - hash);
    }

    final int r = ((hash & 0xFF0000) >> 16);
    final int g = ((hash & 0x00FF00) >> 8);
    final int b = (hash & 0x0000FF);

    return Color.fromRGBO(
      (r + 0xA8) ~/ 2,
      (g + 0x1D) ~/ 2,
      (b + 0x13) ~/ 2,
      1.0,
    );
  }
}
