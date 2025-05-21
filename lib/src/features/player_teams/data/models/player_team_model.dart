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

  factory PlayerTeamModel.fromJson(Map<String, dynamic> json) {
    return PlayerTeamModel(
      id: json['id'] as String?,
      playerId: json['playerId'] as String?,
      teamId: json['teamId'] as String?,
      value: json['value'] as int?,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      leftAt: DateTime.parse(json['leftAt'] as String),
      position: json['position'] as String?,
      shirtNumber: json['shirtNumber'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
