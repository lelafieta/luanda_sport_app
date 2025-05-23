import '../../../profiles/domain/entities/profile_entity.dart';
import '../../../teams/domain/entities/team_entity.dart';

class PlayerEntity {
  final String? id;
  final String? teamId;
  final String? createdBy;
  final String? fullName;
  final String? nickname;
  final int? shirtNumber;
  final String? position;
  final String? nationality;
  final DateTime? birthDate;
  final int? heightCm;
  final int? weightKg;
  final String? foot;
  final String? avatarUrl;
  final String? status;
  final String? type; // 'real' | 'fictitious'
  final String? videoHighlightUrl;
  final String? dominantHand;
  final bool? isActive;
  final String? level; // 'professional' | 'amateur' | 'youth'
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProfileEntity? createdByProfile;
  final TeamEntity? team;

  const PlayerEntity({
    this.id,
    this.teamId,
    this.createdBy,
    this.fullName,
    this.nickname,
    this.shirtNumber,
    this.position,
    this.nationality,
    this.birthDate,
    this.heightCm,
    this.weightKg,
    this.foot,
    this.avatarUrl,
    this.status,
    this.type,
    this.videoHighlightUrl,
    this.dominantHand,
    this.isActive,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.createdByProfile,
    this.team,
  });
}
