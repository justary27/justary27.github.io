import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/blog_model.dart';

class Database {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<List<Blog>> getBlogs() async {
    List<Blog> blogs = [];
    QuerySnapshot blogQuery = await firestore.collection("blogs").get();
    for (var element in blogQuery.docs) {
      blogs.add(Blog.fromJson(element));
    }
    return blogs;
  }

  static Future<Blog> getBlog(String blogId) async {
    DocumentSnapshot blogDoc =
        await firestore.collection("blogs").doc(blogId).get();

    return Blog.fromJson(blogDoc);
  }

  static writeBlog(Map<String, dynamic> blogMap) async {
    try {
      firestore.collection("blogs").add(blogMap);
      debugPrint("Success");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
