import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/footer.dart';
import 'package:url_launcher/link.dart';

class WorkPage extends StatefulWidget {
  final Size size;
  final tabController;
  const WorkPage({Key? key, required this.size, required this.tabController})
      : super(key: key);

  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    Size size = widget.size;
    TabController _tabController = widget.tabController;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                        width: size.width,
                        height: 2 * size.height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromRGBO(130, 246, 176, 1.0),
                                Color.fromRGBO(91, 250, 154, 1.0),
                              ]),
                        )),
                    Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(241, 245, 245, 1.0),
                              Color.fromRGBO(218, 224, 224, 1.0),
                            ]),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(92, 219, 148, 1.0),
                              Color.fromRGBO(56, 149, 131, 1.0),
                            ]),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      child: CustomPaint(
                        painter: RoorkeePainter(),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(218, 224, 224, 1.0),
                              Color.fromRGBO(183, 193, 192, 1.0)
                            ]),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 0.3 * size.height,
                      color: Color.fromRGBO(134, 149, 179, 1.0),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width,
                      height: size.height,
                      child: Text(
                        "Work.",
                        style: GoogleFonts.coveredByYourGrace(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(22, 133, 111, 1.0),
                                fontSize: 0.3 * size.height)),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      child: Stack(),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      child: Stack(
                        children: [
                          Container(
                            width: size.width,
                            height: size.height,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.1 * size.width,
                                vertical: 0.1 * size.height),
                            child: Container(
                              width: 0.8 * size.width,
                              height: 0.8 * size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "CovBot",
                                    style: GoogleFonts.itim(
                                        textStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                22, 133, 111, 1.0),
                                            fontSize: 0.1 * size.width)),
                                  ),
                                  Text(
                                    "The only bot you'll need for Covid-19 resources.",
                                    style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: Colors.black
                                                .withGreen(200)
                                                .withOpacity(0.5),
                                            fontSize: 0.02 * size.width,
                                            fontStyle: FontStyle.italic)),
                                  ),
                                  Container(
                                    width: 0.4 * size.width,
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "\n\nCovBot was made during second wave of Covid-19 in India, when I contacted a covid resource server COVID Fighters (India). CovBot automated the process of serving the important resources they collected directly to the server. In addition to this, CovBot can provide Covid stats for many countries, you can also check out the recent trends through a graph. It also provides some recreational features. It is still functional and you can invite it. CovBot was made with ",
                                          style: GoogleFonts.aBeeZee(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      0.0125 * size.width))),
                                      TextSpan(
                                          text: "team InCognoS.\n",
                                          style: GoogleFonts.coveredByYourGrace(
                                              textStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      22, 133, 111, 1.0),
                                                  fontSize:
                                                      0.015 * size.width)))
                                    ])),
                                  ),
                                  Row(children: [
                                    Link(
                                        uri: Uri.parse(
                                            "https://github.com/just-ary27/CovBot"),
                                        builder: (context, openLink) {
                                          return IconButton(
                                              color: Color.fromRGBO(
                                                  22, 133, 111, 1.0),
                                              onPressed: () {},
                                              icon: Icon(
                                                  FontAwesomeIcons.github));
                                        }),
                                    Link(
                                        uri: Uri.parse(
                                            "https://just-ary27.github.io/CovBot/"),
                                        builder: (context, openLink) {
                                          return IconButton(
                                              color: Color.fromRGBO(
                                                  22, 133, 111, 1.0),
                                              onPressed: () {},
                                              icon: Icon(FontAwesomeIcons
                                                  .firefoxBrowser));
                                        }),
                                    Link(
                                        uri: Uri.parse(
                                            "https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot"),
                                        builder: (context, openLink) {
                                          return IconButton(
                                              color: Color.fromRGBO(
                                                  22, 133, 111, 1.0),
                                              onPressed: () {},
                                              icon: Icon(
                                                  FontAwesomeIcons.discord));
                                        }),
                                    Link(
                                        uri: Uri.parse(
                                            "https://in.mashable.com/social-good/22667/covid-discord-group-helps-indians-find-oxygen-answers-and-community"),
                                        builder: (context, openLink) {
                                          return IconButton(
                                              color: Color.fromRGBO(
                                                  22, 133, 111, 1.0),
                                              onPressed: () {},
                                              icon: Icon(
                                                  FontAwesomeIcons.newspaper));
                                        }),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      child: Stack(
                        children: [
                          Container(
                            width: 0.8 * size.width,
                            height: 0.8 * size.height,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.1 * size.width,
                                vertical: 0.1 * size.height),
                            child: Container(
                              width: 0.8 * size.width,
                              height: 0.8 * size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Jane",
                                    style: GoogleFonts.itim(
                                        textStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                241, 245, 245, 1.0),
                                            fontSize: 0.1 * size.width)),
                                  ),
                                  Text(
                                    "A multi-purpose bot to make your stay at discord comfy.",
                                    style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                    218, 224, 224, 1.0)
                                                .withOpacity(0.7),
                                            fontSize: 0.02 * size.width,
                                            fontStyle: FontStyle.italic)),
                                  ),
                                  Container(
                                    width: 0.4 * size.width,
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "\n\nBots have always fascinated me. So when I was given a chance to make one during Makers' 2021 by",
                                          style: GoogleFonts.aBeeZee(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      0.0125 * size.width))),
                                      TextSpan(
                                          text: " SDS Labs, ",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                        14, 43, 133, 1.0)
                                                    .withOpacity(0.7),
                                                fontSize: 0.0125 * size.width),
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                          text:
                                              "I grabbed it promptly, thus was the result Jane-ify. It is an easy to use multi purpose bot. It features moderation, basic equation solving, statistics and music also! More defining features comin' soon! \n",
                                          style: GoogleFonts.aBeeZee(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      0.0125 * size.width))),
                                    ])),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Link(
                                            uri: Uri.parse(
                                                "https://github.com/just-ary27/CovBot"),
                                            builder: (context, openLink) {
                                              return IconButton(
                                                  color: Color.fromRGBO(
                                                          241, 245, 245, 1.0)
                                                      .withOpacity(0.5),
                                                  onPressed: () {},
                                                  icon: Icon(
                                                      FontAwesomeIcons.github));
                                            }),
                                        Link(
                                            uri: Uri.parse(
                                                "https://just-ary27.github.io/CovBot/"),
                                            builder: (context, openLink) {
                                              return IconButton(
                                                  color: Color.fromRGBO(
                                                          241, 245, 245, 1.0)
                                                      .withOpacity(0.5),
                                                  onPressed: () {},
                                                  icon: Icon(FontAwesomeIcons
                                                      .firefoxBrowser));
                                            }),
                                        Link(
                                            uri: Uri.parse(
                                                "https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot"),
                                            builder: (context, openLink) {
                                              return IconButton(
                                                  color: Color.fromRGBO(
                                                          241, 245, 245, 1.0)
                                                      .withOpacity(0.5),
                                                  onPressed: () {},
                                                  icon: Icon(FontAwesomeIcons
                                                      .discord));
                                            }),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      child: Stack(
                        children: [
                          Container(
                            width: size.width,
                            height: size.height,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "To check all of my work,\n head to my github profile!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.caveatBrush(
                                        textStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                56, 149, 131, 1.0),
                                            fontSize: 0.05 * size.width)),
                                  ),
                                  Link(
                                    uri: Uri.parse(
                                        "https://github.com/just-ary27"),
                                    builder: (context, openLink) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.05 * size.height),
                                        child: MaterialButton(
                                          onPressed: () {
                                            openLink;
                                          },
                                          child: Text(
                                            "Head to github",
                                            style: GoogleFonts.aBeeZee(
                                                textStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                            14, 43, 133, 1.0)
                                                        .withOpacity(0.7),
                                                    fontSize: 20)),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    NavBar(size: size, tabController: _tabController),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RoorkeePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(56, 149, 131, 1.0),
            Color.fromRGBO(184, 194, 215, 1.0)
          ]).createShader(Offset.zero & size);
    ;
    Path path = Path();

    // path.lineTo(size.width, size.height);

    path.moveTo(size.width, 0.48 * size.height);
    path.quadraticBezierTo(
      0.9 * size.width,
      0.5 * size.height,
      0.9 * size.width,
      0.7 * size.height,
    );
    path.lineTo(0.12 * size.width, 0.7 * size.height);
    path.lineTo(0.12 * size.width, 0.65 * size.height);
    path.lineTo(0, 0.65 * size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
