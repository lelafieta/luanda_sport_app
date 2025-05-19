import '../../../players/data/models/player_model.dart';

import '../models/starting_lineup_player_model.dart';

abstract class IStartingLineupPlayerRemoteDataSource {
  Future<List<StartingLineupPlayersModel>> getTeamStartingLineupPlayers(
      String teamId);

  Future<List<StartingLineupPlayersModel>> createStartingLineupPlayer(
      StartingLineupPlayersModel startingLineupPlayer);

  Future<List<StartingLineupPlayersModel>> removeStartingLineupPlayer(
      PlayerModel player);
  Future<List<StartingLineupPlayersModel>> deleteStartingLineupTeam(
      String teamId);
}
