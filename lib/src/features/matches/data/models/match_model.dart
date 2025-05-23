import '../../../competitions/data/models/compeition_model.dart';
import '../../../teams/data/models/team_model.dart';
import '../../domain/entities/match_entity.dart';

class MatchModel extends MatchEntity {
  const MatchModel({
    super.id,
    super.competitionId,
    super.homeTeamId,
    super.awayTeamId,
    super.matchDate,
    super.venue,
    super.refereeId,
    super.homeScore,
    super.awayScore,
    super.status,
    super.createdAt,
    super.isExhibition,
    super.matchType,
    super.stadium,
    super.homeTeam,
    super.awayTeam,
    super.competition,
  });

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      id: map['id'] as String,
      competitionId: map['competition_id'],
      homeTeamId: map['home_team_id'],
      awayTeamId: map['away_team_id'],
      matchDate:
          map['match_date'] != null ? DateTime.parse(map['match_date']) : null,
      venue: map['venue'],
      refereeId: map['referee_id'],
      homeScore: map['home_score'],
      awayScore: map['away_score'],
      status: map['status'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      isExhibition: map['is_exhibition'],
      matchType: map['match_type'],
      stadium: map['stadium'],
      homeTeam: map['home_team'] != null
          ? TeamModel.fromJson(map['home_team'])
          : null,
      awayTeam: map['away_team'] != null
          ? TeamModel.fromJson(map['away_team'])
          : null,
      competition: map['competition'] != null
          ? CompetitionModel.fromMap(map['competition'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'competition_id': competitionId,
      'home_team_id': homeTeamId,
      'away_team_id': awayTeamId,
      'match_date': matchDate?.toIso8601String(),
      'venue': venue,
      'referee_id': refereeId,
      'home_score': homeScore,
      'away_score': awayScore,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'is_exhibition': isExhibition,
      'match_type': matchType,
      'stadium': stadium,
    };
  }
}
