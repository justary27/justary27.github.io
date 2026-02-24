// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../components/footer.dart';
// import '../../enums/device_type.dart';
// import '../../models/screen.dart';
// import '../../constants/route.dart';
// import '../../providers/screen.dart';
// import '../../components/roorkee_painter.dart';
// import '../../components/promo.dart';

// import 'data.dart';
// import 'constraints.dart';
// import 'painters.dart';

// class WhoPage extends ConsumerStatefulWidget {
//   const WhoPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _WhoPageState();
// }

// class _WhoPageState extends ConsumerState<WhoPage> {
//   @override
//   Widget build(BuildContext context) {
//     Screen screen = ref.watch(screenProvider);
//     DeviceType deviceType = screen.deviceType;

//     return GlowingOverscrollIndicator(
//       axisDirection: AxisDirection.up,
//       color: const Color.fromRGBO(198, 197, 255, 1.0).withValues(alpha: 0.3),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       width: screen.width,
//                       height: 5.5 * screen.height,
//                       decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomLeft,
//                           colors: [
//                             Color.fromRGBO(198, 197, 255, 1.0),
//                             Color.fromRGBO(133, 130, 234, 1.0),
//                           ],
//                         ),
//                       ),
//                       child: CustomPaint(painter: WhoPainter()),
//                     ),
//                     Container(
//                       width: screen.width,
//                       height: screen.height,
//                       decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomLeft,
//                           colors: [
//                             Color.fromRGBO(218, 224, 224, 1.0),
//                             Color.fromRGBO(183, 193, 192, 1.0),
//                           ],
//                         ),
//                       ),
//                       child: CustomPaint(
//                         painter: RoorkeePainter(
//                           const Color.fromRGBO(14, 43, 133, 1.0),
//                           const Color.fromRGBO(184, 194, 215, 1.0),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Container(
//                       width: screen.width,
//                       height: screen.height,
//                       alignment: Alignment.center,
//                       child: Text(
//                         "Who?",
//                         style: TextStyle(
//                           fontFamily: "CoveredByYourGrace",
//                           color: const Color.fromRGBO(14, 43, 133, 1.0),
//                           fontSize: WC.heading[deviceType]! * screen.width,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: screen.width,
//                       height: 1.5 * screen.height,
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 0.25 * screen.width,
//                             height: 1.5 * screen.height,
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 0.1 * screen.width,
//                             ),
//                             width: 0.7 * screen.width,
//                             height: 1.5 * screen.height,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Present",
//                                   style: GoogleFonts.openSans(
//                                     textStyle: TextStyle(
//                                       // fontFamily: "Caveat",
//                                       color: const Color.fromRGBO(
//                                         14,
//                                         43,
//                                         133,
//                                         1.0,
//                                       ),
//                                       fontSize:
//                                           WC.time[deviceType]! * screen.width,
//                                       // fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 Text(
//                                   presentDesc.replaceAll("\n", ""),
//                                   textAlign: TextAlign.left,
//                                   style: GoogleFonts.redHatDisplay(
//                                     textStyle: TextStyle(
//                                       // fontFamily: "ABeeZee",
//                                       color: Colors.black,
//                                       fontSize:
//                                           WC.timeDesc[deviceType]! *
//                                           screen.width,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: screen.width,
//                       height: 1.5 * screen.height,
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 0.1 * screen.width,
//                             ),
//                             width: 0.7 * screen.width,
//                             height: 1.5 * screen.height,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Future",
//                                   style: GoogleFonts.openSans(
//                                     textStyle: TextStyle(
//                                       // fontFamily: "Caveat",
//                                       color: const Color.fromRGBO(
//                                         14,
//                                         43,
//                                         133,
//                                         1.0,
//                                       ),
//                                       fontSize:
//                                           WC.time[deviceType]! * screen.width,
//                                     ),
//                                   ),
//                                 ),
//                                 Text(
//                                   futureDesc.replaceAll("\n", ""),
//                                   textAlign: TextAlign.left,
//                                   style: GoogleFonts.redHatDisplay(
//                                     textStyle: TextStyle(
//                                       // fontFamily: "ABeeZee",
//                                       color: Colors.black,
//                                       fontSize:
//                                           WC.timeDesc[deviceType]! *
//                                           screen.width,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 0.25 * screen.width,
//                             height: 1.5 * screen.height,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: screen.width,
//                       height: 1.5 * screen.height,
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 0.25 * screen.width,
//                             height: 1.5 * screen.height,
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 0.1 * screen.width,
//                             ),
//                             width: 0.7 * screen.width,
//                             height: 1.5 * screen.height,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Past",
//                                   style: GoogleFonts.openSans(
//                                     textStyle: TextStyle(
//                                       // fontFamily: "Caveat",
//                                       color: const Color.fromRGBO(
//                                         14,
//                                         43,
//                                         133,
//                                         1.0,
//                                       ),
//                                       fontSize:
//                                           WC.time[deviceType]! * screen.width,
//                                     ),
//                                   ),
//                                 ),
//                                 Text(
//                                   pastDesc.replaceAll("\n", ""),
//                                   textAlign: TextAlign.left,
//                                   style: GoogleFonts.redHatDisplay(
//                                     textStyle: TextStyle(
//                                       // fontFamily: "ABeeZee",
//                                       color: Colors.black,
//                                       fontSize:
//                                           WC.timeDesc[deviceType]! *
//                                           screen.width,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     PromoRedirector(
//                       size: screen.getScreenSize(),
//                       deviceType: deviceType,
//                       pageName: "Blog",
//                       pageDescriptor: "Know more 'bout me!",
//                       button: TextButton.icon(
//                         icon: Icon(
//                           Icons.arrow_forward_ios_rounded,
//                           color: Colors.white.withValues(alpha: 0.7),
//                         ),
//                         onPressed: () {
//                           context.push(RouteHandler.blogPage);
//                         },
//                         label: Text(
//                           "Blog",
//                           style: TextStyle(
//                             fontFamily: "ABeeZee",
//                             color: Colors.white.withValues(alpha: 0.7),
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Footer(size: screen.getScreenSize()),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/footer.dart';
import '../../models/screen.dart';
import '../../providers/screen.dart';

