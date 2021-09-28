import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/footer.dart';
import 'blogConstraints.dart';

const Map _cf = ConstraintFactors;

class BlogPage extends StatefulWidget {
  final Size size;
  final tabcontroller;
  final deviceType;

  const BlogPage(
      {Key? key,
      required this.size,
      required this.tabcontroller,
      required this.deviceType})
      : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    final _tabController = widget.tabcontroller;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
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
                      child: CustomPaint(
                        painter: RoorkeePainter(),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(247, 250, 250, 1.0),
                              Color.fromRGBO(255, 255, 255, 1.0)
                            ]),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 0.3 * size.height,
                      color: Color.fromRGBO(134, 149, 179, 1.0),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width,
                      height: size.height,
                      child: Text(
                        "Blog.",
                        style: GoogleFonts.coveredByYourGrace(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(247, 250, 249, 1.0),
                                fontSize: 0.3 * size.height)),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                    ),
                    NavBar(size: size, tabController: _tabController)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class RoorkeePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(246, 223, 71, 1.0),
            Color.fromRGBO(255, 255, 255, 1.0)
          ]).createShader(Offset.zero & size);

    Path path = Path();

    // path.lineTo(size.width, size.height);

    path.moveTo(size.width, 0.48 * size.height);
    path.quadraticBezierTo(
      0.9 * size.width,
      0.5 * size.height,
      0.9 * size.width,
      0.7 * size.height,
    );
    path.lineTo(0.12 * size.width, 0.7 * size.height);
    path.lineTo(0.12 * size.width, 0.65 * size.height);
    path.lineTo(0, 0.65 * size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
