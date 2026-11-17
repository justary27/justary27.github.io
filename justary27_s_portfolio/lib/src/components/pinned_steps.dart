import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:material_ui/material_ui.dart';

import '../themes/motion.dart';
import 'navbar.dart';

// Where `box`'s top sits on screen at the position's current offset. Scroll
// listeners fire before the next layout, so the box's own on-screen position
// is a frame old there. Its place in the scroll content doesn't move, so
// measure that instead (getOffsetToReveal would subtract pinned headers).
double scrolledTopOf(RenderBox box, ScrollPosition position) {
  final double boxTop = box.localToGlobal(Offset.zero).dy;
  RenderBox content = box;
  RenderObject? node = box.parent;
  while (node != null) {
    if (node is RenderSliverSingleBoxAdapter && node.child != null) {
      final inside = boxTop - node.child!.localToGlobal(Offset.zero).dy;
      return _viewportTop(node) +
          node.constraints.precedingScrollExtent +
          inside -
          position.pixels;
    }
    if (node is RenderAbstractViewport && node is RenderBox) {
      final inside = boxTop - content.localToGlobal(Offset.zero).dy;
      return (node as RenderBox).localToGlobal(Offset.zero).dy +
          inside -
          position.pixels;
    }
    if (node is RenderBox) content = node;
    node = node.parent;
  }
  return boxTop;
}

double _viewportTop(RenderObject sliver) {
  final viewport = RenderAbstractViewport.maybeOf(sliver);
  return viewport is RenderBox
      ? (viewport as RenderBox).localToGlobal(Offset.zero).dy
      : 0;
}

// The page scrolls normally. Progress through a tall section picks a target
// step, and the UI walks there one step at a time so big scrolls never skip.
class PinnedSteps extends StatefulWidget {
  final int stepCount;
  final double pinnedHeight;
  final double scrollHeight;
  final double pinTop;
  final Widget Function(BuildContext context, int step) builder;
  // Pause after moving from one step to the next; Motion.step by default.
  final Duration Function(int from, int to)? stepDelay;

  const PinnedSteps({
    super.key,
    required this.stepCount,
    required this.pinnedHeight,
    required this.scrollHeight,
    required this.builder,
    this.pinTop = NavBar.height,
    this.stepDelay,
  });

  @override
  State<PinnedSteps> createState() => _PinnedStepsState();
}

class _PinnedStepsState extends State<PinnedSteps> {
  final ValueNotifier<double> _pinOffset = ValueNotifier(0);
  final ValueNotifier<int> _step = ValueNotifier(0);
  ScrollPosition? _scrollPosition;
  int _target = 0;
  Timer? _walkTimer;

  double get _pinTravel => widget.scrollHeight - widget.pinnedHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _sync();
    });
  }

  // Who and Work swap scroll physics when frozen, which replaces the position.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (position == _scrollPosition) return;
    _scrollPosition?.removeListener(_sync);
    _scrollPosition = position;
    _scrollPosition?.addListener(_sync);
  }

  void _sync() {
    final box = context.findRenderObject() as RenderBox?;
    final position = _scrollPosition;
    if (box == null || !box.hasSize || position == null) return;
    final top = scrolledTopOf(box, position);
    final travelled = (widget.pinTop - top).clamp(0.0, _pinTravel);
    _pinOffset.value = travelled;

    final progress = travelled / _pinTravel;
    final target = (progress * widget.stepCount).floor().clamp(
      0,
      widget.stepCount - 1,
    );
    if (target == _target) return;
    _target = target;
    if (MediaQuery.disableAnimationsOf(context)) {
      _step.value = target;
    } else if (_walkTimer == null) {
      _walk();
    }
  }

  void _walk() {
    final step = _step.value;
    if (step == _target) {
      _walkTimer = null;
      return;
    }
    final next = step + (step < _target ? 1 : -1);
    _step.value = next;
    _walkTimer = Timer(widget.stepDelay?.call(step, next) ?? Motion.step, _walk);
  }

  @override
  void dispose() {
    _walkTimer?.cancel();
    _scrollPosition?.removeListener(_sync);
    _pinOffset.dispose();
    _step.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.scrollHeight,
      child: Align(
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder<double>(
          valueListenable: _pinOffset,
          builder: (context, offset, child) {
            return Transform.translate(offset: Offset(0, offset), child: child);
          },
          child: SizedBox(
            height: widget.pinnedHeight,
            child: ValueListenableBuilder<int>(
              valueListenable: _step,
              builder: (context, step, _) => widget.builder(context, step),
            ),
          ),
        ),
      ),
    );
  }
}
