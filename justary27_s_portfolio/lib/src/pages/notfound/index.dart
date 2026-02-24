import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../enums/device_type.dart';
import '../../constants/route.dart';
import '../../models/screen.dart';
import '../../providers/screen.dart';
import 'constraints.dart';

class NotFoundPage extends ConsumerStatefulWidget {
  const NotFoundPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends ConsumerState<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    Screen screen = ref.watch(screenProvider);
    DeviceType deviceType = screen.deviceType;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screen.getScreenSize().width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "images/ar_broken.svg",
              width: screen.getScreenSize().width / 5,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Oops! Page Not Found",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontSize: NFC.heading[deviceType]! * screen.width,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextButton.icon(
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
                onPressed: () => context.go(RouteHandler.homePage),
                label: Text(
                  "Go to Home",
                  style: TextStyle(
                    fontFamily: "Ubuntu",
                    color: Colors.white,
                    fontSize: NFC.buttons[deviceType]! * screen.width,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0xFF0d0d0d).withValues(alpha: 0.75),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
