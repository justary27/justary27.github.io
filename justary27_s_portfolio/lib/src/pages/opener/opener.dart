import 'package:flutter/material.dart';

import '../../pages/opener/large_opener.dart';
import '../../pages/opener/small_opener.dart';
import '../../components/deviceDetector.dart';

class OpenerPage extends StatefulWidget {
  final Size size;
  const OpenerPage({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  _OpenerPageState createState() => _OpenerPageState();
}

class _OpenerPageState extends State<OpenerPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    return LayoutBuilder(
      builder: (context, constraints) {
        String _deviceType = deviceDetector(constraints.maxWidth);
        debugPrint(constraints.maxWidth.toString());
        if (_deviceType == 'mobiles390-' ||
            _deviceType == 'mobiles450-' ||
            _deviceType == 'tablets768-') {
          return SmallOpenerPage(
            size: size,
            deviceType: _deviceType,
          );
        } else {
          return LargeOpenerPage(
            size: size,
            deviceType: _deviceType,
          );
        }
      },
    );
  }
}
