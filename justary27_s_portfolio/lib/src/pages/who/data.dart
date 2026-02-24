import '../../models/who.dart';
import 'package:flutter/material.dart';

String pastDesc = """It's almost 2 years now of me stayin' in IITR. 
There's only so much of what I have learned that I can say! The life here has 
been a constants source of adventure, throwing me into violent storms or in 
the pristine valley of flowers in the spring. 
Describing the flowers, there have been many, I like the fact that I am able 
to select a field I wanna do in the future, i.e, coding. Done several projects, 
taken enough PORs to fill a page of resume, became a part of IMG, one of the best 
clubs of IITR. What more can you want? Thorns you ask? Preping for the MTEs and ETEs, 
betrayal by some friends? and the biggest one yet the gruelling intern season. 
Before getting into IIT-R, I got AIR 3792 in Jee Advanced 2020, and AIR 1859 in 
Jee Mains 2020. The path was not always like a fine day at the ocean 
there were several ups but also several stormy days aka downs, despite all this 
I managed to stay on the path during the 4 years of my preparation. 
In these years I also cleared several important exams like NTSE stage-II, 
NSEJS, NSEP, NSEC, NSEA and PRMO. An achievement which I cherish from my 
5th standard is getting AIR 1 in NAO, an astronomy olympiad.""";

String presentDesc = """Having spent almost 5 semesters in IIT-R, quite a lot 
has happened since the time I joined. I have made several friends, connections, 
participated in several hackathons and events, developed several soft skills,
and also learned several industry ones too! Talking about the very present, 
Currently very happy from what I have achieved! Completed earlier milestone of 
clearing GSoC, and was also able to get an intern @Amazon for the next season! 
Also currently Project Leader @Information Management Group, IIT Roorkee.""";

String futureDesc = """Even though I don't plan miles ahead, yet I have a few 
goals; which I wanna clear in da comin' time. The ultimate goal is to master 
everything that the vast field of computer science can provide. 
For the new milestones I'll like to explore other fields like DL, ML 
and blockchain and of course exceling in DSA; From the earlier tagline of 
"I know the path isn't gonna be easy, but nothin' worthwhile is. Isn't it?", 
I have moved to a new one: "One life ends the previous day, 
and you start another one the next day!"  """;

class WhoData {
  WhoData._();

  static final List<WhoSection> sections = [
    // -------------------------------------------------------------------------
    // Present
    // -------------------------------------------------------------------------
    WhoSection(
      label: 'Present',
      accentShade: const Color.fromRGBO(14, 43, 133, 1.0),
      steps: [
        WhoSubStep(
          text: 'TODO: 8club — current role, what you\'re working on.',
          photos: const [],
        ),
        WhoSubStep(
          text:
              'TODO: Personal tidbits — hobbies, interests, what keeps you sane outside work.',
          photos: [],
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // Past
    // -------------------------------------------------------------------------
    WhoSection(
      label: 'Past',
      accentShade: Color.fromRGBO(74, 103, 193, 1.0),
      steps: [
        WhoSubStep(
          text: 'TODO: Repello AI — the founding engineer chapter.',
          photos: [],
        ),
        WhoSubStep(
          text:
              'TODO: IIT-R Year 1 — first steps, first friends, first taste of it all.',
          photos: [],
        ),
        WhoSubStep(
          text:
              'TODO: IIT-R Year 2 — finding your footing, early projects, GSoC.',
          photos: [],
        ),
        WhoSubStep(
          text: 'TODO: IIT-R Year 3 — Amazon intern, growing as an engineer.',
          photos: [],
        ),
        WhoSubStep(
          text:
              'TODO: IIT-R Year 4 — CloudDefense, GSoC mentor, closing the chapter.',
          photos: [],
        ),
        WhoSubStep(
          text:
              'TODO: Pre-IIT part 1 — the grind, the preparation, the years of building towards something.',
          photos: [],
        ),
        WhoSubStep(
          text:
              'TODO: Pre-IIT part 2 — olympiads, AIR 1 in NAO, the achievements that shaped you.',
          photos: [],
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // Future
    // -------------------------------------------------------------------------
    WhoSection(
      label: 'Future',
      accentShade: Color.fromRGBO(134, 163, 223, 1.0),
      steps: [
        WhoSubStep(
          text:
              'TODO: Where you\'re headed — the direction, the goals, what drives you forward.',
          photos: const [],
        ),
        WhoSubStep(
          text:
              'TODO: The philosophical note — the tagline, the outlook, the next chapter.',
          photos: const [],
        ),
      ],
    ),
  ];
}
