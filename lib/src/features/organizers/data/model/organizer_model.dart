import '../../domain/entities/organizer_entity.dart';

class OrganizerModel extends OrganizerEntity {
  const OrganizerModel({
    super.id,
    super.organizationName,
    super.contactEmail,
    super.contactPhone,
    super.websiteUrl,
    super.logoUrl,
    super.totalCompetitionsCreated,
    super.verified,
    super.description,
    super.socialLinks,
    super.createdAt,
    super.profilePictureUrl,
  });

  factory OrganizerModel.fromMap(Map<String, dynamic> map) {
    return OrganizerModel(
      id: map['id'] as String?,
      organizationName: map['organization_name'] as String?,
      contactEmail: map['contact_email'] as String?,
      contactPhone: map['contact_phone'] as String?,
      websiteUrl: map['website_url'] as String?,
      logoUrl: map['logo_url'] as String?,
      totalCompetitionsCreated: map['total_competitions_created'] as int?,
      verified: map['verified'] as bool?,
      description: map['description'] as String?,
      socialLinks: map['social_links'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(map['social_links'])
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      profilePictureUrl: map['profile_picture_url'] as String?,
    );
  }

  factory OrganizerModel.fromEntity(OrganizerEntity entity) {
    return OrganizerModel(
      id: entity.id,
      organizationName: entity.organizationName,
      contactEmail: entity.contactEmail,
      contactPhone: entity.contactPhone,
      websiteUrl: entity.websiteUrl,
      logoUrl: entity.logoUrl,
      totalCompetitionsCreated: entity.totalCompetitionsCreated,
      verified: entity.verified,
      description: entity.description,
      socialLinks: entity.socialLinks,
      createdAt: entity.createdAt,
      profilePictureUrl: entity.profilePictureUrl,
    );
  }

  OrganizerModel copyWith({
    String? id,
    String? organizationName,
    String? contactEmail,
    String? contactPhone,
    String? websiteUrl,
    String? logoUrl,
    int? totalCompetitionsCreated,
    bool? verified,
    String? description,
    Map<String, dynamic>? socialLinks,
    DateTime? createdAt,
    String? profilePictureUrl,
  }) {
    return OrganizerModel(
      id: id ?? this.id,
      organizationName: organizationName ?? this.organizationName,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      totalCompetitionsCreated:
          totalCompetitionsCreated ?? this.totalCompetitionsCreated,
      verified: verified ?? this.verified,
      description: description ?? this.description,
      socialLinks: socialLinks ?? this.socialLinks,
      createdAt: createdAt ?? this.createdAt,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_name': organizationName,
      'contact_email': contactEmail,
      'contact_phone': contactPhone,
      'website_url': websiteUrl,
      'logo_url': logoUrl,
      'total_competitions_created': totalCompetitionsCreated,
      'verified': verified,
      'description': description,
      'social_links': socialLinks,
      'created_at': createdAt?.toIso8601String(),
      'profile_picture_url': profilePictureUrl,
    };
  }
}
