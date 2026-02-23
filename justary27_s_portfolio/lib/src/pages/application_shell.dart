import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/navbar.dart';
import '../enums/device_type.dart';
import '../models/screen_model.dart';
import '../components/navbar/drawer.dart';
import '../providers/navbar_provider.dart';
import '../providers/screen_provider.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class ApplicationShell extends ConsumerWidget {
  final Widget child;

  const ApplicationShell({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        DeviceType deviceType = DeviceType.getDeviceType(constraints.maxWidth);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(screenProvider.notifier).state = Screen(
            constraints.maxWidth,
            constraints.maxHeight,
            deviceType,
          );
        });

        return Scaffold(
          key: scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              (deviceType < DeviceType.smallDesktop)
                  ? 0.1 * constraints.maxHeight
                  : 0.075 * constraints.maxHeight,
            ),
            child: ClipRect(
              child: AnimatedSlide(
                offset:
                    ref.watch(navbarVisibleProvider)
                        ? Offset.zero
                        : const Offset(0, -1),
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: Navbar(navigatorKey: scaffoldKey),
              ),
            ),
          ),
          body: child,
          endDrawer:
              (deviceType < DeviceType.largeTablet)
                  ? SmallDrawer(
                    navigator: scaffoldKey,
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    deviceType: deviceType,
                  )
                  : null,
        );
      },
    );
  }
}
