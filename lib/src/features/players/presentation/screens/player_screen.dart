import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de abas
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Player Clube'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Notícias', icon: Icon(Icons.article)),
              Tab(text: 'Jogos', icon: Icon(Icons.sports_soccer)),
              Tab(text: 'Perfil', icon: Icon(Icons.person)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Conteúdo de Notícias')),
            Center(child: Text('Conteúdo de Jogos')),
            Center(child: Text('Conteúdo do Perfil')),
          ],
        ),
      ),
    );
  }
}
