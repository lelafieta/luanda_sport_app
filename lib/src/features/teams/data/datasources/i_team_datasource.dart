import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/features/teams/data/models/tactical_formation_model.dart';

import '../models/team_model.dart';

abstract class ITeamRemoteDataSource {
  Future<Unit> createTeam(TeamModel team);
  Future<List<TeamModel>> getTeams();
  Future<List<TeamModel>> getMyTeams();
  Future<TacticalFormationModel?> getTeamTacticalFormation(String teamId);
  Future<TeamModel?> getTeamById(String id);
  Future<Unit> updateTeam(TeamModel team);
  Future<Unit> updateTeamSquad(
      String gameType, String formation, String teamId);
  Future<Unit> deleteTeam(String id);
}
