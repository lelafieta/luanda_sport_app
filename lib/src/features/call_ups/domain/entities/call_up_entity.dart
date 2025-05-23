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

  const CallUpEntity({
    this.id,
    this.matchId,
    this.competitionId,
    required this.playerId,
    required this.status,
    this.sentAt,
    this.respondedAt,
    this.notes,
    this.isCancelled,
    this.visibleUntil,
    this.coachId,
  });
}
