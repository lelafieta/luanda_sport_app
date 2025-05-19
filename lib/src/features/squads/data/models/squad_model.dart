import '../../domain/entities/squad_entity.dart';
import 'squad_player_model.dart';

class SquadModel extends SquadEntity {
  SquadModel({
    super.id,
    super.teamId,
    super.size,
    super.formation,
    super.players,
  });

  factory SquadModel.fromMap(Map<String, dynamic> map) {
    return SquadModel(
      id: map['id'],
      teamId: map['team_id'],
      size: map['game_type'],
      formation: map['formation'],
      players: (map['squad_players'] as List)
          .map((p) => SquadPlayerModel.fromMap(p))
          .toList(),
    );
  }

  factory SquadModel.fromEntity(SquadEntity entity) {
    return SquadModel(
      id: entity.id,
      teamId: entity.teamId,
      size: entity.size,
      formation: entity.formation,
      players: entity.players
          ?.map((player) => SquadPlayerModel.fromEntity(player))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'team_id': teamId,
        'size': size,
        'formation': formation,
        'players':
            players?.map((e) => (e as SquadPlayerModel).toMap()).toList(),
      };
}
