import '../../domain/entities/player_team_entity.dart';

class PlayerTeamModel extends PlayerTeamEntity {
  PlayerTeamModel({
    super.id,
    super.playerId,
    super.player,
    super.teamId,
    super.position,
    super.team,
    super.shirtNumber,
    super.value,
    super.joinedAt,
    super.leftAt,
    super.isActive,
    super.createdAt,
  });
}
