class CoachEntity {
  final String? id;
  final String? nationality;
  final String? licenseLevel;
  final int? yearsExperience;
  final String? tacticalStyle;
  final List<dynamic>? coachingCertificates; // jsonb
  final String? videoIntroUrl;
  final DateTime? createdAt;
  final String? profilePictureUrl;

  const CoachEntity({
    this.id,
    this.nationality,
    this.licenseLevel,
    this.yearsExperience,
    this.tacticalStyle,
    this.coachingCertificates,
    this.videoIntroUrl,
    this.createdAt,
    this.profilePictureUrl,
  });
}
