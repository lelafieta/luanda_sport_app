import '../models/squad_model.dart';

abstract class ISquadRemoteDataSource {
  Future<SquadModel> createSquad(SquadModel squad);
  Future<List<SquadModel>> getSquadsByTeam(String teamId);
  Future<SquadModel?> getSquadByGameTypeFormation(
      String gameType, String formation, String teamId);
}
