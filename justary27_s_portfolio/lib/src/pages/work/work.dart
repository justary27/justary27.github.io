// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justary27_s_portfolio/src/components/footer.dart';
import 'package:justary27_s_portfolio/src/components/page_components/promo_components.dart';
import 'package:justary27_s_portfolio/src/components/page_components/work_components.dart';
import 'workConstraints.dart';
import 'package:justary27_s_portfolio/src/components/rPainter.dart';
import 'dart:html' as html;

const Map _cf = ConstraintFactors;

class WorkPage extends StatefulWidget {
  final Size size;
  final String deviceType;

  const WorkPage({
    Key? key,
    required this.size,
    required this.deviceType,
  }) : super(key: key);

  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    final String deviceType = widget.deviceType;
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.up,
      color: Color.fromRGBO(130, 246, 176, 1.0).withOpacity(0.3),
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: SingleChildScrollView(
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
                            painter: RoorkeePainter(
                                Color.fromRGBO(56, 149, 131, 1.0),
                                Color.fromRGBO(184, 194, 215, 1.0)),
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
                                    fontSize: _cf['heading'][deviceType] *
                                        size.width)),
                          ),
                        ),
                        WorkDescriptor(
                          size: size,
                          isRightAligned: true,
                          title: Text(
                            "Lyf",
                            style: GoogleFonts.itim(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(56, 149, 131, 1.0),
                                  fontSize: _cf['projTitle'][deviceType] *
                                      size.width),
                            ),
                          ),
                          subtitle: Text(
                            "Life, Optimized.",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: _cf['projSubtitle'][deviceType] *
                                      size.width,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          description: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      """\n\nHeard someone sayin' that todo and diary app's are simple to make. Does it have to be so? Thinkin' so I decided to make things more complicated. Yes, it's a todo/ diary entry app. But does every other one reminds you of your todos, or can you generated PDFs of your diaries? While storing everything on server to keep data safe, future plans are to include 2FA, biometric authentication and a health check feature! Coming soon to playstore! Check out the UI design's too!""",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.75),
                                        fontSize: _cf['projDescription']
                                                [deviceType] *
                                            size.width),
                                  ),
                                ),
                                // TextSpan(
                                //   text: " SDS Labs, ",
                                //   style: GoogleFonts.aBeeZee(
                                //     textStyle: TextStyle(
                                //         color: Color.fromRGBO(14, 43, 133, 1.0)
                                //             .withOpacity(0.7),
                                //         fontSize: _cf['projEmphasis']
                                //                 [deviceType] *
                                //             size.width),
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ],
                            ),
                            textAlign: TextAlign.right,
                          ),
                          buttonLinks: [
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(56, 149, 131, 1.0)
                                  .withOpacity(0.75),
                              onPressed: () {
                                html.window.open(
                                  "https://github.com/just-ary27/Lyf",
                                  "New Tab",
                                );
                              },
                              icon: Icon(FontAwesomeIcons.github),
                            ),
                            // IconButton(
                            //   iconSize: _cf['projLinks'][deviceType],
                            //   color: Color.fromRGBO(241, 245, 245, 1.0)
                            //       .withOpacity(0.5),
                            //   onPressed: () {
                            //     html.window.open(
                            //       "https://just-ary27.github.io/CovBot/",
                            //       "New Tab",
                            //     );
                            //   },
                            //   icon: Icon(FontAwesomeIcons.firefoxBrowser),
                            // ),
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(56, 149, 131, 1.0)
                                  .withOpacity(0.75),
                              onPressed: () {
                                html.window.open(
                                  "https://www.figma.com/file/3lWdqxgt6QpTEOvfW5Vwu1/Lyf?node-id=123%3A2",
                                  "New tab",
                                );
                              },
                              icon: Icon(FontAwesomeIcons.figma),
                            ),
                          ],
                          model: SvgPicture.asset(
                            "images/lyf.svg",
                            color: Color.fromRGBO(56, 149, 131, 1.0),
                          ),
                        ),
                        WorkDescriptor(
                          size: size,
                          title: Text(
                            "BugHeist: UI",
                            style: GoogleFonts.itim(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(22, 133, 111, 1.0),
                                  fontSize: _cf['projTitle'][deviceType] *
                                      size.width),
                            ),
                          ),
                          subtitle: Text(
                            "Why not share some UI related experience?",
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                  color: Colors.black
                                      .withGreen(200)
                                      .withOpacity(0.5),
                                  fontSize: _cf['projSubtitle'][deviceType] *
                                      size.width,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          description: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      """\n\nWhile developing the app is the primary task at hand for my GSoC project, I have also reworked the whole UI. Since, I haven't put anything related to my UI designing exp, thought this would be good! Also do check out the app on the playstore and iOS store!""",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: _cf['projDescription']
                                                [deviceType] *
                                            size.width),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          buttonLinks: [
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(22, 133, 111, 1.0),
                              onPressed: () {
                                html.window.open(
                                  'https://www.figma.com/file/NYD5WZzJywnO338lchnece/BugHeist?node-id=8%3A1129',
                                  'New Tab',
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.figma,
                              ),
                            ),
                            // IconButton(
                            //   iconSize: _cf['projLinks'][deviceType],
                            //   color: Color.fromRGBO(22, 133, 111, 1.0),
                            //   onPressed: () {
                            //     html.window.open(
                            //         'https://just-ary27.github.io/CovBot/',
                            //         'New Tab');
                            //   },
                            //   icon: Icon(FontAwesomeIcons.firefoxBrowser),
                            // ),
                            // IconButton(
                            //   iconSize: _cf['projLinks'][deviceType],
                            //   color: Color.fromRGBO(22, 133, 111, 1.0),
                            //   onPressed: () {
                            //     html.window.open(
                            //         'https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot',
                            //         'New Tab');
                            //   },
                            //   icon: Icon(FontAwesomeIcons.discord),
                            // ),
                            // IconButton(
                            //   iconSize: _cf['projLinks'][deviceType],
                            //   color: Color.fromRGBO(22, 133, 111, 1.0),
                            //   onPressed: () {
                            //     html.window.open(
                            //         'https://in.mashable.com/social-good/22667/covid-discord-group-helps-indians-find-oxygen-answers-and-community',
                            //         'New Tab');
                            //   },
                            //   icon: Icon(FontAwesomeIcons.newspaper),
                            // ),
                          ],
                          model: SvgPicture.asset("images/bugheist.svg"),
                        ),
                        WorkDescriptor(
                          size: size,
                          isRightAligned: true,
                          title: Text(
                            "GSoC'22",
                            style: GoogleFonts.itim(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(241, 245, 245, 1.0),
                                  fontSize: _cf['projTitle'][deviceType] *
                                      size.width),
                            ),
                          ),
                          subtitle: Text(
                            "What can be better than contributing in GSoC?",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(218, 224, 224, 1.0)
                                      .withOpacity(0.7),
                                  fontSize: _cf['projSubtitle'][deviceType] *
                                      size.width,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          description: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      """\n\nSince, when I got to know about Google's Summer of Code, I have always wanted to become a contributor. 
                                      Never I thought that I would get a chance to be one! This summer of 22, I am contributing to one of the most prestigious orgs in security,""",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: _cf['projDescription']
                                                [deviceType] *
                                            size.width),
                                  ),
                                ),
                                TextSpan(
                                  text: " OWASP, ",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Color.fromRGBO(14, 43, 133, 1.0)
                                            .withOpacity(0.7),
                                        fontSize: _cf['projEmphasis']
                                                [deviceType] *
                                            size.width),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      """I am working on improving their flutter app "BugHeist". You can check my project on the GSoC'22 website too! 
                                      Also, I have written and writing blogs regarding my GSoC experience. Do check 'em!\n""",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: _cf['projDescription']
                                                [deviceType] *
                                            size.width),
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.right,
                          ),
                          buttonLinks: [
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(241, 245, 245, 1.0)
                                  .withOpacity(0.5),
                              onPressed: () {
                                html.window.open(
                                  "https://github.com/Bugheist/Flutter",
                                  "New Tab",
                                );
                              },
                              icon: Icon(FontAwesomeIcons.github),
                            ),
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(241, 245, 245, 1.0)
                                  .withOpacity(0.5),
                              onPressed: () {
                                html.window.open(
                                  "https://summerofcode.withgoogle.com/programs/2022/projects/ShGlbTKv",
                                  "New Tab",
                                );
                              },
                              icon: Icon(FontAwesomeIcons.firefoxBrowser),
                            ),
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(241, 245, 245, 1.0)
                                  .withOpacity(0.5),
                              onPressed: () {
                                html.window.open(
                                  "https://medium.com/@justary27/my-gsoc22-voyage-beginning-4296df5af625",
                                  "New tab",
                                );
                              },
                              icon: Icon(FontAwesomeIcons.medium),
                            ),
                          ],
                          model: SvgPicture.asset("images/gsoc.svg"),
                        ),
                        WorkDescriptor(
                          size: size,
                          title: Text(
                            "CovBot",
                            style: GoogleFonts.itim(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(22, 133, 111, 1.0),
                                  fontSize: _cf['projTitle'][deviceType] *
                                      size.width),
                            ),
                          ),
                          subtitle: Text(
                            "The only bot you'll need for Covid-19 resources.",
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                  color: Colors.black
                                      .withGreen(200)
                                      .withOpacity(0.5),
                                  fontSize: _cf['projSubtitle'][deviceType] *
                                      size.width,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          description: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "\n\nCovBot was made during second wave of Covid-19 in India, when I contacted a covid resource server COVID Fighters (India). CovBot automated the process of serving the important resources they collected directly to the server. In addition to this, CovBot can provide Covid stats for many countries, you can also check out the recent trends through a graph. It also provides some recreational features. It is still functional and you can invite it. CovBot was made with ",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: _cf['projDescription']
                                                [deviceType] *
                                            size.width),
                                  ),
                                ),
                                TextSpan(
                                  text: "team InCognoS.\n",
                                  style: GoogleFonts.coveredByYourGrace(
                                    textStyle: TextStyle(
                                        color:
                                            Color.fromRGBO(22, 133, 111, 1.0),
                                        fontSize: _cf['projEmphasis']
                                                [deviceType] *
                                            size.width),
                                  ),
                                )
                              ],
                            ),
                          ),
                          buttonLinks: [
                            IconButton(
                                iconSize: _cf['projLinks'][deviceType],
                                color: Color.fromRGBO(22, 133, 111, 1.0),
                                onPressed: () {
                                  html.window.open(
                                      'https://github.com/just-ary27/CovBot',
                                      'New Tab');
                                },
                                icon: Icon(FontAwesomeIcons.github)),
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(22, 133, 111, 1.0),
                              onPressed: () {
                                html.window.open(
                                    'https://just-ary27.github.io/CovBot/',
                                    'New Tab');
                              },
                              icon: Icon(FontAwesomeIcons.firefoxBrowser),
                            ),
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(22, 133, 111, 1.0),
                              onPressed: () {
                                html.window.open(
                                    'https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot',
                                    'New Tab');
                              },
                              icon: Icon(FontAwesomeIcons.discord),
                            ),
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(22, 133, 111, 1.0),
                              onPressed: () {
                                html.window.open(
                                    'https://in.mashable.com/social-good/22667/covid-discord-group-helps-indians-find-oxygen-answers-and-community',
                                    'New Tab');
                              },
                              icon: Icon(FontAwesomeIcons.newspaper),
                            ),
                          ],
                          model: SvgPicture.asset(
                            "images/covbot.svg",
                            color: Color.fromRGBO(56, 149, 131, 1.0),
                          ),

                          // model: ModelViewer(
                          //   src: 'assets/models/CovBot.gltf',
                          //   alt: "A 3D model of an astronaut",
                          //   ar: false,
                          //   autoRotate: true,
                          //   cameraControls: false,
                          // ),
                        ),
                        WorkDescriptor(
                          size: size,
                          isRightAligned: true,
                          title: Text(
                            "Jane",
                            style: GoogleFonts.itim(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(241, 245, 245, 1.0),
                                  fontSize: _cf['projTitle'][deviceType] *
                                      size.width),
                            ),
                          ),
                          subtitle: Text(
                            "A multi-purpose bot to make your stay at discord comfy.",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(218, 224, 224, 1.0)
                                      .withOpacity(0.7),
                                  fontSize: _cf['projSubtitle'][deviceType] *
                                      size.width,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          description: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "\n\nBots have always fascinated me. So when I was given a chance to make one during Makers' 2021 by",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: _cf['projDescription']
                                                [deviceType] *
                                            size.width),
                                  ),
                                ),
                                TextSpan(
                                  text: " SDS Labs, ",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Color.fromRGBO(14, 43, 133, 1.0)
                                            .withOpacity(0.7),
                                        fontSize: _cf['projEmphasis']
                                                [deviceType] *
                                            size.width),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "I grabbed it promptly, thus was the result Jane-ify. It is an easy to use multi purpose bot. It features moderation, basic equation solving, statistics and music also! More defining features comin' soon! \n",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: _cf['projDescription']
                                                [deviceType] *
                                            size.width),
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.right,
                          ),
                          buttonLinks: [
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(241, 245, 245, 1.0)
                                  .withOpacity(0.5),
                              onPressed: () {
                                html.window.open(
                                    "https://github.com/just-ary27/CovBot",
                                    "New Tab");
                              },
                              icon: Icon(FontAwesomeIcons.github),
                            ),
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(241, 245, 245, 1.0)
                                  .withOpacity(0.5),
                              onPressed: () {
                                html.window.open(
                                    "https://just-ary27.github.io/CovBot/",
                                    "New Tab");
                              },
                              icon: Icon(FontAwesomeIcons.firefoxBrowser),
                            ),
                            IconButton(
                              iconSize: _cf['projLinks'][deviceType],
                              color: Color.fromRGBO(241, 245, 245, 1.0)
                                  .withOpacity(0.5),
                              onPressed: () {
                                html.window.open(
                                    "https://discord.com/oauth2/authorize?client_id=835222640821796924&scope=bot",
                                    "New tab");
                              },
                              icon: Icon(FontAwesomeIcons.discord),
                            ),
                          ],
                          model: SvgPicture.asset("images/jane.svg"),
                        ),
                        PromoRedirector(
                          size: size,
                          deviceType: deviceType,
                          pageName: "GitHub",
                          pageDescriptor:
                              "To check all of my work,\n head to my github!",
                          button: TextButton.icon(
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            onPressed: () {
                              html.window.open(
                                'https://github.com/just-ary27',
                                'New Tab',
                              );
                            },
                            label: Text(
                              "Head to github",
                              style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        NavBar(
                          size: size,
                          deviceType: deviceType,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
