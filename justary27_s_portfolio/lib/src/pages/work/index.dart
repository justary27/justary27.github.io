import 'package:material_ui/material_ui.dart';

import '../../components/fit.dart';
import '../../components/footer.dart';
import '../../components/landing.dart';
import '../../components/navbar.dart';
import '../../components/pinned_steps.dart';
import '../../enums/layout.dart';
import '../../themes/colors.dart';
import '../../themes/dimens.dart';
import '../../themes/motion.dart';
import '../../themes/route_ink.dart';
import '../../themes/typography.dart';
import 'data.dart';
import 'widgets/experience_section.dart';
import 'widgets/github_band.dart';
import 'widgets/positions_section.dart';
import 'widgets/projects_section.dart';

const String _placeholder = "<placeholder>";
const double _contentWidth = 1152;
const double _barHeight = 64;
const Color _barGround = Color(0xFFECF0F0);

enum WorkSection { experience, projects, positions }

extension on WorkSection {
  String get label => switch (this) {
    WorkSection.experience => "Experience",
    WorkSection.projects => "Projects",
    WorkSection.positions => "Positions",
  };
}

// GitHub orgs the work data links to, other than his own account.
final List<String> _githubOrgs = {
  for (final entry in [
    ...WorkExperienceData.experiences,
    ...ProjectData.projects,
  ])
    for (final link in entry.links)
      ?RegExp(r'github\.com/([^/]+)/').firstMatch(link.url)?.group(1),
  for (final position in PositionData.positions)
    for (final link in position.links)
      ?RegExp(r'github\.com/([^/]+)/').firstMatch(link.url)?.group(1),
}.where((org) => org != "justary27").toList();

class WorkPage extends StatefulWidget {
  final Size size;

  const WorkPage({super.key, required this.size});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  final ScrollController _scroll = ScrollController();
  final Map<WorkSection, GlobalKey> _keys = {
    for (final s in WorkSection.values) s: GlobalKey(),
  };
  final ValueNotifier<WorkSection> _current = ValueNotifier(
    WorkSection.experience,
  );
  // The bar's right-hand label, one per section (step, project, position).
  final Map<WorkSection, ValueNotifier<String>> _labels = {
    for (final s in WorkSection.values) s: ValueNotifier(""),
  };
  final GlobalKey<ExperienceSectionState> _experience = GlobalKey();
  final GlobalKey _pageLine = GlobalKey();
  final ProjectRowController _projects = ProjectRowController(
    count: ProjectData.projects.length,
  );

  // Content starts under the navbar, then under the docked pill bar.
  double get _dockedTop => NavBar.height + _barHeight;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_track);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && Landing.of(context) == Landing.work) {
        Landing.glide(context, _scroll, _pageLine);
      }
    });
  }

  @override
  void dispose() {
    _scroll.removeListener(_track);
    _scroll.dispose();
    _current.dispose();
    for (final label in _labels.values) {
      label.dispose();
    }
    _projects.dispose();
    super.dispose();
  }

  // Measured from the scroll offset: the listener runs before layout, so the
  // box's own on-screen position would be a frame old.
  double? _topOf(WorkSection section) {
    final box =
        _keys[section]!.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !_scroll.hasClients) return null;
    return scrolledTopOf(box, _scroll.position);
  }

  // The current pill is the last section whose top has reached the bar.
  void _track() {
    WorkSection current = WorkSection.experience;
    for (final section in WorkSection.values) {
      final top = _topOf(section);
      if (top != null && top <= _dockedTop + 1) current = section;
    }
    _current.value = current;
  }

  void _jump(WorkSection section) {
    final top = _topOf(section);
    if (top == null) return;
    final target = (_scroll.offset + top - _dockedTop).clamp(
      0.0,
      _scroll.position.maxScrollExtent,
    );
    if (MediaQuery.disableAnimationsOf(context)) {
      _scroll.jumpTo(target);
    } else {
      _scroll.animateTo(
        target,
        duration: Motion.glideBetweenYears,
        curve: MotionCurves.standard,
      );
    }
  }

  // Positions' "Led →" chips: glide to Projects and turn the row to it.
  void _showProject(String id) {
    final index = ProjectData.projects.indexWhere((p) => p.id == id);
    if (index < 0) return;
    _jump(WorkSection.projects);
    _projects.go(context, index);
  }

  @override
  Widget build(BuildContext context) {
    final double gutter = (0.04 * widget.size.width).clamp(16, double.infinity);
    final ink = RouteInk.work;

    // The scroll view starts under the navbar, so the pill bar docks at its
    // top edge and nothing scrolls behind the bar.
    return DecoratedBox(
      decoration: BoxDecoration(gradient: ink.ground),
      child: Padding(
        padding: const EdgeInsets.only(top: NavBar.height),
        child: CustomScrollView(
          controller: _scroll,
          slivers: [
            SliverToBoxAdapter(
              child: RouteHero(
                title: "Work.",
                gradient: ink.hero,
                color: ink.ink,
                width: widget.size.width,
              ),
            ),
            SliverToBoxAdapter(
              child: _Column(
                key: _pageLine,
                gutter: gutter,
                padding: const EdgeInsets.only(top: Space.s96, bottom: 40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Text(
                    _placeholder,
                    style: AppText.bodyL.copyWith(color: AppColors.ink700),
                  ),
                ),
              ),
            ),
            // The pill bar docks under the navbar for these three sections and
            // releases with the group, before the GitHub band.
            SliverMainAxisGroup(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _BarDelegate(
                    gutter: gutter,
                    current: _current,
                    labels: _labels,
                    onPick: _jump,
                  ),
                ),
                // One block, so every section is laid out whenever the bar is
                // on screen and the pills can measure where to jump.
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final section in WorkSection.values)
                        KeyedSubtree(
                          key: _keys[section],
                          child: _SectionShell(
                            section: section,
                            gutter: gutter,
                            trailing: section == WorkSection.projects
                                ? ProjectArrows(
                                    controller: _projects,
                                    projects: ProjectData.projects,
                                  )
                                : null,
                            child: section == WorkSection.experience
                                ? ExperienceSection(
                                    key: _experience,
                                    companies: WorkExperienceData.experiences,
                                    viewportHeight: widget.size.height,
                                    gutter: gutter,
                                    pinTop: _dockedTop,
                                    onStepLabel: (l) =>
                                        _labels[section]!.value = l,
                                  )
                                : section == WorkSection.projects
                                ? ProjectsSection(
                                    projects: ProjectData.projects,
                                    controller: _projects,
                                    gutter: gutter,
                                    onLabel: (l) => _labels[section]!.value = l,
                                  )
                                : PositionsSection(
                                    positions: PositionData.positions,
                                    projects: ProjectData.projects,
                                    gutter: gutter,
                                    onLabel: (l) => _labels[section]!.value = l,
                                    onExperience: (id) => _experience
                                        .currentState
                                        ?.showCompany(id),
                                    onProject: _showProject,
                                  ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: GitHubBand(gutter: gutter, orgs: _githubOrgs),
            ),
            SliverToBoxAdapter(child: Footer(size: widget.size)),
          ],
        ),
      ),
    );
  }
}

