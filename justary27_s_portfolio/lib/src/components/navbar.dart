import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatefulWidget {
  final Size size;
  final TabController tabController;

  const Navbar({Key? key, required this.size, required this.tabController})
      : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = widget.size;
    TabController _tabController = widget.tabController;

    return Container(
      width: size.width,
      height: 0.15 * size.height,
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.02 * size.width),
              child: IconButton(
                icon: Icon(Icons.opacity),
                onPressed: () {},
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 0.15 * size.height,
                    width: 0.3 * size.width,
                    child: TabBar(
                      indicator: BoxDecoration(),
                      controller: _tabController,
                      tabs: [
                        MouseRegion(
                          onHover: (pointer) {},
                          child: Text(
                            "Intro",
                            style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Text(
                          "Who",
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(color: Colors.white)),
                        ),
                        Text(
                          "Work",
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(color: Colors.white)),
                        ),
                        Text(
                          "Blog",
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.02 * size.width),
              child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Contact",
                    style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(color: Colors.white)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
