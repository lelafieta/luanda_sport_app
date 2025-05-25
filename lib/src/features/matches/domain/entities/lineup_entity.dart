import '../../../players/domain/entities/player_entity.dart';
import '../../../teams/domain/entities/team_entity.dart';
import 'match_entity.dart';

class LineupEntity {
  final String? id;
  final String? matchId;
  final String? teamId;
  final String? playerId;
  final String? position;
  final bool? isCaptain;
  final bool? isStarting;
  final DateTime? createdAt;
  final MatchEntity? match;
  final TeamEntity? team;
  final PlayerEntity? player;

  LineupEntity({
    this.id,
    this.matchId,
    this.teamId,
    this.playerId,
    this.position,
    this.isCaptain,
    this.isStarting,
    this.createdAt,
    this.match,
    this.team,
    this.player,
  });
}
