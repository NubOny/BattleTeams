import 'package:flutter/material.dart';
import 'route_names.dart';
import 'package:bteams/models/allmodels.dart';
import 'package:bteams/screens/allpages.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.sessionDetails:
        final session = settings.arguments;

        if (session is! Session) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Erro ao carregar sessão')),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => SessionDetailsPage(session: session),
        );

      case RouteNames.groupDetail:
        final group = settings.arguments;

        if (group is! Group) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Erro ao carregar grupo')),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => GroupDetailsPage(groupName: group.name),
        );

      default:
        return null; // deixa usar o routes normal
    }
  }

  static Map<String, WidgetBuilder> routes = {
    RouteNames.splash: (context) => const SplashView(),
    RouteNames.welcome: (context) => const WelcomePage(),
    RouteNames.home: (context) => const HomePage(),
    RouteNames.createTeamBalanced: (context) => const NewTeamPage(),
    RouteNames.createTeamRandom: (context) => const NewRandomTeamPage(),
    RouteNames.selectShuffle: (context) => const SelectShuffle(),
    RouteNames.savedSessions: (context) => const SessionsPage(),
    RouteNames.savedCrew: (context) => const GroupsPage(),
    RouteNames.settings: (context) => const SettingsPages(),
  };
}
