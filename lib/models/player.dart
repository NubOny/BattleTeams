import 'dart:math';

class Player {
  final String id;
  final String name;
  final int skill;

  Player({String? id, required this.name, required this.skill})
    : id = id ?? Random().nextInt(100000).toString();

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'skill': skill};

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(name: json['name'], id: json['id'], skill: json['skill']);
  }
}
