import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/screen_model.dart';
import 'large_opener.dart';
import 'small_opener.dart';

import '../../providers/screen_provider.dart';
import '../../enums/device_type.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    Screen screen = ref.watch(screenProvider);
    DeviceType deviceType = screen.deviceType;

    if (deviceType < DeviceType.largeTablet) {
      return SmallOpenerPage(
        size: screen.getScreenSize(),
        deviceType: deviceType,
      );
    }

    return LargeOpenerPage(
      size: screen.getScreenSize(),
      deviceType: deviceType,
    );
  }
}
