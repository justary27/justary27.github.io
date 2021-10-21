import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/ar.dart';
import 'openerConstraints.dart';

const Map _cf = ConstraintFactors;

class OpenerPage extends StatefulWidget {
  final Size size;
  final String deviceType;
  const OpenerPage({
    Key? key,
    required this.size,
    required this.deviceType,
  }) : super(key: key);

  @override
  _OpenerPageState createState() => _OpenerPageState();
}

class _OpenerPageState extends State<OpenerPage> {
  ValueNotifier<bool> isMoving = ValueNotifier(false);
  ValueNotifier<Offset> offset = ValueNotifier(Offset.zero);

  Stream<Matrix4> _transformer() async* {
    while (isMoving.value) {
      yield Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, offset.value.dx / 10,
          offset.value.dy / 10, 0, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    final String deviceType = widget.deviceType;

    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: isMoving,
          builder: (_, __, ___) => Container(
            width: size.width,
            height: size.height,
            color: Colors.black,
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  child: Image.asset(
                    "images/space1.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedPositioned(
                  width: 1.4 * size.width,
                  height: 1.7 * size.height,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  top: (isMoving.value) ? offset.value.dy / 2 : 0,
                  left: (isMoving.value) ? offset.value.dx / 2 : 0,
                  child: Image.asset(
                    "images/space1.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: size.width,
          height: size.height,
          color: Colors.black.withOpacity(0.3),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(0.1 * size.width),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Aryan Ranjan",
                  style: TextStyle(
                      fontFamily: "Allison",
                      color: Colors.white,
                      fontSize: _cf['name'][deviceType] * size.width),
                ),
                Text(
                  "IITR'24 | Codifyin' reality",
                  style: GoogleFonts.caveat(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: _cf['taLine'][deviceType] * size.width)),
                ),
              ],
            ),
          ),
        ),
        MouseRegion(
          onHover: (notif) {
            if (notif.delta != Offset.zero) {
              isMoving.value = true;
              offset.value = notif.delta;
              // Future.delayed(Duration(milliseconds: 300));
            } else {
              isMoving.value = false;
            }
          },
          child: Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(0.075 * size.width),
              child: Container(
                // transform: Matrix4(
                //     1,0,0,0.001,
                //     1,0,0,0,
                //     1,0,0,0,
                //     1,0,0,1,
                // ),
                child: CustomPaint(
                  painter: ArPainter(Colors.white.withOpacity(0.3)),
                  size: Size(0.15 * size.width,
                      (0.15 * size.width * 1.572944297082228).toDouble()),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
