import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../enums/work.dart';
import '../../../models/work.dart';
import '../../../components/anchor.dart';

// Work Experience Card Component
class WorkExperienceCard extends StatelessWidget {
  final WorkExperience experience;
  final int activePointIndex;
  final Size size;

  const WorkExperienceCard({
    super.key,
    required this.experience,
    required this.activePointIndex,
    required this.size,
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

  Widget _buildLeftCard(BuildContext context) {
    return Container(
      width: 0.4 * size.width,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Company | Role row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                experience.company,
                style: TextStyle(
                  fontFamily: "ABeeZee",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: experience.primaryColor,
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

              // Role (keeps its original style)
              Text(
                experience.coreInfo.role,
                style: TextStyle(
                  fontFamily: "ABeeZee",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),

          _buildCoreInfo(),

          const SizedBox(height: 20),

          Container(height: 1, color: Colors.grey.withValues(alpha: 0.5)),

          const SizedBox(height: 20),

          _buildPointsList(),

          const SizedBox(height: 20),

          if (experience.links.isNotEmpty) ...[_buildLinks(context)],
        ],
      ),
    );
  }

  Widget _buildCoreInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              experience.coreInfo.duration,
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
          experience.coreInfo.overview,
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

  Widget _buildPointsList() {
    return Column(
      children: List.generate(experience.scrollablePoints.length, (index) {
        final point = experience.scrollablePoints[index];
        final isActive = index == activePointIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                isActive
                    ? (point.highlightColor ?? experience.highlightColor)
                        .withValues(alpha: 0.12)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  isActive
                      ? (point.highlightColor ?? experience.highlightColor)
                      : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(top: 6, right: 10),
                width: isActive ? 8 : 6,
                height: isActive ? 8 : 6,
                decoration: BoxDecoration(
                  color: isActive ? experience.primaryColor : Colors.grey[400],
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  point.text,
                  style: TextStyle(
                    fontFamily: "ABeeZee",
                    fontSize: isActive ? 14 : 13,
                    height: 1.4,
                    color: isActive ? Colors.black87 : Colors.grey[600],
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLinks(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children:
          experience.links.map((link) {
            return AnchorButton(
              parentContext: context,
              destUrl: link.url,
              icon: Icon(link.icon, size: 24),
              iconSize: 24,
              color: experience.primaryColor,
            );
          }).toList(),
    );
  }

  Widget _buildRightGraphics() {
    final graphic =
        activePointIndex == -1
            ? experience.coreGraphic
            : experience.scrollablePoints[activePointIndex].graphic;

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
          key: ValueKey('${experience.id}-$activePointIndex'),
          decoration: BoxDecoration(
            color: experience.cardBackgroundColor,
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
