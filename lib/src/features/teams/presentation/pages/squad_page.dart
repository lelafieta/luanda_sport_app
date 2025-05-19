import 'package:flutter/material.dart';

class SquadPage extends StatefulWidget {
  const SquadPage({super.key});

  @override
  State<SquadPage> createState() => _SquadPageState();
}

class _SquadPageState extends State<SquadPage> {
  late List<Formation> allFormations;
  late List<GameType> gameTypes;

  GameType? selectedGameType;
  Formation? selectedFormation;

  @override
  void initState() {
    super.initState();
    allFormations = _getAllFormations();
    gameTypes = _generateGameTypesFromFormations();
    selectedGameType = gameTypes.first;
    selectedFormation = _getCompatibleFormations(selectedGameType!).first;
  }

  @override
  Widget build(BuildContext context) {
    final filteredFormations = _getCompatibleFormations(selectedGameType!);

    return Scaffold(
      appBar: AppBar(title: const Text("Selecionar Formação")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Dropdown GameType
            DropdownButton<GameType>(
              isExpanded: true,
              hint: const Text("Selecionar Tipo de Jogo"),
              value: selectedGameType,
              items: gameTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.label),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  selectedGameType = value;

                  final compat = _getCompatibleFormations(value);
                  selectedFormation = compat.isNotEmpty ? compat.first : null;
                });
              },
            ),

            const SizedBox(height: 12),

            /// Dropdown Formation
            DropdownButton<Formation>(
              isExpanded: true,
              hint: const Text("Selecionar Formação"),
              value: selectedFormation,
              items: filteredFormations.map((formation) {
                return DropdownMenuItem(
                  value: formation,
                  child: Text(formation.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFormation = value;
                });
              },
            ),

            const SizedBox(height: 20),

            if (selectedFormation != null)
              Expanded(child: _buildFormation(selectedFormation!)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormation(Formation formation) {
    return Column(
      children: formation.lines.map((playersInLine) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(playersInLine, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text('${index + 1}')),
              );
            }),
          ),
        );
      }).toList(),
    );
  }

  /// Todas as formações possíveis
  List<Formation> _getAllFormations() {
    return [
      Formation(name: '1-1', lines: [1, 1]), // 2
      Formation(name: '2-2', lines: [2, 2]), // 4
      Formation(name: '1-2-1', lines: [1, 2, 1]), // 4
      Formation(name: '2-3-1', lines: [2, 3, 1]), // 6
      Formation(name: '3-2-1', lines: [3, 2, 1]), // 6
      Formation(name: '3-3', lines: [3, 3]), // 6
      Formation(name: '3-2-2', lines: [3, 2, 2]), // 7
      Formation(name: '3-3-1', lines: [3, 3, 1]), // 7
      Formation(name: '4-2-1', lines: [4, 2, 1]), // 7
      Formation(name: '4-4-2', lines: [4, 4, 2]), // 10
      Formation(name: '4-3-3', lines: [4, 3, 3]), // 10
      Formation(name: '3-5-2', lines: [3, 5, 2]), // 10
      Formation(name: '4-5-1', lines: [4, 5, 1]), // 10
      Formation(name: '4-3-1-2', lines: [4, 3, 1, 2]), // 10
      Formation(name: '5-4-1', lines: [5, 4, 1]), // 10
      Formation(name: '4-3-2-1', lines: [4, 3, 2, 1]), // 10
      Formation(name: '5-3-2', lines: [5, 3, 2]), // 10
      Formation(name: '3-4-3', lines: [3, 4, 3]), // 10
      Formation(name: '5-4-2', lines: [5, 4, 2]), // 11
    ];
  }

  /// Gera os tipos de jogo automaticamente com base nas formações disponíveis
  List<GameType> _generateGameTypesFromFormations() {
    final uniqueTotals =
        allFormations.map((f) => f.totalPlayers).toSet().toList()..sort();

    return uniqueTotals.map((total) {
      final side = (total / 2).round();
      return GameType(label: '${side}x$side', totalPlayers: total);
    }).toList();
  }

  /// Retorna formações compatíveis com o tipo de jogo
  List<Formation> _getCompatibleFormations(GameType gameType) {
    return allFormations
        .where((f) => f.totalPlayers == gameType.totalPlayers)
        .toList();
  }
}

/// Modelos
class GameType {
  final String label;
  final int totalPlayers;

  GameType({
    required this.label,
    required this.totalPlayers,
  });

  @override
  String toString() => label;
}

class Formation {
  final String name;
  final List<int> lines;

  Formation({
    required this.name,
    required this.lines,
  });

  int get totalPlayers => lines.fold(0, (a, b) => a + b);

  @override
  String toString() => name;
}
