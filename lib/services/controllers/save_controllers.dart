import 'package:bteams/models/allmodels.dart';
import 'package:bteams/services/local_storage.dart';

// Lógica de salvar sessão
Future<void> saveSession(List<Teams> teams, type) async {
  final storage = LocalStorageService();

  List<Session> sessions = await storage.loadSessions();

  final newSession = Session(teams: teams, createdAt: DateTime.now(), type: type);

  sessions.add(newSession);

  await storage.saveSessions(sessions);
}

// Lógica de Salvar grupo
Future<void> saveGroup(String name, List<Player> players) async {
  final storage = LocalStorageService();

  List<Group> groups = await storage.loadGroups();

  final newGroup = Group(name: name, players: players);

  groups.add(newGroup);

  await storage.saveGroups(groups);
}

// Lógica de Salvar Player
Future<void> savePlayer(Player newPlayer) async {
  final storage = LocalStorageService();

  List<Player> players = await storage.loadPlayers();

  final exists = players.any((p) => p.id == newPlayer.id);

  if (!exists) {
    players.add(newPlayer);
    await storage.savePlayers(players);
  }
}
