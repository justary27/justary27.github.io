import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/navbar.dart';
import '../enums/device_type.dart';
import '../models/screen.dart';
import '../providers/navbar.dart';
import '../providers/screen.dart';
import '../themes/motion.dart';
import '../themes/route_ink.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class ApplicationShell extends ConsumerWidget {
  final String path;
  final Widget child;

  const ApplicationShell({required this.path, required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        DeviceType deviceType = DeviceType.getDeviceType(constraints.maxWidth);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref
              .read(screenProvider.notifier)
              .update(
                Screen(constraints.maxWidth, constraints.maxHeight, deviceType),
              );
        });

        final scaffold = Scaffold(
          key: scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(NavBar.height),
            child: ClipRect(
              child: AnimatedSlide(
                offset: ref.watch(navbarVisibleProvider)
                    ? Offset.zero
                    : const Offset(0, -1),
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                // The full navbar on every window; it fits down to 360.
                child: NavBar(
                  size: constraints.biggest,
                  deviceType: deviceType,
                ),
              ),
            ),
          ),
          body: child,
        );

        return AnimatedTheme(
          data: Theme.of(context)
              .copyWith(extensions: [RouteInk.forPath(path)]),
          duration: Motion.step,
          curve: MotionCurves.standard,
          child: scaffold,
        );
      },
    );
  }
}
