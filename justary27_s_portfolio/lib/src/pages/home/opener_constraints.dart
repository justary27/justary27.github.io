import '../../enums/device_type.dart';

class OC {
  OC._();

  static const Map<DeviceType, double> name = {
    DeviceType.smallMobile: 0.110,
    DeviceType.largeMobile: 0.0995,
    DeviceType.smallTablet: 0.095,
    DeviceType.largeTablet: 0.0825,
    DeviceType.smallLaptop: 0.07,
    DeviceType.largeLaptop: 0.045,
    DeviceType.smallDesktop: 0.045,
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

  static const Map<DeviceType, double> buttons = {
    DeviceType.smallMobile: 0.0400,
    DeviceType.largeMobile: 0.0350,
    DeviceType.smallTablet: 0.0300,
    DeviceType.largeTablet: 0.0200,
    DeviceType.smallLaptop: 0.015,
    DeviceType.largeLaptop: 0.015,
    DeviceType.smallDesktop: 0.015,
  };

  static const Map<DeviceType, double> heading = {
    DeviceType.smallMobile: 0.25,
    DeviceType.largeMobile: 0.25,
    DeviceType.smallTablet: 0.25,
    DeviceType.largeTablet: 0.25,
    DeviceType.smallLaptop: 0.25,
    DeviceType.largeLaptop: 0.225,
    DeviceType.smallDesktop: 0.225,
  };

  static const Map<DeviceType, double> aboutMe = {
    DeviceType.smallMobile: 0.035,
    DeviceType.largeMobile: 0.0325,
    DeviceType.smallTablet: 0.0275,
    DeviceType.largeTablet: 0.0180,
    DeviceType.smallLaptop: 0.0135,
    DeviceType.largeLaptop: 0.0130,
    DeviceType.smallDesktop: 0.0130,
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

  static const Map<DeviceType, double> techStack = {
    DeviceType.smallMobile: 30,
    DeviceType.largeMobile: 30,
    DeviceType.smallTablet: 35,
    DeviceType.largeTablet: 35,
    DeviceType.smallLaptop: 40,
    DeviceType.largeLaptop: 40,
    DeviceType.smallDesktop: 40,
  };
}
