import '../../../players/data/models/player_model.dart';
import '../../../teams/data/models/team_model.dart';
import '../../domain/entities/lineup_entity.dart';
import 'match_model.dart';

class LineupModel extends LineupEntity {
  LineupModel({
    super.id,
    super.matchId,
    super.teamId,
    super.playerId,
    super.position,
    super.isCaptain,
    super.isStarting,
    super.createdAt,
    super.match,
    super.player,
    super.team,
  });

  factory LineupModel.fromMap(Map<String, dynamic> map) {
    return LineupModel(
      id: map['id'],
      matchId: map['match_id'],
      teamId: map['team_id'],
      playerId: map['player_id'],
      position: map['position'],
      isCaptain: map['is_captain'],
      isStarting: map['is_starting'],
      createdAt: DateTime.parse(map['created_at']),
      match: (map['match'] == null) ? null : MatchModel.fromMap(map['match']),
      player:
          (map['player'] == null) ? null : PlayerModel.fromMap(map['player']),
      team: (map['team'] == null) ? null : TeamModel.fromMap(map['team']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'match_id': matchId,
      'team_id': teamId,
      'player_id': playerId,
      'position': position,
      'is_captain': isCaptain,
      'is_starting': isStarting,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
