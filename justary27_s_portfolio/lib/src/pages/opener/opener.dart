import 'package:flutter/material.dart';

import '../../pages/opener/large_opener.dart';
import '../../pages/opener/small_opener.dart';
import '../../components/deviceDetector.dart';

class OpenerPage extends StatefulWidget {
  const OpenerPage({
    super.key,
  });

  @override
  State<OpenerPage> createState() => _OpenerPageState();
}

class _OpenerPageState extends State<OpenerPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size size = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        String _deviceType = deviceDetector(size.width);
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
