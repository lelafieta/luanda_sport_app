class CompetitionEntity {
  final String id;
  final String name;
  final int? season;
  final DateTime? startDate;
  final DateTime? endDate;
  final String type;
  final String? category;
  final String gameType;
  final String playerType;
  final int? maxTeams;
  final int? maxPlayersPerTeam;
  final DateTime? registrationDeadline;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? groupQtd;

  CompetitionEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.gameType,
    required this.playerType,
    this.season,
    this.startDate,
    this.endDate,
    this.category,
    this.maxTeams,
    this.maxPlayersPerTeam,
    this.registrationDeadline,
    this.location,
    this.latitude,
    this.longitude,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.groupQtd,
  });
}
