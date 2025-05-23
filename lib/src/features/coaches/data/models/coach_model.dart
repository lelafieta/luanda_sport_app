import '../../domain/entities/coach_entity.dart';

class CoachModel extends CoachEntity {
  const CoachModel({
    super.id,
    super.nationality,
    super.licenseLevel,
    super.yearsExperience,
    super.tacticalStyle,
    super.coachingCertificates,
    super.videoIntroUrl,
    super.createdAt,
    super.profilePictureUrl,
  });

  factory CoachModel.fromMap(Map<String, dynamic> map) {
    return CoachModel(
      id: map['id'] as String?,
      nationality: map['nationality'] as String?,
      licenseLevel: map['license_level'] as String?,
      yearsExperience: map['years_experience'] as int?,
      tacticalStyle: map['tactical_style'] as String?,
      coachingCertificates: map['coaching_certificates'] is List
          ? List<dynamic>.from(map['coaching_certificates'])
          : null,
      videoIntroUrl: map['video_intro_url'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      profilePictureUrl: map['profile_picture_url'] as String?,
    );
  }

  factory CoachModel.fromEntity(CoachEntity entity) {
    return CoachModel(
      id: entity.id,
      nationality: entity.nationality,
      licenseLevel: entity.licenseLevel,
      yearsExperience: entity.yearsExperience,
      tacticalStyle: entity.tacticalStyle,
      coachingCertificates: entity.coachingCertificates,
      videoIntroUrl: entity.videoIntroUrl,
      createdAt: entity.createdAt,
      profilePictureUrl: entity.profilePictureUrl,
    );
  }

  CoachModel copyWith({
    String? id,
    String? nationality,
    String? licenseLevel,
    int? yearsExperience,
    String? tacticalStyle,
    List<dynamic>? coachingCertificates,
    String? videoIntroUrl,
    DateTime? createdAt,
    String? profilePictureUrl,
  }) {
    return CoachModel(
      id: id ?? this.id,
      nationality: nationality ?? this.nationality,
      licenseLevel: licenseLevel ?? this.licenseLevel,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      tacticalStyle: tacticalStyle ?? this.tacticalStyle,
      coachingCertificates: coachingCertificates ?? this.coachingCertificates,
      videoIntroUrl: videoIntroUrl ?? this.videoIntroUrl,
      createdAt: createdAt ?? this.createdAt,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nationality': nationality,
      'license_level': licenseLevel,
      'years_experience': yearsExperience,
      'tactical_style': tacticalStyle,
      'coaching_certificates': coachingCertificates,
      'video_intro_url': videoIntroUrl,
      'created_at': createdAt?.toIso8601String(),
      'profile_picture_url': profilePictureUrl,
    };
  }
}
