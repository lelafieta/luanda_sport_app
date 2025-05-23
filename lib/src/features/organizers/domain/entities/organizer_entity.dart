class OrganizerEntity {
  final String? id;
  final String? organizationName;
  final String? contactEmail;
  final String? contactPhone;
  final String? websiteUrl;
  final String? logoUrl;
  final int? totalCompetitionsCreated;
  final bool? verified;
  final String? description;
  final Map<String, dynamic>? socialLinks;
  final DateTime? createdAt;
  final String? profilePictureUrl;

  const OrganizerEntity({
    this.id,
    this.organizationName,
    this.contactEmail,
    this.contactPhone,
    this.websiteUrl,
    this.logoUrl,
    this.totalCompetitionsCreated,
    this.verified,
    this.description,
    this.socialLinks,
    this.createdAt,
    this.profilePictureUrl,
  });
}
