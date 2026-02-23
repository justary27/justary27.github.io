// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:model_viewer_plus/model_viewer_plus.dart';

// import '../../components/footer.dart';
// import '../../components/anchor.dart';
// import '../../enums/device_type.dart';
// import '../../models/screen_model.dart';
// import '../../providers/screen_provider.dart';
// import '../../components/roorkee_painter.dart';
// import '../../components/promo/promo_components.dart';
// import '../../components/page_components/work_components.dart';

// import 'work_constants.dart';
// import 'work_constraints.dart';

// class WorkPage extends ConsumerStatefulWidget {
//   const WorkPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _WorkPageState();
// }

// class _WorkPageState extends ConsumerState<WorkPage> {
//   Future<void> _launchLink(String url) async {
//     await launchUrl(
//       Uri.parse(url),
//       webOnlyWindowName: '_blank',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Screen screen = ref.watch(screenProvider);
//     DeviceType deviceType = screen.deviceType;

//     return GlowingOverscrollIndicator(
//       axisDirection: AxisDirection.up,
//       color: const Color.fromRGBO(130, 246, 176, 0.3),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   width: screen.width,
//                   height: screen.height,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(130, 246, 176, 1.0),
//                         Color.fromRGBO(91, 250, 154, 1.0),
//                       ],
//                     ),
//                   ),
//                   child: Text(
//                     "Work.",
//                     style: TextStyle(
//                       fontFamily: "CoveredByYourGrace",
//                       color: const Color.fromRGBO(22, 133, 111, 1.0),
//                       fontSize: WC.heading[deviceType]! * screen.width,
//                     ),
//                   ),
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   isRightAligned: true,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(130, 246, 176, 1.0),
//                         Color.fromRGBO(91, 250, 154, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "CloudDefense.AI",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",
//                         color: const Color.fromRGBO(56, 149, 131, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "An automation and testing experience in security.",
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         color: Colors.white.withValues(alpha: 0.85),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#intern"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#cloud service provieders"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                   ],
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: cdaiDesc,
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.black.withValues(alpha: 0.75),
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   buttonLinks: const [],
//                   model: const ModelViewer(
//                     src: 'assets/models/cdai.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(241, 245, 245, 1.0),
//                         Color.fromRGBO(218, 224, 224, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "Amazon",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",
//                         color: const Color.fromRGBO(56, 149, 131, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "A FAANG experience in software development!",
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         color:
//                             Colors.black.withGreen(200).withValues(alpha: 0.5),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#intern"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#amazon"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#SDE"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     )
//                   ],
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: amazonDesc,
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.black.withValues(alpha: 0.75),
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   buttonLinks: const [],
//                   model: const ModelViewer(
//                     src: 'assets/models/amazon.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   isRightAligned: true,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(92, 219, 148, 1.0),
//                         Color.fromRGBO(56, 149, 131, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "IMG, IIT Roorkee",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",
//                         color: const Color.fromRGBO(241, 245, 245, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "Chief of Mobile Development and Open Source Initiatives",
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         color: const Color.fromRGBO(218, 224, 224, 1.0)
//                             .withValues(alpha: 0.85),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#PoR"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#app dev"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#open source"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#mentoring"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                   ],
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: imgDesc,
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.black.withValues(alpha: 0.75),
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   buttonLinks: [
//                     AnchorButton(
//                       icon: const Icon(Icons.public),
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       iconSize: WC.projLinks[deviceType],
//                       destUrl: "https://channeli.in/maintainer_site/",
//                       parentContext: context,
//                     ),
//                   ],
//                   model: const ModelViewer(
//                     src: 'assets/models/img.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(241, 245, 245, 1.0),
//                         Color.fromRGBO(218, 224, 224, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "GSoC'23",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",
//                         color: const Color.fromRGBO(56, 149, 131, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "Mentor and Maintainer, BLT project, OWASP Foundation",
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         color:
//                             Colors.black.withGreen(200).withValues(alpha: 0.5),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#PoR"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#GSoC'23"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#OWASP"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#mentoring"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                   ],
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: gsoc23Desc,
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.black.withValues(alpha: 0.75),
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   buttonLinks: [
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(22, 133, 111, 1.0),
//                       destUrl:
//                           "https://summerofcode.withgoogle.com/archive/2023/projects/FrMdpNvR",
//                       icon: const Icon(FontAwesomeIcons.google),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(22, 133, 111, 1.0),
//                       destUrl: "https://github.com/OWASP-BLT/BLT-Flutter",
//                       icon: const Icon(FontAwesomeIcons.github),
//                       parentContext: context,
//                     ),
//                     // AnchorButton(
//                     //   iconSize: cf['projLinks'][_deviceType],
//                     //   color: const Color.fromRGBO(241, 245, 245, 1.0)
//                     //       .withValues(alpha: 0.5),
//                     //   destUrl:
//                     //       " https://medium.com/@justary27/my-gsoc22-voyage-conclusion-e0bf34fec239",
//                     //   icon: const Icon(FontAwesomeIcons.medium),
//                     //   parentContext: context,
//                     // ),
//                   ],
//                   model: const ModelViewer(
//                     src: 'assets/models/gsoc.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   isRightAligned: true,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(92, 219, 148, 1.0),
//                         Color.fromRGBO(56, 149, 131, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "Placement Online",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",
//                         color: const Color.fromRGBO(241, 245, 245, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "Fun to make your own college's placement app!",
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         color: const Color.fromRGBO(218, 224, 224, 1.0)
//                             .withValues(alpha: 0.85),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: placementDesc,
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.black.withValues(alpha: 0.75),
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   buttonLinks: [
//                     AnchorButton(
//                       icon: const Icon(FontAwesomeIcons.github),
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       iconSize: WC.projLinks[deviceType],
//                       destUrl:
//                           "https://github.com/IMGIITRoorkee/placement-flutter",
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       destUrl:
//                           "https://play.google.com/store/apps/details?id=com.channeli.img.placementonline",
//                       icon: const Icon(FontAwesomeIcons.googlePlay),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       destUrl:
//                           "https://apps.apple.com/in/app/channel-i-placement-online/id1667945708",
//                       icon: const Icon(FontAwesomeIcons.appStoreIos),
//                       parentContext: context,
//                     ),
//                   ],
//                   model: const ModelViewer(
//                     src: 'assets/models/placement.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#project"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#imgiitr"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#app dev"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     )
//                   ],
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(241, 245, 245, 1.0),
//                         Color.fromRGBO(218, 224, 224, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "Noticeboard",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",
//                         color: const Color.fromRGBO(56, 149, 131, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "A pleasure of making IITR's official noticeboard app.",
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         color:
//                             Colors.black.withGreen(200).withValues(alpha: 0.5),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: noticeboardDesc,
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.black.withValues(alpha: 0.75),
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   buttonLinks: [
//                     AnchorButton(
//                       icon: const Icon(FontAwesomeIcons.github),
//                       color: const Color.fromRGBO(56, 149, 131, 1.0)
//                           .withValues(alpha: 0.75),
//                       iconSize: WC.projLinks[deviceType],
//                       destUrl:
//                           "https://github.com/IMGIITRoorkee/noticeboard-mobile-app",
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(56, 149, 131, 1.0)
//                           .withValues(alpha: 0.75),
//                       destUrl:
//                           "https://play.google.com/store/apps/details?id=com.img.noticeboard",
//                       icon: const Icon(FontAwesomeIcons.googlePlay),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(56, 149, 131, 1.0)
//                           .withValues(alpha: 0.75),
//                       destUrl:
//                           "https://apps.apple.com/in/app/channel-i-noticeboard/id6443708603",
//                       icon: const Icon(FontAwesomeIcons.appStoreIos),
//                       parentContext: context,
//                     ),
//                   ],
//                   model: const ModelViewer(
//                     src: 'assets/models/noticeboard.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#project"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#imgiitr"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#app dev"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     )
//                   ],
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   isRightAligned: true,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(130, 246, 176, 1.0),
//                         Color.fromRGBO(91, 250, 154, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "Lyf",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",
//                         color: const Color.fromRGBO(56, 149, 131, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "Life, Optimized.",
//                     textAlign: TextAlign.right,
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         color: Colors.white.withValues(alpha: 0.85),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#self project"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#app dev"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#backend dev"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                   ],
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: lyfDesc,
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.black.withValues(alpha: 0.75),
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   buttonLinks: [
//                     AnchorButton(
//                       icon: const Icon(FontAwesomeIcons.github),
//                       color: const Color.fromRGBO(56, 149, 131, 1.0)
//                           .withValues(alpha: 0.75),
//                       iconSize: WC.projLinks[deviceType],
//                       destUrl: "https://github.com/justary27/Lyf",
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(56, 149, 131, 1.0)
//                           .withValues(alpha: 0.75),
//                       destUrl:
//                           "https://www.figma.com/file/3lWdqxgt6QpTEOvfW5Vwu1/Lyf?node-id=123%3A2",
//                       icon: const Icon(FontAwesomeIcons.figma),
//                       parentContext: context,
//                     ),
//                   ],
//                   // model: SvgPicture.asset(
//                   //   "images/lyf.svg",
//                   //   colorFilter: const ColorFilter.mode(
//                   //     Color.fromRGBO(56, 149, 131, 1.0),
//                   //     BlendMode.srcIn,
//                   //   ),
//                   // ),
//                   model: const ModelViewer(
//                     src: 'assets/models/lyf.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(241, 245, 245, 1.0),
//                         Color.fromRGBO(218, 224, 224, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "BugHeist:UI",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",
//                         color: const Color.fromRGBO(56, 149, 131, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "Why not share some UI related experience?",
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         color:
//                             Colors.black.withGreen(200).withValues(alpha: 0.5),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#GSoC'22"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#OWASP"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#ui design"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                   ],
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: bltDesc,
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.black,
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   buttonLinks: [
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(22, 133, 111, 1.0),
//                       destUrl:
//                           'https://www.figma.com/file/NYD5WZzJywnO338lchnece/BugHeist?node-id=8%3A1129',
//                       icon: const Icon(
//                         FontAwesomeIcons.figma,
//                       ),
//                       parentContext: context,
//                     ),
//                   ],
//                   // model: SvgPicture.asset("images/bugheist.svg"),
//                   model: const ModelViewer(
//                     src: 'assets/models/blt.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   isRightAligned: true,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(92, 219, 148, 1.0),
//                         Color.fromRGBO(56, 149, 131, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "GSoC'22",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",
//                         color: const Color.fromRGBO(241, 245, 245, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "What can be better than contributing in GSoC?",
//                     textAlign: TextAlign.right,
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         color: const Color.fromRGBO(218, 224, 224, 1.0)
//                             .withValues(alpha: 0.85),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#GSoC'22"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#OWASP"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#app dev"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#backend dev"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                   ],
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: gsoc22Desc[0],
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.white,
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                         TextSpan(
//                           text: gsoc22Desc[1],
//                           style: TextStyle(
//                             fontFamily: "ABeeZee",
//                             color: const Color.fromRGBO(14, 43, 133, 1.0)
//                                 .withValues(alpha: 0.7),
//                             fontSize:
//                                 WC.projEmphasis[deviceType]! * screen.width,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextSpan(
//                           text: gsoc22Desc[2],
//                           style: TextStyle(
//                             fontFamily: "ABeeZee",
//                             color: Colors.white,
//                             fontSize:
//                                 WC.projDescription[deviceType]! * screen.width,
//                           ),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   buttonLinks: [
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       destUrl:
//                           "https://summerofcode.withgoogle.com/archive/2022/projects/ShGlbTKv",
//                       icon: const Icon(FontAwesomeIcons.google),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       destUrl: "https://github.com/Bugheist/Flutter",
//                       icon: const Icon(FontAwesomeIcons.github),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       destUrl:
//                           "https://apps.apple.com/us/app/owasp-blt/id6448071954",
//                       icon: const Icon(FontAwesomeIcons.appStoreIos),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       destUrl:
//                           "https://medium.com/@justary27/my-gsoc22-voyage-beginning-4296df5af625",
//                       icon: const Icon(FontAwesomeIcons.medium),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       destUrl:
//                           "https://medium.com/@justary27/my-gsoc22-voyage-conclusion-e0bf34fec239",
//                       icon: const Icon(FontAwesomeIcons.medium),
//                       parentContext: context,
//                     ),
//                   ],
//                   // model: SvgPicture.asset("images/gsoc.svg"),
//                   model: const ModelViewer(
//                     src: 'assets/models/gsoc.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(241, 245, 245, 1.0),
//                         Color.fromRGBO(218, 224, 224, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "CovBot",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",
//                         color: const Color.fromRGBO(22, 133, 111, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "The only bot you'll need for Covid-19 resources.",
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         // color: Colors.white.withValues(alpha: 0.85),
//                         color:
//                             Colors.black.withGreen(200).withValues(alpha: 0.5),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#discord bot"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#hackathon project"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                   ],
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: covbotDesc[0],
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.black,
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                         TextSpan(
//                           text: covbotDesc[1],
//                           style: TextStyle(
//                             fontFamily: "CoveredByYourGrace",
//                             color: const Color.fromRGBO(22, 133, 111, 1.0),
//                             fontSize:
//                                 WC.projEmphasis[deviceType]! * screen.width,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   buttonLinks: [
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(22, 133, 111, 1.0),
//                       destUrl: 'https://github.com/justary27/CovBot',
//                       icon: const Icon(FontAwesomeIcons.github),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(22, 133, 111, 1.0),
//                       destUrl:
//                           'https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot',
//                       icon: const Icon(FontAwesomeIcons.discord),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(22, 133, 111, 1.0),
//                       destUrl:
//                           'https://in.mashable.com/social-good/22667/covid-discord-group-helps-indians-find-oxygen-answers-and-community',
//                       icon: const Icon(FontAwesomeIcons.newspaper),
//                       parentContext: context,
//                     ),
//                   ],
//                   // model: SvgPicture.asset(
//                   //   "images/covbot.svg",
//                   //   colorFilter: const ColorFilter.mode(
//                   //     Color.fromRGBO(56, 149, 131, 1.0),
//                   //     BlendMode.srcIn,
//                   //   ),
//                   // ),

//                   model: const ModelViewer(
//                     src: 'assets/models/covbot.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                 ),
//                 WorkDescriptor(
//                   size: screen.getScreenSize(),
//                   isRightAligned: true,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(92, 219, 148, 1.0),
//                         Color.fromRGBO(56, 149, 131, 1.0),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     "Jane",
//                     style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                         // fontFamily: "Itim",

//                         color: const Color.fromRGBO(241, 245, 245, 1.0),
//                         fontSize: WC.projTitle[deviceType]! * screen.width,
//                       ),
//                     ),
//                   ),
//                   subtitle: Text(
//                     "A multi-purpose bot to make your stay at discord comfy.",
//                     textAlign: TextAlign.right,
//                     style: GoogleFonts.abel(
//                       textStyle: TextStyle(
//                         // fontFamily: "Ubuntu",
//                         color: const Color.fromRGBO(218, 224, 224, 1.0)
//                             .withValues(alpha: 0.7),
//                         fontSize: WC.projSubtitle[deviceType]! * screen.width,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   tags: [
//                     Chip(
//                       label: const Text("#discord bot"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                     Chip(
//                       label: const Text("#first self project"),
//                       labelPadding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: BorderSide(
//                           color: const Color.fromRGBO(56, 149, 131, 1.0)
//                               .withValues(alpha: 0.75),
//                         ),
//                       ),
//                       color: WidgetStateColor.transparent,
//                       labelStyle: TextStyle(
//                         color: const Color.fromRGBO(56, 149, 131, 1.0)
//                             .withValues(alpha: 0.75),
//                       ),
//                     ),
//                   ],
//                   description: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: janeDesc[0],
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.white,
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                         TextSpan(
//                           text: janeDesc[1],
//                           style: TextStyle(
//                             fontFamily: "ABeeZee",
//                             color: const Color.fromRGBO(14, 43, 133, 1.0)
//                                 .withValues(alpha: 0.7),
//                             fontSize:
//                                 WC.projEmphasis[deviceType]! * screen.width,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextSpan(
//                           text: janeDesc[2],
//                           style: GoogleFonts.redHatDisplay(
//                             textStyle: TextStyle(
//                               // fontFamily: "ABeeZee",
//                               color: Colors.white,
//                               fontSize: WC.projDescription[deviceType]! *
//                                   screen.width,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   buttonLinks: [
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       destUrl: "https://github.com/justary27/CovBot",
//                       icon: const Icon(FontAwesomeIcons.github),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       destUrl: "https://justary27.github.io/CovBot/",
//                       icon: const Icon(FontAwesomeIcons.firefoxBrowser),
//                       parentContext: context,
//                     ),
//                     AnchorButton(
//                       iconSize: WC.projLinks[deviceType],
//                       color: const Color.fromRGBO(241, 245, 245, 1.0)
//                           .withValues(alpha: 0.5),
//                       destUrl:
//                           "https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot",
//                       icon: const Icon(FontAwesomeIcons.discord),
//                       parentContext: context,
//                     ),
//                   ],
//                   // model: SvgPicture.asset("images/jane.svg"),
//                   model: const ModelViewer(
//                     src: 'assets/models/jane.gltf',
//                     alt: "A 3D model of an astronaut",
//                     ar: false,
//                     autoRotate: true,
//                     cameraControls: true,
//                     disableZoom: true,
//                     interactionPrompt: InteractionPrompt.none,
//                   ),
//                 ),
//                 PromoRedirector(
//                   size: screen.getScreenSize(),
//                   deviceType: deviceType,
//                   pageName: "GitHub",
//                   customPainter: RoorkeePainter(
//                     const Color.fromRGBO(56, 149, 131, 1.0),
//                     const Color.fromRGBO(184, 194, 215, 1.0),
//                   ),
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color.fromRGBO(218, 224, 224, 1.0),
//                         Color.fromRGBO(183, 193, 192, 1.0)
//                       ],
//                     ),
//                   ),
//                   pageDescriptor:
//                       "To check all of my work,\n head to my github!",
//                   button: TextButton.icon(
//                     icon: Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.white.withValues(alpha: 0.7),
//                     ),
//                     onPressed: () => _launchLink(
//                       'https://github.com/justary27',
//                     ),
//                     label: Text(
//                       "Head to github",
//                       style: TextStyle(
//                         fontFamily: "ABeeZee",
//                         color: Colors.white.withValues(alpha: 0.7),
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Footer(
//                   size: screen.getScreenSize(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/footer.dart';
import '../../components/page_components/work_components.dart';
import '../../components/promo/promo_components.dart';
import '../../components/quick_navbar.dart';
import '../../components/roorkee_painter.dart';
import '../../models/screen_model.dart';
import '../../providers/screen_provider.dart';

import 'data.dart';
import 'work_constraints.dart';

// ============================================================================
// PER-TAB SCROLL STATE HELPER
// ============================================================================
class _TabScrollState {
  int currentItemIndex = 0;
  int currentPointIndex = -1; // -1 = core section
  bool hasCompleted = false;

  void reset() {
    currentItemIndex = 0;
    currentPointIndex = -1;
    hasCompleted = false;
  }
}

// ============================================================================
// PAGE
// ============================================================================
class WorkPage extends ConsumerStatefulWidget {
  const WorkPage({super.key});

  @override
  ConsumerState<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends ConsumerState<WorkPage>
    with SingleTickerProviderStateMixin {
  // ============================================================================
  // CONSTANTS
  // ============================================================================
  static const int _experienceTabIndex = 0;
  static const int _projectsTabIndex = 1;
  static const int _positionsTabIndex = 2;

  static const double _scrollDeltaIgnoreThreshold = 0.5;
  static const double _scrollThresholdMultiplier = 0.35;
  static const double _freezePointAbove = 0.5;
  static const double _freezePointBelow = 1.1;
  static const double _freezePointMax = 2.0;
  static const double _scrollOffsetAdjustment = 2.0;

  // ============================================================================
  // STATE — SHARED SCROLL
  // ============================================================================
  late TabController _tabController;
  late ScrollController _scrollController;

  bool _isFrozen = false;
  double _freezeOffset = 0;
  double _accumulatedDelta = 0;

  // ============================================================================
  // STATE — PER-TAB
  // ============================================================================
  final List<_TabScrollState> _tabStates = [
    _TabScrollState(), // Work Experience
    _TabScrollState(), // Projects
    _TabScrollState(), // Positions
  ];

  // Lazy loading — WorkEx is built immediately; others on first visit
  final List<bool> _tabBuilt = [true, false, false];

  // ============================================================================
  // CONVENIENCE GETTERS
  // ============================================================================
  _TabScrollState get _current => _tabStates[_tabController.index];

  bool get _isPositionsTab => _tabController.index == _positionsTabIndex;

  /// Total scroll states for the active tab.
  int get _totalPoints {
    switch (_tabController.index) {
      case _experienceTabIndex:
        return WorkExperienceData.experiences.fold(
          0,
          (sum, exp) => sum + exp.scrollablePoints.length + 1,
        );
      case _projectsTabIndex:
        return ProjectData.projects.fold(
          0,
          (p, proj) => p + proj.scrollablePoints.length + 1,
        );
      case _positionsTabIndex:
        return PositionData.positions.length; // one state per position
      default:
        return 0;
    }
  }

  /// Global point index (0-based) within the active tab.
  int get _globalPointIndex {
    if (_isPositionsTab) return _current.currentItemIndex;

    final items =
        _tabController.index == _experienceTabIndex
            ? WorkExperienceData.experiences
            : ProjectData.projects;

    int index = 0;
    for (int i = 0; i < _current.currentItemIndex; i++) {
      index += items[i].scrollablePoints.length + 1;
    }
    return index + _current.currentPointIndex + 1;
  }

  // ============================================================================
  // LIFECYCLE
  // ============================================================================
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ============================================================================
  // TAB NAVIGATION
  // ============================================================================
  void _handleTabChange(int index) {
    setState(() {
      _isFrozen = false;
      _accumulatedDelta = 0;
      _tabController.animateTo(index);
      _tabBuilt[index] = true;

      // Scroll to top of tab section on switch
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    });
  }

  /// Called from PositionsTab when a linked project chip is tapped.
  void _navigateToProject(String projectId) {
    final targetIndex = ProjectData.projects.indexWhere(
      (p) => p.id == projectId,
    );
    if (targetIndex == -1) return;

    setState(() {
      _isFrozen = false;
      _accumulatedDelta = 0;
      _tabBuilt[_projectsTabIndex] = true;
      _tabController.animateTo(_projectsTabIndex);

      // Jump to the target project's core section
      _tabStates[_projectsTabIndex].currentItemIndex = targetIndex;
      _tabStates[_projectsTabIndex].currentPointIndex = -1;
      _tabStates[_projectsTabIndex].hasCompleted = false;
    });

    // Freeze into the projects tab at the target project
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        final screenHeight = MediaQuery.of(context).size.height;
        _scrollController.jumpTo(screenHeight);
        setState(() {
          _isFrozen = true;
          _freezeOffset = screenHeight;
        });
      }
    });
  }

  // ============================================================================
  // ITEM NAVIGATION
  // ============================================================================
  void _nextPoint() {
    if (_isPositionsTab) {
      // Positions have no sub-points — advance directly to next position
      final isLast =
          _current.currentItemIndex == PositionData.positions.length - 1;
      setState(() {
        if (!isLast) {
          _current.currentItemIndex++;
        } else {
          _completeScrollSession();
        }
      });
      return;
    }

    // WorkEx / Projects — standard sub-point navigation
    final items =
        _tabController.index == _experienceTabIndex
            ? WorkExperienceData.experiences
            : ProjectData.projects;

    final currentItem = items[_current.currentItemIndex];
    final maxPointIndex = currentItem.scrollablePoints.length - 1;
    final isLastItem = _current.currentItemIndex == items.length - 1;

    setState(() {
      if (_current.currentPointIndex < maxPointIndex) {
        _current.currentPointIndex++;
      } else if (!isLastItem) {
        _current.currentItemIndex++;
        _current.currentPointIndex = -1;
      } else {
        _completeScrollSession();
      }
    });
  }

  void _prevPoint() {
    if (_isPositionsTab) {
      final isFirst = _current.currentItemIndex == 0;
      setState(() {
        if (!isFirst) {
          _current.currentItemIndex--;
        } else {
          _unfreeze(scrollingDown: false);
        }
      });
      return;
    }

    final items =
        _tabController.index == _experienceTabIndex
            ? WorkExperienceData.experiences
            : ProjectData.projects;

    setState(() {
      if (_current.currentPointIndex > -1) {
        _current.currentPointIndex--;
      } else if (_current.currentItemIndex > 0) {
        _current.currentItemIndex--;
        _current.currentPointIndex =
            items[_current.currentItemIndex].scrollablePoints.length - 1;
      } else {
        _unfreeze(scrollingDown: false);
      }
    });
  }

  void _jumpToItem(int index) {
    if (index == _current.currentItemIndex) return;

    final screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      _current.currentItemIndex = index;
      _current.currentPointIndex = _isPositionsTab ? 0 : -1;
      _isFrozen = true;
      _current.hasCompleted = false;
      _freezeOffset = screenHeight;
      _accumulatedDelta = 0;
    });
  }

  void _completeScrollSession() {
    _current.hasCompleted = true;
    _isFrozen = false;
    _unfreeze(scrollingDown: true);
  }

  void _resetScrollSession() {
    setState(() {
      _current.hasCompleted = false;
      _current.currentItemIndex = 0;
      _current.currentPointIndex = _isPositionsTab ? 0 : -1;
    });
  }

  // ============================================================================
  // SCROLL LOCK METHODS
  // ============================================================================
  void _unfreeze({required bool scrollingDown}) {
    if (!_scrollController.hasClients) return;

    setState(() => _isFrozen = false);

    final offset =
        scrollingDown
            ? _freezeOffset + _scrollOffsetAdjustment
            : _freezeOffset - _scrollOffsetAdjustment;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        _scrollController.jumpTo(offset);
      }
    });
  }

  void _lockScrollPosition() {
    if (!_scrollController.hasClients) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        _scrollController.jumpTo(_freezeOffset);
      }
    });
  }

  void _enterFreezeMode({
    required double screenHeight,
    required bool isReverse,
  }) {
    final items =
        _tabController.index == _experienceTabIndex
            ? WorkExperienceData.experiences
            : _tabController.index == _projectsTabIndex
            ? ProjectData.projects
            : null; // positions

    final lastItemIndex =
        _isPositionsTab ? PositionData.positions.length - 1 : items!.length - 1;

    setState(() {
      _isFrozen = true;
      _freezeOffset = screenHeight;
      _current.currentItemIndex = isReverse ? lastItemIndex : 0;
      _current.currentPointIndex =
          isReverse && !_isPositionsTab
              ? items![lastItemIndex].scrollablePoints.length - 1
              : _isPositionsTab
              ? 0
              : -1;
      _current.hasCompleted = false;
      _accumulatedDelta = 0;
    });

    _lockScrollPosition();
  }

  // ============================================================================
  // SCROLL HANDLER
  // ============================================================================
  bool _onScroll(ScrollNotification notification) {
    final screenHeight = MediaQuery.of(context).size.height;
    final freezePoint = screenHeight;

    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta ?? 0;
      final offset = notification.metrics.pixels;

      // Enter freeze mode (scrolling down into tab section)
      if (!_isFrozen && !_current.hasCompleted && offset >= freezePoint) {
        _enterFreezeMode(screenHeight: screenHeight, isReverse: false);
        return true;
      }

      // Enter reverse freeze mode (scrolling up from below)
      if (!_isFrozen &&
          _current.hasCompleted &&
          offset > freezePoint * _freezePointBelow &&
          offset <= freezePoint * _freezePointMax &&
          delta < 0) {
        _enterFreezeMode(screenHeight: screenHeight, isReverse: true);
        return true;
      }

      // Reset when scrolled back to top
      if (_current.hasCompleted && offset < freezePoint * _freezePointAbove) {
        _resetScrollSession();
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
      _nextPoint();
    } else if (_accumulatedDelta < -threshold) {
      _accumulatedDelta = 0;
      _prevPoint();
    }
  }

  // ============================================================================
  // UTILITY
  // ============================================================================
  Future<void> _launchLink(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  // ============================================================================
  // BUILD
  // ============================================================================
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
              _isFrozen
                  ? const NeverScrollableScrollPhysics()
                  : const ClampingScrollPhysics(),
          child: Column(
            children: [
              _buildHeroSection(screen),
              _buildTabSection(screen),
              _buildPromoSection(screen),
              Footer(size: screen.getScreenSize()),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // HERO
  // ============================================================================
  Widget _buildHeroSection(Screen screen) {
    return Container(
      width: screen.width,
      height: screen.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(130, 246, 176, 1),
            Color.fromRGBO(91, 250, 154, 1),
          ],
        ),
      ),
      child: Text(
        "Work.",
        style: TextStyle(
          fontFamily: "CoveredByYourGrace",
          fontSize: WC.heading[screen.deviceType]! * screen.width,
          color: const Color.fromRGBO(22, 133, 111, 1),
        ),
      ),
    );
  }

  // ============================================================================
  // TAB SECTION
  // ============================================================================
  Widget _buildTabSection(Screen screen) {
    return Container(
      color: Colors.white,
      child: Column(children: [_buildTabBar(screen), _buildTabContent(screen)]),
    );
  }

  Widget _buildTabBar(Screen screen) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0.025 * screen.width,
        vertical: 0.025 * screen.height,
      ),
      child: Row(
        children: [
          _buildTabButton("Work Experience", _experienceTabIndex),
          const SizedBox(width: 12),
          _buildTabButton("Projects", _projectsTabIndex),
          const SizedBox(width: 12),
          _buildTabButton("Positions", _positionsTabIndex),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = _tabController.index == index;

    return GestureDetector(
      onTap: () => _handleTabChange(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? const Color.fromRGBO(22, 133, 111, 1)
                  : Colors.grey[200],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: "ABeeZee",
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(Screen screen) {
    final tabIndex = _tabController.index;
    final state = _tabStates[tabIndex];

    return IndexedStack(
      index: tabIndex,
      children: [
        // ── Work Experience ──────────────────────────────────────────────────
        _tabBuilt[_experienceTabIndex]
            ? WorkExperienceTab(
              screen: screen,
              currentCompanyIndex:
                  _tabStates[_experienceTabIndex].currentItemIndex,
              currentPointIndex:
                  _tabStates[_experienceTabIndex].currentPointIndex,
              isFrozen: _isFrozen && tabIndex == _experienceTabIndex,
              globalPointIndex:
                  tabIndex == _experienceTabIndex ? _globalPointIndex : 0,
              totalPoints: tabIndex == _experienceTabIndex ? _totalPoints : 1,
              onJumpToCompany: _jumpToItem,
            )
            : SizedBox(height: screen.height),

        // ── Projects ─────────────────────────────────────────────────────────
        _tabBuilt[_projectsTabIndex]
            ? ProjectsTab(
              screen: screen,
              currentProjectIndex:
                  _tabStates[_projectsTabIndex].currentItemIndex,
              currentPointIndex:
                  _tabStates[_projectsTabIndex].currentPointIndex,
              isFrozen: _isFrozen && tabIndex == _projectsTabIndex,
              globalPointIndex:
                  tabIndex == _projectsTabIndex ? _globalPointIndex : 0,
              totalPoints: tabIndex == _projectsTabIndex ? _totalPoints : 1,
              onJumpToProject: _jumpToItem,
            )
            : SizedBox(height: screen.height),

        // ── Positions ────────────────────────────────────────────────────────
        _tabBuilt[_positionsTabIndex]
            ? PositionsTab(
              screen: screen,
              currentPositionIndex:
                  _tabStates[_positionsTabIndex].currentItemIndex,
              isFrozen: _isFrozen && tabIndex == _positionsTabIndex,
              onJumpToPosition: _jumpToItem,
              onNavigateToProject: _navigateToProject,
            )
            : SizedBox(height: screen.height),
      ],
    );
  }

  // ============================================================================
  // PROMO
  // ============================================================================
  Widget _buildPromoSection(Screen screen) {
    return PromoRedirector(
      size: screen.getScreenSize(),
      deviceType: screen.deviceType,
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
            Color.fromRGBO(183, 193, 192, 1.0),
          ],
        ),
      ),
      pageDescriptor: "To check all of my work,\n head to my github!",
      button: TextButton.icon(
        icon: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white.withValues(alpha: 0.7),
        ),
        onPressed: () => _launchLink('https://github.com/justary27'),
        label: Text(
          "Head to github",
          style: TextStyle(
            fontFamily: "ABeeZee",
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

/// Pure display widget for the Positions of Responsibility tab.
/// No sub-points — each position is a single scroll state (core section only).
/// All scroll state is owned by WorkPage and passed in as parameters.
class PositionsTab extends StatelessWidget {
  final Screen screen;
  final int currentPositionIndex;
  final bool isFrozen;
  final void Function(int index) onJumpToPosition;
  final void Function(String projectId) onNavigateToProject;

  const PositionsTab({
    super.key,
    required this.screen,
    required this.currentPositionIndex,
    required this.isFrozen,
    required this.onJumpToPosition,
    required this.onNavigateToProject,
  });

  @override
  Widget build(BuildContext context) {
    final position = PositionData.positions[currentPositionIndex];

    // Resolve linked projects from ProjectData
    final linkedProjects =
        ProjectData.projects
            .where((p) => position.linkedProjectIds.contains(p.id))
            .toList();

    return SizedBox(
      height: 0.9 * screen.height,
      child: Stack(
        children: [
          PositionCard(
            position: position,
            size: screen.getScreenSize(),
            linkedProjects: linkedProjects,
            onProjectTap: onNavigateToProject,
          ),
          if (isFrozen) _buildQuickNavBar(),
          if (isFrozen) _buildPositionCounter(),
        ],
      ),
    );
  }

  Widget _buildQuickNavBar() {
    return Positioned(
      right: 40,
      top: 0,
      bottom: 0,
      child: Center(
        child: QuickNavBar(
          items:
              PositionData.positions.map((p) {
                return QuickNavItem(
                  label: p.organization,
                  icon: Icons.star_outline,
                );
              }).toList(),
          currentIndex: currentPositionIndex,
          onItemTap: onJumpToPosition,
        ),
      ),
    );
  }

  Widget _buildPositionCounter() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          '${currentPositionIndex + 1} / ${PositionData.positions.length}',
          style: const TextStyle(
            fontFamily: "ABeeZee",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

/// Pure display widget for the Projects tab.
/// Structurally identical to WorkExperienceTab — same scroll-jacking, same card.
/// All scroll state is owned by WorkPage and passed in as parameters.
class ProjectsTab extends StatelessWidget {
  final Screen screen;
  final int currentProjectIndex;
  final int currentPointIndex;
  final bool isFrozen;
  final int globalPointIndex;
  final int totalPoints;
  final void Function(int index) onJumpToProject;

  const ProjectsTab({
    super.key,
    required this.screen,
    required this.currentProjectIndex,
    required this.currentPointIndex,
    required this.isFrozen,
    required this.globalPointIndex,
    required this.totalPoints,
    required this.onJumpToProject,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.9 * screen.height,
      child: Stack(
        children: [
          WorkExperienceCard(
            experience: ProjectData.projects[currentProjectIndex],
            activePointIndex: currentPointIndex,
            size: screen.getScreenSize(),
          ),
          if (isFrozen) _buildQuickNavBar(),
          if (isFrozen) _buildPointCounter(),
        ],
      ),
    );
  }

  Widget _buildQuickNavBar() {
    return Positioned(
      right: 40,
      top: 0,
      bottom: 0,
      child: Center(
        child: QuickNavBar(
          items:
              ProjectData.projects.map((p) {
                return QuickNavItem(
                  label: p.company,
                  icon: Icons.folder_outlined,
                );
              }).toList(),
          currentIndex: currentProjectIndex,
          onItemTap: onJumpToProject,
        ),
      ),
    );
  }

  Widget _buildPointCounter() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          '${globalPointIndex + 1} / $totalPoints',
          style: const TextStyle(
            fontFamily: "ABeeZee",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

/// Pure display widget for the Work Experience tab.
/// All scroll state is owned by WorkPage and passed in as parameters.
class WorkExperienceTab extends StatelessWidget {
  final Screen screen;
  final int currentCompanyIndex;
  final int currentPointIndex;
  final bool isFrozen;
  final int globalPointIndex;
  final int totalPoints;
  final void Function(int index) onJumpToCompany;

  const WorkExperienceTab({
    super.key,
    required this.screen,
    required this.currentCompanyIndex,
    required this.currentPointIndex,
    required this.isFrozen,
    required this.globalPointIndex,
    required this.totalPoints,
    required this.onJumpToCompany,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.9 * screen.height,
      child: Stack(
        children: [
          WorkExperienceCard(
            experience: WorkExperienceData.experiences[currentCompanyIndex],
            activePointIndex: currentPointIndex,
            size: screen.getScreenSize(),
          ),
          if (isFrozen) _buildQuickNavBar(),
          if (isFrozen) _buildPointCounter(),
        ],
      ),
    );
  }

  Widget _buildQuickNavBar() {
    return Positioned(
      right: 40,
      top: 0,
      bottom: 0,
      child: Center(
        child: QuickNavBar(
          items:
              WorkExperienceData.experiences.map((exp) {
                return QuickNavItem(label: exp.company, icon: Icons.business);
              }).toList(),
          currentIndex: currentCompanyIndex,
          onItemTap: onJumpToCompany,
        ),
      ),
    );
  }

  Widget _buildPointCounter() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          '${globalPointIndex + 1} / $totalPoints',
          style: const TextStyle(
            fontFamily: "ABeeZee",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
