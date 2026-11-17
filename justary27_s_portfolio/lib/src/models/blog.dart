import 'package:cloud_firestore/cloud_firestore.dart';

enum BlogSource { medium, site }

class Blog {
  String id;
  String title;
  String tagLine;
  String link;
  String minRead;
  String description;
  DateTime createdOn;

  // Notes-app fields; null until the post docs carry them.
  BlogSource? source;
  String? mediumUrl;
  bool? isTop;
  String? topNote;
  String? series;
  int? seriesPart;
  String? keyword;

  String get blogId => id;
  String get blogTitle => title;
  String get blogTagLine => tagLine;
  String get blogLink => link;
  String get blogMinRead => minRead;
  String get blogDescription => description;
  String get blogCreatedOn {
    return "${createdOn.day}/${createdOn.month}/${createdOn.year}";
  }

  Blog(
    this.id,
    this.title,
    this.tagLine,
    this.link,
    this.minRead,
    this.description,
    this.createdOn, {
    this.source,
    this.mediumUrl,
    this.isTop,
    this.topNote,
    this.series,
    this.seriesPart,
    this.keyword,
  });

  factory Blog.fromJson(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? const {};
    return Blog(
      snapshot.id,
      snapshot['title'],
      snapshot['tagLine'],
      snapshot['link'],
      snapshot['minRead'],
      snapshot['description'],
      snapshot['createdOn'].toDate(),
      source: BlogSource.values.asNameMap()[data['source']],
      mediumUrl: data['mediumUrl'] as String?,
      isTop: data['isTop'] as bool?,
      topNote: data['topNote'] as String?,
      series: data['series'] as String?,
      seriesPart: data['seriesPart'] as int?,
      keyword: data['keyword'] as String?,
    );
  }
}
