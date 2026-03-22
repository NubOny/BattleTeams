import 'package:bteams/routes/route_names.dart';
import 'package:bteams/core/theme/theme.dart';
import 'package:bteams/models/allmodels.dart';
import 'package:bteams/services/local_storage.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Session session;

  const ResultPage({required this.session, super.key});

  String? skillNick(int level) {
    switch (level) {
      case 1:
        return 'Novato';
      case 2:
        return 'Amador';
      case 3:
        return 'Pro';
      case 4:
        return 'Veterano';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        centerTitle: true,
        title: Column(
          children: [
            SizedBox(height: 15),
            Text(
              "Resultado",
              style: TextStyle(fontFamily: 'Capital', fontSize: 40),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          SizedBox(height: 15),

          Container(height: 2, color: Colors.black12),

          SizedBox(height: 15),

          Expanded(
            child: ListView.builder(
              itemCount: session.teams.length,
              itemBuilder: (_, index) {
                final team = session.teams[index];

                // Escolhe a cor do time baseado no index, repetindo se necessário
                final Color cardColor =
                    TeamColors.teamColors[index % TeamColors.teamColors.length];

                return Card(
                  color: cardColor, // Define a cor do Card
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Time ${index + 1}",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'SquareBold',
                              color: Colors
                                  .white, // Para contraste com a cor do card
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        Container(height: 2, color: Colors.black38),

                        SizedBox(height: 10),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: team.players.map((p) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    p.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SquareBold',
                                      color: Colors.white,
                                    ),
                                  ),

                                  Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SquareBold',
                                      color: Colors.white,
                                    ),
                                  ),

                                  Text(
                                    '${skillNick(p.skill)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SquareBold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () async {
                        final storage = LocalStorageService();
                        final sessions = await storage.loadSessions();
                        sessions.add(session);
                        await storage.saveSessions(sessions);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Sessão salva com sucesso!")),
                        );
                        Navigator.pushReplacementNamed(
                          context,
                          RouteNames.savedSessions,
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 6,
                      ),

                      child: Text(
                        "Salvar",
                        style: TextStyle(
                          fontFamily: 'SquareBold',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 20),

                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteNames.home,
                          (Route route) => false,
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.tertiary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 6,
                      ),

                      child: Text(
                        "Sair\nsem salvar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SquareBold',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
