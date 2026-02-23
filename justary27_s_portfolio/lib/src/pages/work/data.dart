import 'package:flutter/material.dart';
import '../../enums/work.dart';
import '../../models/work.dart';

class WorkExperienceData {
  static final List<WorkExperience> experiences = [
    // CloudDefense.AI
    WorkExperience(
      id: 'clouddefense',
      company: 'CloudDefense.AI',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/cdai.gltf', // Your logo model
      ),
      coreInfo: const CoreInfo(
        role: 'Cloud Security Research Intern',
        duration: 'Dec 2023 - Jun 2024',
        overview:
            'CloudDefense is a comprehensive platform for CNAPP and infrastructure security, encompassing CSPM, CIEM,CWP, and Kubernetes Security Posture Management (KSPM)',
      ),
      scrollablePoints: const [
        ScrollablePoint(
          text:
              'Implemented end-to-end unit test module for various modules of the Adaptive Cloud Security platform from scratch',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/cdai.gltf',
            description: 'CloudDefense Platform Testing',
          ),
        ),
        ScrollablePoint(
          text:
              'Reduced test execution costs by 90% by minimizing infrastructure runtime through optimized test strategies',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/cdai.gltf',
            description: 'Cost Optimization Results',
          ),
        ),
        ScrollablePoint(
          text:
              'Wrote comprehensive test suites covering AWS, Azure, and GCP integrations using Terraform and Docker',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/cdai.gltf',
            description: 'Multi-Cloud Testing',
          ),
        ),
        ScrollablePoint(
          text:
              'Deployed tests into CI/CD pipeline through GitHub workflows ensuring continuous quality checks',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/cdai.gltf',
            description: 'CI/CD Integration',
          ),
        ),
      ],
      links: const [
        WorkLink(
          label: 'Website',
          url: 'https://clouddefense.ai',
          icon: Icons.language,
        ),
      ],
      primaryColor: const Color(0xFF56958F),
      secondaryColor: const Color(0xFF389583),
      highlightColor: const Color(0xFF82F6B0),
      cardBackgroundColor: const Color(0xFFF5F9F8),
    ),

    // Amazon
    WorkExperience(
      id: 'amazon',
      company: 'Amazon',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/cdai.gltf', // Your logo model
      ),
      coreInfo: const CoreInfo(
        role: 'Software Development Engineer Intern',
        duration: 'May 2023 - Jul 2023',
        overview:
            'Developed staging website for Prime Video campaign previews and achieved 2% reduction in customer impact.',
      ),
      scrollablePoints: const [
        ScrollablePoint(
          text:
              'Developed and deployed a staging website for campaign previews on the Market Landing Page',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/amazon.gltf',
            description: 'Staging Website Interface',
          ),
        ),
        ScrollablePoint(
          text:
              'Achieved a 2% (1,200,000+ users) reduction in customer impact on the MLP page through better preview capabilities',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/amazon.gltf',
            description: 'Impact Metrics',
          ),
        ),
        ScrollablePoint(
          text:
              'Built the solution using React, Sass, and AWS services following Amazon\'s best practices',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/amazon.gltf',
            description: 'Technology Stack',
          ),
        ),
        ScrollablePoint(
          text:
              'Integrated the staging platform with CI/CD pipelines for automated deployment and testing',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/amazon.gltf',
            description: 'Deployment Pipeline',
          ),
        ),
        ScrollablePoint(
          text:
              'Collaborated with Prime Video team to ensure seamless integration with existing infrastructure',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/amazon.gltf',
            description: 'Team Collaboration',
          ),
        ),
      ],
      links: const [
        WorkLink(
          label: 'Prime Video',
          url: 'https://www.primevideo.com',
          icon: Icons.play_circle_outline,
        ),
      ],
      primaryColor: const Color(0xFFFF9900),
      secondaryColor: const Color(0xFF146EB4),
      highlightColor: const Color(0xFFFFD699),
      cardBackgroundColor: const Color(0xFFFFF9F0),
    ),
  ];
}
