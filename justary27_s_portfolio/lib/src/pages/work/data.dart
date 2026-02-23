import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../enums/work.dart';
import '../../models/work.dart';

class WorkExperienceData {
  static final List<WorkExperience> experiences = [
    // -------------------------------------------------------------------------
    // CloudDefense.AI
    // -------------------------------------------------------------------------
    WorkExperience(
      id: 'clouddefense',
      company: 'CloudDefense.AI',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/cdai.gltf',
      ),
      coreInfo: const CoreInfo(
        role: 'Cloud Security Research Intern',
        duration: 'Dec 2023 - Jun 2024',
        overview:
            'CloudDefense is a comprehensive platform for CNAPP and infrastructure security, encompassing CSPM, CIEM, CWP, and Kubernetes Security Posture Management (KSPM)',
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
      // No public links — internal product, per original commented code
      links: const [],
      primaryColor: const Color(0xFF56958F),
      secondaryColor: const Color(0xFF389583),
      highlightColor: const Color(0xFF82F6B0),
      cardBackgroundColor: const Color(0xFFF5F9F8),
    ),

    // -------------------------------------------------------------------------
    // Amazon
    // -------------------------------------------------------------------------
    WorkExperience(
      id: 'amazon',
      company: 'Amazon',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/amazon.gltf',
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
          label: 'Amazon',
          url: 'https://www.amazon.com',
          icon: FontAwesomeIcons.amazon,
        ),
      ],
      primaryColor: const Color(0xFFFF9900),
      secondaryColor: const Color(0xFF146EB4),
      highlightColor: const Color(0xFFFFD699),
      cardBackgroundColor: const Color(0xFFFFF9F0),
    ),
  ];
}

