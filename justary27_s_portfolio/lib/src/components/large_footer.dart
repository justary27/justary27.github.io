import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/route.dart';
import '../enums/device_type.dart';
import '../themes/colors.dart';
import '../themes/dimens.dart';
import '../themes/motion.dart';
import '../themes/typography.dart';
import 'ar_mark_painter.dart';
import 'contact.dart';
import 'pill_button.dart';

class LargeFooter extends StatefulWidget {
  final Size size;

  const LargeFooter({super.key, required this.size});

  @override
  State<LargeFooter> createState() => _LargeFooterState();
}

class _LargeFooterState extends State<LargeFooter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _inkController;
  late final Animation<double> _ink;
  ScrollPosition? _scrollPosition;
  bool _hasInked = false;

  @override
  void initState() {
    super.initState();
    _inkController = AnimationController(
      vsync: this,
      duration: Motion.slowDraw,
    );
    _ink = CurvedAnimation(parent: _inkController, curve: MotionCurves.draw);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _drawInkOnceVisible();
    });
  }

  // Who and Work swap scroll physics when frozen, which replaces the position.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (_hasInked || position == _scrollPosition) return;
    _scrollPosition?.removeListener(_drawInkOnceVisible);
    _scrollPosition = position;
    _scrollPosition?.addListener(_drawInkOnceVisible);
  }

  void _drawInkOnceVisible() {
    if (_hasInked) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    if (top >= MediaQuery.sizeOf(context).height) return;

    _hasInked = true;
    _scrollPosition?.removeListener(_drawInkOnceVisible);
    _scrollPosition = null;
    if (MediaQuery.disableAnimationsOf(context)) {
      _inkController.value = 1;
    } else {
      _inkController.forward();
    }
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_drawInkOnceVisible);
    _inkController.dispose();
    super.dispose();
  }

  void _navigate(String destination) {
    if (GoRouterState.of(context).uri.path != destination) {
      context.push(destination);
    }
  }

  void _openContact() {
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return ContactCard(
          size: widget.size,
          deviceType: DeviceType.getDeviceType(widget.size.width),
        );
      },
    );
  }

  Future<void> _openLink(Uri url) async {
    await launchUrl(url, webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final sidePadding = max(Space.s16, 0.04 * widget.size.width);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.footerSlate),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            right: -40,
            bottom: -74,
            width: 240,
            height: 240 / ArMarkPainter.aspectRatio,
            child: RepaintBoundary(
              child: CustomPaint(
                painter: ArMarkPainter(
                  progress: _ink,
                  color: AppColors.arWatermark,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 56, sidePadding, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1152),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 14,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aryan Ranjan",
                                style: AppText.signatureFooter.copyWith(
                                  color: Colors.white,
                                  height: 0.9,
                                ),
                              ),
                              const SizedBox(height: 14),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 300,
                                ),
                                child: Text(
                                  "<placeholder>",
                                  style: AppText.label.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    color: AppColors.onFooterMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: Space.s40),
                        Expanded(flex: 10, child: _buildLinks()),
                        const SizedBox(width: Space.s40),
                        Expanded(flex: 16, child: _buildActions()),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Container(
                      padding: const EdgeInsets.only(top: 14),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                      child: Text(
                        "© ${DateTime.now().year} Aryan Ranjan",
                        style: AppText.label.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.onFooterMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (label, path) in const [
          ("Work", RouteHandler.workPage),
          ("Who", RouteHandler.whoPage),
          ("Blog", RouteHandler.blogPage),
        ])
          _FooterAction(
            onTap: () => _navigate(path),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                label,
                style: AppText.label.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            PillButton(
              label: "Say hi",
              icon: Icons.mail_outline,
              variant: PillVariant.filled,
              color: Colors.white,
              onColor: AppColors.ink900,
              onPressed: _openContact,
            ),
            PillButton(
              label: "Résumé",
              icon: Icons.file_download_outlined,
              color: Colors.white,
              // Absolute path: Uri.base is the current route, not the site root.
              onPressed: () =>
                  _openLink(Uri.base.resolve("/assets/assets/resume.pdf")),
            ),
          ],
        ),
        const SizedBox(height: Space.s16),
        _FooterAction(
          onTap: _openContact,
          child: Text(
            "writetoranjanaryan@gmail.com",
            style: AppText.label.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.onFooterMuted,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.onFooterMuted,
            ),
          ),
        ),
        const SizedBox(height: Space.s16),
        Transform.translate(
          offset: const Offset(-9, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SocialLink(
                label: "LinkedIn",
                icon: FontAwesomeIcons.linkedin,
                onTap: () => _openLink(
                  Uri.parse("https://www.linkedin.com/in/justary27"),
                ),
              ),
              const SizedBox(width: 14),
              _SocialLink(
                label: "GitHub",
                icon: FontAwesomeIcons.github,
                onTap: () =>
                    _openLink(Uri.parse("https://github.com/justary27")),
              ),
              const SizedBox(width: 14),
              _SocialLink(
                label: "X",
                icon: FontAwesomeIcons.xTwitter,
                onTap: () => _openLink(Uri.parse("https://x.com/JustAry27")),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialLink extends StatelessWidget {
  final String label;
  final FaIconData icon;
  final VoidCallback onTap;

  const _SocialLink({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: _FooterAction(
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(child: FaIcon(icon, size: 26, color: Colors.white)),
        ),
      ),
    );
  }
}

class _FooterAction extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const _FooterAction({required this.onTap, required this.child});

  @override
  State<_FooterAction> createState() => _FooterActionState();
}

class _FooterActionState extends State<_FooterAction> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (hovered) => setState(() => _isHovered = hovered),
      borderRadius: BorderRadius.circular(Radii.small),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.white.withValues(alpha: 0.2),
      child: AnimatedOpacity(
        opacity: _isHovered ? 0.75 : 1,
        duration: Motion.quick,
        curve: MotionCurves.standard,
        child: widget.child,
      ),
    );
  }
}
