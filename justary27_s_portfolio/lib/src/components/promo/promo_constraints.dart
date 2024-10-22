import '../../enums/device_type.dart';

/// Storage class for `PromoComponent` constraints
class PC {
  PC._();

  static const Map<DeviceType, double> taLine = {
    DeviceType.smallMobile: 0.0460,
    DeviceType.largeMobile: 0.0410,
    DeviceType.smallTablet: 0.0360,
    DeviceType.largeTablet: 0.0300,
    DeviceType.smallLaptop: 0.02,
    DeviceType.largeLaptop: 0.02,
  };

  static const Map<DeviceType, Map<String, double>> rotLine = {
    DeviceType.smallMobile: {'width': 0.02500, 'height': 0.01400},
    DeviceType.largeMobile: {'width': 0.02250, 'height': 0.01317},
    DeviceType.smallTablet: {'width': 0.02000, 'height': 0.01170},
    DeviceType.largeTablet: {'width': 0.01750, 'height': 0.01083},
    DeviceType.smallLaptop: {'width': 0.0150, 'height': 0.010},
    DeviceType.largeLaptop: {'width': 0.0150, 'height': 0.010},
  };
}
