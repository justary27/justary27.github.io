import '../../enums/device_type.dart';

/// Storage class for `BlogDetailsPage` constraints.
class BDC {
  BDC._();

  static const Map<DeviceType, double> heroHeight = {
    DeviceType.smallMobile: 0.40,
    DeviceType.largeMobile: 0.40,
    DeviceType.smallTablet: 0.45,
    DeviceType.largeTablet: 0.55,
    DeviceType.smallLaptop: 0.60,
    DeviceType.largeLaptop: 0.65,
    DeviceType.smallDesktop: 0.65,
  };

  static const Map<DeviceType, double> heroTitle = {
    DeviceType.smallMobile: 0.075,
    DeviceType.largeMobile: 0.070,
    DeviceType.smallTablet: 0.055,
    DeviceType.largeTablet: 0.045,
    DeviceType.smallLaptop: 0.035,
    DeviceType.largeLaptop: 0.030,
    DeviceType.smallDesktop: 0.030,
  };

  static const Map<DeviceType, double> contentWidth = {
    DeviceType.smallMobile: 0.92,
    DeviceType.largeMobile: 0.90,
    DeviceType.smallTablet: 0.85,
    DeviceType.largeTablet: 0.75,
    DeviceType.smallLaptop: 0.55,
    DeviceType.largeLaptop: 0.48,
    DeviceType.smallDesktop: 0.55,
  };
}
