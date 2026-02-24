import 'dart:ui';

class RouteHandler {
  RouteHandler._();

  /// Homepage path
  static const String homePage = "/";

  // Web Pages

  // static const String introPage = "/intro";
  static const String whoPage = "/who";
  static const String workPage = "/work";
  static const String blogPage = "/blog";
  static String blogDetailsPage(String blogId) => "/blog/$blogId";

  // Page Colors

  static const Color homeColor = Color(0xFF0d0d0d);
  static const Color whoColor = Color(0xFF0E2B85);
  static const Color workColor = Color(0xFF389583);
  static const Color blogColor = Color(0xFFA81D13);
  // static const Color oldBlogColor = Color(0xFFF6DF47);
}
