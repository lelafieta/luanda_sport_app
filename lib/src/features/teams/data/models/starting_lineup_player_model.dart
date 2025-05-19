import '../../../players/data/models/player_model.dart';
import '../../domain/entities/starting_lineup_player_entity.dart';

class StartingLineupPlayersModel extends StartingLineupPlayersEntity {
  StartingLineupPlayersModel(
      {required super.id,
      required super.teamId,
      required super.playerId,
      required super.createdAt,
      required super.positionIndex,
      super.player});

  factory StartingLineupPlayersModel.fromMap(Map<String, dynamic> map) {
    return StartingLineupPlayersModel(
      id: map['id'] as String,
      teamId: map['team_id'] as String,
      playerId: map['player_id'] as String,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      positionIndex: (map['position_index'] as num?)?.toInt() ?? 0,
      player:
          map['players'] != null ? PlayerModel.fromMap(map['players']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'team_id': teamId,
      'player_id': playerId,
      'created_at': createdAt?.toIso8601String(),
      'position_index': positionIndex,
    };
  }

  factory StartingLineupPlayersModel.fromEntity(
      StartingLineupPlayersEntity entity) {
    return StartingLineupPlayersModel(
      id: entity.id,
      teamId: entity.teamId,
      playerId: entity.playerId,
      createdAt: entity.createdAt,
      positionIndex: entity.positionIndex,
      player: entity.player,
    );
  }
}
