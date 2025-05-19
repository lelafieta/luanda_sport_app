import 'package:dartz/dartz.dart';

import '../models/player_model.dart';

abstract class IPlayerRemoteDataSource {
  Future<List<PlayerModel>> getPlayers();
  Future<PlayerModel?> getPlayerById(String id);
  Future<List<PlayerModel>> getPlayersByTeam(String id);
  Future<Unit> createPlayer(PlayerModel player);
  Future<Unit> updatePlayer(PlayerModel player);
  Future<Unit> deletePlayer(String id);
}
