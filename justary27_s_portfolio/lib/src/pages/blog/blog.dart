import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/footer.dart';
import '../../models/blog_model.dart';
import '../../services/database.dart';
import '../../enums/device_type.dart';
import '../../models/screen_model.dart';
import '../../handlers/route_handler.dart';
import '../../providers/screen_provider.dart';
import '../../components/roorkee_painter.dart';
import '../../components/promo/promo_components.dart';
import '../../components/page_components/blog_dialog/blog_dialog.dart';

import 'blog_constraints.dart';

class BlogPage extends ConsumerStatefulWidget {
  const BlogPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlogPageState();
}

class _BlogPageState extends ConsumerState<BlogPage> {
  @override
  Widget build(BuildContext context) {
    Screen screen = ref.watch(screenProvider);
    DeviceType deviceType = screen.deviceType;

    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.up,
      color: const Color(0xFFA81D13).withOpacity(0.3),
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
                      height: screen.height,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(241, 245, 245, 1.0),
                              Color.fromRGBO(218, 224, 224, 1.0),
                            ]),
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
                            Color.fromRGBO(183, 193, 192, 1.0)
                          ],
                        ),
                      ),
                      child: CustomPaint(
                        painter: RoorkeePainter(
                          const Color(0xFFA81D13),
                          const Color.fromRGBO(145, 155, 153, 1.0)
                              .withOpacity(0.4),
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
                      height: screen.height,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: screen.width,
                            height: screen.height,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.1 * screen.width,
                              vertical: 0.1 * screen.height,
                            ),
                            child: SizedBox(
                              width: 0.8 * screen.width,
                              height: 0.8 * screen.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Checkout the latest blogs!",
                                    style: TextStyle(
                                      fontFamily: "Itim",
                                      color: const Color(0xFFA81D13),
                                      fontSize: BC.blogList[deviceType]! *
                                          screen.width,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, 0.1 * screen.height, 0, 0),
                                    child: Container(
                                      width: 0.8 * screen.width,
                                      height: 0.5 * screen.height,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: FutureBuilder<List<Blog>>(
                                            future: Database.getBlogs(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      if (index.isEven) {
                                                        return ListTile(
                                                          leading: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .blogTitle[0]
                                                                  .toUpperCase(),
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "Ubuntu",
                                                                color: Color(
                                                                    0xFFA81D13),
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                            vertical: 0.02 *
                                                                screen.height,
                                                            horizontal: 0.03 *
                                                                screen.width,
                                                          ),
                                                          title: Text(
                                                            snapshot
                                                                .data![index]
                                                                .blogTitle,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  "Ubuntu",
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            snapshot
                                                                .data![index]
                                                                .tagLine,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Ubuntu",
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.75),
                                                            ),
                                                          ),
                                                          // isThreeLine: true,
                                                          shape: (index == 0)
                                                              ? const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                )
                                                              : (index ==
                                                                      snapshot.data!
                                                                              .length -
                                                                          1)
                                                                  ? const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                      ),
                                                                    )
                                                                  : null,
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Dialog(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                  ),
                                                                  child: blogProvider(
                                                                      screen
                                                                          .getScreenSize(),
                                                                      snapshot.data![
                                                                          index],
                                                                      deviceType),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          trailing: Text(
                                                            snapshot
                                                                .data![index]
                                                                .blogCreatedOn,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  "Ubuntu",
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          tileColor:
                                                              const Color(
                                                                  0xFFA81D13),
                                                        );
                                                      } else {
                                                        return ListTile(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                            vertical: 0.02 *
                                                                screen.height,
                                                            horizontal: 0.03 *
                                                                screen.width,
                                                          ),
                                                          leading: CircleAvatar(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFFA81D13),
                                                            child: Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .blogTitle[0]
                                                                  .toUpperCase(),
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "Ubuntu",
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                          title: Text(
                                                            snapshot
                                                                .data![index]
                                                                .blogTitle,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  "Ubuntu",
                                                              color: Color(
                                                                  0xFFA81D13),
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          shape: (index ==
                                                                  snapshot.data!
                                                                          .length -
                                                                      1)
                                                              ? const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10),
                                                                  ),
                                                                )
                                                              : null,
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                    child:
                                                                        blogProvider(
                                                                      screen
                                                                          .getScreenSize(),
                                                                      snapshot.data![
                                                                          index],
                                                                      deviceType,
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          subtitle: Text(
                                                            snapshot
                                                                .data![index]
                                                                .tagLine,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "ABeeZee",
                                                              color: const Color(
                                                                      0xFFA81D13)
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                          ),
                                                          trailing: Text(
                                                            snapshot
                                                                .data![index]
                                                                .blogCreatedOn,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  "Ubuntu",
                                                              color: Color(
                                                                  0xFFA81D13),
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          tileColor: Colors
                                                              .white
                                                              .withOpacity(
                                                                  0.75),
                                                        );
                                                      }
                                                    });
                                              } else {
                                                return const Center(
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Color.fromRGBO(
                                                          252, 220, 102, 1.0),
                                                    ),
                                                  ),
                                                );
                                              }
                                            }),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
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
                    Footer(
                      size: screen.getScreenSize(),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
