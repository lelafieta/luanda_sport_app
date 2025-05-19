import '../../../profiles/data/models/profile_model.dart';
import '../../domain/entities/team_entity.dart';

class TeamModel extends TeamEntity {
  const TeamModel(
      {super.id,
      super.name,
      super.logoUrl,
      super.description,
      super.category,
      super.location,
      super.captainName,
      super.captainContact,
      super.memberLimit,
      super.foundedAt,
      super.inviteCode,
      super.socialLinks,
      super.status,
      super.createdBy,
      super.createdAt,
      super.equipmentType,
      super.equipmentMainColor,
      super.equipmentTypeColor,
      super.equipmentNumberColor,
      super.abbreviation,
      super.createdByProfile,
      super.formation,
      super.gameType});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      logoUrl: json['logo_url'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      location: json['location'] as String?,
      captainName: json['captain_name'] as String?,
      captainContact: json['captain_contact'] as String?,
      memberLimit: json['member_limit'] as int?,
      foundedAt: json['founded_at'] != null
          ? DateTime.tryParse(json['founded_at'])
          : null,
      inviteCode: json['invite_code'] as String?,
      socialLinks: json['social_links'] as Map<String, dynamic>?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      equipmentType: json['equipment_type'] as String?,
      equipmentMainColor: json['equipament_main_color'] as String?,
      equipmentTypeColor: json['equipament_type_color'] as String?,
      equipmentNumberColor: json['equipament_number_color'] as String?,
      abbreviation: json['abbreviation'] as String?,
      formation: json['formation'] as String?,
      gameType: json['game_type'] as String?,
      createdByProfile: json['created_by_profile'] != null
          ? ProfileModel.fromJson(
              json['created_by_profile'] as Map<String, dynamic>)
          : null,
    );
  }

  factory TeamModel.fromEntity(TeamEntity entity) {
    return TeamModel(
        id: entity.id,
        name: entity.name,
        logoUrl: entity.logoUrl,
        description: entity.description,
        category: entity.category,
        location: entity.location,
        captainName: entity.captainName,
        captainContact: entity.captainContact,
        memberLimit: entity.memberLimit,
        foundedAt: entity.foundedAt,
        inviteCode: entity.inviteCode,
        socialLinks: entity.socialLinks,
        status: entity.status,
        createdBy: entity.createdBy,
        createdAt: entity.createdAt,
        equipmentType: entity.equipmentType,
        equipmentMainColor: entity.equipmentMainColor,
        equipmentTypeColor: entity.equipmentTypeColor,
        equipmentNumberColor: entity.equipmentNumberColor,
        abbreviation: entity.abbreviation,
        createdByProfile: entity.createdByProfile,
        formation: entity.formation,
        gameType: entity.gameType);
  }

  Map<String, dynamic> toJson() {
    print(formation);
    print(gameType);
    return {
      'id': id,
      'name': name,
      'logo_url': logoUrl,
      'description': description,
      'category': category,
      'location': location,
      'captain_name': captainName,
      'captain_contact': captainContact,
      'member_limit': memberLimit,
      'founded_at': foundedAt?.toIso8601String(),
      'invite_code': inviteCode,
      'social_links': socialLinks,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
      'equipment_type': equipmentType,
      'abbreviation': abbreviation,
      'equipament_main_color': equipmentMainColor,
      'equipament_type_color': equipmentTypeColor,
      'equipament_number_color': equipmentNumberColor,
      'formation': formation,
      'game_type': gameType,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo_url': logoUrl,
      'description': description,
      'category': category,
      'location': location,
      'captain_name': captainName,
      'captain_contact': captainContact,
      'member_limit': memberLimit,
      'founded_at': foundedAt?.toIso8601String(),
      'invite_code': inviteCode,
      'social_links': socialLinks,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
      'equipment_type': equipmentType,
      'abbreviation': abbreviation,
      'equipament_main_color': equipmentMainColor,
      'equipament_type_color': equipmentTypeColor,
      'equipament_number_color': equipmentNumberColor,
      'created_by_profile': createdByProfile,
      'formation': formation,
      'game_type': gameType,
    };
  }

  TeamModel copyWith({
    String? id,
    String? name,
    String? logoUrl,
    String? description,
    String? category,
    String? location,
    String? captainName,
    String? captainContact,
    int? memberLimit,
    DateTime? foundedAt,
    String? inviteCode,
    Map<String, dynamic>? socialLinks,
    String? status,
    String? createdBy,
    DateTime? createdAt,
    String? equipmentType,
    String? abbreviation,
    String? equipamentMainColor,
    String? equipamentTypeColor,
    String? equipamentNumberColor,
    ProfileModel? createdByProfile,
    String? formation,
    String? gameType,
  }) {
    print("GAME TYPE: ${gameType}");
    return TeamModel(
        id: id ?? this.id,
        name: name ?? this.name,
        logoUrl: logoUrl ?? this.logoUrl,
        description: description ?? this.description,
        category: category ?? this.category,
        location: location ?? this.location,
        captainName: captainName ?? this.captainName,
        captainContact: captainContact ?? this.captainContact,
        memberLimit: memberLimit ?? this.memberLimit,
        foundedAt: foundedAt ?? this.foundedAt,
        inviteCode: inviteCode ?? this.inviteCode,
        socialLinks: socialLinks ?? this.socialLinks,
        status: status ?? this.status,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        equipmentType: equipmentType ?? this.equipmentType,
        equipmentMainColor: equipmentType ?? equipmentMainColor,
        equipmentTypeColor: equipmentType ?? equipmentTypeColor,
        equipmentNumberColor: abbreviation ?? equipmentNumberColor,
        abbreviation: abbreviation ?? this.abbreviation,
        createdByProfile: createdByProfile ?? createdByProfile,
        formation: this.formation ?? formation,
        gameType: this.gameType ?? gameType);
  }
}
