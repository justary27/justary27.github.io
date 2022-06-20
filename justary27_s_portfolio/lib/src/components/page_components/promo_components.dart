import 'package:flutter/material.dart';

class PromoRedirector extends StatelessWidget {
  final Size size;
  final Text pageName;
  final Text pageDescriptor;
  final TextButton button;
  const PromoRedirector({
    Key? key,
    required this.size,
    required this.pageName,
    required this.pageDescriptor,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TextButton.icon(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.arrow_forward_ios_rounded,
          //     color: Colors.white.withOpacity(0.7),
          //   ),
          //   label: Text(""),
          // )
        ],
      ),
    );
  }
}
