import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/trophy_model.dart';
import 'i_trophy_datasource.dart';

class TrophyRemoteDataSource implements ITrophyRemoteDataSource {
  final SupabaseClient client;

  TrophyRemoteDataSource({required this.client});

  @override
  Future<List<TrophyModel>> getTrophies({String? competitionId}) async {
    final query = client.from('trophies').select();

    if (competitionId != null) {
      query.eq('competition_id', competitionId);
    }

    final response = await query;
    return (response as List)
        .map((json) => TrophyModel.fromJson(json))
        .toList();
  }

  @override
  Future<TrophyModel?> getTrophyById(String id) async {
    final data =
        await client.from('trophies').select().eq('id', id).maybeSingle();

    if (data == null) return null;
    return TrophyModel.fromJson(data);
  }

  @override
  Future<Unit> createTrophy(TrophyModel trophy) async {
    await client.from('trophies').insert(trophy.toJson());
    return unit;
  }

  @override
  Future<Unit> updateTrophy(TrophyModel trophy) async {
    await client.from('trophies').update(trophy.toJson()).eq('id', trophy.id!);
    return unit;
  }

  @override
  Future<Unit> deleteTrophy(String id) async {
    await client.from('trophies').delete().eq('id', id);
    return unit;
  }

  @override
  Future<List<TrophyModel>> getTrophiesByTeam(String teamId) async {
    final data = await client.from('trophies').select().eq('team_id', teamId);

    return (data as List).map((json) => TrophyModel.fromJson(json)).toList();
  }
}
