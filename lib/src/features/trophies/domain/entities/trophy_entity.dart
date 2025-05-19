class TrophyEntity {
  final String? id;
  final String? name;
  final String? description;
  final int? position;
  final String? competitionId;
  final String? teamId;
  final DateTime? awardedAt;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TrophyEntity({
    this.id,
    this.name,
    this.description,
    this.position,
    this.competitionId,
    this.teamId,
    this.awardedAt,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });
}
