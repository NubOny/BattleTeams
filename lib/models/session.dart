import 'teams.dart';

enum SessionType { random, balanced }

class Session {
  final List<Teams> teams;
  final DateTime createdAt;
  final SessionType type;

  Session({required this.teams, required this.createdAt, required this.type});

  Map<String, dynamic> toJson() => {
    'teams': teams.map((t) => t.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'type': type.name,
  };

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      teams: (json['teams'] as List).map((t) => Teams.fromJson(t)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      type: SessionType.values.firstWhere((e) => e.name == json['type']),
    );
  }
}
