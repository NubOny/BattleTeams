import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:bteams/models/allmodels.dart';

// Checagem para definir se é novo usuário ou não
class User {
  static const _keyIsNew = 'no';

  static Future<bool> isNew() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsNew) ?? false;
  }

  static Future<void> isNotNew() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsNew, true);
  }
}

// Sistema de salvamento local de dados
class LocalStorageService {
  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/app_data.json');
  }

  Future<Map<String, dynamic>> _readData() async {
    final file = await _getFile();

    if (!await file.exists()) {
      return {
        'players': [],
        'groups': [],
        'sessions': [],
      };
    }

    final content = await file.readAsString();
    return jsonDecode(content);
  }

  Future<void> _writeData(Map<String, dynamic> data) async {
    final file = await _getFile();
    await file.writeAsString(jsonEncode(data));
  }

  // PLAYERS
  Future<List<Player>> loadPlayers() async {
    final data = await _readData();
    return (data['players'] as List)
        .map((p) => Player.fromJson(p))
        .toList();
  }

  Future<void> savePlayers(List<Player> players) async {
    final data = await _readData();
    data['players'] = players.map((p) => p.toJson()).toList();
    await _writeData(data);
  }

  // GROUPS
  Future<List<Group>> loadGroups() async {
    final data = await _readData();
    return (data['groups'] as List)
        .map((g) => Group.fromJson(g))
        .toList();
  }

  Future<void> saveGroups(List<Group> groups) async {
    final data = await _readData();
    data['groups'] = groups.map((g) => g.toJson()).toList();
    await _writeData(data);
  }

  // SESSIONS
  Future<List<Session>> loadSessions() async {
    final data = await _readData();
    return (data['sessions'] as List)
        .map((s) => Session.fromJson(s))
        .toList();
  }

  Future<void> saveSessions(List<Session> sessions) async {
    final data = await _readData();
    data['sessions'] = sessions.map((s) => s.toJson()).toList();
    await _writeData(data);
  }
}