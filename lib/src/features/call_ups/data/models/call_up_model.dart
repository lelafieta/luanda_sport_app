import '../../../coaches/data/models/coach_model.dart';
import '../../../competitions/data/models/compeition_model.dart';
import '../../../matches/data/models/match_model.dart';
import '../../../players/data/models/player_model.dart';
import '../../domain/entities/call_up_entity.dart';

class CallUpModel extends CallUpEntity {
  const CallUpModel({
    super.id,
    super.matchId,
    super.competitionId,
    required super.playerId,
    required super.status,
    super.sentAt,
    super.respondedAt,
    super.notes,
    super.isCancelled,
    super.visibleUntil,
    super.coachId,
    super.coach,
    super.competition,
    super.player,
    super.match,
  });

  factory CallUpModel.fromMap(Map<String, dynamic> map) {
    return CallUpModel(
      id: map['id'] as String?,
      matchId: map['match_id'] as String?,
      competitionId: map['competition_id'] as String?,
      playerId: map['player_id'] as String,
      status: map['status'] as String,
      sentAt: map['sent_at'] != null ? DateTime.tryParse(map['sent_at']) : null,
      respondedAt: map['responded_at'] != null
          ? DateTime.tryParse(map['responded_at'])
          : null,
      notes: map['notes'] as String?,
      isCancelled: map['is_cancelled'] as bool? ?? false,
      visibleUntil: map['visible_until'] != null
          ? DateTime.tryParse(map['visible_until'])
          : null,
      coachId: map['coach_id'] as String?,
      coach: map['coaches'] != null ? CoachModel.fromMap(map['coaches']) : null,
      player:
          map['players'] != null ? PlayerModel.fromMap(map['players']) : null,
      competition: map['competitions'] != null
          ? CompetitionModel.fromMap(map['competitions'])
          : null,
      match: map['match'] != null ? MatchModel.fromMap(map['match']) : null,
    );
  }

  factory CallUpModel.fromEntity(CallUpEntity entity) {
    return CallUpModel(
      id: entity.id,
      matchId: entity.matchId,
      competitionId: entity.competitionId,
      playerId: entity.playerId,
      status: entity.status,
      sentAt: entity.sentAt,
      respondedAt: entity.respondedAt,
      notes: entity.notes,
      isCancelled: entity.isCancelled,
      visibleUntil: entity.visibleUntil,
      coachId: entity.coachId,
    );
  }

  CallUpModel copyWith({
    String? id,
    String? matchId,
    String? competitionId,
    String? playerId,
    String? status,
    DateTime? sentAt,
    DateTime? respondedAt,
    String? notes,
    bool? isCancelled,
    DateTime? visibleUntil,
    String? coachId,
  }) {
    return CallUpModel(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      competitionId: competitionId ?? this.competitionId,
      playerId: playerId ?? this.playerId,
      status: status ?? this.status,
      sentAt: sentAt ?? this.sentAt,
      respondedAt: respondedAt ?? this.respondedAt,
      notes: notes ?? this.notes,
      isCancelled: isCancelled ?? this.isCancelled,
      visibleUntil: visibleUntil ?? this.visibleUntil,
      coachId: coachId ?? this.coachId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'match_id': matchId,
      'competition_id': competitionId,
      'player_id': playerId,
      'status': status,
      'sent_at': sentAt?.toIso8601String(),
      'responded_at': respondedAt?.toIso8601String(),
      'notes': notes,
      'is_cancelled': isCancelled,
      'visible_until': visibleUntil?.toIso8601String(),
      'coach_id': coachId,
    };
  }
}
