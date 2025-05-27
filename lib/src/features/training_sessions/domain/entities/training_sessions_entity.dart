import '../../../coaches/domain/entities/coach_entity.dart';
import '../../../teams/domain/entities/team_entity.dart';

class TrainingSessionEntity {
  final String? id;
  final String? coachId;
  final String? teamId;
  final DateTime? sessionDate;
  final String? focus;
  final String? notes;
  final CoachEntity? coach;
  final TeamEntity? team;

  TrainingSessionEntity({
    this.id,
    this.coachId,
    this.teamId,
    this.sessionDate,
    this.focus,
    this.notes,
    this.coach,
    this.team,
  });
}
