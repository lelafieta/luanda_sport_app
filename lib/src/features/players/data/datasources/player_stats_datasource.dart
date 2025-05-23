import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/params/player_stats_params.dart';
import '../models/player_stats_model.dart';
import 'i_player_stats_datasource.dart';

class PlayerStatsRemoteDataSource implements IPlayerStatsRemoteDataSource {
  final SupabaseClient client;

  PlayerStatsRemoteDataSource({required this.client});

  @override
  Future<Unit> createPlayerStats(PlayerStatsModel playerStats) async {
    await client.from('players').insert(playerStats.toMap());
    return unit;
  }

  @override
  Future<Unit> deletePlayer(String id) async {
    await client.from('players').delete().eq('id', id);
    return unit;
  }

  @override
  Future<PlayerStatsModel?> getPlayerStatsById(String id) async {
    final response = await client
        .from('player_stats')
        .select('*, teams(*), players(*)')
        .eq('id', id)
        .maybeSingle();

    if (response != null) {
      return PlayerStatsModel.fromMap(response);
    }
    return null;
  }

  @override
  Future<PlayerStatsModel?> getPlayerStatsByTeam(
      PlayerStatsParams params) async {
    final response = await client
        .from('player_stats')
        .select('*, teams(*), players(*)')
        .eq('player_id', params.playerId)
        .eq('team_id', params.teamId)
        .maybeSingle();

    if (response != null) {
      return PlayerStatsModel.fromMap(response);
    }
    return null;
  }

  @override
  Future<Unit> updatePlayerStats(PlayerStatsModel playerStats) async {
    await client
        .from('player_stats')
        .update(playerStats.toMap())
        .eq('id', playerStats.id!);
    return unit;
  }
}
