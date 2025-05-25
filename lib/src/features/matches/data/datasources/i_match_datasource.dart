import '../../domain/params/set_match_score_params.dart';
import '../models/match_event_model.dart';
import '../models/match_model.dart';
import '../models/match_stats_model.dart';
import '../../../players/data/models/player_model.dart';

abstract class IMatchRemoteDataSource {
  // 🧩 Criação & Edição de Partidas
  Future<void> createMatch(MatchModel match);
  Future<void> updateMatch(MatchModel match);
  Future<void> deleteMatch(String matchId);
  Future<void> setMatchScore(SetMatchScoreParams params);
  Future<void> assignPlayersToMatch(String matchId, List<String> playerIds);

  // 🔎 Consulta de Partidas
  Future<List<MatchModel>> getAllMatches();
  Future<List<MatchModel>> getUpcomingMatches();
  Future<List<MatchModel>> getLatestMatches();
  Future<MatchModel?> getMatchById(String matchId);
  Future<List<MatchModel>> getMatchesByTeam(String teamId);
  Future<List<MatchModel>> getMatchesByPlayer(String playerId);
  Future<List<MatchModel>> searchMatches(Map<String, dynamic> filters);
  Future<List<MatchModel>> getUpcomingMatchesByPlayer(String playerId);

  // 📊 Resultados e Estatísticas
  Future<MatchStatsModel?> getMatchStats(String matchId);
  Future<List<PlayerModel>> getTopScorersInMatch(String matchId);
  Future<List<MatchEventModel>> getMatchEvents(String matchId);
  Future<String> generateMatchReport(String matchId);
}
