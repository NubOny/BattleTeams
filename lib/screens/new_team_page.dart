import 'package:flutter/material.dart';

class NewTeamPage extends StatefulWidget {
  const NewTeamPage({super.key});

  @override
  State<NewTeamPage> createState() => _NewTeamPageState();
}

class _NewTeamPageState extends State<NewTeamPage> {
  final TextEditingController _nameController = TextEditingController();

  int _selectedSkill = 1;
  int _numTeams = 2;

  List<Player> players = [];
  List<Player> savedPlayers = [];

  void _addPlayer({bool save = false}) {
    if (_nameController.text.isEmpty) return;

    final player = Player(name: _nameController.text, skill: _selectedSkill);

    setState(() {
      players.add(player);
      if (save) {
        savedPlayers.add(player);
      }

      _nameController.clear();
      _selectedSkill = 1;
    });
  }

  void _createTeams() {
    // TODO: Implementar lógica (aleatória / equilibrada)
    print("Criar times com ${players.length} jogadores");
  }

  void _saveGroup() {
    // TODO: Implementar persistência
    print("Grupo salvo!");
  }

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
                              "Nível $level",
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
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text("Salvar + adicionar"),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _addPlayer(save: false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text("Só adicionar"),
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
                      subtitle: Text("Nível ${p.skill}"),
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

            /// BOTÃO PRINCIPAL (QUADRADO E DESTACADO)
            SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                onPressed: players.length >= _numTeams ? _createTeams : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 6,
                ),
                child: Text(
                  "CRIAR TIMES",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Player {
  final String name;
  final int skill;

  Player({required this.name, required this.skill});
}
