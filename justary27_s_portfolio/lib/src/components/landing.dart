import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../themes/motion.dart';
import 'navbar.dart';
import 'pinned_steps.dart';

// Desk objects on Home land past each page's hero; the spot rides in the URL
// as a #fragment so the links stay real links.
abstract final class Landing {
  static const String work = "about";
  static const String who = "off-the-clock";
  static const String blog = "stories";

  static String of(BuildContext context) => GoRouter.maybeOf(context) == null
      ? ""
      : GoRouterState.of(context).uri.fragment;

  // Glides once the route's entrance has finished, so the slide-in and the
  // scroll don't fight; [target] ends up just under the navbar.
  static void glide(
    BuildContext context,
    ScrollController scroll,
    GlobalKey target,
  ) {
    void go() => WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = target.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached || !scroll.hasClients) return;
      final to =
          (scroll.offset +
                  scrolledTopOf(box, scroll.position) -
                  NavBar.height)
              .clamp(0.0, scroll.position.maxScrollExtent);
      if (MediaQuery.disableAnimationsOf(target.currentContext!)) {
        scroll.jumpTo(to);
      } else {
        scroll.animateTo(
          to,
          duration: Motion.glideBetweenYears,
          curve: MotionCurves.standard,
        );
      }
    });

    final entrance = ModalRoute.of(context)?.animation;
    if (entrance == null || entrance.isCompleted) return go();
    late final AnimationStatusListener onStatus;
    onStatus = (status) {
      if (!status.isCompleted) return;
      entrance.removeStatusListener(onStatus);
      go();
    };
    entrance.addStatusListener(onStatus);
  }
}
