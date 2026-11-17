import '../../models/blog.dart';

const String placeholder = "<placeholder>";

const List<String> _months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

String noteDate(DateTime d) => "${d.day} ${_months[d.month - 1]} ${d.year}";

// One row in the notes app: a single post, or a series collapsed into one.
class Note {
  final String number;
  final String title;
  final String read;
  final int year;
  final DateTime date;
  final String keyword;
  final bool onlyHere;
  final int seriesParts;
  final Blog opens;
  final bool isTop;
  final String? topNote;

  const Note({
    required this.number,
    required this.title,
    required this.read,
    required this.year,
    required this.date,
    required this.keyword,
    required this.onlyHere,
    required this.seriesParts,
    required this.opens,
    required this.isTop,
    required this.topNote,
  });

  bool get isSeries => seriesParts > 1;
}

// Numbers count up from the oldest post; the list shows newest first.
List<Note> buildNotes(List<Blog> blogs) {
  final sorted = [...blogs]..sort((a, b) => a.createdOn.compareTo(b.createdOn));
  final numbers = {
    for (int i = 0; i < sorted.length; i++)
      sorted[i].id: (i + 1).toString().padLeft(2, "0"),
  };

  final List<Note> notes = [];
  final Map<String, List<Blog>> series = {};
  for (final blog in sorted) {
    if (blog.series == null) {
      notes.add(_single(blog, numbers[blog.id]!));
    } else {
      series.putIfAbsent(blog.series!, () => []).add(blog);
    }
  }
  for (final entry in series.entries) {
    final parts = entry.value
      ..sort((a, b) => (a.seriesPart ?? 0).compareTo(b.seriesPart ?? 0));
    if (parts.length == 1) {
      notes.add(_single(parts.first, numbers[parts.first.id]!));
      continue;
    }
    final latest = parts.reduce(
      (a, b) => a.createdOn.isAfter(b.createdOn) ? a : b,
    );
    notes.add(
      Note(
        number: parts.reversed.map((p) => numbers[p.id]!).join("·"),
        title: entry.key,
        read: "${parts.length} parts",
        year: latest.createdOn.year,
        date: latest.createdOn,
        keyword: parts.first.keyword ?? placeholder,
        onlyHere: parts.every((p) => p.source == BlogSource.site),
        seriesParts: parts.length,
        opens: parts.first,
        isTop: parts.any((p) => p.isTop == true),
        topNote: parts.first.topNote,
      ),
    );
  }
  return notes..sort((a, b) => b.date.compareTo(a.date));
}

Note _single(Blog blog, String number) => Note(
  number: number,
  title: blog.title,
  read: blog.minRead,
  year: blog.createdOn.year,
  date: blog.createdOn,
  keyword: blog.keyword ?? placeholder,
  onlyHere: blog.source == BlogSource.site,
  seriesParts: 1,
  opens: blog,
  isTop: blog.isTop == true,
  topNote: blog.topNote,
);

// Route extra for a post opened by the notes app's zoom: the zoom already
// covered the screen in the header's red, so the route skips its own slide.
class ZoomedOpen {
  final Blog blog;

  const ZoomedOpen(this.blog);
}
