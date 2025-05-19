class UpdateTeamSquadParams {
  final String teamId;
  final String formation; // Ex: "4-4-2"
  final String gameType; // Ex: "11x11"

  UpdateTeamSquadParams({
    required this.teamId,
    required this.formation,
    required this.gameType,
  });

  Map<String, dynamic> toJson() {
    return {
      'team_id': teamId,
      'formation': formation,
      'game_type': gameType,
    };
  }

  @override
  String toString() =>
      'UpdateTeamSquadParams(teamId: $teamId, formation: $formation, gameType: $gameType)';
}
