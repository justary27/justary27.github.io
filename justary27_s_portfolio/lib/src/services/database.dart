import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:justary27_s_portfolio/src/models/blog_model.dart';

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

  static writeBlog(Map<String, dynamic> blogMap) async {
    try {
      firestore.collection("blogs").add(blogMap);
      print("Success");
    } catch (e) {
      print(e);
    }
  }
}
