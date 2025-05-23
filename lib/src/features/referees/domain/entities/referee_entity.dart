class RefereeEntity {
  final String? id;
  final String? refereeCategory; // 'main', 'assistant', 'fourth', 'VAR'
  final String? licenseNumber;
  final String? licenseLevel;
  final int? yearsExperience;
  final int? matchesOfficiated;
  final String? currentLeague;
  final bool? physicalFitnessCertified;
  final bool? availableForMatches;
  final DateTime? createdAt;
  final String? profilePictureUrl;

  const RefereeEntity({
    this.id,
    this.refereeCategory,
    this.licenseNumber,
    this.licenseLevel,
    this.yearsExperience,
    this.matchesOfficiated,
    this.currentLeague,
    this.physicalFitnessCertified,
    this.availableForMatches,
    this.createdAt,
    this.profilePictureUrl,
  });
}
