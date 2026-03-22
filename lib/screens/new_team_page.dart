import 'package:bteams/core/theme/theme.dart';
import 'package:bteams/screens/allpages.dart';
import 'package:bteams/services/local_storage.dart';
import 'package:bteams/models/allmodels.dart';
import 'package:bteams/services/controllers/save_controllers.dart';
import 'package:bteams/services/team_generator.dart';
import 'package:flutter/material.dart';

class NewTeamPage extends StatefulWidget {
  const NewTeamPage({super.key});

  @override
  State<NewTeamPage> createState() => _NewTeamPageState();
}

class _NewTeamPageState extends State<NewTeamPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Carregamento de dados
  Future<void> _loadData() async {
    final storage = LocalStorageService();

    final loadedGroups = await storage.loadGroups();

    setState(() {
      memoryGroups = loadedGroups;
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

  // Função de adicionar player na lista
  void _addPlayer({bool save = false}) async {
    if (_nameController.text.isEmpty) return;

    final player = Player(name: _nameController.text, skill: _selectedSkill);

    setState(() {
      players.add(player);
    });

    // Lógica de salvar o player na memória
    if (save) {
      await savePlayer(player);
    }

    _nameController.clear();
    _selectedSkill = 1;
  }

  // Lógica de criar os times
  void _createTeams() {
    if (_numTeams > players.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Número de times maior que número de jogadores!"),
        ),
      );
      return;
    }

    final generatedTeams = generateBalancedTeams(
      players: players,
      numberOfTeams: _numTeams,
    );

    final session = Session(
      teams: generatedTeams,
      createdAt: DateTime.now(),
      type: SessionType.balanced,
    );

    // Navegar para tela de resultado
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultPage(session: session)),
    );
  }

  // Lógica de salvamento de grupo
  Future<void> _saveGroup(String name) async {
    await saveGroup(name, players);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("'$name' salvo com sucesso!")));
  }

  int _selectedSkill = 1;
  int _numTeams = 2;

  List<Player> players = []; // Lista de Jogadores
  List<Group> memoryGroups = []; // Grupos salvos na memória

  bool _groupSaved = false; // Indica se o grupo já foi salvo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        title: Text("Dividir Times"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// CARD DE INPUT
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
              ),
              child: Column(
                children: [
                  /// NOME
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Nome do jogador",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  /// HABILIDADE (GRID 2x2)
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3,
                    children: List.generate(4, (index) {
                      int level = index + 1;
                      bool selected = _selectedSkill == level;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSkill = level;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selected ? Colors.blue : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              '${levelNick(level)}',
                              style: TextStyle(
                                color: selected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 16),

                  /// BOTÕES
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _addPlayer(save: true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondary,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Salvar + adicionar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _addPlayer(save: false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Só adicionar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            /// LISTA
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final p = players[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(p.name),
                      subtitle: Text("${levelNick(p.skill)}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            players.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            /// TIMES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Times"),
                DropdownButton<int>(
                  value: _numTeams,
                  items: [2, 3, 4, 5]
                      .map((e) => DropdownMenuItem(value: e, child: Text("$e")))
                      .toList(),
                  onChanged: (v) {
                    setState(() {
                      _numTeams = v!;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 16),

            /// Botões Principais
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: ElevatedButton(
                      onPressed: (players.length >= _numTeams && !_groupSaved)
                          ? () {
                              _showSaveGroupDialog(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 6,
                      ),
                      child: Text(
                        "Salvar Grupo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: players.length >= _numTeams
                              ? Colors.white
                              : Colors.black26,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 20),

                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: ElevatedButton(
                      onPressed: players.length >= _numTeams
                          ? _createTeams
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 6,
                      ),
                      child: Text(
                        "CRIAR TIMES",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: players.length >= _numTeams
                              ? Colors.white
                              : Colors.black26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget estilo popup para colocar o nome do grupo
  void _showSaveGroupDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text("Nome do Grupo"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Digite o nome do grupo"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o popup
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                String groupName = _controller.text.trim();
                if (groupName.isNotEmpty) {
                  await _saveGroup(groupName);
                  setState(() {
                    _groupSaved = true; // Desabilita o botão após salvar
                  });
                  Navigator.of(context).pop(); // Fecha o popup
                }
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }
}
