import '../../domain/entities/competition_entity.dart';

class CompetitionModel extends CompetitionEntity {
  CompetitionModel({
    required super.id,
    required super.name,
    required super.type,
    required super.gameType,
    required super.playerType,
    super.season,
    super.startDate,
    super.endDate,
    super.category,
    super.maxTeams,
    super.maxPlayersPerTeam,
    super.registrationDeadline,
    super.location,
    super.latitude,
    super.longitude,
    super.createdBy,
    super.createdAt,
    super.updatedAt,
    super.groupQtd,
  });

  factory CompetitionModel.fromMap(Map<String, dynamic> json) {
    return CompetitionModel(
      id: json['id'],
      name: json['name'],
      season: json['season'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      type: json['type'],
      category: json['category'],
      gameType: json['game_type'],
      playerType: json['player_type'],
      maxTeams: json['max_teams'],
      maxPlayersPerTeam: json['max_players_per_team'],
      registrationDeadline: json['registration_deadline'] != null
          ? DateTime.parse(json['registration_deadline'])
          : null,
      location: json['location'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      createdBy: json['created_by'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      groupQtd: json['group_qtd'],
    );
  }

  factory CompetitionModel.fromEntity(CompetitionEntity entity) {
    return CompetitionModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      gameType: entity.gameType,
      playerType: entity.playerType,
      season: entity.season,
      startDate: entity.startDate,
      endDate: entity.endDate,
      category: entity.category,
      maxTeams: entity.maxTeams,
      maxPlayersPerTeam: entity.maxPlayersPerTeam,
      registrationDeadline: entity.registrationDeadline,
      location: entity.location,
      latitude: entity.latitude,
      longitude: entity.longitude,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      groupQtd: entity.groupQtd,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'season': season,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'type': type,
      'category': category,
      'game_type': gameType,
      'player_type': playerType,
      'max_teams': maxTeams,
      'max_players_per_team': maxPlayersPerTeam,
      'registration_deadline': registrationDeadline?.toIso8601String(),
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'group_qtd': groupQtd,
    };
  }
}
