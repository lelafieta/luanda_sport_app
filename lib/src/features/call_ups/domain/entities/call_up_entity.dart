import '../../../coaches/domain/entities/coach_entity.dart';
import '../../../competitions/domain/entities/competition_entity.dart';
import '../../../matches/domain/entities/match_entity.dart';
import '../../../players/domain/entities/player_entity.dart';

class CallUpEntity {
  final String? id;
  final String? matchId;
  final String? competitionId;
  final String playerId;
  final String status; // 'pending', 'accepted', 'declined', etc.
  final DateTime? sentAt;
  final DateTime? respondedAt;
  final String? notes;
  final bool? isCancelled;
  final DateTime? visibleUntil;
  final String? coachId;
  final String? position;
  final CoachEntity? coach;
  final CompetitionEntity? competition;
  final PlayerEntity? player;
  final MatchEntity? match;

  const CallUpEntity({
    this.id,
    this.matchId,
    this.competitionId,
    required this.playerId,
    required this.status,
    this.sentAt,
    this.respondedAt,
    this.notes,
    this.position,
    this.isCancelled,
    this.visibleUntil,
    this.coachId,
    this.coach,
    this.competition,
    this.player,
    this.match,
  });
}
