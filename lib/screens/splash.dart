import 'package:flutter/material.dart';
import 'package:bteams/core/theme/theme.dart';
import 'package:bteams/routes/route_names.dart';
import 'package:bteams/services/local_storage.dart';

class SplashView extends StatefulWidget {
  final Future<void> Function()? onLoad;

  const SplashView({super.key, this.onLoad});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _startLoading();
    loadData();
  }

  void loadData() async {
    setState(() {});
  }

  Future<void> _startLoading() async {
    if (widget.onLoad != null) {
      await widget.onLoad!();
    }

    final jaViu = await User.isNew();

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      jaViu ? RouteNames.home : RouteNames.welcome,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/bteams_logo.png'),
              width: 220,
            ),

            SizedBox(height: 20),

            Text(
              'BattleTeams',
              style: TextStyle(
                fontSize: 50,
                color: Colors.black,
                fontFamily: 'Capital',
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black38,
                  ),
                  Shadow(
                    offset: Offset(-1, -1),
                    blurRadius: 2,
                    color: Colors.white24,
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            CircularProgressIndicator(
              color: AppTheme.secondary,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
