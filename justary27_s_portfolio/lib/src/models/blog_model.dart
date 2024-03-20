import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  String title;
  String tagLine;
  String link;
  String description;
  DateTime createdOn;

  String get blogTitle => title;
  String get blogTagLine => tagLine;
  String get blogLink => blogLink;
  String get blogDescription => description;
  String get blogCreatedOn {
    return "${createdOn.day}/${createdOn.month}/${createdOn.year}";
  }

  Blog(this.title, this.tagLine, this.link, this.description, this.createdOn);

  factory Blog.fromJson(QueryDocumentSnapshot snapshot) {
    return Blog(
      snapshot['title'],
      snapshot['tagLine'],
      snapshot['link'],
      snapshot['description'],
      snapshot['createdOn'].toDate(),
    );
  }
}
