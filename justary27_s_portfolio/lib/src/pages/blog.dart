import 'package:flutter/cupertino.dart';
import 'package:justary27_s_portfolio/src/components/footer.dart';

class BlogPage extends StatefulWidget {
  final Size size;
  final tabcontroller;
  const BlogPage({Key? key, required this.size, required this.tabcontroller})
      : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    final _tabController = widget.tabcontroller;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(),
              Container(
                child: Column(
                  children: [NavBar(size: size, tabController: _tabController)],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
