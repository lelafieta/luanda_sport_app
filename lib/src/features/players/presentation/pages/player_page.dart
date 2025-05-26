import 'package:flutter/material.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carlos João'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Resumo'),
              Tab(text: 'Estatísticas'),
              Tab(text: 'Partidas'),
              Tab(text: 'Conquistas'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PlayerSummaryTab(),
            PlayerStatsTab(),
            PlayerMatchesTab(),
            PlayerAchievementsTab(),
          ],
        ),
      ),
    );
  }
}

class PlayerSummaryTab extends StatelessWidget {
  const PlayerSummaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/player.jpg'),
        ),
        SizedBox(height: 12),
        Center(
            child: Text('Carlos João',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
        Center(child: Text('Atacante • Camisa 9')),
        Center(child: Text('Time: Vitória FC')),
        Center(child: Text('Nacionalidade: Angola')),
        Center(child: Text('Nascimento: 10/02/2001')),
      ],
    );
  }
}

class PlayerStatsTab extends StatelessWidget {
  const PlayerStatsTab({super.key});

  Widget _stat(String title, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(title),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Estatísticas da Carreira',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _stat('Partidas', '85'),
            _stat('Gols', '34'),
            _stat('Assistências', '15'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _stat('Amarelos', '6'),
            _stat('Vermelhos', '1'),
            _stat('Minutos', '5400'),
          ],
        ),
      ],
    );
  }
}

class PlayerMatchesTab extends StatelessWidget {
  const PlayerMatchesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        MatchTile(
            team: 'Vitória FC',
            opponent: 'Petro Luanda',
            result: '2-1',
            goals: 1),
        MatchTile(
            team: 'Vitória FC',
            opponent: '1º de Agosto',
            result: '1-1',
            goals: 0),
        MatchTile(
            team: 'Vitória FC',
            opponent: 'Bravos Maquis',
            result: '3-0',
            goals: 2),
      ],
    );
  }
}

class MatchTile extends StatelessWidget {
  final String team;
  final String opponent;
  final String result;
  final int goals;

  const MatchTile({
    super.key,
    required this.team,
    required this.opponent,
    required this.result,
    required this.goals,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.sports_soccer),
      title: Text('$team vs $opponent'),
      subtitle: Text('Resultado: $result'),
      trailing: Text('Gols: $goals'),
    );
  }
}

class PlayerAchievementsTab extends StatelessWidget {
  const PlayerAchievementsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('🏆 Artilheiro do Girabola 2023'),
        SizedBox(height: 8),
        Text('🥇 Melhor Jogador Sub-21 de Angola'),
        SizedBox(height: 8),
        Text('⚽ Golo Mais Bonito da Temporada 2022'),
      ],
    );
  }
}
