import 'dart:ui';

import '../enums/device_type.dart';
import '../enums/layout.dart';

class Screen {
  double width;
  double height;
  DeviceType deviceType;

  Screen(this.width, this.height, this.deviceType);

  Layout get layout => Layout.of(Size(width, height));

  Size getScreenSize() {
    return Size(width, height);
  }
}
