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

  static const Map<DeviceType, double> sectionLabel = {
    DeviceType.smallMobile: 0.110,
    DeviceType.largeMobile: 0.0975,
    DeviceType.smallTablet: 0.075,
    DeviceType.largeTablet: 0.0625,
    DeviceType.smallLaptop: 0.05,
    DeviceType.largeLaptop: 0.045,
    DeviceType.smallDesktop: 0.045,
  };

  static const Map<DeviceType, double> stepText = {
    DeviceType.smallMobile: 0.0325,
    DeviceType.largeMobile: 0.0295,
    DeviceType.smallTablet: 0.0250,
    DeviceType.largeTablet: 0.0180,
    DeviceType.smallLaptop: 0.0135,
    DeviceType.largeLaptop: 0.0130,
    DeviceType.smallDesktop: 0.0130,
  };
}
