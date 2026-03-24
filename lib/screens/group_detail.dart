import 'package:flutter/material.dart';
import 'package:bteams/core/theme/theme.dart';
import 'package:bteams/models/allmodels.dart';
import 'package:bteams/services/local_storage.dart';

class GroupDetailsPage extends StatefulWidget {
  final String groupName;

  const GroupDetailsPage({super.key, required this.groupName});

  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  final storage = LocalStorageService();
  Group? group;
  bool isLoading = true;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    loadGroup();
  }

  Future<void> loadGroup() async {
    final groups = await storage.loadGroups();
    setState(() {
      group = groups.firstWhere((g) => g.name == widget.groupName);
      isLoading = false;
    });
  }

  String? levelNick(int level) {
    switch (level) {
      case 1:
        return 'Novato';
      case 2:
        return 'Amador';
      case 3:
        return 'Pró';
      case 4:
        return 'Veterano';
      default:
        return null;
    }
  }

  Future<void> deletePlayer(int index) async {
    if (group == null) return;

    final player = group!.players[index];

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir jogador'),
        content: Text('Tem certeza que deseja apagar ${player.name}?'),
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

    if (confirm != true) return;

    // Remove com animação
    final removedPlayer = group!.players.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildPlayerCard(removedPlayer, animation),
      duration: const Duration(milliseconds: 300),
    );

    // Salva no storage
    final groups = await storage.loadGroups();
    final gIndex = groups.indexWhere((g) => g.name == group!.name);
    if (gIndex != -1) {
      groups[gIndex] = group!;
      await storage.saveGroups(groups);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (group == null) {
      return const Scaffold(body: Center(child: Text('Grupo não encontrado')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              group!.name,
              style: const TextStyle(fontFamily: 'SquareBold', fontSize: 16),
            ),
          ],
        ),
        backgroundColor: AppTheme.background,
      ),
      backgroundColor: AppTheme.background,
      body: group!.players.isEmpty
          ? const Center(
              child: Text(
                'Nenhum player neste grupo',
                style: TextStyle(fontFamily: 'SquareBold', fontSize: 16),
              ),
            )
          : AnimatedList(
              key: _listKey,
              padding: const EdgeInsets.all(12),
              initialItemCount: group!.players.length,
              itemBuilder: (context, index, animation) {
                final player = group!.players[index];
                return _buildPlayerCard(player, animation);
              },
            ),
    );
  }

  Widget _buildPlayerCard(Player player, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        color: AppTheme.primary,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: const TextStyle(
                      fontFamily: 'SquareBold',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${levelNick(player.skill)}',
                    style: const TextStyle(
                      fontFamily: 'SquareBold',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: AppTheme.background),
                onPressed: () {
                  final index = group!.players.indexOf(player);
                  if (index != -1) deletePlayer(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
