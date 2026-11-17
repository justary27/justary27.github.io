import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/device_type.dart';
import '../models/screen.dart';

class ScreenNotifier extends Notifier<Screen> {
  @override
  Screen build() => Screen(1000, 1400, DeviceType.smallLaptop); // Default value

  void update(Screen screen) => state = screen;
}

final screenProvider = NotifierProvider<ScreenNotifier, Screen>(
  ScreenNotifier.new,
);
