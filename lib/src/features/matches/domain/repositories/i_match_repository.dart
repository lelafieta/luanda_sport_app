import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../players/domain/entities/player_entity.dart';
import '../entities/match_entity.dart';
import '../entities/match_event_entity.dart';
import '../entities/match_stats_entity.dart';
import '../params/assign_players_to_match_params.dart';
import '../params/get_matches_by_player_team_params.dart';
import '../params/set_match_score_params.dart';

abstract class IMatchRepository {
  // 🧩 Criação & Edição de Partidas
  Future<Either<Failure, Unit>> createMatch(MatchEntity match);
  Future<Either<Failure, Unit>> updateMatch(MatchEntity match);
  Future<Either<Failure, Unit>> deleteMatch(String matchId);
  Future<Either<Failure, Unit>> setMatchScore(SetMatchScoreParams params);
  Future<Either<Failure, Unit>> assignPlayersToMatch(
      AssignPlayersToMatchParams params);

  // 🔎 Consulta de Partidas
  Future<Either<Failure, List<MatchEntity>>> getAllMatches();
  Future<Either<Failure, List<MatchEntity>>> getUpcomingMatches();
  Future<Either<Failure, List<MatchEntity>>> getLatestMatches();
  Future<Either<Failure, MatchEntity?>> getMatchById(String matchId);
  Future<Either<Failure, List<MatchEntity>>> getMatchesByTeam(String teamId);
  Future<Either<Failure, List<MatchEntity>>> getMatchesByPlayer(
      String playerId);
  Future<Either<Failure, List<MatchEntity>>> getMatchesByPlayerTeam(
      GetMatchesByPlayerTeamParams params);
  Future<Either<Failure, List<MatchEntity>>> searchMatches(
      Map<String, dynamic> filters);

  Future<Either<Failure, List<MatchEntity>>> getUpcomingMatchesByPlayer(
      String playerId);

  // 📊 Resultados e Estatísticas
  Future<Either<Failure, MatchStatsEntity?>> getMatchStats(String matchId);
  Future<Either<Failure, List<PlayerEntity>>> getTopScorersInMatch(
      String matchId);
  Future<Either<Failure, List<MatchEventEntity>>> getMatchEvents(
      String matchId);
  Future<Either<Failure, String>> generateMatchReport(String matchId);
}
