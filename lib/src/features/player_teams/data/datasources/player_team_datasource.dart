import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/params/create_player_team_params.dart';
import '../models/player_team_model.dart';
import 'i_player_team_datasource.dart';

class PlayerTeamRemoteDataSource extends IPlayerTeamRemoteDataSource {
  final SupabaseClient client;
  PlayerTeamRemoteDataSource({required this.client});
  @override
  Future<Unit> createPlayerTeam(CreatePlayerTeamParams playerTeam) {
    return client
        .from('player_teams')
        .insert(playerTeam.toMap())
        .then((value) => unit)
        .catchError((error) {
      throw Exception('Error creating player team: $error');
    });
  }

  @override
  Future<List<PlayerTeamModel>> getPlayerTeams(String playerId) {
    print(playerId);
    return client
        .from('player_teams')
        .select('*, players(*), teams(*)')
        .eq('player_id', playerId)
        .then((value) {
      return (value as List)
          .map((e) => PlayerTeamModel.fromMap(e as Map<String, dynamic>))
          .toList();
    }).catchError((error) {
      throw Exception('Error getting player teams: $error');
    });
  }
}
