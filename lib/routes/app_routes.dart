import 'package:flutter/material.dart';
import 'route_names.dart';
import 'package:bteams/screens/allpages.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    RouteNames.splash: (context) => const SplashView(),
    RouteNames.welcome: (context) => const WelcomePage(),
    RouteNames.home: (context) => const HomePage(),
  };
}
