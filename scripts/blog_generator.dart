import 'dart:io';

void main() {
  print("Enter blog title");
  String? blogTitle = stdin.readLineSync();

  print("Enter blog TagLine");
  String? blogTagLine = stdin.readLineSync();

  print("Enter blog Description");
  String? blogDescription = stdin.readLineSync();

  print("Enter blog Link");
  String? blogLink = stdin.readLineSync();

  print({
    '\n'
        "createdOn": DateTime.now(),
    '\n'
        "title": blogTitle,
    '\n'
        "tagLine": blogTagLine,
    '\n'
        "description": blogDescription,
    '\n'
        "link": blogLink,
  });
}
