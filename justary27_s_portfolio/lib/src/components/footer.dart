import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../constants/contact.dart';
import '../constants/route.dart';
import '../enums/layout.dart';
import '../themes/colors.dart';
import '../themes/dimens.dart';
import '../themes/motion.dart';
import '../themes/typography.dart';
import 'app_link.dart';
import 'ar_mark_painter.dart';
import 'contact_envelope.dart';
import 'ink_on_view.dart';
import 'pill_button.dart';

class Footer extends StatefulWidget {
  final Size size;

  const Footer({super.key, required this.size});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  void _openContact() => showContactEnvelope(context);

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(MediaQuery.sizeOf(context));
    final compact = layout.isCompact;
    final phone = layout.isPhone;
    final signOff = Column(
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
          constraints: const BoxConstraints(maxWidth: 300),
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
    );
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
              child: InkOnView(
                duration: Motion.slowDraw,
                curve: MotionCurves.draw,
                builder: (context, ink) {
                  return CustomPaint(
                    painter: ArMarkPainter(
                      progress: ink,
                      color: AppColors.arWatermark,
                    ),
                  );
                },
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
                    // Tablet: the sign-off across the top, links and
                    // actions in two columns under it.
                    // Phone: everything in one column.
                    if (phone)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 28,
                        children: [signOff, _buildLinks(), _buildActions()],
                      )
                    else if (compact)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: Space.s32,
                        children: [
                          signOff,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: Space.s40,
                            children: [
                              Expanded(child: _buildLinks()),
                              Expanded(child: _buildActions()),
                            ],
                          ),
                        ],
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 14, child: signOff),
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
          AppLink(
            to: path,
            builder: (context, states) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  label,
                  style: AppText.label.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              );
            },
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
              to: ContactHandler.resumeUrl,
            ),
          ],
        ),
        const SizedBox(height: Space.s16),
        AppLink(
          to: ContactHandler.mailto,
          builder: (context, states) {
            return Text(
              ContactHandler.email,
              style: AppText.label.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.onFooterMuted,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.onFooterMuted,
              ),
            );
          },
        ),
        const SizedBox(height: Space.s16),
        Transform.translate(
          offset: const Offset(-9, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppLink.icon(
                label: "LinkedIn",
                icon: const FaIcon(FontAwesomeIcons.linkedin),
                iconSize: 26,
                color: Colors.white,
                to: "https://www.linkedin.com/in/justary27",
              ),
              const SizedBox(width: 14),
              AppLink.icon(
                label: "GitHub",
                icon: const FaIcon(FontAwesomeIcons.github),
                iconSize: 26,
                color: Colors.white,
                to: "https://github.com/justary27",
              ),
              const SizedBox(width: 14),
              AppLink.icon(
                label: "X",
                icon: const FaIcon(FontAwesomeIcons.xTwitter),
                iconSize: 26,
                color: Colors.white,
                to: "https://x.com/JustAry27",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
