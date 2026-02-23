import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnchorButton extends StatefulWidget {
  final Widget icon;
  final Color? color;
  final double? iconSize;
  final String destUrl;
  final BuildContext parentContext;
  const AnchorButton({
    super.key,
    this.color,
    this.iconSize,
    required this.icon,
    required this.destUrl,
    required this.parentContext,
  });

  @override
  State<AnchorButton> createState() => _AnchorButtonState();
}

class _AnchorButtonState extends State<AnchorButton> {
  OverlayEntry _linkText = OverlayEntry(
    builder: (context) => const Placeholder(),
  );

  @override
  void initState() {
    _linkText = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: 0,
          bottom: 0,
          child: Material(
            color: Colors.transparent,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(4),
              child: Text(
                widget.destUrl,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.85)),
              ),
            ),
          ),
        );
      },
    );
    super.initState();
  }

  void _showDestinationLink(PointerEnterEvent event) {
    Overlay.of(widget.parentContext).insert(_linkText);
  }

  void _removeDestinationLink(PointerExitEvent event) {
    _linkText.remove();
  }

  Future<void> _launchLink(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _showDestinationLink,
      onExit: _removeDestinationLink,
      child: IconButton(
        icon: widget.icon,
        iconSize: widget.iconSize,
        color: widget.color,
        onPressed: () => _launchLink(widget.destUrl),
      ),
    );
  }
}
