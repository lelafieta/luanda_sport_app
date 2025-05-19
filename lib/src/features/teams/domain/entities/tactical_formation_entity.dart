class TacticalFormationEntity {
  final String? id;
  final String? teamId;
  final String? gameType;
  final Map<String, List<String>>? players;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TacticalFormationEntity({
    this.id,
    this.teamId,
    this.gameType,
    this.players,
    this.createdAt,
    this.updatedAt,
  });
}
