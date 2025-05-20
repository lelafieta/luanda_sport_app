import 'package:flutter/material.dart';

class FanScreen extends StatefulWidget {
  const FanScreen({super.key});

  @override
  State<FanScreen> createState() => _FanScreenState();
}

class _FanScreenState extends State<FanScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de abas
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fã Clube'),
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
