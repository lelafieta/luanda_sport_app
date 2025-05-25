import '../../../players/data/models/player_model.dart';
import '../../../teams/data/models/team_model.dart';
import '../../data/models/match_model.dart';

class MatchPlayerEntity {
  final String? id;
  final String? matchId;
  final String? playerId;
  final String? teamId;
  final int? goals;
  final int? assists;
  final int? minutesPlayed;
  final int? yellowCards;
  final int? redCards;
  final bool? isStarting;
  final DateTime? createdAt;
  final MatchModel? match;
  final PlayerModel? player;
  final TeamModel? team;

  MatchPlayerEntity(
      {this.id,
      this.matchId,
      this.playerId,
      this.teamId,
      this.goals,
      this.assists,
      this.minutesPlayed,
      this.yellowCards,
      this.redCards,
      this.isStarting,
      this.createdAt,
      this.match,
      this.player,
      this.team});
}
