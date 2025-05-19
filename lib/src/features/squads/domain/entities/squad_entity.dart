import 'squad_player_entity.dart';

class SquadEntity {
  final String? id;
  final String? teamId;
  final String? size; // ex: '11x11'
  final String? formation; // ex: '4-4-2'
  final List<SquadPlayerEntity>? players;

  SquadEntity({
    this.id,
    this.teamId,
    this.size,
    this.formation,
    this.players,
  });
}
