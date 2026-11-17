import 'dart:ui';

import '../../models/desk.dart';
import '../../models/outcome.dart';
import '../../constants/contact.dart';

String selfDesc = """I'm a recent graduate from Indian Institute of Technology 
Roorkee. Currently working as a software developer. 
I'm very fascinated with computers, hence I'm interested in all things 
like software development, testing, competitive programming, data science, infosec
& UI/UX design.""";

class DeskData {
  DeskData._();

  static const DeskPeek game = DeskPeek(
    eyebrow: "Currently playing",
    title: "Horizon Forbidden West",
    body: "I stream my runs on YouTube.",
    linkLabel: "Watch on YouTube ↗",
    linkUrl: ContactHandler.youtube,
    fromX: 200,
    fromY: 560,
    cardX: 452,
    tabletFrom: Offset(375, 915),
    tabletCard: Offset(440, 610),
  );

  static const DeskPeek music = DeskPeek(
    eyebrow: "On repeat",
    title: "Billie Eilish",
    body: "<placeholder>",
    fromX: 330,
    fromY: 330,
    cardX: 452,
    tabletFrom: Offset(144, 905),
    tabletCard: Offset(200, 630),
  );

  static const DeskPeek sketch = DeskPeek(
    eyebrow: "From the sketchbook",
    title: "UI explorations that never shipped",
    body: "<placeholder>",
    fromX: 420,
    fromY: 540,
    cardX: 452,
    tabletFrom: Offset(600, 912),
    tabletCard: Offset(470, 610),
  );

  static const DeskPeek places = DeskPeek(
    eyebrow: "Places & plates",
    title: "Roorkee → Delhi → Bengaluru",
    body: "Best biryani: still deciding.",
    linkLabel: "More on Instagram ↗",
    linkUrl: ContactHandler.instagram,
    fromX: 780,
    fromY: 600,
    cardX: 470,
    tabletFrom: Offset(232, 690),
    tabletCard: Offset(410, 360),
  );

  static const String latestPostTitle = "Crack that GSoC!";
  static const String latestPostMeta = "22 Aug 2024 · 11 min";
}

class SayHiData {
  SayHiData._();

  static const String pitch =
      "Building something ambitious and need someone to own the tech? I'm up for engineering leadership, early-stage builds and a good tech argument.";
  static const List<String> topics = [
    "a tech lead role",
    "building with you",
    "just saying hi",
  ];
  static const String deliveredNote = "<placeholder>";
}

class SelectedWorkData {
  SelectedWorkData._();

  static const List<Outcome> outcomes = [
    Outcome(
      number: "10.2M/hr",
      project: "Patronus · 8club",
      line: "A notification service I designed in Go.",
      stack: "GO · SQS · FCM",
    ),
    Outcome(
      number: "−90%",
      project: "Feed v2 · 8club",
      line: "Memory, via hybrid fan-out and batch scoring.",
      stack: "FASTAPI · REDIS · SQS",
    ),
    Outcome(
      number: "70%",
      project: "ARTEMIS · Repello AI",
      line: "Of the product, as founding engineer.",
      stack: "PYTHON · REACT · AWS",
    ),
    Outcome(
      number: "<placeholder>",
      project: "<placeholder>",
      line: "<placeholder>",
      stack: "<placeholder>",
    ),
    Outcome(
      number: "<placeholder>",
      project: "<placeholder>",
      line: "<placeholder>",
      stack: "<placeholder>",
    ),
  ];
}
