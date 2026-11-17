import 'package:material_ui/material_ui.dart';

import 'pinned_steps.dart';

class InkOnView extends StatefulWidget {
  final Duration duration;
  final Curve curve;
  final double viewportFraction;
  final Widget Function(BuildContext context, Animation<double> ink) builder;

  const InkOnView({
    super.key,
    required this.duration,
    required this.curve,
    required this.builder,
    this.viewportFraction = 1,
  });

  @override
  State<InkOnView> createState() => _InkOnViewState();
}

class _InkOnViewState extends State<InkOnView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _ink;
  ScrollPosition? _scrollPosition;
  bool _hasInked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _ink = CurvedAnimation(parent: _controller, curve: widget.curve);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _inkOnceVisible();
    });
  }

  // Who and Work swap scroll physics when frozen, which replaces the position.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (_hasInked || position == _scrollPosition) return;
    _scrollPosition?.removeListener(_inkOnceVisible);
    _scrollPosition = position;
    _scrollPosition?.addListener(_inkOnceVisible);
  }

  void _inkOnceVisible() {
    if (_hasInked) return;
    final box = context.findRenderObject() as RenderBox?;
    final position = _scrollPosition;
    if (box == null || !box.hasSize || position == null) return;
    final top = scrolledTopOf(box, position);
    if (top >= widget.viewportFraction * MediaQuery.sizeOf(context).height) {
      return;
    }

    _hasInked = true;
    _scrollPosition?.removeListener(_inkOnceVisible);
    _scrollPosition = null;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_inkOnceVisible);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _ink);
}
