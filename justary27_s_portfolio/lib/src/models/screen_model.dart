import 'dart:ui';

import '../enums/device_type.dart';

class Screen {
  double width;
  double height;
  DeviceType deviceType;

  Screen(this.width, this.height, this.deviceType);

  Size getScreenSize() {
    return Size(width, height);
  }
}
