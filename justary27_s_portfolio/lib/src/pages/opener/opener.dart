import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/pages/opener/large_opener.dart';
import 'package:justary27_s_portfolio/src/pages/opener/small_opener.dart';

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

  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    final String deviceType = widget.deviceType;
    if (widget.deviceType == 'mobiles390-' ||
        widget.deviceType == 'mobiles450-' ||
        widget.deviceType == 'tablets768-') {
      return SmallOpenerPage(
        size: size,
        deviceType: deviceType,
      );
    } else {
      return LargeOpenerPage(
        size: size,
        deviceType: widget.deviceType,
      );
    }
  }
}
