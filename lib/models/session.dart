import 'teams.dart';

class Session {
  final List<Teams> teams;
  final DateTime createdAt;

  Session({required this.teams, required this.createdAt});

  Map<String, dynamic> toJson() => {
    'teams': teams.map((t) => t.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
  };

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      teams: (json['teams'] as List).map((t) => Teams.fromJson(t)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
