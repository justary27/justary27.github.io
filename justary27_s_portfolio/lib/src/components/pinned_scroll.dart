import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import 'navbar.dart';
import 'pinned_steps.dart';

// Holds its child under the navbar while the page scrolls `travel` pixels,
// reporting how far it has gone so the child can scroll something inside.
class PinnedScroll extends StatefulWidget {
  final double pinnedHeight;
  final double travel;
  final double pinTop;
  final Widget Function(BuildContext context, ValueListenable<double> travelled)
  builder;

  const PinnedScroll({
    super.key,
    required this.pinnedHeight,
    required this.travel,
    required this.builder,
    this.pinTop = NavBar.height,
  });

  @override
  State<PinnedScroll> createState() => _PinnedScrollState();
}

class _PinnedScrollState extends State<PinnedScroll> {
  final ValueNotifier<double> _travelled = ValueNotifier(0);
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _sync();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (position == _scrollPosition) return;
    _scrollPosition?.removeListener(_sync);
    _scrollPosition = position;
    _scrollPosition?.addListener(_sync);
  }

  @override
  void didUpdateWidget(PinnedScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.travel != widget.travel) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _sync();
      });
    }
  }

  void _sync() {
    final box = context.findRenderObject() as RenderBox?;
    final position = _scrollPosition;
    if (box == null || !box.hasSize || position == null) return;
    final top = scrolledTopOf(box, position);
    _travelled.value = (widget.pinTop - top).clamp(0.0, widget.travel);
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_sync);
    _travelled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.pinnedHeight + widget.travel,
      child: Align(
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder<double>(
          valueListenable: _travelled,
          builder: (context, offset, child) {
            return Transform.translate(offset: Offset(0, offset), child: child);
          },
          child: SizedBox(
            height: widget.pinnedHeight,
            child: widget.builder(context, _travelled),
          ),
        ),
      ),
    );
  }
}
