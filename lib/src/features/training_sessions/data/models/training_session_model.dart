import '../../../coaches/data/models/coach_model.dart';
import '../../../teams/data/models/team_model.dart';
import '../../domain/entities/training_sessions_entity.dart';

class TrainingSessionModel extends TrainingSessionEntity {
  TrainingSessionModel(
      {super.id,
      super.coachId,
      super.teamId,
      super.sessionDate,
      super.focus,
      super.notes,
      super.coach,
      super.team});

  factory TrainingSessionModel.fromJson(Map<String, dynamic> json) {
    return TrainingSessionModel(
      id: json['id'] as String,
      coachId: json['coach_id'] as String?,
      teamId: json['team_id'] as String?,
      sessionDate: json['session_date'] != null
          ? DateTime.parse(json['session_date'])
          : null,
      focus: json['focus'] as String?,
      notes: json['notes'] as String?,
      coach: json['coach'] != null ? CoachModel.fromMap(json['coach']) : null,
      team: json['team'] != null ? TeamModel.fromMap(json['team']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coach_id': coachId,
      'team_id': teamId,
      'session_date': sessionDate?.toIso8601String(),
      'focus': focus,
      'notes': notes,
    };
  }
}
