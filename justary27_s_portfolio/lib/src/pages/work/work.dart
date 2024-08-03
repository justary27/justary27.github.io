import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../components/footer.dart';
import '../../components/anchor.dart';
import '../../enums/device_type.dart';
import '../../models/screen_model.dart';
import '../../providers/screen_provider.dart';
import '../../components/roorkee_painter.dart';
import '../../components/promo/promo_components.dart';
import '../../components/page_components/work_components.dart';

import 'work_constants.dart';
import 'work_constraints.dart';

class WorkPage extends ConsumerStatefulWidget {
  const WorkPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WorkPageState();
}

class _WorkPageState extends ConsumerState<WorkPage> {
  Future<void> _launchLink(String url) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: '_blank',
    );
  }

  @override
  Widget build(BuildContext context) {
    Screen screen = ref.watch(screenProvider);
    DeviceType deviceType = screen.deviceType;

    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.up,
      color: const Color.fromRGBO(130, 246, 176, 1.0).withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: screen.width,
                  height: screen.height,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(130, 246, 176, 1.0),
                        Color.fromRGBO(91, 250, 154, 1.0),
                      ],
                    ),
                  ),
                  child: Text(
                    "Work.",
                    style: TextStyle(
                      fontFamily: "CoveredByYourGrace",
                      color: const Color.fromRGBO(22, 133, 111, 1.0),
                      fontSize: WC.heading[deviceType]! * screen.width,
                    ),
                  ),
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  isRightAligned: true,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(130, 246, 176, 1.0),
                        Color.fromRGBO(91, 250, 154, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "CloudDefense.AI",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",
                        color: const Color.fromRGBO(56, 149, 131, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "An automation and testing experience in security.",
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        color: Colors.white.withOpacity(0.85),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tags: [
                    Chip(
                      label: const Text("#intern"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#cloud service provieders"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                  ],
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: cdaiDesc,
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.black.withOpacity(0.75),
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                  buttonLinks: const [],
                  model: const ModelViewer(
                    src: 'assets/models/cdai.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(241, 245, 245, 1.0),
                        Color.fromRGBO(218, 224, 224, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "Amazon",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",
                        color: const Color.fromRGBO(56, 149, 131, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "A FAANG experience in software development!",
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        color: Colors.black.withGreen(200).withOpacity(0.5),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tags: [
                    Chip(
                      label: const Text("#intern"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#amazon"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#SDE"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    )
                  ],
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: amazonDesc,
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.black.withOpacity(0.75),
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buttonLinks: const [],
                  model: const ModelViewer(
                    src: 'assets/models/amazon.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  isRightAligned: true,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(92, 219, 148, 1.0),
                        Color.fromRGBO(56, 149, 131, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "IMG, IIT Roorkee",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",
                        color: const Color.fromRGBO(241, 245, 245, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "Chief of Mobile Development and Open Source Initiatives",
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        color: const Color.fromRGBO(218, 224, 224, 1.0)
                            .withOpacity(0.85),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tags: [
                    Chip(
                      label: const Text("#PoR"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#app dev"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#open source"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#mentoring"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                  ],
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: imgDesc,
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.black.withOpacity(0.75),
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                  buttonLinks: [
                    AnchorButton(
                      icon: const Icon(Icons.public),
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      iconSize: WC.projLinks[deviceType],
                      destUrl: "https://channeli.in/maintainer_site/",
                      parentContext: context,
                    ),
                  ],
                  model: const ModelViewer(
                    src: 'assets/models/img.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(241, 245, 245, 1.0),
                        Color.fromRGBO(218, 224, 224, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "GSoC'23",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",
                        color: const Color.fromRGBO(56, 149, 131, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "Mentor and Maintainer, BLT project, OWASP Foundation",
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        color: Colors.black.withGreen(200).withOpacity(0.5),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tags: [
                    Chip(
                      label: const Text("#PoR"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#GSoC'23"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#OWASP"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#mentoring"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                  ],
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: gsoc23Desc,
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.black.withOpacity(0.75),
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buttonLinks: [
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(22, 133, 111, 1.0),
                      destUrl:
                          "https://summerofcode.withgoogle.com/archive/2023/projects/FrMdpNvR",
                      icon: const Icon(FontAwesomeIcons.google),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(22, 133, 111, 1.0),
                      destUrl: "https://github.com/OWASP-BLT/BLT-Flutter",
                      icon: const Icon(FontAwesomeIcons.github),
                      parentContext: context,
                    ),
                    // AnchorButton(
                    //   iconSize: cf['projLinks'][_deviceType],
                    //   color: const Color.fromRGBO(241, 245, 245, 1.0)
                    //       .withOpacity(0.5),
                    //   destUrl:
                    //       " https://medium.com/@justary27/my-gsoc22-voyage-conclusion-e0bf34fec239",
                    //   icon: const Icon(FontAwesomeIcons.medium),
                    //   parentContext: context,
                    // ),
                  ],
                  model: const ModelViewer(
                    src: 'assets/models/gsoc.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  isRightAligned: true,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(92, 219, 148, 1.0),
                        Color.fromRGBO(56, 149, 131, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "Placement Online",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",
                        color: const Color.fromRGBO(241, 245, 245, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "Fun to make your own college's placement app!",
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        color: const Color.fromRGBO(218, 224, 224, 1.0)
                            .withOpacity(0.85),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: placementDesc,
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.black.withOpacity(0.75),
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                  buttonLinks: [
                    AnchorButton(
                      icon: const Icon(FontAwesomeIcons.github),
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      iconSize: WC.projLinks[deviceType],
                      destUrl:
                          "https://github.com/IMGIITRoorkee/placement-flutter",
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      destUrl:
                          "https://play.google.com/store/apps/details?id=com.channeli.img.placementonline",
                      icon: const Icon(FontAwesomeIcons.googlePlay),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      destUrl:
                          "https://apps.apple.com/in/app/channel-i-placement-online/id1667945708",
                      icon: const Icon(FontAwesomeIcons.appStoreIos),
                      parentContext: context,
                    ),
                  ],
                  model: const ModelViewer(
                    src: 'assets/models/placement.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                  tags: [
                    Chip(
                      label: const Text("#project"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#imgiitr"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#app dev"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    )
                  ],
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(241, 245, 245, 1.0),
                        Color.fromRGBO(218, 224, 224, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "Noticeboard",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",
                        color: const Color.fromRGBO(56, 149, 131, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "A pleasure of making IITR's official noticeboard app.",
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        color: Colors.black.withGreen(200).withOpacity(0.5),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: noticeboardDesc,
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.black.withOpacity(0.75),
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buttonLinks: [
                    AnchorButton(
                      icon: const Icon(FontAwesomeIcons.github),
                      color: const Color.fromRGBO(56, 149, 131, 1.0)
                          .withOpacity(0.75),
                      iconSize: WC.projLinks[deviceType],
                      destUrl:
                          "https://github.com/IMGIITRoorkee/noticeboard-mobile-app",
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(56, 149, 131, 1.0)
                          .withOpacity(0.75),
                      destUrl:
                          "https://play.google.com/store/apps/details?id=com.img.noticeboard",
                      icon: const Icon(FontAwesomeIcons.googlePlay),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(56, 149, 131, 1.0)
                          .withOpacity(0.75),
                      destUrl:
                          "https://apps.apple.com/in/app/channel-i-noticeboard/id6443708603",
                      icon: const Icon(FontAwesomeIcons.appStoreIos),
                      parentContext: context,
                    ),
                  ],
                  model: const ModelViewer(
                    src: 'assets/models/noticeboard.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                  tags: [
                    Chip(
                      label: const Text("#project"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#imgiitr"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#app dev"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    )
                  ],
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  isRightAligned: true,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(130, 246, 176, 1.0),
                        Color.fromRGBO(91, 250, 154, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "Lyf",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",
                        color: const Color.fromRGBO(56, 149, 131, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "Life, Optimized.",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        color: Colors.white.withOpacity(0.85),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tags: [
                    Chip(
                      label: const Text("#self project"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#app dev"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#backend dev"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                  ],
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: lyfDesc,
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.black.withOpacity(0.75),
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                  buttonLinks: [
                    AnchorButton(
                      icon: const Icon(FontAwesomeIcons.github),
                      color: const Color.fromRGBO(56, 149, 131, 1.0)
                          .withOpacity(0.75),
                      iconSize: WC.projLinks[deviceType],
                      destUrl: "https://github.com/justary27/Lyf",
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(56, 149, 131, 1.0)
                          .withOpacity(0.75),
                      destUrl:
                          "https://www.figma.com/file/3lWdqxgt6QpTEOvfW5Vwu1/Lyf?node-id=123%3A2",
                      icon: const Icon(FontAwesomeIcons.figma),
                      parentContext: context,
                    ),
                  ],
                  // model: SvgPicture.asset(
                  //   "images/lyf.svg",
                  //   colorFilter: const ColorFilter.mode(
                  //     Color.fromRGBO(56, 149, 131, 1.0),
                  //     BlendMode.srcIn,
                  //   ),
                  // ),
                  model: const ModelViewer(
                    src: 'assets/models/lyf.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(241, 245, 245, 1.0),
                        Color.fromRGBO(218, 224, 224, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "BugHeist:UI",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",
                        color: const Color.fromRGBO(56, 149, 131, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "Why not share some UI related experience?",
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        color: Colors.black.withGreen(200).withOpacity(0.5),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tags: [
                    Chip(
                      label: const Text("#GSoC'22"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#OWASP"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#ui design"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                  ],
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: bltDesc,
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.black,
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buttonLinks: [
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(22, 133, 111, 1.0),
                      destUrl:
                          'https://www.figma.com/file/NYD5WZzJywnO338lchnece/BugHeist?node-id=8%3A1129',
                      icon: const Icon(
                        FontAwesomeIcons.figma,
                      ),
                      parentContext: context,
                    ),
                  ],
                  // model: SvgPicture.asset("images/bugheist.svg"),
                  model: const ModelViewer(
                    src: 'assets/models/blt.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  isRightAligned: true,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(92, 219, 148, 1.0),
                        Color.fromRGBO(56, 149, 131, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "GSoC'22",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",
                        color: const Color.fromRGBO(241, 245, 245, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "What can be better than contributing in GSoC?",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        color: const Color.fromRGBO(218, 224, 224, 1.0)
                            .withOpacity(0.85),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tags: [
                    Chip(
                      label: const Text("#GSoC'22"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#OWASP"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#app dev"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#backend dev"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                  ],
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: gsoc22Desc[0],
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.white,
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: gsoc22Desc[1],
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            color: const Color.fromRGBO(14, 43, 133, 1.0)
                                .withOpacity(0.7),
                            fontSize:
                                WC.projEmphasis[deviceType]! * screen.width,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: gsoc22Desc[2],
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            color: Colors.white,
                            fontSize:
                                WC.projDescription[deviceType]! * screen.width,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                  buttonLinks: [
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      destUrl:
                          "https://summerofcode.withgoogle.com/archive/2022/projects/ShGlbTKv",
                      icon: const Icon(FontAwesomeIcons.google),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      destUrl: "https://github.com/Bugheist/Flutter",
                      icon: const Icon(FontAwesomeIcons.github),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      destUrl:
                          "https://apps.apple.com/us/app/owasp-blt/id6448071954",
                      icon: const Icon(FontAwesomeIcons.appStoreIos),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      destUrl:
                          "https://medium.com/@justary27/my-gsoc22-voyage-beginning-4296df5af625",
                      icon: const Icon(FontAwesomeIcons.medium),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      destUrl:
                          "https://medium.com/@justary27/my-gsoc22-voyage-conclusion-e0bf34fec239",
                      icon: const Icon(FontAwesomeIcons.medium),
                      parentContext: context,
                    ),
                  ],
                  // model: SvgPicture.asset("images/gsoc.svg"),
                  model: const ModelViewer(
                    src: 'assets/models/gsoc.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(241, 245, 245, 1.0),
                        Color.fromRGBO(218, 224, 224, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "CovBot",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",
                        color: const Color.fromRGBO(22, 133, 111, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "The only bot you'll need for Covid-19 resources.",
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        // color: Colors.white.withOpacity(0.85),
                        color: Colors.black.withGreen(200).withOpacity(0.5),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tags: [
                    Chip(
                      label: const Text("#discord bot"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#hackathon project"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                  ],
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: covbotDesc[0],
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.black,
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: covbotDesc[1],
                          style: TextStyle(
                            fontFamily: "CoveredByYourGrace",
                            color: const Color.fromRGBO(22, 133, 111, 1.0),
                            fontSize:
                                WC.projEmphasis[deviceType]! * screen.width,
                          ),
                        )
                      ],
                    ),
                  ),
                  buttonLinks: [
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(22, 133, 111, 1.0),
                      destUrl: 'https://github.com/justary27/CovBot',
                      icon: const Icon(FontAwesomeIcons.github),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(22, 133, 111, 1.0),
                      destUrl:
                          'https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot',
                      icon: const Icon(FontAwesomeIcons.discord),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(22, 133, 111, 1.0),
                      destUrl:
                          'https://in.mashable.com/social-good/22667/covid-discord-group-helps-indians-find-oxygen-answers-and-community',
                      icon: const Icon(FontAwesomeIcons.newspaper),
                      parentContext: context,
                    ),
                  ],
                  // model: SvgPicture.asset(
                  //   "images/covbot.svg",
                  //   colorFilter: const ColorFilter.mode(
                  //     Color.fromRGBO(56, 149, 131, 1.0),
                  //     BlendMode.srcIn,
                  //   ),
                  // ),

                  model: const ModelViewer(
                    src: 'assets/models/covbot.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                ),
                WorkDescriptor(
                  size: screen.getScreenSize(),
                  isRightAligned: true,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(92, 219, 148, 1.0),
                        Color.fromRGBO(56, 149, 131, 1.0),
                      ],
                    ),
                  ),
                  title: Text(
                    "Jane",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        // fontFamily: "Itim",

                        color: const Color.fromRGBO(241, 245, 245, 1.0),
                        fontSize: WC.projTitle[deviceType]! * screen.width,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "A multi-purpose bot to make your stay at discord comfy.",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        // fontFamily: "Ubuntu",
                        color: const Color.fromRGBO(218, 224, 224, 1.0)
                            .withOpacity(0.7),
                        fontSize: WC.projSubtitle[deviceType]! * screen.width,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tags: [
                    Chip(
                      label: const Text("#discord bot"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                    Chip(
                      label: const Text("#first self project"),
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color.fromRGBO(56, 149, 131, 1.0)
                              .withOpacity(0.75),
                        ),
                      ),
                      color: WidgetStateColor.transparent,
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(56, 149, 131, 1.0)
                            .withOpacity(0.75),
                      ),
                    ),
                  ],
                  description: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: janeDesc[0],
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.white,
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: janeDesc[1],
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            color: const Color.fromRGBO(14, 43, 133, 1.0)
                                .withOpacity(0.7),
                            fontSize:
                                WC.projEmphasis[deviceType]! * screen.width,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: janeDesc[2],
                          style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                              // fontFamily: "ABeeZee",
                              color: Colors.white,
                              fontSize: WC.projDescription[deviceType]! *
                                  screen.width,
                            ),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                  buttonLinks: [
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      destUrl: "https://github.com/justary27/CovBot",
                      icon: const Icon(FontAwesomeIcons.github),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      destUrl: "https://justary27.github.io/CovBot/",
                      icon: const Icon(FontAwesomeIcons.firefoxBrowser),
                      parentContext: context,
                    ),
                    AnchorButton(
                      iconSize: WC.projLinks[deviceType],
                      color: const Color.fromRGBO(241, 245, 245, 1.0)
                          .withOpacity(0.5),
                      destUrl:
                          "https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot",
                      icon: const Icon(FontAwesomeIcons.discord),
                      parentContext: context,
                    ),
                  ],
                  // model: SvgPicture.asset("images/jane.svg"),
                  model: const ModelViewer(
                    src: 'assets/models/jane.gltf',
                    alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                ),
                PromoRedirector(
                  size: screen.getScreenSize(),
                  deviceType: deviceType,
                  pageName: "GitHub",
                  customPainter: RoorkeePainter(
                    const Color.fromRGBO(56, 149, 131, 1.0),
                    const Color.fromRGBO(184, 194, 215, 1.0),
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(218, 224, 224, 1.0),
                        Color.fromRGBO(183, 193, 192, 1.0)
                      ],
                    ),
                  ),
                  pageDescriptor:
                      "To check all of my work,\n head to my github!",
                  button: TextButton.icon(
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    onPressed: () => _launchLink(
                      'https://github.com/justary27',
                    ),
                    label: Text(
                      "Head to github",
                      style: TextStyle(
                        fontFamily: "ABeeZee",
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Footer(
                  size: screen.getScreenSize(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
