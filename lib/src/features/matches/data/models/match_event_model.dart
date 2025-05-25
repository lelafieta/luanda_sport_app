import '../../../players/data/models/player_model.dart';
import '../../../teams/data/models/team_model.dart';
import '../../domain/entities/match_event_entity.dart';
import 'match_model.dart';

class MatchEventModel extends MatchEventEntity {
  MatchEventModel({
    super.id,
    super.matchId,
    super.playerId,
    super.teamId,
    super.eventType,
    super.minute,
    super.period,
    super.description,
    super.substitutionFor,
    super.createdAt,
    super.match,
    super.player,
    super.team,
  });

  factory MatchEventModel.fromMap(Map<String, dynamic> map) {
    return MatchEventModel(
      id: map['id'],
      matchId: map['match_id'],
      playerId: map['player_id'],
      teamId: map['team_id'],
      eventType: map['event_type'],
      minute: map['minute'],
      period: map['period'],
      description: map['description'],
      substitutionFor: map['substitution_for'],
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
      'player_id': playerId,
      'team_id': teamId,
      'event_type': eventType,
      'minute': minute,
      'period': period,
      'description': description,
      'substitution_for': substitutionFor,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
