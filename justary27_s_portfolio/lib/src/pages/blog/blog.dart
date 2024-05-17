import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/footer.dart';
import '../../models/blog_model.dart';
import '../../services/database.dart';
import '../../components/rPainter.dart';
import '../../components/deviceDetector.dart';
import '../../utils/handlers/route_handler.dart';
import '../../components/blog_dialog/blog_dialog.dart';
import '../../components/page_components/promo_components.dart';

import 'blog_constraints.dart' show cf;

class BlogPage extends StatefulWidget {
  const BlogPage({
    super.key,
  });

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final Size size = Size(
        constraints.maxWidth,
        constraints.maxHeight,
      );
      String _deviceType = deviceDetector(size.width);
      return GlowingOverscrollIndicator(
        axisDirection: AxisDirection.up,
        color: const Color.fromRGBO(252, 220, 102, 1.0).withOpacity(0.3),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromRGBO(252, 220, 102, 1.0),
                                Color.fromRGBO(246, 223, 71, 1.0),
                              ]),
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: size.height,
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
                        width: size.width,
                        height: size.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromRGBO(247, 250, 250, 1.0),
                                Color.fromRGBO(255, 255, 255, 1.0)
                              ]),
                        ),
                        child: CustomPaint(
                          painter: RoorkeePainter(
                            const Color(0xFFFA8C5D),
                            const Color.fromRGBO(255, 255, 255, 1.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: size.width,
                        height: size.height,
                        child: Text(
                          "Blog.",
                          style: TextStyle(
                            fontFamily: "CoveredByYourGrace",
                            color: const Color.fromRGBO(247, 250, 249, 1.0),
                            fontSize: cf['heading'][_deviceType] * size.width,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: size.width,
                              height: size.height,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.1 * size.width,
                                vertical: 0.1 * size.height,
                              ),
                              child: SizedBox(
                                width: 0.8 * size.width,
                                height: 0.8 * size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Checkout the latest blogs!",
                                      style: TextStyle(
                                        fontFamily: "Itim",
                                        color: const Color(0xFFFA8C5D),
                                        fontSize: cf['blogList'][_deviceType] *
                                            size.width,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0.1 * size.height, 0, 0),
                                      child: Container(
                                        width: 0.8 * size.width,
                                        height: 0.5 * size.height,
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
                                                            leading:
                                                                CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .blogTitle[
                                                                        0]
                                                                    .toUpperCase(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      "Ubuntu",
                                                                  color: Color(
                                                                      0xFFFA8C5D),
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                              vertical: 0.02 *
                                                                  size.height,
                                                              horizontal: 0.03 *
                                                                  size.width,
                                                            ),
                                                            title: Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .blogTitle,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "Ubuntu",
                                                                color: Colors
                                                                    .white,
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
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                    ),
                                                                  )
                                                                : (index ==
                                                                        snapshot.data!.length -
                                                                            1)
                                                                    ? const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(10),
                                                                          bottomRight:
                                                                              Radius.circular(10),
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
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      child: blogProvider(
                                                                          size,
                                                                          snapshot
                                                                              .data![index],
                                                                          _deviceType),
                                                                    );
                                                                  });
                                                            },
                                                            trailing: Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .blogCreatedOn,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "Ubuntu",
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                            tileColor:
                                                                const Color(
                                                                    0xFFFA8C5D),
                                                          );
                                                        } else {
                                                          return ListTile(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                              vertical: 0.02 *
                                                                  size.height,
                                                              horizontal: 0.03 *
                                                                  size.width,
                                                            ),
                                                            leading:
                                                                CircleAvatar(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFFFA8C5D),
                                                              child: Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .blogTitle[
                                                                        0]
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
                                                                    0xFFFA8C5D),
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
                                                                      child: blogProvider(
                                                                          size,
                                                                          snapshot
                                                                              .data![index],
                                                                          _deviceType),
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
                                                                        0xFFFA8C5D)
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
                                                                    0xFFFA8C5D),
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
                        size: size,
                        deviceType: _deviceType,
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
                        size: size,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

// class RoorkeePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..style = PaintingStyle.fill
//       ..shader = LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomLeft,
//           colors: [
//             Color.fromRGBO(246, 223, 71, 1.0),
//             Color.fromRGBO(255, 255, 255, 1.0)
//           ]).createShader(Offset.zero & size);
//
//     Path path = Path();
//
//     // path.lineTo(size.width, size.height);
//
//     path.moveTo(size.width, 0.48 * size.height);
//     path.quadraticBezierTo(
//       0.9 * size.width,
//       0.5 * size.height,
//       0.9 * size.width,
//       0.7 * size.height,
//     );
//     path.lineTo(0.12 * size.width, 0.7 * size.height);
//     path.lineTo(0.12 * size.width, 0.65 * size.height);
//     path.lineTo(0, 0.65 * size.height);
//     path.lineTo(0, size.height);
//     path.lineTo(size.width, size.height);
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
