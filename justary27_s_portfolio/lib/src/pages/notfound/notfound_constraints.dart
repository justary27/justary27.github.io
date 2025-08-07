import '../../enums/device_type.dart';

class NFC {
  NFC._();

  static const Map<DeviceType, double> heading = {
    DeviceType.smallMobile: 0.05,
    DeviceType.largeMobile: 0.05,
    DeviceType.smallTablet: 0.05,
    DeviceType.largeTablet: 0.05,
    DeviceType.smallLaptop: 0.05,
    DeviceType.largeLaptop: 0.05,
    DeviceType.smallDesktop: 0.025,
  };

  static const Map<DeviceType, double> buttons = {
    DeviceType.smallMobile: 0.0400,
    DeviceType.largeMobile: 0.0350,
    DeviceType.smallTablet: 0.0300,
    DeviceType.largeTablet: 0.0200,
    DeviceType.smallLaptop: 0.015,
    DeviceType.largeLaptop: 0.015,
    DeviceType.smallDesktop: 0.015,
  };
}
