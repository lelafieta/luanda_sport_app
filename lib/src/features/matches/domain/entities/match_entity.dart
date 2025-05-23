import '../../../competitions/domain/entities/competition_entity.dart';
import '../../../teams/domain/entities/team_entity.dart';

class MatchEntity {
  final String? id;
  final String? competitionId;
  final String? homeTeamId;
  final String? awayTeamId;
  final DateTime? matchDate;
  final String? venue;
  final String? refereeId;
  final int? homeScore;
  final int? awayScore;
  final String? status;
  final DateTime? createdAt;
  final bool? isExhibition;
  final String? matchType;
  final String? stadium;
  final TeamEntity? homeTeam;
  final TeamEntity? awayTeam;
  final CompetitionEntity? competition;

  const MatchEntity(
      {this.id,
      this.competitionId,
      this.homeTeamId,
      this.awayTeamId,
      this.matchDate,
      this.venue,
      this.refereeId,
      this.homeScore,
      this.awayScore,
      this.status,
      this.createdAt,
      this.isExhibition,
      this.matchType,
      this.stadium,
      this.homeTeam,
      this.awayTeam,
      this.competition});
}
