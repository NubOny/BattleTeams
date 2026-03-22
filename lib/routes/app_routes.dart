import 'package:flutter/material.dart';
import 'route_names.dart';
import 'package:bteams/screens/allpages.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    RouteNames.splash: (context) => const SplashView(),
    RouteNames.welcome: (context) => const WelcomePage(),
    RouteNames.home: (context) => const HomePage(),
    RouteNames.createTeam: (context) => const NewTeamPage(),
    RouteNames.selectShuffle: (context) => const SelectShuffle(),
    RouteNames.savedSessions: (context) => const SessionsPages(),
    RouteNames.savedCrew: (context) => const GroupPages(),
    RouteNames.crewSettings: (context) => const GroupSettingsPage(),
    RouteNames.settings: (context) => const SettingsPages(),
  };
}
