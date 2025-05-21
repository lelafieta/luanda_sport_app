import '../../../players/domain/entities/player_entity.dart';
import '../../../teams/domain/entities/team_entity.dart';

class PlayerTeamEntity {
  final String? id;
  final String? playerId;
  final String? teamId;
  final int? value;
  final DateTime? joinedAt;
  final DateTime? leftAt;
  final String? position;
  final int? shirtNumber;
  final bool? isActive;
  final DateTime? createdAt;
  final PlayerEntity? player;
  final TeamEntity? team;

  const PlayerTeamEntity({
    this.id,
    this.playerId,
    this.teamId,
    this.value,
    this.isActive,
    this.joinedAt,
    this.leftAt,
    this.position,
    this.shirtNumber,
    this.player,
    this.team,
    this.createdAt,
  });
}
