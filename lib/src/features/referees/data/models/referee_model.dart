import '../../domain/entities/referee_entity.dart';

class RefereeModel extends RefereeEntity {
  const RefereeModel({
    super.id,
    super.refereeCategory,
    super.licenseNumber,
    super.licenseLevel,
    super.yearsExperience,
    super.matchesOfficiated,
    super.currentLeague,
    super.physicalFitnessCertified,
    super.availableForMatches,
    super.createdAt,
    super.profilePictureUrl,
  });

  factory RefereeModel.fromMap(Map<String, dynamic> map) {
    return RefereeModel(
      id: map['id'] as String?,
      refereeCategory: map['referee_category'] as String?,
      licenseNumber: map['license_number'] as String?,
      licenseLevel: map['license_level'] as String?,
      yearsExperience: map['years_experience'] as int?,
      matchesOfficiated: map['matches_officiated'] as int? ?? 0,
      currentLeague: map['current_league'] as String?,
      physicalFitnessCertified:
          map['physical_fitness_certified'] as bool? ?? true,
      availableForMatches: map['available_for_matches'] as bool? ?? true,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      profilePictureUrl: map['profile_picture_url'] as String?,
    );
  }

  factory RefereeModel.fromEntity(RefereeEntity entity) {
    return RefereeModel(
      id: entity.id,
      refereeCategory: entity.refereeCategory,
      licenseNumber: entity.licenseNumber,
      licenseLevel: entity.licenseLevel,
      yearsExperience: entity.yearsExperience,
      matchesOfficiated: entity.matchesOfficiated,
      currentLeague: entity.currentLeague,
      physicalFitnessCertified: entity.physicalFitnessCertified,
      availableForMatches: entity.availableForMatches,
      createdAt: entity.createdAt,
      profilePictureUrl: entity.profilePictureUrl,
    );
  }

  RefereeModel copyWith({
    String? id,
    String? refereeCategory,
    String? licenseNumber,
    String? licenseLevel,
    int? yearsExperience,
    int? matchesOfficiated,
    String? currentLeague,
    bool? physicalFitnessCertified,
    bool? availableForMatches,
    DateTime? createdAt,
    String? profilePictureUrl,
  }) {
    return RefereeModel(
      id: id ?? this.id,
      refereeCategory: refereeCategory ?? this.refereeCategory,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      licenseLevel: licenseLevel ?? this.licenseLevel,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      matchesOfficiated: matchesOfficiated ?? this.matchesOfficiated,
      currentLeague: currentLeague ?? this.currentLeague,
      physicalFitnessCertified:
          physicalFitnessCertified ?? this.physicalFitnessCertified,
      availableForMatches: availableForMatches ?? this.availableForMatches,
      createdAt: createdAt ?? this.createdAt,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'referee_category': refereeCategory,
      'license_number': licenseNumber,
      'license_level': licenseLevel,
      'years_experience': yearsExperience,
      'matches_officiated': matchesOfficiated,
      'current_league': currentLeague,
      'physical_fitness_certified': physicalFitnessCertified,
      'available_for_matches': availableForMatches,
      'created_at': createdAt?.toIso8601String(),
      'profile_picture_url': profilePictureUrl,
    };
  }
}
