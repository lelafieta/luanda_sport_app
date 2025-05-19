import '../../../profiles/data/models/profile_model.dart';
import '../../domain/entities/player_entity.dart';

class PlayerModel extends PlayerEntity {
  const PlayerModel({
    super.id,
    super.teamId,
    super.createdBy,
    super.fullName,
    super.nickname,
    super.shirtNumber,
    super.position,
    super.type, // Adicionado aqui
    super.nationality,
    super.birthDate,
    super.heightCm,
    super.weightKg,
    super.foot,
    super.avatarUrl,
    super.status,
    super.createdAt,
    super.updatedAt,
    super.createdByProfile,
  });

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      id: map['id'] as String?,
      teamId: map['team_id'] as String?,
      createdBy: map['created_by'] as String?,
      fullName: map['full_name'] as String?,
      nickname: map['nickname'] as String?,
      shirtNumber: map['shirt_number'] as int?,
      position: map['position'] as String?,
      type: map['type'] as String?, // Adicionado aqui
      nationality: map['nationality'] as String?,
      birthDate: map['birth_date'] != null
          ? DateTime.tryParse(map['birth_date'])
          : null,
      heightCm: map['height_cm'] as int?,
      weightKg: map['weight_kg'] as int?,
      foot: map['foot'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      status: map['status'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
      createdByProfile: map['created_by_profile'] != null
          ? ProfileModel.fromJson(map['created_by_profile'])
          : null,
    );
  }

  factory PlayerModel.fromEntity(PlayerEntity entity) {
    return PlayerModel(
      id: entity.id,
      teamId: entity.teamId,
      createdBy: entity.createdBy,
      fullName: entity.fullName,
      nickname: entity.nickname,
      shirtNumber: entity.shirtNumber,
      position: entity.position,
      type: entity.type, // Adicionado aqui
      nationality: entity.nationality,
      birthDate: entity.birthDate,
      heightCm: entity.heightCm,
      weightKg: entity.weightKg,
      foot: entity.foot,
      avatarUrl: entity.avatarUrl,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      createdByProfile: entity.createdByProfile,
    );
  }

  PlayerModel copyWith({
    String? id,
    String? teamId,
    String? createdBy,
    String? fullName,
    String? nickname,
    int? shirtNumber,
    String? position,
    String? type, // Adicionado aqui
    String? nationality,
    DateTime? birthDate,
    int? heightCm,
    int? weightKg,
    String? foot,
    String? avatarUrl,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    ProfileModel? createdByProfile,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      createdBy: createdBy ?? this.createdBy,
      fullName: fullName ?? this.fullName,
      nickname: nickname ?? this.nickname,
      shirtNumber: shirtNumber ?? this.shirtNumber,
      position: position ?? this.position,
      type: type ?? this.type, // Adicionado aqui
      nationality: nationality ?? this.nationality,
      birthDate: birthDate ?? this.birthDate,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      foot: foot ?? this.foot,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdByProfile: createdByProfile ?? this.createdByProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'team_id': teamId,
      'created_by': createdBy,
      'full_name': fullName,
      'nickname': nickname,
      'shirt_number': shirtNumber,
      'position': position,
      'type': type, // Adicionado aqui
      'nationality': nationality,
      'birth_date': birthDate?.toIso8601String(),
      'height_cm': heightCm,
      'weight_kg': weightKg,
      'foot': foot,
      'avatar_url': avatarUrl,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
