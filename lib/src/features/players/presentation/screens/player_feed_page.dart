import 'package:flutter/material.dart';
import 'package:luanda_sport_app/src/core/utils/title_widget.dart';

class PlayerFeedPage extends StatefulWidget {
  const PlayerFeedPage({super.key});

  @override
  State<PlayerFeedPage> createState() => _PlayerFeedPageState();
}

class _PlayerFeedPageState extends State<PlayerFeedPage> {
  // Simulações para exemplo
  final bool convocado = true;
  final bool noOnzeInicial = true;
  final bool isTreino = false; // Se for treino, muda o texto e estilo

  // Detalhes do jogo ou treino
  final String adversario = "Petro de Luanda";
  final String dataEvento = "Dom, 26 de Maio - 15h30";
  final String estadio = "Estádio 11 de Novembro";
  final String posicao = "Meio-Campo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: "Meu Estatus na equipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: convocado ? Colors.green[100] : Colors.red[100],
              child: ListTile(
                leading: Icon(
                  convocado ? Icons.check_circle : Icons.cancel,
                  color: convocado ? Colors.green : Colors.red,
                ),
                title: Text(
                  convocado
                      ? "Você foi convocado para a equipe!"
                      : "Você não foi convocado.",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (convocado) ...[
              const SizedBox(height: 16),
              Card(
                color: isTreino ? Colors.yellow[100] : Colors.orange[100],
                child: ListTile(
                  leading: Icon(
                    isTreino ? Icons.fitness_center : Icons.sports_soccer,
                    color: isTreino ? Colors.amber : Colors.orange,
                  ),
                  title: Text(
                    isTreino
                        ? "Treino programado"
                        : "Próximo Jogo: contra $adversario",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Data: $dataEvento"),
                      Text("Local: $estadio"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                color: Colors.teal[100],
                child: ListTile(
                  leading: const Icon(Icons.person_pin, color: Colors.teal),
                  title: const Text(
                    "Sua Posição",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(posicao),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Card(
              color: noOnzeInicial ? Colors.blue[100] : Colors.grey[300],
              child: ListTile(
                leading: Icon(
                  noOnzeInicial ? Icons.star : Icons.star_border,
                  color: noOnzeInicial ? Colors.blue : Colors.grey,
                ),
                title: Text(
                  noOnzeInicial
                      ? "Você está no 11 inicial!"
                      : "Você não está no 11 inicial.",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
