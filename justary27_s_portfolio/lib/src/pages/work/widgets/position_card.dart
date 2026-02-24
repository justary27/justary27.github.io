import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../components/anchor.dart';
import '../../../enums/work.dart';
import '../../../models/work.dart';

class PositionCard extends StatelessWidget {
  final Position position;
  final Size size;
  final List<WorkExperience> linkedProjects;
  final void Function(String projectId) onProjectTap;

  const PositionCard({
    super.key,
    required this.position,
    required this.size,
    required this.linkedProjects,
    required this.onProjectTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLeftCard(context),
          SizedBox(width: 0.03 * size.width),
          _buildRightGraphics(),
        ],
      ),
    );
  }

  // ============================================================================
  // LEFT CARD
  // ============================================================================
  Widget _buildLeftCard(BuildContext context) {
    return Container(
      width: 0.4 * size.width,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Organization | Role row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                position.organization,
                style: TextStyle(
                  fontFamily: "ABeeZee",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: position.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "|",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.grey.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  position.coreInfo.role,
                  style: TextStyle(
                    fontFamily: "ABeeZee",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withValues(alpha: 0.6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          _buildCoreInfo(),

          const SizedBox(height: 20),

          Container(height: 1, color: Colors.grey.withValues(alpha: 0.5)),

          const SizedBox(height: 20),

          if (linkedProjects.isNotEmpty) ...[
            _buildLinkedProjects(),
            const SizedBox(height: 20),
          ],

          if (position.links.isNotEmpty) _buildLinks(context),
        ],
      ),
    );
  }

  Widget _buildCoreInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              position.coreInfo.duration,
              style: TextStyle(
                fontFamily: "ABeeZee",
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          position.coreInfo.overview,
          style: TextStyle(
            fontFamily: "ABeeZee",
            fontSize: 14,
            height: 1.5,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildLinkedProjects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related Projects',
          style: TextStyle(
            fontFamily: "ABeeZee",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              linkedProjects.map((project) {
                return _ProjectChip(
                  project: project,
                  onTap: () => onProjectTap(project.id),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildLinks(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children:
          position.links.map((link) {
            return AnchorButton(
              parentContext: context,
              destUrl: link.url,
              icon: Icon(link.icon, size: 24),
              iconSize: 24,
              color: position.primaryColor,
            );
          }).toList(),
    );
  }

  // ============================================================================
  // RIGHT GRAPHICS
  // ============================================================================
  Widget _buildRightGraphics() {
    final graphic = position.coreGraphic;

    return Expanded(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
        child: Container(
          key: ValueKey(position.id),
          decoration: BoxDecoration(
            color: position.cardBackgroundColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: _buildGraphicContent(graphic),
        ),
      ),
    );
  }

  Widget _buildGraphicContent(Graphic graphic) {
    switch (graphic.type) {
      case GraphicType.image:
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(graphic.path, fit: BoxFit.cover),
        );

      case GraphicType.animation:
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: ModelViewer(
            src: graphic.path,
            alt: graphic.description ?? "3D Animation",
            ar: false,
            autoRotate: true,
            cameraControls: true,
            disableZoom: true,
            interactionPrompt: InteractionPrompt.none,
          ),
        );

      case GraphicType.diagram:
      case GraphicType.stats:
        return Center(
          child: Text(
            graphic.description ?? "Graphic Content",
            style: const TextStyle(
              fontFamily: "ABeeZee",
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        );
    }
  }
}

// ============================================================================
// PROJECT CHIP
// ============================================================================
class _ProjectChip extends StatefulWidget {
  final WorkExperience project;
  final VoidCallback onTap;

  const _ProjectChip({required this.project, required this.onTap});

  @override
  State<_ProjectChip> createState() => _ProjectChipState();
}

class _ProjectChipState extends State<_ProjectChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color:
                _isHovered
                    ? widget.project.primaryColor
                    : widget.project.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.project.primaryColor.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.open_in_new_rounded,
                size: 12,
                color: _isHovered ? Colors.white : widget.project.primaryColor,
              ),
              const SizedBox(width: 6),
              Text(
                widget.project.company,
                style: TextStyle(
                  fontFamily: "ABeeZee",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color:
                      _isHovered ? Colors.white : widget.project.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
