import 'package:flutter/material.dart';
import 'package:bteams/routes/route_names.dart';
import 'package:bteams/core/theme/theme.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigation({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        // Alterar todos para pushReplacement depois
        Navigator.pushReplacementNamed(context, RouteNames.home);
        break;

      case 1:
        Navigator.pushNamed(context, RouteNames.savedTeams);
        break;

      case 2:
        Navigator.pushNamed(context, RouteNames.createTeam);
        break;

      case 3:
        Navigator.pushNamed(context, RouteNames.savedCrew);
        break;

      case 4:
        Navigator.pushNamed(context, RouteNames.settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppTheme.primary,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30),
          label: "Início",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.groups, size: 30),
          label: "Times",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add, size: 30),
          label: "Criar Time",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group, size: 30),
          label: "Grupos",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, size: 30),
          label: 'Definições',
        ),
      ],
    );
  }
}
