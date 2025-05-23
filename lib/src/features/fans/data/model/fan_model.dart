import '../../domain/entities/fan_entity.dart';

class FanModel extends FanEntity {
  const FanModel({
    super.id,
    super.followTeams,
    super.appNotificationsEnabled,
    super.preferences,
    super.createdAt,
    super.profilePictureUrl,
  });

  factory FanModel.fromMap(Map<String, dynamic> map) {
    return FanModel(
      id: map['id'] as String?,
      followTeams: map['follow_teams'] as bool?,
      appNotificationsEnabled: map['app_notifications_enabled'] as bool?,
      preferences: map['preferences'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(map['preferences'])
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      profilePictureUrl: map['profile_picture_url'] as String?,
    );
  }

  factory FanModel.fromEntity(FanEntity entity) {
    return FanModel(
      id: entity.id,
      followTeams: entity.followTeams,
      appNotificationsEnabled: entity.appNotificationsEnabled,
      preferences: entity.preferences,
      createdAt: entity.createdAt,
      profilePictureUrl: entity.profilePictureUrl,
    );
  }

  FanModel copyWith({
    String? id,
    bool? followTeams,
    bool? appNotificationsEnabled,
    Map<String, dynamic>? preferences,
    DateTime? createdAt,
    String? profilePictureUrl,
  }) {
    return FanModel(
      id: id ?? this.id,
      followTeams: followTeams ?? this.followTeams,
      appNotificationsEnabled:
          appNotificationsEnabled ?? this.appNotificationsEnabled,
      preferences: preferences ?? this.preferences,
      createdAt: createdAt ?? this.createdAt,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'follow_teams': followTeams,
      'app_notifications_enabled': appNotificationsEnabled,
      'preferences': preferences,
      'created_at': createdAt?.toIso8601String(),
      'profile_picture_url': profilePictureUrl,
    };
  }
}
