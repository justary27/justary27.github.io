import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/navbar.dart';
import '../enums/device_type.dart';
import '../models/screen_model.dart';
import '../components/navbar/drawer.dart';
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
              0.1 * constraints.maxHeight,
            ),
            child: Navbar(
              navigatorKey: scaffoldKey,
            ),
          ),
          body: child,
          endDrawer: (deviceType < DeviceType.largeTablet)
              ? SmallDrawer(
                  navigator: scaffoldKey,
                  size: Size(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  ),
                  deviceType: deviceType,
                )
              : null,
        );
      },
    );
  }
}
