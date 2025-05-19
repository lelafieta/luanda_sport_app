class CompetitionEntity {
  final String id;
  final String name;
  final int qtdTeam;
  final int organizerId;
  final int rulesId;
  final int prizeId;
  final String level;
  final int season;
  final bool
      isHomeAndAway; // Indicates if the competition has home and away games
  final bool hasGroupStage; // Indicates if the competition has a group stage
  final int groupCount; // Number of groups in the competition
  final DateTime startDate; // Start date of the competition
  final DateTime endDate; // End date of the competition

  CompetitionEntity({
    required this.id,
    required this.name,
    required this.qtdTeam,
    required this.organizerId,
    required this.rulesId,
    required this.prizeId,
    required this.season,
    required this.level,
    required this.isHomeAndAway,
    required this.hasGroupStage,
    required this.groupCount,
    required this.startDate,
    required this.endDate,
  });
}
