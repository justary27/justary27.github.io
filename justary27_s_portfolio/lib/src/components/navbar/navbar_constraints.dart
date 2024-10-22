import '../../enums/device_type.dart';

/// Storage class for Navbar constraints.
class NC {
  NC._();

  static const Map<DeviceType, double> email = {
    DeviceType.smallMobile: 0.110,
    DeviceType.largeMobile: 0.0975,
    DeviceType.smallTablet: 0.075,
    DeviceType.largeTablet: 0.0625,
    DeviceType.smallLaptop: 0.05,
    DeviceType.largeLaptop: 0.045,
  };

  static const Map<DeviceType, double> links = {
    DeviceType.smallMobile: 16,
    DeviceType.largeMobile: 17.5,
    DeviceType.smallTablet: 19.5,
    DeviceType.largeTablet: 21,
    DeviceType.smallLaptop: 24,
    DeviceType.largeLaptop: 27,
  };

  static const Map<DeviceType, double> taLine = {
    DeviceType.smallMobile: 0.0460,
    DeviceType.largeMobile: 0.0410,
    DeviceType.smallTablet: 0.0360,
    DeviceType.largeTablet: 0.0300,
    DeviceType.smallLaptop: 0.02,
    DeviceType.largeLaptop: 0.02,
  };
}
