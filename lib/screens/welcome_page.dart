import 'package:bteams/core/theme/theme.dart';
import 'package:bteams/routes/route_names.dart';
import 'package:bteams/services/local_storage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              Image.asset('assets/images/bteams_logo.png', width: 150),

              const SizedBox(height: 30),

              const Text(
                "Bem vindo ao",
                style: TextStyle(fontSize: 20, fontFamily: 'SquareBold'),
              ),

              const Text(
                'BattleTeams',
                style: TextStyle(
                  fontSize: 50,
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

              const SizedBox(height: 10),

              const Text(
                "Seu aplicativo de\nDivisão de Times Inteligente",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              SizedBox(height: 20),

              // Botão de seguir
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    // Cria um 'token' para não aparecer mais essa pagina para o usuário
                    await User.isNotNew();

                    Navigator.pushReplacementNamed(context, RouteNames.home);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Divida e Vença!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Capital',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
