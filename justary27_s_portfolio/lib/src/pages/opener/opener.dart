import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/footer.dart';
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
  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    final String deviceType = widget.deviceType;

    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          color: Colors.black,
          child: Center(
              child: MaterialButton(
            onPressed: () {
              print(ModalRoute.of(context)!.settings.name);
            },
            child: Text(
              "Click me",
              style: TextStyle(color: Colors.white),
            ),
          )),
        ),
      ],
    );
  }
}
