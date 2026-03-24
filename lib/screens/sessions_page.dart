import 'package:bteams/core/theme/theme.dart';
import 'package:bteams/core/widgets/bottom_navigation.dart';
import 'package:bteams/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:bteams/models/allmodels.dart';
import 'package:bteams/services/local_storage.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({super.key});

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  final storage = LocalStorageService();
  List<Session> sessions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSessions();
  }

  Future<void> loadSessions() async {
    final data = await storage.loadSessions();

    setState(() {
      sessions = data.reversed.toList();
      isLoading = false;
    });
  }

  Future<void> deleteSession(Session session) async {
    final updatedList = sessions.where((s) => s != session).toList();

    await storage.saveSessions(updatedList.reversed.toList());

    setState(() {
      sessions = updatedList;
    });
  }

  int totalPlayers(Session session) {
    return session.teams.fold(0, (sum, team) => sum + team.players.length);
  }

  void goToCreateSession() {
    Navigator.pushNamed(context, RouteNames.selectShuffle);
  }

  Future<void> confirmDelete(Session session) async {
    final confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir sessão'),
        content: const Text('Tem certeza que deseja apagar esta sessão?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      deleteSession(session);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'Sessoes',
              style: TextStyle(fontFamily: 'SquareBold', fontSize: 20),
            ),
          ],
        ),
        backgroundColor: AppTheme.background,
      ),
      bottomNavigationBar: AppBottomNavigation(currentIndex: 1),
      backgroundColor: AppTheme.background,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : sessions.isEmpty
          ? _emptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];

                final cardColor = index.isEven
                    ? AppTheme.primary
                    : AppTheme.tertiary;

                return SessionCard(
                  session: session,
                  totalPlayers: totalPlayers(session),
                  onDelete: () => deleteSession(session),
                  color: cardColor,
                );
              },
            ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sem sessoes salvas',
            style: TextStyle(fontSize: 16, fontFamily: 'SquareBold'),
          ),
          const SizedBox(height: 12),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondary,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
              ),
            ),
            onPressed: goToCreateSession,
            child: const Text(
              'Criar nova sessão',
              style: TextStyle(
                fontFamily: 'SquareBold',
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SessionCard extends StatelessWidget {
  final Session session;
  final int totalPlayers;
  final VoidCallback onDelete;
  final Color color;

  const SessionCard({
    super.key,
    required this.session,
    required this.totalPlayers,
    required this.onDelete,
    required this.color,
  });

  String getTypeLabel() {
    switch (session.type) {
      case SessionType.random:
        return 'Aleatório';
      case SessionType.balanced:
        return 'Balanceado';
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = session.createdAt;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.sessionDetails,
          arguments: session,
        );
      },
      child: Card(
        color: color,
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Topo do card
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'SquareBold',
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppTheme.background),
                    onPressed: onDelete,
                  ),
                ],
              ),

              const SizedBox(height: 0),

              Text(
                'Tipo: ${getTypeLabel()}',
                style: const TextStyle(
                  fontFamily: 'SquareBold',
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoItem(
                    icon: Icons.groups,
                    label: 'Times',
                    value: session.teams.length.toString(),
                  ),
                  _infoItem(
                    icon: Icons.person,
                    label: 'Players',
                    value: totalPlayers.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'SquareBold',
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'SquareBold',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
