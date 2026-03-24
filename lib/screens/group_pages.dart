import 'package:bteams/core/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:bteams/core/theme/theme.dart';
import 'package:bteams/routes/route_names.dart';
import 'package:bteams/models/allmodels.dart';
import 'package:bteams/services/local_storage.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final storage = LocalStorageService();
  List<Group> groups = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGroups();
  }

  Future<void> loadGroups() async {
    final data = await storage.loadGroups();

    setState(() {
      groups = data.reversed.toList();
      isLoading = false;
    });
  }

  Future<void> deleteGroup(Group group) async {
    final updatedList = groups.where((g) => g != group).toList();

    await storage.saveGroups(updatedList.reversed.toList());

    setState(() {
      groups = updatedList;
    });
  }

  Future<void> confirmDelete(Group group) async {
    final confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir grupo'),
        content: const Text('Tem certeza que deseja apagar este grupo?'),
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
      deleteGroup(group);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grupos',
          style: TextStyle(fontFamily: 'SquareBold', fontSize: 20),
        ),
        backgroundColor: AppTheme.background,
      ),
      bottomNavigationBar: AppBottomNavigation(currentIndex: 3),
      backgroundColor: AppTheme.background,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : groups.isEmpty
          ? _emptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];

                final cardColor = index.isEven
                    ? AppTheme.primary
                    : AppTheme.tertiary;

                return GroupCard(
                  group: group,
                  onDelete: () => confirmDelete(group),
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
          const Text('Sem grupos salvos', style: TextStyle(fontSize: 16, fontFamily: 'SquareBold')),
        ],
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final Group group;
  final VoidCallback onDelete;
  final Color color;

  const GroupCard({
    super.key,
    required this.group,
    required this.onDelete,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.pushNamed(context, RouteNames.groupDetail, arguments: group);
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
                    group.name,
                    style: const TextStyle(
                      fontSize: 16,
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
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.person, size: 18, color: Colors.white),
                  const SizedBox(width: 12),
                  Text(
                    '${group.players.length} players',
                    style: const TextStyle(
                      fontFamily: 'SquareBold',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
