import '../../../players/data/models/player_model.dart';
import '../../../teams/data/models/team_model.dart';
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

  factory PlayerTeamModel.fromMap(Map<String, dynamic> json) {
    return PlayerTeamModel(
      id: json['id']?.toString() ?? '',
      playerId: json['player_id']?.toString() ?? '',
      teamId: json['team_id']?.toString() ?? '',
      value: json['value'] is int
          ? json['value'] as int
          : int.tryParse(json['value']?.toString() ?? '0'),
      joinedAt: json['joined_at'] != null
          ? DateTime.tryParse(json['joined_at']) ?? DateTime(2000)
          : DateTime(2000),
      leftAt:
          json['left_at'] != null ? DateTime.tryParse(json['left_at']) : null,
      position: json['position']?.toString(),
      shirtNumber: json['shirt_number'] is int
          ? json['shirt_number'] as int
          : int.tryParse(json['shirt_number']?.toString() ?? ''),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']) ?? DateTime.now()
          : DateTime.now(),
      isActive: json['is_active'] is bool
          ? json['is_active'] as bool
          : json['is_active'] == true,
      player: json['players'] != null && json['players'] is Map<String, dynamic>
          ? PlayerModel.fromMap(json['players'])
          : null,
      team: json['teams'] != null && json['teams'] is Map<String, dynamic>
          ? TeamModel.fromJson(json['teams'])
          : null,
    );
  }
}
