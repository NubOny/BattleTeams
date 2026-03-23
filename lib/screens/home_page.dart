import 'package:bteams/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:bteams/core/theme/theme.dart';
import 'package:bteams/core/widgets/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      bottomNavigationBar: AppBottomNavigation(currentIndex: 0),
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: Row(
          children: [
            SizedBox(width: 10),
            Text('Inicio', style: TextStyle(fontFamily: 'SquareBold')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra logo abaixo do AppBar
            Container(height: 2, color: Colors.grey[350]),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(120, 158, 158, 158),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsetsGeometry.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Crie seus times',
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'Capital',
                            ),
                          ),

                          Text(
                            'Organize times para esportes, jogos, eventos e mais',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Capital',
                              fontSize: 20,
                            ),
                          ),

                          SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.selectShuffle,
                                );
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 2,
                              ),
                              child: Text(
                                'Criar Novo Time',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'Capital',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),

                      Text(
                        'Proximos Passos',
                        style: TextStyle(
                          fontFamily: 'SquareBold',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),

                  ActionCard(
                    title: 'Gerenciar Grupos',
                    subtitle: 'Veja e edite seus grupos já criados',
                    icon: Icons.list,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.savedCrew);
                    },
                  ),

                  ActionCard(
                    title: 'Historico de Times',
                    subtitle: 'Reveja os times criados que você salvou',
                    icon: Icons.access_time,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.savedSessions);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // mantém fundo transparente
      borderRadius: BorderRadius.circular(20), // borda arredondada para ripple
      child: InkWell(
        borderRadius: BorderRadius.circular(20), // ripple respeita borda
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 26, color: Colors.black87),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SquareBold',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
