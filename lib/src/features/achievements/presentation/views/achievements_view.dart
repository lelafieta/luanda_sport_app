import 'package:flutter/material.dart';

class Achievement {
  final String title;
  final String description;
  final IconData icon;
  final bool unlocked;

  Achievement({
    required this.title,
    required this.description,
    required this.icon,
    required this.unlocked,
  });
}

class AchievementsView extends StatelessWidget {
  AchievementsView({super.key});
  final List<Achievement> achievements = [
    Achievement(
      title: 'Primeira Vitória',
      description: 'Ganhou sua primeira partida.',
      icon: Icons.emoji_events,
      unlocked: true,
    ),
    Achievement(
      title: 'Participante Ativo',
      description: 'Participou de 10 eventos.',
      icon: Icons.group,
      unlocked: false,
    ),
    Achievement(
      title: 'Campeão',
      description: 'Venceu um torneio.',
      icon: Icons.verified,
      unlocked: true,
    ),
    // Adicione mais conquistas aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Conquistas')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: achievements.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // duas por linha
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final ach = achievements[index];
            return Card(
              color:
                  ach.unlocked ? Colors.green.shade100 : Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(ach.icon,
                        size: 40,
                        color: ach.unlocked ? Colors.green : Colors.grey),
                    const SizedBox(height: 10),
                    Text(
                      ach.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            ach.unlocked ? Colors.black : Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      ach.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: ach.unlocked
                            ? Colors.black87
                            : Colors.grey.shade600,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
