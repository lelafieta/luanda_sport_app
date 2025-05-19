import 'package:luanda_sport_app/src/features/teams/domain/entities/tactical_formation_entity.dart';

class TacticalFormationModel extends TacticalFormationEntity {
  TacticalFormationModel({
    super.id,
    super.teamId,
    super.gameType,
    super.players,
    super.createdAt,
    super.updatedAt,
  });

  factory TacticalFormationModel.fromJson(Map<String, dynamic> json) {
    return TacticalFormationModel(
      id: json['id'] as String?,
      teamId: json['team_id'] as String?,
      gameType: json['game_type'] as String?,
      players: (json['players'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          List<String>.from(value as List),
        ),
      ),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team_id': teamId,
      'game_type': gameType,
      'players': players,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
