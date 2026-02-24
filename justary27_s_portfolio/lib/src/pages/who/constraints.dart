import '../../enums/device_type.dart';

/// Storage class for Who page constraints.
class WC {
  WC._();

  static const Map<DeviceType, double> heading = {
    DeviceType.smallMobile: 0.25,
    DeviceType.largeMobile: 0.25,
    DeviceType.smallTablet: 0.25,
    DeviceType.largeTablet: 0.25,
    DeviceType.smallLaptop: 0.25,
    DeviceType.largeLaptop: 0.225,
    DeviceType.smallDesktop: 0.225,
  };

  static const Map<DeviceType, double> time = {
    DeviceType.smallMobile: 0.110,
    DeviceType.largeMobile: 0.0975,
    DeviceType.smallTablet: 0.075,
    DeviceType.largeTablet: 0.0625,
    DeviceType.smallLaptop: 0.05,
    DeviceType.largeLaptop: 0.045,
    DeviceType.smallDesktop: 0.045,
  };

  static const Map<DeviceType, double> timeDesc = {
    DeviceType.smallMobile: 0.0325,
    DeviceType.largeMobile: 0.0295,
    DeviceType.smallTablet: 0.0250,
    DeviceType.largeTablet: 0.0180,
    DeviceType.smallLaptop: 0.0135,
    DeviceType.largeLaptop: 0.0130,
    DeviceType.smallDesktop: 0.0130,
  };

  static const Map<DeviceType, double> taLine = {
    DeviceType.smallMobile: 0.0460,
    DeviceType.largeMobile: 0.0410,
    DeviceType.smallTablet: 0.0360,
    DeviceType.largeTablet: 0.0300,
    DeviceType.smallLaptop: 0.02,
    DeviceType.largeLaptop: 0.02,
    DeviceType.smallDesktop: 0.02,
  };

  static const Map<DeviceType, Map<String, double>> rotLine = {
    DeviceType.smallMobile: {'width': 0.02500, 'height': 0.01400},
    DeviceType.largeMobile: {'width': 0.02250, 'height': 0.01317},
    DeviceType.smallTablet: {'width': 0.02000, 'height': 0.01170},
    DeviceType.largeTablet: {'width': 0.01750, 'height': 0.01083},
    DeviceType.smallLaptop: {'width': 0.0150, 'height': 0.010},
    DeviceType.largeLaptop: {'width': 0.0150, 'height': 0.010},
    DeviceType.smallDesktop: {'width': 0.0150, 'height': 0.010},
  };
}
