import '../../../players/data/models/player_model.dart';
import '../../../teams/data/models/team_model.dart';
import '../../domain/entities/match_player_entity.dart';
import 'match_model.dart';

class MatchPlayerModel extends MatchPlayerEntity {
  MatchPlayerModel({
    super.id,
    super.matchId,
    super.playerId,
    super.teamId,
    super.goals,
    super.assists,
    super.minutesPlayed,
    super.yellowCards,
    super.redCards,
    super.isStarting,
    super.createdAt,
    super.match,
    super.player,
    super.team,
  });

  factory MatchPlayerModel.fromMap(Map<String, dynamic> map) {
    return MatchPlayerModel(
      id: map['id'],
      matchId: map['match_id'],
      playerId: map['player_id'],
      teamId: map['team_id'],
      goals: map['goals'],
      assists: map['assists'],
      minutesPlayed: map['minutes_played'],
      yellowCards: map['yellow_cards'],
      redCards: map['red_cards'],
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
      'player_id': playerId,
      'team_id': teamId,
      'goals': goals,
      'assists': assists,
      'minutes_played': minutesPlayed,
      'yellow_cards': yellowCards,
      'red_cards': redCards,
      'is_starting': isStarting,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
