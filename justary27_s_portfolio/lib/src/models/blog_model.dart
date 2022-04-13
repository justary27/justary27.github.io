import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  String title;
  String tagLine;
  String link;
  String description;
  DateTime createdOn;

  String get blogTitle => this.title;
  String get blogTagLine => this.tagLine;
  String get blogLink => this.blogLink;
  String get blogDescription => this.description;
  String get blogCreatedOn {
    return "${this.createdOn.day}/${this.createdOn.month}/${this.createdOn.year}";
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
