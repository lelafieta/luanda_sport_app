import 'package:luanda_sport_app/src/features/players/domain/entities/player_entity.dart';
import 'package:luanda_sport_app/src/features/teams/domain/entities/team_entity.dart';

class PlayerStatsEntity {
  final String? id;
  final String? playerId;
  final String? teamId;
  final int? match;
  final int? minutesPlayed;
  final int? goals;
  final int? assists;
  final int? yellowCards;
  final int? redCards;
  final int? passesCompleted;
  final int? shotsOnTarget;
  final int? draw;
  final int? lose;
  final int? win;
  final DateTime? createdAt;
  final TeamEntity? team;
  final PlayerEntity? player;

  const PlayerStatsEntity(
      {required this.id,
      this.playerId,
      this.teamId,
      this.match,
      this.minutesPlayed,
      this.goals,
      this.assists,
      this.yellowCards,
      this.redCards,
      this.passesCompleted,
      this.shotsOnTarget,
      this.draw,
      this.lose,
      this.win,
      this.createdAt,
      this.team,
      this.player});
}