/// Projects reuse the WorkExperience model — same scroll-jacking structure.
/// Replace placeholder paths and text with real assets when ready.
class ProjectData {
  static final List<WorkExperience> projects = [
    // -------------------------------------------------------------------------
    // Placement Online
    // -------------------------------------------------------------------------
    WorkExperience(
      id: 'placement_online',
      company: 'Placement Online',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/placement.gltf',
      ),
      coreInfo: const CoreInfo(
        role: 'Mobile Application',
        duration: '2022 - Present',
        overview:
            'IIT Roorkee\'s official placement mobile app, used by students to view companies, apply for opportunities, and track results. Active user base of 2000+ students.',
      ),
      scrollablePoints: const [
        ScrollablePoint(
          text:
              'Launched the app on iOS, making it available to the entire campus community',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/placement.gltf',
          ),
        ),
        ScrollablePoint(
          text:
              'Maintained an active user base of 2000+ students across placement and internship cycles',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/placement.gltf',
          ),
        ),
      ],
      links: const [
        WorkLink(
          label: 'GitHub',
          url: 'https://github.com/IMGIITRoorkee/placement-flutter',
          icon: FontAwesomeIcons.github,
        ),
        WorkLink(
          label: 'Play Store',
          url:
              'https://play.google.com/store/apps/details?id=com.channeli.img.placementonline',
          icon: FontAwesomeIcons.googlePlay,
        ),
        WorkLink(
          label: 'App Store',
          url:
              'https://apps.apple.com/in/app/channel-i-placement-online/id1667945708',
          icon: FontAwesomeIcons.appStoreIos,
        ),
      ],
      primaryColor: const Color(0xFF0E2B85),
      secondaryColor: const Color(0xFF1A3FAA),
      highlightColor: const Color(0xFFB8C6FF),
      cardBackgroundColor: const Color(0xFFF5F6FF),
    ),

    // -------------------------------------------------------------------------
    // Noticeboard
    // -------------------------------------------------------------------------
    WorkExperience(
      id: 'noticeboard',
      company: 'Noticeboard',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/noticeboard.gltf',
      ),
      coreInfo: const CoreInfo(
        role: 'Mobile Application',
        duration: '2021 - Present',
        overview:
            'Official noticeboard app of IIT Roorkee. Revamped and launched on both Android and iOS. Used by the entire campus — students and faculty — with 10,000+ active users.',
      ),
      scrollablePoints: const [
        ScrollablePoint(
          text:
              'Revamped the app from scratch and shipped on both Android and iOS',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/noticeboard.gltf',
          ),
        ),
        ScrollablePoint(
          text: 'Serves 10,000+ active users across the IIT Roorkee campus',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/noticeboard.gltf',
          ),
        ),
      ],
      links: const [
        WorkLink(
          label: 'GitHub',
          url: 'https://github.com/IMGIITRoorkee/noticeboard-mobile-app',
          icon: FontAwesomeIcons.github,
        ),
        WorkLink(
          label: 'Play Store',
          url:
              'https://play.google.com/store/apps/details?id=com.img.noticeboard',
          icon: FontAwesomeIcons.googlePlay,
        ),
        WorkLink(
          label: 'App Store',
          url:
              'https://apps.apple.com/in/app/channel-i-noticeboard/id6443708603',
          icon: FontAwesomeIcons.appStoreIos,
        ),
      ],
      primaryColor: const Color(0xFF389583),
      secondaryColor: const Color(0xFF56958F),
      highlightColor: const Color(0xFF82F6B0),
      cardBackgroundColor: const Color(0xFFF5F9F8),
    ),

    // -------------------------------------------------------------------------
    // Lyf
    // -------------------------------------------------------------------------
    WorkExperience(
      id: 'lyf',
      company: 'Lyf',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/lyf.gltf',
      ),
      coreInfo: const CoreInfo(
        role: 'Personal Project · Mobile Application',
        duration: '2022',
        overview:
            'A todo and diary app that goes beyond the ordinary — reminds you of todos and lets you generate PDFs of your diary entries.',
      ),
      scrollablePoints: const [
        ScrollablePoint(
          text:
              'Built smart todo reminders that surface tasks at the right time',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/lyf.gltf',
          ),
        ),
        ScrollablePoint(
          text:
              'Implemented PDF generation for diary entries — a feature no ordinary diary app has',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/lyf.gltf',
          ),
        ),
      ],
      links: const [
        WorkLink(
          label: 'GitHub',
          url: 'https://github.com/justary27/Lyf',
          icon: FontAwesomeIcons.github,
        ),
        WorkLink(
          label: 'Figma',
          url:
              'https://www.figma.com/file/3lWdqxgt6QpTEOvfW5Vwu1/Lyf?node-id=123%3A2',
          icon: FontAwesomeIcons.figma,
        ),
      ],
      primaryColor: const Color(0xFFA81D13),
      secondaryColor: const Color(0xFFC4261B),
      highlightColor: const Color(0xFFFFB3AF),
      cardBackgroundColor: const Color(0xFFFFF5F5),
    ),

    // -------------------------------------------------------------------------
    // BugHeist UI
    // -------------------------------------------------------------------------
    WorkExperience(
      id: 'bugheist_ui',
      company: 'BugHeist UI',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/gsoc.gltf',
      ),
      coreInfo: const CoreInfo(
        role: 'Open Source · GSoC \'22',
        duration: '2022',
        overview:
            'Contributed to BugHeist, an open-source bug hunting platform, as part of Google Summer of Code 2022 under OWASP.',
      ),
      scrollablePoints: const [
        ScrollablePoint(
          text: 'Contributed 36+ PRs to the BugHeist project during GSoC \'22',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/gsoc.gltf',
          ),
        ),
        ScrollablePoint(
          text: 'Drove ~70% of total contributions to the project that summer',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/gsoc.gltf',
          ),
        ),
      ],
      links: const [
        WorkLink(
          label: 'GitHub',
          url: 'https://github.com/OWASP-BLT/BLT-Flutter',
          icon: FontAwesomeIcons.github,
        ),
        WorkLink(
          label: 'App Store',
          url: 'https://apps.apple.com/us/app/owasp-blt/id6448071954',
          icon: FontAwesomeIcons.appStoreIos,
        ),
        WorkLink(
          label: 'Medium — Beginning',
          url:
              'https://medium.com/@justary27/my-gsoc22-voyage-beginning-4296df5af625',
          icon: FontAwesomeIcons.medium,
        ),
        WorkLink(
          label: 'Medium — Conclusion',
          url:
              'https://medium.com/@justary27/my-gsoc22-voyage-conclusion-e0bf34fec239',
          icon: FontAwesomeIcons.medium,
        ),
      ],
      primaryColor: const Color(0xFFE67E22),
      secondaryColor: const Color(0xFFF39C12),
      highlightColor: const Color(0xFFFFDEB3),
      cardBackgroundColor: const Color(0xFFFFFBF5),
    ),

    // -------------------------------------------------------------------------
    // GSoC '22 — Contributor
    // -------------------------------------------------------------------------
    WorkExperience(
      id: 'gsoc22',
      company: 'GSoC \'22',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/gsoc.gltf',
      ),
      coreInfo: const CoreInfo(
        role: 'Google Summer of Code · Contributor',
        duration: 'May 2022 - Sep 2022',
        overview:
            'Selected as a GSoC contributor under OWASP. Worked on the BugHeist Flutter app, building new features and improving the overall codebase.',
      ),
      scrollablePoints: const [
        ScrollablePoint(
          text:
              'Selected from a competitive applicant pool to contribute to OWASP\'s BugHeist project',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/gsoc.gltf',
          ),
        ),
        ScrollablePoint(
          text:
              'Delivered the full GSoC project scope on time, earning a passing evaluation',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/gsoc.gltf',
          ),
        ),
      ],
      links: const [
        WorkLink(
          label: 'GSoC Archive',
          url:
              'https://summerofcode.withgoogle.com/archive/2022/projects/ShGlbTKv',
          icon: FontAwesomeIcons.google,
        ),
        WorkLink(
          label: 'GitHub',
          url: 'https://github.com/Bugheist/Flutter',
          icon: FontAwesomeIcons.github,
        ),
        WorkLink(
          label: 'Medium — Beginning',
          url:
              'https://medium.com/@justary27/my-gsoc22-voyage-beginning-4296df5af625',
          icon: FontAwesomeIcons.medium,
        ),
        WorkLink(
          label: 'Medium — Conclusion',
          url:
              'https://medium.com/@justary27/my-gsoc22-voyage-conclusion-e0bf34fec239',
          icon: FontAwesomeIcons.medium,
        ),
      ],
      primaryColor: const Color(0xFF4285F4),
      secondaryColor: const Color(0xFF34A853),
      highlightColor: const Color(0xFFB3D1FF),
      cardBackgroundColor: const Color(0xFFF5F8FF),
    ),

    // -------------------------------------------------------------------------
    // CovBot
    // -------------------------------------------------------------------------
    WorkExperience(
      id: 'covbot',
      company: 'CovBot',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/covbot.gltf',
      ),
      coreInfo: const CoreInfo(
        role: 'Personal Project · Discord Bot',
        duration: '2021',
        overview:
            'A COVID-19 information Discord bot built during the pandemic to provide quick, reliable answers to common questions. Featured in Mashable India.',
      ),
      scrollablePoints: const [
        ScrollablePoint(
          text:
              'Built a conversational bot providing accurate COVID-19 information during the pandemic',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/covbot.gltf',
          ),
        ),
        ScrollablePoint(
          text:
              'Featured in Mashable India for helping users find oxygen and community resources',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/covbot.gltf',
          ),
        ),
      ],
      links: const [
        WorkLink(
          label: 'GitHub',
          url: 'https://github.com/justary27/CovBot',
          icon: FontAwesomeIcons.github,
        ),
        WorkLink(
          label: 'Discord',
          url:
              'https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot',
          icon: FontAwesomeIcons.discord,
        ),
        WorkLink(
          label: 'Mashable',
          url:
              'https://in.mashable.com/social-good/22667/covid-discord-group-helps-indians-find-oxygen-answers-and-community',
          icon: FontAwesomeIcons.newspaper,
        ),
      ],
      primaryColor: const Color(0xFF00796B),
      secondaryColor: const Color(0xFF009688),
      highlightColor: const Color(0xFFB2DFDB),
      cardBackgroundColor: const Color(0xFFF5FFFE),
    ),

    // -------------------------------------------------------------------------
    // Jane
    // -------------------------------------------------------------------------
    WorkExperience(
      id: 'jane',
      company: 'Jane',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/jane.gltf',
      ),
      coreInfo: const CoreInfo(
        role: 'Personal Project · Discord Bot',
        duration: '2021',
        overview:
            'A multi-purpose Discord bot to make your stay at Discord comfy — combining utility, fun, and moderation features in one.',
      ),
      scrollablePoints: const [
        ScrollablePoint(
          text:
              'Built a multi-purpose Discord bot with utility, fun, and moderation features',
          graphic: Graphic(
            type: GraphicType.animation,
            path: 'assets/models/jane.gltf',
          ),
        ),
      ],
      links: const [
        WorkLink(
          label: 'Web',
          url: 'https://justary27.github.io/Jane/', // TODO: confirm URL
          icon: FontAwesomeIcons.firefoxBrowser,
        ),
        WorkLink(
          label: 'Discord',
          url:
              'https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot',
          icon: FontAwesomeIcons.discord,
        ),
      ],
      primaryColor: const Color(0xFF7B1FA2),
      secondaryColor: const Color(0xFF9C27B0),
      highlightColor: const Color(0xFFE1BEE7),
      cardBackgroundColor: const Color(0xFFFDF5FF),
    ),
  ];
}

