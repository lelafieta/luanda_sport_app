import 'package:dartz/dartz.dart';
import '../../domain/entities/player_stats_entity.dart';
import '../../domain/params/player_stats_params.dart';
import '../models/player_stats_model.dart';

abstract class IPlayerStatsRemoteDataSource {
  Future<Unit> createPlayerStats(PlayerStatsModel playerStats);
  Future<PlayerStatsModel?> getPlayerStatsById(String id);
  Future<PlayerStatsModel?> getPlayerStatsByTeam(PlayerStatsParams params);
  Future<Unit> updatePlayerStats(PlayerStatsModel playerStats);
  Future<Unit> deletePlayer(String playerId);
}
