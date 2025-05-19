import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/player_model.dart';
import 'i_player_datasource.dart';

class PlayerRemoteDataSource implements IPlayerRemoteDataSource {
  final SupabaseClient client;

  PlayerRemoteDataSource({required this.client});

  @override
  Future<List<PlayerModel>> getPlayers() async {
    final response = await client.from('players').select();
    return (response as List)
        .map((e) => PlayerModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PlayerModel?> getPlayerById(String id) async {
    final response =
        await client.from('players').select().eq('id', id).maybeSingle();

    if (response != null) {
      return PlayerModel.fromMap(response as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<Unit> createPlayer(PlayerModel player) async {
    await client.from('players').insert(player.toMap());
    return unit;
  }

  @override
  Future<Unit> updatePlayer(PlayerModel player) async {
    await client.from('players').update(player.toMap()).eq('id', player.id!);
    return unit;
  }

  @override
  Future<Unit> deletePlayer(String id) async {
    await client.from('players').delete().eq('id', id);
    return unit;
  }

  @override
  Future<List<PlayerModel>> getPlayersByTeam(String teamId) async {
    final response =
        await client.from('players').select().eq('team_id', teamId);

    print((response as List)
        .map((e) => PlayerModel.fromMap(e as Map<String, dynamic>))
        .toList()
        .length);

    return (response as List)
        .map((e) => PlayerModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
