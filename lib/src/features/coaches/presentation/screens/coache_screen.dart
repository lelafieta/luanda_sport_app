import 'package:flutter/material.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de abas
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Treinador Clube'),
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
