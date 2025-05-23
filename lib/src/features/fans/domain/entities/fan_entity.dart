class FanEntity {
  final String? id;
  final bool? followTeams;
  final bool? appNotificationsEnabled;
  final Map<String, dynamic>? preferences; // jsonb
  final DateTime? createdAt;
  final String? profilePictureUrl;

  const FanEntity({
    this.id,
    this.followTeams,
    this.appNotificationsEnabled,
    this.preferences,
    this.createdAt,
    this.profilePictureUrl,
  });
}
