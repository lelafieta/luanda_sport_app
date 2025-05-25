import '../../../players/domain/entities/player_entity.dart';
import '../../../teams/domain/entities/team_entity.dart';
import 'match_entity.dart';

class MatchEventEntity {
  final String? id;
  final String? matchId;
  final String? playerId;
  final String? teamId;
  final String? eventType; // pode ser convertido para Enum
  final int? minute;
  final String? period;
  final String? description;
  final String? substitutionFor;
  final DateTime? createdAt;
  final MatchEntity? match;
  final TeamEntity? team;
  final PlayerEntity? player;

  MatchEventEntity(
      {this.id,
      this.matchId,
      this.playerId,
      this.teamId,
      this.eventType,
      this.minute,
      this.period,
      this.description,
      this.substitutionFor,
      this.createdAt,
      this.match,
      this.player,
      this.team});
}
