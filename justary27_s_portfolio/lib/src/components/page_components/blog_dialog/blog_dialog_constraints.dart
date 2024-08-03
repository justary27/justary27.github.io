import '../../../enums/device_type.dart';

/// Storage class for `BlogDialog` constraints
class BDC {
  BDC._();

  static const Map<DeviceType, double> blogTitle = {
    DeviceType.smallMobile: 0.10,
    DeviceType.largeMobile: 0.10,
    DeviceType.smalltablet: 0.0725,
    DeviceType.largeTablet: 0.065,
    DeviceType.smallLaptop: 0.05,
    DeviceType.largeLaptop: 0.05,
  };
}