class PositionData {
  static final List<Position> positions = [
    // -------------------------------------------------------------------------
    // IMG IIT Roorkee — Chief of Mobile Development & Open Source
    // -------------------------------------------------------------------------
    Position(
      id: 'img_chief',
      organization: 'IMG IIT Roorkee',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/cdai.gltf', // TODO: replace with IMG logo model
      ),
      coreInfo: const CoreInfo(
        role: 'Chief · Mobile Development & Open Source',
        duration: '2021 - 2024',
        overview:
            'Joined IMG IIT Roorkee as a Project Leader and rose to Chief of Mobile Development and Open Source Initiatives. Led multiple institute-level apps, mentored club members, and championed open-source culture across campus.',
      ),
      links: const [
        WorkLink(
          label: 'IMG',
          url: 'https://img.channeli.in',
          icon: FontAwesomeIcons.globe,
        ),
      ],
      linkedProjectIds: ['noticeboard', 'placement_online'],
      primaryColor: const Color(0xFF0E2B85),
      secondaryColor: const Color(0xFF1A3FAA),
      highlightColor: const Color(0xFFB8C6FF),
      cardBackgroundColor: Colors.white,
    ),

    // -------------------------------------------------------------------------
    // GSoC '23 — Mentor
    // -------------------------------------------------------------------------
    Position(
      id: 'gsoc23_mentor',
      organization: 'GSoC \'23',
      coreGraphic: Graphic(
        type: GraphicType.animation,
        path: 'assets/models/gsoc.gltf',
      ),
      coreInfo: const CoreInfo(
        role: 'Google Summer of Code · Mentor',
        duration: 'May 2023 - Sep 2023',
        overview:
            'Returned to OWASP\'s BugHeist project — this time as a mentor. Selected and guided contributors through their GSoC journey, reviewing PRs and shaping the project roadmap.',
      ),
      links: const [
        WorkLink(
          label: 'GSoC Archive',
          url:
              'https://summerofcode.withgoogle.com/archive/2023/projects/FrMdpNvR',
          icon: FontAwesomeIcons.google,
        ),
        WorkLink(
          label: 'GitHub',
          url: 'https://github.com/OWASP-BLT/BLT-Flutter',
          icon: FontAwesomeIcons.github,
        ),
      ],
      linkedProjectIds: ['bugheist_ui', 'gsoc22'],
      primaryColor: const Color(0xFF4285F4),
      secondaryColor: const Color(0xFF34A853),
      highlightColor: const Color(0xFFB3D1FF),
      cardBackgroundColor: Colors.white,
    ),
  ];
}
