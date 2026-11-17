import '../../constants/contact.dart';
import '../../models/who.dart';

const String _p = "<placeholder>";

// Years 2020 → now, from the Who prototype's skeleton. Entry text is his old
// Who copy or the Work data where one fits; everything else is <placeholder>
// until he writes it.
class WhoTimelineData {
  WhoTimelineData._();

  static const List<WhoYear> years = [
    WhoYear(
      year: "2020",
      entries: [
        WhoEntry(
          month: 7,
          when: "JUL 2020",
          kind: WhoKind.life,
          title: "IIT Roorkee",
          // From the old Who page's "Past" copy.
          text:
              "Before getting into IIT-R, I got AIR 3792 in Jee Advanced 2020, "
              "and AIR 1859 in Jee Mains 2020.",
          media: [
            WhoMedia.photo(caption: _p),
            WhoMedia.photo(caption: _p),
          ],
        ),
        WhoEntry(
          month: 12,
          when: "DEC 2020",
          kind: WhoKind.code,
          title: _p,
          text: _p,
          media: [
            WhoMedia.link(
              WhoLinkKind.github,
              title: "justary27 on GitHub",
              url: "https://github.com/justary27",
            ),
          ],
        ),
      ],
    ),
    WhoYear(
      year: "2021",
      entries: [
        WhoEntry(
          month: 5,
          when: "MAY 2021",
          kind: WhoKind.code,
          title: "CovBot",
          // CovBot's overview in Work data.
          text:
              "A COVID-19 information Discord bot built during the pandemic to "
              "provide quick, reliable answers to common questions. Featured in "
              "Mashable India.",
          media: [
            WhoMedia.link(
              WhoLinkKind.news,
              title: "Mashable: a Discord group helps Indians find oxygen",
              url: "https://in.mashable.com/social-good/22667/covid-discord-group-helps-indians-find-oxygen-answers-and-community",
            ),
            WhoMedia.photo(caption: _p),
          ],
        ),
        WhoEntry(month: 9, when: _p, kind: WhoKind.life, title: _p, text: _p),
      ],
    ),
    WhoYear(
      year: "2022",
      entries: [
        WhoEntry(
          month: 5,
          when: "MAY – SEP 2022",
          kind: WhoKind.work,
          title: "Google Summer of Code · Contributor",
          // GSoC '22's overview in Work data.
          text:
              "Selected as a GSoC contributor under OWASP. Worked on the "
              "BugHeist Flutter app — designed UI, built features, and "
              "engineered backend APIs.",
          workId: "gsoc22",
          media: [
            WhoMedia.photo(caption: _p),
            WhoMedia.link(
              WhoLinkKind.medium,
              title: "My GSoC'22 Voyage: Conclusion",
              url: "https://medium.com/@justary27/my-gsoc22-voyage-conclusion-e0bf34fec239",
            ),
          ],
        ),
        WhoEntry(
          month: 12,
          when: _p,
          kind: WhoKind.trip,
          title: _p,
          text: _p,
          media: [
            WhoMedia.photo(caption: _p),
            WhoMedia.photo(caption: _p),
          ],
        ),
      ],
    ),
    WhoYear(
      year: "2023",
      entries: [
        WhoEntry(
          month: 5,
          when: "MAY – JUL 2023",
          kind: WhoKind.work,
          title: "Software Development Engineer Intern · Amazon",
          // Amazon's overview in Work data.
          text:
              "Worked at Amazon on the Prime Video team as an SDE intern, "
              "building a staging website for the Market Landing Page campaign "
              "previews.",
          workId: "amazon",
          media: [WhoMedia.photo(caption: _p)],
        ),
        WhoEntry(month: 9, when: _p, kind: WhoKind.life, title: _p, text: _p),
      ],
    ),
    WhoYear(
      year: "2024",
      entries: [
        WhoEntry(
          month: 5,
          when: "MAY 2024",
          kind: WhoKind.life,
          title: "IIT Roorkee '24",
          text: _p,
          media: [
            WhoMedia.photo(caption: _p),
            WhoMedia.photo(caption: _p),
          ],
        ),
        WhoEntry(
          month: 9,
          when: "SEP 2024",
          kind: WhoKind.work,
          title: "Founding Software Development Engineer · Repello AI",
          // Repello's overview in Work data.
          text:
              "Repello AI is an AI security company building ARTEMIS — an AI "
              "Red Teaming platform. Joined as a founding SDE, contributing "
              "across the full product: from the front-end redesign to the "
              "security engine and SDK.",
          workId: "repello",
          media: [WhoMedia.photo(caption: _p)],
        ),
      ],
    ),
    WhoYear(
      year: "2025",
      entries: [
        WhoEntry(
          month: 3,
          when: _p,
          kind: WhoKind.life,
          title: _p,
          text: _p,
          media: [
            WhoMedia.link(
              WhoLinkKind.youtube,
              title: _p,
              url: ContactHandler.youtube,
              live: true,
            ),
          ],
        ),
        WhoEntry(
          month: 7,
          when: _p,
          kind: WhoKind.work,
          title: "Fullstack AI Engineer · 8club",
          text: _p,
          workId: "8club",
          media: [WhoMedia.photo(caption: _p)],
        ),
      ],
    ),
    WhoYear(
      year: "2026",
      entries: [
        WhoEntry(
          month: 6,
          when: _p,
          kind: WhoKind.work,
          title: "Senior Fullstack AI Engineer · 8club",
          text: _p,
          workId: "8club",
          media: [WhoMedia.photo(caption: _p)],
        ),
      ],
    ),
  ];
}
