import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(Widget page) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static void pop() {
    navigatorKey.currentState!.pop(); // Handle back navigation
  }

  static void popWithResult<T>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }
}
