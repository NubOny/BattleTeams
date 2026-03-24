import 'package:bteams/core/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:bteams/core/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class SettingsPages extends StatelessWidget {
  const SettingsPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          "Configurações",
          style: TextStyle(fontFamily: 'SquareBold', fontSize: 20),
        ),
        backgroundColor: AppTheme.background,
        centerTitle: true,
        titleSpacing: 0,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              "© 2026 Joao (NubOny) Diogenes",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontFamily: 'SquareBold',
              ),
            ),
          ),
          AppBottomNavigation(currentIndex: 4),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Material(
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 10,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Ajude o Desenvolvedor",
                            style: TextStyle(
                              fontFamily: 'SquareBold',
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      /// Chave Pix
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(
                              text: '1496d3da-bbb1-4b51-86c7-1341e302dc9b',
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Chave Pix Copiada",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SquareBold',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        },
                        child: const ListTile(
                          title: Text(
                            "Chave Pix",
                            style: TextStyle(
                              fontFamily: 'SquareBold',
                              fontSize: 13,
                            ),
                          ),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),

                      const Divider(height: 1),

                      /// QR Code
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "QR Code",
                                  style: TextStyle(fontFamily: 'SquareBold'),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/qrcode.png',
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.contain,

                                      // 🔽 Fallback aqui
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Column(
                                              children: const [
                                                Icon(
                                                  Icons.qr_code_2,
                                                  size: 80,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "QR Code indisponível",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("Fechar"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const ListTile(
                          title: Text(
                            "QR Code",
                            style: TextStyle(
                              fontFamily: 'SquareBold',
                              fontSize: 13,
                            ),
                          ),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            CaixaOpcoes(
              titulo: "Dados do aplicativo",
              itens: [
                {"Apagar Dados de Sessoes": () {}},
                {"Apagar Dados de Grupos": () {}},
                {"Apagar todos os Dados": () {}},
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CaixaOpcoes extends StatelessWidget {
  final String titulo;
  final List<Map<String, VoidCallback>> itens;

  const CaixaOpcoes({super.key, required this.titulo, required this.itens});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 4),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'SquareBold',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              ...itens.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return Column(
                  children: [
                    InkWell(
                      onTap: item.values.first,
                      child: ListTile(
                        title: Text(
                          item.keys.first,
                          style: TextStyle(
                            fontFamily: 'SquareBold',
                            fontSize: 13,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                    if (index != itens.length - 1) const Divider(height: 1),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
