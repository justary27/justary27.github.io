import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/components/navbar.dart';
import 'package:justary27_s_portfolio/src/pages/intro.dart';
import 'package:justary27_s_portfolio/src/pages/who.dart';
import 'package:justary27_s_portfolio/src/pages/work.dart';

import 'blog.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              IntroPage(
                size: size,
                tabController: _tabController,
              ),
              WhoPage(
                size: size,
                TabController: _tabController,
              ),
              WorkPage(
                size: size,
                tabController: _tabController,
              ),
              BlogPage(
                size: size,
                tabcontroller: _tabController,
              ),
            ],
          ),
          Navbar(
            size: size,
            tabController: _tabController,
          ),
        ],
      ),
    );
  }
}
