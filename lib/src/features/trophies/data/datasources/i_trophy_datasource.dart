import 'package:dartz/dartz.dart';
import '../models/trophy_model.dart';

abstract class ITrophyRemoteDataSource {
  Future<List<TrophyModel>> getTrophies({String? competitionId});
  Future<TrophyModel?> getTrophyById(String id);
  Future<Unit> createTrophy(TrophyModel trophy);
  Future<Unit> updateTrophy(TrophyModel trophy);
  Future<Unit> deleteTrophy(String id);
  Future<List<TrophyModel>> getTrophiesByTeam(String teamId);
}
