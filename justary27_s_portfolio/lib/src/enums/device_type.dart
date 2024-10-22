enum DeviceType implements Comparable<DeviceType> {
  smallMobile(min: 360, max: 390),
  largeMobile(min: 390, max: 450),
  smallTablet(min: 451, max: 768),
  largeTablet(min: 769, max: 1024),
  smallLaptop(min: 1025, max: 1536),
  largeLaptop(min: 1537, max: 1920);

  const DeviceType({
    required this.min,
    required this.max,
  });

  final double min;
  final double max;

  bool operator <(DeviceType other) {
    return max < other.max;
  }

  @override
  int compareTo(DeviceType other) => (max - other.max).toInt();

  @override
  String toString() {
    return '$runtimeType($min, $max)';
  }

  static DeviceType getDeviceType(double width) {
    if (width < DeviceType.smallMobile.max) {
      return DeviceType.smallMobile;
    } else if (width <= DeviceType.largeMobile.max) {
      return DeviceType.largeMobile;
    } else if (width <= DeviceType.smallTablet.max) {
      return DeviceType.smallTablet;
    } else if (width <= DeviceType.largeTablet.max) {
      return DeviceType.largeTablet;
    } else if (width <= DeviceType.smallLaptop.max) {
      return DeviceType.smallLaptop;
    } else {
      return DeviceType.largeLaptop;
    }
  }
}
