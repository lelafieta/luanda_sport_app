class RuleEntity {
  final List<String>? tiebreakers;
  final int? matchDuration;
  final int? restTime;
  final int? substitutionsAllowed;
  final bool? drawsAllowed;

  final bool? extraTimeAllowed;
  final int? extraTimeDuration;
  final bool? penaltyAllowed;
  final bool? homeAndAway;

  final int? pointsVictory;
  final int? pointsDraw;
  final int? pointsLose;

  final int? maxPlayers;
  final DateTime? registrationDeadline;
  final bool? foreignPlayers;
  final List<String>? punishments;

  final String? createdBy;

  RuleEntity({
    this.tiebreakers,
    this.matchDuration,
    this.restTime,
    this.substitutionsAllowed,
    this.drawsAllowed,
    this.extraTimeAllowed,
    this.extraTimeDuration,
    this.penaltyAllowed,
    this.homeAndAway,
    this.pointsVictory,
    this.pointsDraw,
    this.pointsLose,
    this.maxPlayers,
    this.registrationDeadline,
    this.foreignPlayers,
    this.punishments,
    this.createdBy,
  });
}
