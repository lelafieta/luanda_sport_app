import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../players/domain/entities/player_entity.dart';
import '../entities/match_entity.dart';
import '../entities/match_event_entity.dart';
import '../entities/match_stats_entity.dart';

abstract class IMatchRepository {
  // 🧩 Criação & Edição de Partidas
  Future<Either<Failure, Unit>> createMatch(MatchEntity match);
  Future<Either<Failure, Unit>> updateMatch(MatchEntity match);
  Future<Either<Failure, Unit>> deleteMatch(String matchId);
  Future<Either<Failure, Unit>> setMatchScore(
      String matchId, Map<String, dynamic> scoreData);
  Future<Either<Failure, Unit>> assignPlayersToMatch(
      String matchId, List<String> players);

  // 🔎 Consulta de Partidas
  Future<Either<Failure, List<MatchEntity>>> getAllMatches();
  Future<Either<Failure, List<MatchEntity>>> getUpcomingMatches();
  Future<Either<Failure, List<MatchEntity>>> getLatestMatches();
  Future<Either<Failure, MatchEntity>> getMatchById(String matchId);
  Future<Either<Failure, List<MatchEntity>>> getMatchesByTeam(String teamId);
  Future<Either<Failure, List<MatchEntity>>> getMatchesByPlayer(
      String playerId);
  Future<Either<Failure, List<MatchEntity>>> searchMatches(
      Map<String, dynamic> filters);

  // 📊 Resultados e Estatísticas
  Future<Either<Failure, MatchStatsEntity>> getMatchStats(String matchId);
  Future<Either<Failure, List<PlayerEntity>>> getTopScorersInMatch(
      String matchId);
  Future<Either<Failure, List<MatchEventEntity>>> getMatchEvents(
      String matchId);
  Future<Either<Failure, String>> generateMatchReport(String matchId);
}
