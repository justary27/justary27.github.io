import 'package:flutter/material.dart';

class WorkDescriptor extends StatelessWidget {
  final Size size;
  final Text title;
  final Text subtitle;
  final Text description;
  final List<Widget> buttonLinks;
  final dynamic model;
  final bool? isRightAligned;
  const WorkDescriptor({
    super.key,
    required this.size,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.buttonLinks,
    this.model,
    this.isRightAligned,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              padding: EdgeInsets.symmetric(
                horizontal: 0.015 * size.width,
                vertical: 0.1 * size.height,
              ),
              alignment: (isRightAligned == null)
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: SizedBox(
                width: 0.4 * size.width,
                height: size.height,
                child: model,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 0.1 * size.width,
                vertical: 0.1 * size.height,
              ),
              width: size.width,
              height: size.height,
              child: Column(
                crossAxisAlignment: (isRightAligned == null)
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: buildWorkWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildWorkWidget() {
    return [
      title,
      subtitle,
      SizedBox(
        width: 0.4 * size.width,
        child: description,
      ),
      ButtonBar(
        alignment: (isRightAligned == null)
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: buttonLinks,
      )
    ];
  }
}
