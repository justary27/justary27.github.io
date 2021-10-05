import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/components/navbar.dart';
import 'intro/intro.dart';
import 'who/who.dart';
import 'work/work.dart';
import 'blog/blog.dart';
import 'package:justary27_s_portfolio/src/components/deviceDetector.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String deviceType = deviceDetector(size);
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              IntroPage(
                size: size,
                tabController: _tabController,
                deviceType: deviceType,
              ),
              WhoPage(
                size: size,
                TabController: _tabController,
                deviceType: deviceType,
              ),
              WorkPage(
                size: size,
                tabController: _tabController,
                deviceType: deviceType,
              ),
              BlogPage(
                size: size,
                tabcontroller: _tabController,
                deviceType: deviceType,
              ),
            ],
          ),
          Navbar(
            size: size,
            tabController: _tabController,
            deviceType: deviceType,
          ),
        ],
      ),
      extendBody: true,
    );
  }
}
