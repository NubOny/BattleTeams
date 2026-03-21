import 'player.dart';

class Group {
  final String name;
  final List<Player> players;

  Group({required this.name, required this.players});

  Map<String, dynamic> toJson() => {
    'name': name,
    'players': players.map((p) => p.toJson()).toList(),
  };

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json['name'],
      players: (json['players'] as List)
          .map((p) => Player.fromJson(p))
          .toList(),
    );
  }
}
