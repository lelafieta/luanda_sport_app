import '../../domain/entities/trophy_entity.dart';

class TrophyModel extends TrophyEntity {
  const TrophyModel({
    super.id,
    super.name,
    super.description,
    super.position,
    super.competitionId,
    super.teamId,
    super.awardedAt,
    super.imageUrl,
    super.createdAt,
    super.updatedAt,
  });

  factory TrophyModel.fromJson(Map<String, dynamic> json) {
    return TrophyModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      position: json['position'],
      competitionId: json['competitionId'],
      teamId: json['teamId'],
      awardedAt:
          json['awardedAt'] != null ? DateTime.parse(json['awardedAt']) : null,
      imageUrl: json['imageUrl'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'position': position,
      'competitionId': competitionId,
      'teamId': teamId,
      'awardedAt': awardedAt?.toIso8601String(),
      'imageUrl': imageUrl,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory TrophyModel.fromEntity(TrophyEntity entity) {
    return TrophyModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      position: entity.position,
      competitionId: entity.competitionId,
      teamId: entity.teamId,
      awardedAt: entity.awardedAt,
      imageUrl: entity.imageUrl,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