class _Column extends StatelessWidget {
  final double gutter;
  final EdgeInsets padding;
  final Widget child;

  const _Column({
    super.key,
    required this.gutter,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding.add(EdgeInsets.symmetric(horizontal: gutter)),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _contentWidth),
          child: Align(alignment: Alignment.centerLeft, child: child),
        ),
      ),
    );
  }
}

class _BarDelegate extends SliverPersistentHeaderDelegate {
  final double gutter;
  final ValueNotifier<WorkSection> current;
  final Map<WorkSection, ValueNotifier<String>> labels;
  final ValueChanged<WorkSection> onPick;

  _BarDelegate({
    required this.gutter,
    required this.current,
    required this.labels,
    required this.onPick,
  });

  @override
  double get minExtent => _barHeight;

  @override
  double get maxExtent => _barHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final ink = RouteInk.work.ink;
    final phone = Layout.of(MediaQuery.sizeOf(context)).isPhone;
    return Container(
      height: _barHeight,
      padding: EdgeInsets.symmetric(horizontal: gutter),
      decoration: BoxDecoration(
        color: _barGround,
        border: Border(bottom: BorderSide(color: ink.withValues(alpha: 0.12))),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _contentWidth),
          child: ValueListenableBuilder<WorkSection>(
            valueListenable: current,
            builder: (context, selected, _) => Row(
              spacing: Space.s8,
              children: [
                for (final section in WorkSection.values)
                  _SectionPill(
                    label: section.label,
                    selected: section == selected,
                    small: phone,
                    onTap: () => onPick(section),
                  ),
                // Where you are inside the current section; truncates on
                // narrow windows rather than pushing past the edge. A phone
                // only has room for the pills.
                if (!phone)
                  Expanded(
                    child: ValueListenableBuilder<String>(
                      valueListenable: labels[selected]!,
                      builder: (context, label, _) => Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: AppText.meta.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.56,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_BarDelegate oldDelegate) =>
      oldDelegate.gutter != gutter || oldDelegate.current != current;
}

class _SectionPill extends StatelessWidget {
  final String label;
  final bool selected;
  // Phone: tighter, so all three fit at 360.
  final bool small;
  final VoidCallback onTap;

  const _SectionPill({
    required this.label,
    required this.selected,
    required this.small,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ink = RouteInk.work.ink;
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? ink : Colors.transparent,
        shape: StadiumBorder(side: BorderSide(color: ink, width: 1.5)),
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          splashFactory: NoSplash.splashFactory,
          hoverColor: ink.withValues(alpha: 0.06),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: small ? 7 : Space.s8,
              horizontal: small ? 13 : Space.s16,
            ),
            child: Text(
              label,
              style: AppText.label.copyWith(
                fontSize: small ? 13 : null,
                color: selected ? Colors.white : ink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionShell extends StatelessWidget {
  final WorkSection section;
  final double gutter;
  final Widget child;
  // Sits at the right of the heading, e.g. the Projects arrows.
  final Widget? trailing;

  const _SectionShell({
    required this.section,
    required this.gutter,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final double top = section == WorkSection.experience ? 72 : 64.0;
    final phone = Layout.of(MediaQuery.sizeOf(context)).isPhone;
    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Space.s8,
      children: [
        Text(section.label, style: AppText.h2.copyWith(fontSize: 40)),
        Text(
          _placeholder,
          style: AppText.body.copyWith(fontSize: 18, color: AppColors.ink700),
        ),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Column(
          gutter: gutter,
          padding: EdgeInsets.only(top: top),
          child: phone && trailing != null
              // Phone: the trailing control drops under the heading and
              // scrolls sideways if it's wider than the screen.
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 18,
                  children: [
                    heading,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: trailing,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: heading),
                    ?trailing,
                  ],
                ),
        ),
        child,
      ],
    );
  }
}
