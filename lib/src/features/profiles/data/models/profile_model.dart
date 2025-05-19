import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    super.id,
    super.updatedAt,
    super.username,
    super.fullName,
    super.avatarUrl,
    super.website,
  });

  ProfileModel copyWith({
    String? id,
    DateTime? updatedAt,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? website,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      website: website ?? this.website,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String?,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      username: map['username'] as String?,
      fullName: map['full_name'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      website: map['website'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': updatedAt?.toIso8601String(),
      'username': username,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'website': website,
    };
  }
}
