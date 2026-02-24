import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/device_type.dart';
import '../models/screen.dart';

final screenProvider = StateProvider<Screen>((ref) {
  return Screen(1000, 1400, DeviceType.smallLaptop); // Default value
});
