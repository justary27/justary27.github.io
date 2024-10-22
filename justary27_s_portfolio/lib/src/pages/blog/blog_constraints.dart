import '../../enums/device_type.dart';

/// Storage class for Blog page constraints.
class BC {
  BC._();

  static const Map<DeviceType, double> heading = {
    DeviceType.smallMobile: 0.25,
    DeviceType.largeMobile: 0.25,
    DeviceType.smallTablet: 0.25,
    DeviceType.largeTablet: 0.25,
    DeviceType.smallLaptop: 0.25,
    DeviceType.largeLaptop: 0.225,
  };

  static const Map<DeviceType, double> blogList = {
    DeviceType.smallMobile: 0.10,
    DeviceType.largeMobile: 0.10,
    DeviceType.smallTablet: 0.0725,
    DeviceType.largeTablet: 0.065,
    DeviceType.smallLaptop: 0.05,
    DeviceType.largeLaptop: 0.05,
  };
}
