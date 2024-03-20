// @JS()
// library three_js;
//
// import 'package:js/js.dart';
//
// @JS()
// class ThreeJs {
//   external factory ThreeJs();
// }

import 'package:flutter/material.dart';

class ModelViewer extends StatefulWidget {
  final Size size;
  final String src;

  const ModelViewer({super.key, required this.size, required this.src});

  @override
  State<ModelViewer> createState() => _ModelViewerState();
}

class _ModelViewerState extends State<ModelViewer> {
  @override
  Widget build(BuildContext context) {
    // Size size = widget.size;
    return Container();
  }
}
