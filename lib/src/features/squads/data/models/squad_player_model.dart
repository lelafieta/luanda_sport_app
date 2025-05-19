import '../../../players/data/models/player_model.dart';
import '../../domain/entities/squad_player_entity.dart';

class SquadPlayerModel extends SquadPlayerEntity {
  SquadPlayerModel({
    super.id,
    super.squadId,
    super.playerId,
    super.tacticalPosition,
    super.jerseyNumber,
    super.isStarter,
    super.player, // Atualizado para PlayerModel
  });

  factory SquadPlayerModel.fromMap(Map<String, dynamic> map) {
    return SquadPlayerModel(
      id: map['id'],
      squadId: map['squad_id'],
      playerId: map['player_id'],
      tacticalPosition: map['tactical_position'],
      jerseyNumber: map['jersey_number'],
      isStarter: map['is_starter'],
      player:
          (map['players'] == null) ? null : PlayerModel.fromMap(map['players']),
    );
  }

  factory SquadPlayerModel.fromEntity(SquadPlayerEntity entity) {
    return SquadPlayerModel(
      id: entity.id,
      squadId: entity.squadId,
      playerId: entity.playerId,
      tacticalPosition: entity.tacticalPosition,
      jerseyNumber: entity.jerseyNumber,
      isStarter: entity.isStarter,
      player: PlayerModel.fromEntity(entity.player!),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'squad_id': squadId,
        'player_id': playerId,
        'tactical_position': tacticalPosition,
        'jersey_number': jerseyNumber,
        'is_starter': isStarter,
        'player': (player as PlayerModel).toMap(),
      };
}
