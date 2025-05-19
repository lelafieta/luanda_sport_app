import 'package:luanda_sport_app/src/features/players/domain/entities/player_entity.dart';

class StartingLineupPlayersEntity {
  final String id;
  final String teamId;
  final String playerId;
  final DateTime? createdAt;
  final int positionIndex;
  PlayerEntity? player;
  StartingLineupPlayersEntity(
      {required this.id,
      required this.teamId,
      required this.playerId,
      this.createdAt,
      required this.positionIndex,
      this.player});
}