import 'data.dart';
import 'painters.dart';
import 'constraints.dart';

// =============================================================================
// PAGE
// =============================================================================
class WhoPage extends ConsumerStatefulWidget {
  const WhoPage({super.key});

  @override
  ConsumerState<WhoPage> createState() => _WhoPageState();
}

class _WhoPageState extends ConsumerState<WhoPage>
    with TickerProviderStateMixin {
  // ---------------------------------------------------------------------------
  // Constants
  // ---------------------------------------------------------------------------
  static const double _scrollDeltaIgnoreThreshold = 0.5;
  static const double _scrollThresholdMultiplier = 0.35;

  // ---------------------------------------------------------------------------
  // Scroll state
  // ---------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();

  /// Which section we're frozen in (0 = Present, 1 = Past, 2 = Future).
  /// -1 means not frozen.
  int _frozenSectionIndex = -1;
  int _currentStepIndex = 0;
  double _accumulatedDelta = 0;
  bool _isTransitioning = false;

  bool get _isFrozen => _frozenSectionIndex >= 0;

  // ---------------------------------------------------------------------------
  // Animation controllers
  // ---------------------------------------------------------------------------
  late final AnimationController _circleController;
  late Animation<double> _circleAnimation;

  // ---------------------------------------------------------------------------
  // Init / Dispose
  // ---------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _circleAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Circle progress
  //
  // The painter spans 3x screen height. Each section occupies 1/3 of that.
  // Within a section, sub-steps drift ±intraDrift around the node center.
  // ---------------------------------------------------------------------------
  double _circleProgressFor(int sectionIndex, int stepIndex) {
    const sectionChunk = 1.0 / 3;
    const maxIntraDrift = 0.05;

    final sectionBase = sectionIndex * sectionChunk + (sectionChunk / 2);
    final stepsInSection = WhoData.sections[sectionIndex].steps.length;
    final intraDrift =
        stepsInSection > 1
            ? ((stepIndex / (stepsInSection - 1)) - 0.5) * maxIntraDrift
            : 0.0;

    return (sectionBase + intraDrift).clamp(0.0, 1.0);
  }

  void _animateCircleTo(double target, {bool isInterSection = false}) {
    final current = _circleAnimation.value;
    _circleController.duration = Duration(
      milliseconds: isInterSection ? 800 : 350,
    );
    _circleAnimation = Tween<double>(begin: current, end: target).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeInOut),
    );
    _circleController.forward(from: 0);
  }

  // ---------------------------------------------------------------------------
  // Freeze / unfreeze
  // ---------------------------------------------------------------------------
  void _freezeAt(int sectionIndex, {bool reverse = false}) {
    final steps = WhoData.sections[sectionIndex].steps;
    final stepIndex = reverse ? steps.length - 1 : 0;
    final screenHeight = MediaQuery.of(context).size.height;
    final lockOffset = (sectionIndex + 1) * screenHeight;

    setState(() {
      _frozenSectionIndex = sectionIndex;
      _currentStepIndex = stepIndex;
      _accumulatedDelta = 0;
    });

    // Set position once without fighting scroll physics
    if (_scrollController.hasClients &&
        (_scrollController.offset - lockOffset).abs() > 1.0) {
      _scrollController.jumpTo(lockOffset);
    }

    _animateCircleTo(
      _circleProgressFor(sectionIndex, stepIndex),
      isInterSection: true,
    );
  }

  void _unfreeze() {
    setState(() {
      _frozenSectionIndex = -1;
      _currentStepIndex = 0;
      _accumulatedDelta = 0;
    });
  }

  // ---------------------------------------------------------------------------
  // Sub-step navigation (within a frozen section)
  // ---------------------------------------------------------------------------
  void _nextStep() {
    final currentSection =
        _frozenSectionIndex; // capture before any state change
    final section = WhoData.sections[currentSection];
    final isLastStep = _currentStepIndex == section.steps.length - 1;

    if (isLastStep) {
      final nextSectionIndex = currentSection + 1;
      final screenHeight = MediaQuery.of(context).size.height;

      setState(() => _isTransitioning = true);
      _unfreeze();

      if (nextSectionIndex >= WhoData.sections.length) {
        // Animate to final position (1.0) before scrolling to footer
        _animateCircleTo(1.0, isInterSection: true);

        // Scroll to max extent to show footer without overshooting
        final maxScroll = _scrollController.position.maxScrollExtent;
        _scrollController
            .animateTo(
              maxScroll,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOutCubic,
            )
            .then((_) => setState(() => _isTransitioning = false));
      } else {
        _scrollController
            .animateTo(
              (nextSectionIndex + 1) * screenHeight,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOutCubic,
            )
            .then((_) {
              setState(() => _isTransitioning = false);
              _freezeAt(nextSectionIndex);
            });
      }
    } else {
      setState(() => _currentStepIndex++);
      _animateCircleTo(
        _circleProgressFor(_frozenSectionIndex, _currentStepIndex),
      );
    }
  }

  void _prevStep() {
    final currentSection =
        _frozenSectionIndex; // capture before any state change
    final isFirstStep = _currentStepIndex == 0;

    if (isFirstStep) {
      final prevSectionIndex = currentSection - 1;
      final screenHeight = MediaQuery.of(context).size.height;

      setState(() => _isTransitioning = true);
      _unfreeze();

      if (prevSectionIndex < 0) {
        // Animate to initial position (0.0) before scrolling to hero
        _animateCircleTo(0.0, isInterSection: true);

        _scrollController
            .animateTo(
              0,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOutCubic,
            )
            .then((_) => setState(() => _isTransitioning = false));
      } else {
        _scrollController
            .animateTo(
              (prevSectionIndex + 1) * screenHeight,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOutCubic,
            )
            .then((_) {
              setState(() => _isTransitioning = false);
              _freezeAt(prevSectionIndex, reverse: true);
            });
      }
    } else {
      setState(() => _currentStepIndex--);
      _animateCircleTo(
        _circleProgressFor(_frozenSectionIndex, _currentStepIndex),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Scroll listener — detects crossing section boundaries
  // ---------------------------------------------------------------------------
  bool _onScroll(ScrollNotification notification) {
    // Don't process any scroll events during transitions or when frozen
    if (_isTransitioning || _isFrozen) return false;

    final screenHeight = MediaQuery.of(context).size.height;

    if (notification is ScrollEndNotification) {
      final offset = notification.metrics.pixels;
      for (int i = 0; i < WhoData.sections.length; i++) {
        final sectionOffset = (i + 1) * screenHeight;
        if ((offset - sectionOffset).abs() < screenHeight * 0.1) {
          _freezeAt(i);
          return true;
        }
      }
    }

    return false;
  }

  void _handlePointerScroll(PointerScrollEvent event) {
    if (!_isFrozen) return;

    final delta = event.scrollDelta.dy;
    if (delta.abs() < _scrollDeltaIgnoreThreshold) return;

    _accumulatedDelta += delta;
    final threshold =
        _scrollThresholdMultiplier * MediaQuery.of(context).size.height;

    if (_accumulatedDelta > threshold) {
      _accumulatedDelta = 0;
      _nextStep();
    } else if (_accumulatedDelta < -threshold) {
      _accumulatedDelta = 0;
      _prevStep();
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final screen = ref.watch(screenProvider);

    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) _handlePointerScroll(event);
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics:
              _isFrozen || _isTransitioning
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
          child: Column(
            children: [
              // ---------------------------------------------------------------
              // Hero — 1x height
              // ---------------------------------------------------------------
              _WhoHeading(screen: screen),

              // ---------------------------------------------------------------
              // Story area — 3x height total
              // Stack: painter behind, 3 section boxes on top
              // ---------------------------------------------------------------
              AnimatedBuilder(
                animation: _circleController,
                builder: (context, _) {
                  return SizedBox(
                    width: screen.width,
                    height: 3 * screen.height,
                    child: Stack(
                      children: [
                        // Background painter spanning full 3x height
                        Positioned.fill(
                          child: CustomPaint(
                            painter: WhoPathPainter(
                              circleProgress: _circleAnimation.value,
                              frozenSectionIndex: _frozenSectionIndex,
                            ),
                          ),
                        ),

                        // 3 section boxes stacked vertically
                        Positioned.fill(
                          child: Column(
                            children: [
                              for (int i = 0; i < WhoData.sections.length; i++)
                                Expanded(
                                  child: _WhoSectionBox(
                                    screen: screen,
                                    section: WhoData.sections[i],
                                    sectionIndex: i,
                                    isActive: _frozenSectionIndex == i,
                                    currentStepIndex:
                                        _frozenSectionIndex == i
                                            ? _currentStepIndex
                                            : 0,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // ---------------------------------------------------------------
              // Footer
              // ---------------------------------------------------------------
              Footer(size: screen.getScreenSize()),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// HEADING — 1x height, gradient, no painter
// =============================================================================
class _WhoHeading extends StatelessWidget {
  final Screen screen;

  const _WhoHeading({required this.screen});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screen.width,
      height: screen.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(198, 197, 255, 1.0),
            Color.fromRGBO(133, 130, 234, 1.0),
          ],
        ),
      ),
      child: Center(
        child: Text(
          "Who?",
          style: TextStyle(
            fontFamily: "CoveredByYourGrace",
            color: const Color.fromRGBO(14, 43, 133, 1.0),
            fontSize: WC.heading[screen.deviceType]! * screen.width,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION BOX — 1x height, shows active step content
// =============================================================================
class _WhoSectionBox extends StatelessWidget {
  final Screen screen;
  final dynamic section;
  final int sectionIndex;
  final bool isActive;
  final int currentStepIndex;

  const _WhoSectionBox({
    required this.screen,
    required this.section,
    required this.sectionIndex,
    required this.isActive,
    required this.currentStepIndex,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = section.accentShade as Color;
    final step = section.steps[currentStepIndex];
    final totalSteps = (section.steps as List).length;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      width: screen.width,
      color:
          isActive
              ? accentColor.withValues(alpha: 0.08)
              : accentColor.withValues(alpha: 0.03),
      child: Stack(
        children: [
          // Content row — Positioned.fill so Row gets full width/height
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                left:
                    sectionIndex == 1
                        ? 0.08 * screen.width
                        : 0.25 * screen.width,
                right:
                    sectionIndex == 1
                        ? 0.25 * screen.width
                        : 0.08 * screen.width,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left: label + step text
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 400),
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color:
                                  isActive
                                      ? accentColor
                                      : accentColor.withValues(alpha: 0.35),
                              fontSize:
                                  WC.sectionLabel[screen.deviceType]! *
                                  screen.width,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: Text(section.label as String),
                        ),
                        SizedBox(height: 0.03 * screen.height),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          child: Text(
                            step.text as String,
                            key: ValueKey(
                              'text_${sectionIndex}_$currentStepIndex',
                            ),
                            style: GoogleFonts.redHatDisplay(
                              textStyle: TextStyle(
                                color:
                                    isActive
                                        ? Colors.black87
                                        : Colors.black87.withValues(alpha: 0.2),
                                fontSize:
                                    WC.stepText[screen.deviceType]! *
                                    screen.width,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 0.04 * screen.width),

                  // Right: collage
                  Expanded(
                    flex: 3,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: _PhotoCollage(
                        key: ValueKey(
                          'collage_${sectionIndex}_$currentStepIndex',
                        ),
                        photos: step.photos as List<String>,
                        seed: currentStepIndex,
                        opacity: isActive ? 1.0 : 0.15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Step counter
          if (isActive)
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '${currentStepIndex + 1} / $totalSteps',
                  style: TextStyle(
                    fontFamily: "ABeeZee",
                    fontSize: 12,
                    color: accentColor.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// PHOTO COLLAGE — dice layout, max 5, random rotations
// =============================================================================
class _PhotoCollage extends StatelessWidget {
  final List<String> photos;
  final int seed;
  final double opacity;

  const _PhotoCollage({
    super.key,
    required this.photos,
    required this.seed,
    this.opacity = 1.0,
  });

  static const List<Alignment> _dicePositions = [
    Alignment(-0.6, -0.5),
    Alignment(0.6, -0.5),
    Alignment(0.0, 0.0),
    Alignment(-0.6, 0.5),
    Alignment(0.6, 0.5),
  ];

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) return const SizedBox.shrink();

    final rng = Random(seed);
    final count = photos.length.clamp(1, 5);

    return Opacity(
      opacity: opacity,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(count, (i) {
            final rotation = (rng.nextDouble() * 30 - 15) * (pi / 180);

            return Align(
              alignment: _dicePositions[i],
              child: Transform.rotate(
                angle: rotation,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(2, 4),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(photos[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
