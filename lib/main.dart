import 'package:bteams/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:bteams/routes/app_routes.dart';
import 'package:bteams/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BattleTeams',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: AppTheme.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.background,
          primary: AppTheme.primary,
          secondary: AppTheme.secondary,
          tertiary: AppTheme.tertiary,
        ),
        useMaterial3: true, // Habilita o design moderno do Material 3
      ),

      initialRoute: RouteNames.splash,

      routes: AppRoutes.routes,
    );

  }
}
