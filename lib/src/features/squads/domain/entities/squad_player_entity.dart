import '../../../players/domain/entities/player_entity.dart';

class SquadPlayerEntity {
  final String? id;
  final String? squadId;
  final String? playerId;
  final String? tacticalPosition;
  final int? jerseyNumber;
  final bool? isStarter;
  final PlayerEntity? player;

  SquadPlayerEntity(
      {required this.id,
      required this.squadId,
      required this.playerId,
      required this.tacticalPosition,
      required this.jerseyNumber,
      required this.isStarter,
      required this.player});
}
