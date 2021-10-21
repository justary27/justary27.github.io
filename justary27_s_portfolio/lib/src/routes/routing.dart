import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/pages/blog/blog.dart';
import 'package:justary27_s_portfolio/src/pages/intro/intro.dart';
import 'package:justary27_s_portfolio/src/pages/opener/opener.dart';
import 'package:justary27_s_portfolio/src/pages/who/who.dart';
import 'package:justary27_s_portfolio/src/pages/work/work.dart';

class RouteManager {
  static const String homePage = "/";
  static const String introPage = "/intro";
  static const String whoPage = "/who";
  static const String workPage = "/work";
  static const String blogPage = "/blog";
  static late Size size;
  static late String deviceType;
  static String currentRoute = "home";
  static Color currentColor = Colors.black;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => OpenerPage(
                  size: size,
                  deviceType: deviceType,
                ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.00;
              const end = 1.00;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 750));
      case introPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => IntroPage(
            size: size,
            deviceType: deviceType,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, -1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        );
      case whoPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => WhoPage(
            size: size,
            deviceType: deviceType,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        );
      case workPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => WorkPage(
            size: size,
            deviceType: deviceType,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        );
      case blogPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlogPage(
            size: size,
            deviceType: deviceType,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        );
      default:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => OpenerPage(
            size: size,
            deviceType: deviceType,
          ),
        );
    }
  }

  static void navigateToHome(GlobalKey<NavigatorState> navigator) {
    navigator.currentState!.pushNamed(RouteManager.homePage);
    RouteManager.currentRoute = "home";
    RouteManager.currentColor = Colors.black;
  }

  static void navigateToIntro(GlobalKey<NavigatorState> navigator) {
    navigator.currentState!.pushNamed(RouteManager.introPage);
    RouteManager.currentRoute = "intro";
    RouteManager.currentColor = Color.fromRGBO(236, 131, 131, 1.0);
  }

  static void navigateToWho(GlobalKey<NavigatorState> navigator) {
    navigator.currentState!.pushNamed(RouteManager.whoPage);
    RouteManager.currentRoute = "who";
    RouteManager.currentColor = Color.fromRGBO(14, 43, 133, 1.0);
  }

  static void navigateToWork(GlobalKey<NavigatorState> navigator) {
    navigator.currentState!.pushNamed(RouteManager.workPage);
    RouteManager.currentRoute = "work";
    RouteManager.currentColor = Color.fromRGBO(56, 149, 131, 1.0);
  }

  static void navigateToBlog(GlobalKey<NavigatorState> navigator) {
    navigator.currentState!.pushNamed(RouteManager.blogPage);
    RouteManager.currentRoute = "blog";
    RouteManager.currentColor = Color.fromRGBO(246, 223, 71, 1.0);
  }
}
