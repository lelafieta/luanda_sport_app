import 'package:luanda_sport_app/src/features/players/domain/entities/player_entity.dart';
import 'package:luanda_sport_app/src/features/teams/domain/entities/team_entity.dart';
import '../../../teams/data/models/team_model.dart';
import '../../domain/entities/player_stats_entity.dart';
import 'player_model.dart';

class PlayerStatsModel extends PlayerStatsEntity {
  PlayerStatsModel({
    super.id,
    super.playerId,
    super.teamId,
    super.match,
    super.minutesPlayed,
    super.goals,
    super.assists,
    super.yellowCards,
    super.redCards,
    super.passesCompleted,
    super.shotsOnTarget,
    super.draw,
    super.lose,
    super.win,
    super.player,
    super.team,
    super.createdAt,
  });

  factory PlayerStatsModel.fromMap(Map<String, dynamic> map) {
    return PlayerStatsModel(
      id: map['id'],
      playerId: map['player_id'],
      teamId: map['team_id'],
      match: map['match'],
      minutesPlayed: map['minutes_played'],
      goals: map['goals'],
      assists: map['assists'],
      yellowCards: map['yellow_cards'],
      redCards: map['red_cards'],
      passesCompleted: map['passes_completed'],
      shotsOnTarget: map['shots_on_target'],
      draw: map['draw'],
      lose: map['lose'],
      win: map['win'],
      player: map['player'] != null
          ? PlayerModel.fromMap(map['players'] as Map<String, dynamic>)
          : null,
      team: map['team'] != null
          ? TeamModel.fromMap(map['teams'] as Map<String, dynamic>)
          : null,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'player_id': playerId,
      'team_id': teamId,
      'match': match,
      'minutes_played': minutesPlayed,
      'goals': goals,
      'assists': assists,
      'yellow_cards': yellowCards,
      'red_cards': redCards,
      'passes_completed': passesCompleted,
      'shots_on_target': shotsOnTarget,
      'draw': draw,
      'lose': lose,
      'win': win,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  /// 🔁 Converte de Entity para Model
  factory PlayerStatsModel.fromEntity(PlayerStatsEntity entity) {
    return PlayerStatsModel(
      id: entity.id,
      playerId: entity.playerId,
      teamId: entity.teamId,
      match: entity.match,
      minutesPlayed: entity.minutesPlayed,
      goals: entity.goals,
      assists: entity.assists,
      yellowCards: entity.yellowCards,
      redCards: entity.redCards,
      passesCompleted: entity.passesCompleted,
      shotsOnTarget: entity.shotsOnTarget,
      draw: entity.draw,
      lose: entity.lose,
      win: entity.win,
      createdAt: entity.createdAt,
    );
  }

  /// 🔁 Converte de Model para Entity
  PlayerStatsEntity toEntity({
    TeamEntity? team,
    PlayerEntity? player,
  }) {
    return PlayerStatsEntity(
      id: id,
      playerId: playerId,
      teamId: teamId,
      match: match,
      minutesPlayed: minutesPlayed,
      goals: goals,
      assists: assists,
      yellowCards: yellowCards,
      redCards: redCards,
      passesCompleted: passesCompleted,
      shotsOnTarget: shotsOnTarget,
      draw: draw,
      lose: lose,
      win: win,
      createdAt: createdAt,
      team: team,
      player: player,
    );
  }
}
