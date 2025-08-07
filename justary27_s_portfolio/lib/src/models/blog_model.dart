import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  String id;
  String title;
  String tagLine;
  String link;
  String minRead;
  String description;
  DateTime createdOn;

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
    this.createdOn,
  );

  factory Blog.fromJson(DocumentSnapshot snapshot) {
    return Blog(
      snapshot.id,
      snapshot['title'],
      snapshot['tagLine'],
      snapshot['link'],
      snapshot['minRead'],
      snapshot['description'],
      snapshot['createdOn'].toDate(),
    );
  }
}
