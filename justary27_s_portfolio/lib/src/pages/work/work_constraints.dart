import '../../enums/device_type.dart';

/// Storage class for Work page constraints.
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

  static const Map<DeviceType, double> projTitle = {
    DeviceType.smallMobile: 0.20,
    DeviceType.largeMobile: 0.175,
    DeviceType.smallTablet: 0.15,
    DeviceType.largeTablet: 0.125,
    DeviceType.smallLaptop: 0.1,
    DeviceType.largeLaptop: 0.08,
    DeviceType.smallDesktop: 0.08,
  };

  static const Map<DeviceType, double> projSubtitle = {
    DeviceType.smallMobile: 0.06,
    DeviceType.largeMobile: 0.05,
    DeviceType.smallTablet: 0.04,
    DeviceType.largeTablet: 0.03,
    DeviceType.smallLaptop: 0.021,
    DeviceType.largeLaptop: 0.02,
    DeviceType.smallDesktop: 0.02,
  };

  static const Map<DeviceType, double> projDescription = {
    DeviceType.smallMobile: 0.0320,
    DeviceType.largeMobile: 0.0280,
    DeviceType.smallTablet: 0.0245,
    DeviceType.largeTablet: 0.0175,
    DeviceType.smallLaptop: 0.0130,
    DeviceType.largeLaptop: 0.0125,
    DeviceType.smallDesktop: 0.0125,
  };

  static const Map<DeviceType, double> projLinks = {
    DeviceType.smallMobile: 16,
    DeviceType.largeMobile: 17.5,
    DeviceType.smallTablet: 19.5,
    DeviceType.largeTablet: 21,
    DeviceType.smallLaptop: 24,
    DeviceType.largeLaptop: 27,
    DeviceType.smallDesktop: 27,
  };

  static const Map<DeviceType, double> projEmphasis = {
    DeviceType.smallMobile: 0.0320,
    DeviceType.largeMobile: 0.0280,
    DeviceType.smallTablet: 0.0250,
    DeviceType.largeTablet: 0.0180,
    DeviceType.smallLaptop: 0.0135,
    DeviceType.largeLaptop: 0.0130,
    DeviceType.smallDesktop: 0.0130,
  };
}
