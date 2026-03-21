import 'player.dart';

class Teams {
  final List<Player> players;

  Teams({required this.players});

  Map<String, dynamic> toJson() => {
    'players': players.map((p) => p.toJson()).toList(),
  };

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      players: (json['players'] as List)
          .map((p) => Player.fromJson(p))
          .toList(),
    );
  }
}
