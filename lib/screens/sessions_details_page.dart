import 'package:bteams/core/theme/theme.dart';
import 'package:bteams/routes/route_names.dart';
import 'package:flutter/material.dart';
// import 'route_names.dart'; // ajuste no seu projeto
// import 'app_theme.dart';
import 'package:bteams/services/local_storage.dart';
import 'package:bteams/models/allmodels.dart';

class SessionDetailsPage extends StatelessWidget {
  final Session session;

  const SessionDetailsPage({super.key, required this.session});

  String skillNick(int level) {
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
        return 'Desconhecido';
    }
  }

  Future<void> deleteSession(BuildContext context) async {
    final storage = LocalStorageService();
    final sessions = await storage.loadSessions();

    sessions.removeWhere((s) => s.createdAt == session.createdAt);

    await storage.saveSessions(sessions);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Sessão apagada")));

    Navigator.pushReplacementNamed(context, RouteNames.savedSessions);
  }

  @override
  Widget build(BuildContext context) {
    final showSkills = session.type == SessionType.balanced;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0,
        title: const Text(
          "Detalhes da Sessão",
          style: TextStyle(fontFamily: 'SquareBold', fontSize: 20),
        ),
        backgroundColor: AppTheme.background,
      ),
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          const SizedBox(height: 15),
          Container(height: 2, color: Colors.black12),
          const SizedBox(height: 15),

          /// LISTA DE TIMES
          Expanded(
            child: ListView.builder(
              itemCount: session.teams.length,
              itemBuilder: (_, index) {
                final team = session.teams[index];

                final Color cardColor =
                    TeamColors.teamColors[index % TeamColors.teamColors.length];

                return Card(
                  color: cardColor,
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Time ${index + 1}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'SquareBold',
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        Container(height: 2, color: Colors.black38),
                        const SizedBox(height: 10),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: team.players.map((p) {
                            if (showSkills) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      p.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'SquareBold',
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      skillNick(p.skill),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'SquareBold',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Center(
                                  child: Text(
                                    p.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SquareBold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// BOTÕES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                /// Apagar sessão
                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () async {
                        final confirm = await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text(
                              'Apagar sessão',
                              style: TextStyle(
                                fontFamily: 'SquareBold',
                                fontSize: 15,
                              ),
                            ),
                            content: const Text(
                              'Tem certeza que deseja apagar esta sessão?',
                              style: TextStyle(
                                fontFamily: 'SquareBold',
                                fontSize: 12,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Apagar'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          await deleteSession(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 6,
                      ),
                      child: const Text(
                        "Apagar sessão",
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

                const SizedBox(width: 20),

                /// VOLTAR
                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);

                        // ou com rota nomeada:
                        // Navigator.pushNamed(context, 'sua_rota_sessions');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 6,
                      ),
                      child: const Text(
                        "Voltar",
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

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
