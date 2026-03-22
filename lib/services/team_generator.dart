import 'package:bteams/models/allmodels.dart';
import 'dart:math';

// Código de geração equilibrada
List<Teams> generateBalancedTeams({
  required List<Player> players,
  required int numberOfTeams,
}) {
  if (numberOfTeams <= 0) return [];

  // Ordena por skill (maior primeiro)
  List<Player> sortedPlayers = List.from(players)
    ..sort((a, b) => b.skill.compareTo(a.skill));

  // Cria os times vazios
  List<List<Player>> teams = List.generate(numberOfTeams, (_) => []);
  List<int> teamsSkillSum = List.generate(numberOfTeams, (_) => 0);

  // Distribui cada jogador para o time com menor soma atual
  for (var player in sortedPlayers) {
    // Encontra índice do time com menor soma de skill
    int minIndex = 0;
    for (int i = 1; i < numberOfTeams; i++) {
      if (teamsSkillSum[i] < teamsSkillSum[minIndex]) minIndex = i;
    }

    teams[minIndex].add(player);
    teamsSkillSum[minIndex] += player.skill;
  }

  // Converte para model Teams
  return teams.map((teamPlayers) => Teams(players: teamPlayers)).toList();
}

// Código de geração aleatória
List<Teams> generateRandomTeams({
  required List<Player> players,
  required int numberOfTeams,
}) {
  if (numberOfTeams <= 0) return [];

  List<Player> shuffledPlayers = List.from(players)..shuffle(Random());

  List<List<Player>> teams = List.generate(numberOfTeams, (_) => []);

  // Distribui jogadores de forma sequencial
  for (int i = 0; i < shuffledPlayers.length; i++) {
    teams[i % numberOfTeams].add(shuffledPlayers[i]);
  }

  // Converte para model Teams
  return teams.map((teamPlayers) => Teams(players: teamPlayers)).toList();
}