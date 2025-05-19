class ProfileEntity {
  final String? id;
  final DateTime? updatedAt;
  final String? username;
  final String? fullName;
  final String? avatarUrl;
  final String? website;

  const ProfileEntity({
    this.id,
    this.updatedAt,
    this.username,
    this.fullName,
    this.avatarUrl,
    this.website,
  });
}
