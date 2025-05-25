import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/features/teams/data/models/tactical_formation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/team_model.dart';
import 'i_team_datasource.dart';

class TeamRemoteDataSource implements ITeamRemoteDataSource {
  final SupabaseClient client;

  TeamRemoteDataSource({required this.client});

  @override
  Future<Unit> createTeam(TeamModel team) async {
    final response = await client
        .from('teams')
        .insert(team.copyWith(createdBy: client.auth.currentUser!.id).toMap());
    if (response.error != null) {
      throw Exception('Erro ao criar equipe: ${response.error!.message}');
    }
    return unit;
  }

  @override
  Future<List<TeamModel>> getTeams() async {
    final response =
        await client.from('teams').select('*, created_by_profile:profiles(*)');

    final data = response as List<dynamic>;
    return data.map((item) => TeamModel.fromMap(item)).toList();
  }

  @override
  Future<List<TeamModel>> getMyTeams() async {
    final response =
        await client.from('teams').select('*, created_by_profile:profiles(*)');

    final data = response as List<dynamic>;
    return data.map((item) => TeamModel.fromMap(item)).toList();
  }

  @override
  Future<TeamModel?> getTeamById(String id) async {
    final response = await client
        .from('teams')
        .select('*, created_by_profile:profiles(*)')
        .eq('id', id)
        .single();

    return TeamModel.fromMap(response);
  }

  @override
  Future<Unit> updateTeam(TeamModel team) async {
    await client.from('teams').update(team.toJson()).eq('id', team.id!);
    return unit;
  }

  @override
  Future<Unit> deleteTeam(String id) async {
    await client.from('teams').delete().eq('id', id);
    return unit;
  }

  @override
  Future<TacticalFormationModel?> getTeamTacticalFormation(String teamId) {
    // TODO: implement getTeamTacticalFormation
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateTeamSquad(
      String gameType, String formation, String teamId) async {
    await client.from('teams').update({
      "game_type": gameType,
      "formation": formation,
    }).eq('id', teamId);
    return unit;
  }
}
