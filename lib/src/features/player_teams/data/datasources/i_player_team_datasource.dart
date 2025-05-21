import 'package:dartz/dartz.dart';
import '../../domain/params/create_player_team_params.dart';
import '../models/player_team_model.dart';

abstract class IPlayerTeamRemoteDataSource {
  Future<Unit> createPlayerTeam(CreatePlayerTeamParams playerTeam);
  Future<List<PlayerTeamModel>> getPlayerTeams(String playerId);
}
