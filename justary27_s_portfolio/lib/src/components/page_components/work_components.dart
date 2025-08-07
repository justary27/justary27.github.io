import 'package:flutter/material.dart';

class WorkDescriptor extends StatelessWidget {
  final Size size;
  final dynamic title;
  final Text subtitle;
  final List<Widget> tags;
  final Text description;
  final List<Widget> buttonLinks;
  final dynamic model;
  final bool? isRightAligned;
  final BoxDecoration decoration;
  const WorkDescriptor({
    super.key,
    required this.size,
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.description,
    required this.buttonLinks,
    required this.decoration,
    this.model,
    this.isRightAligned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      decoration: decoration,
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: size.height),
      child: Stack(
        children: [
          Positioned(
            right: isRightAligned == null ? 0 : null,
            left: isRightAligned == true ? 0 : null,
            width: 0.45 * size.width,
            top: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.015 * size.width),
              constraints: BoxConstraints(minHeight: size.height),
              child: model,
            ),
          ),
          Container(
            width: size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 0.1 * size.width,
              vertical: 0.05 * size.height,
              // right: 0.1 * size.width,
            ),
            constraints: BoxConstraints(minHeight: size.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  (isRightAligned == null)
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
              children: buildWorkWidget(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildWorkWidget() {
    return [
      FittedBox(fit: BoxFit.scaleDown, child: title),
      subtitle,
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Wrap(
          alignment:
              (isRightAligned == null)
                  ? WrapAlignment.start
                  : WrapAlignment.end,
          children: List.generate(
            tags.length,
            (int index) => Padding(
              padding: EdgeInsets.only(
                left: isRightAligned == null ? 0 : 12.0,
                right: isRightAligned == true ? 0 : 12.0,
                top: 10.0,
              ),
              child: tags[index],
            ),
          ),
        ),
      ),
      SizedBox(
        width: 0.4 * size.width,
        child: MouseRegion(cursor: SystemMouseCursors.text, child: description),
      ),
      Row(
        mainAxisAlignment:
            (isRightAligned == null)
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
        children: List.generate(
          buttonLinks.length,
          (int index) => Padding(
            padding: EdgeInsets.only(
              left: isRightAligned == null ? 0 : 12.0,
              right: isRightAligned == true ? 0 : 12.0,
              top: 10.0,
            ),
            child: buttonLinks[index],
          ),
        ),
      ),
    ];
  }
}
