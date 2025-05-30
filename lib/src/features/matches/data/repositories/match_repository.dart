import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/features/matches/domain/params/get_matches_by_player_team_params.dart';
import '../../../../core/error/failure.dart';
import '../../../players/domain/entities/player_entity.dart';
import '../../domain/entities/match_entity.dart';
import '../../domain/entities/match_event_entity.dart';
import '../../domain/entities/match_stats_entity.dart';
import '../../domain/params/assign_players_to_match_params.dart';
import '../../domain/params/set_match_score_params.dart';
import '../../domain/repositories/i_match_repository.dart';
import '../datasources/i_match_datasource.dart';
import '../models/match_model.dart';

class MatchRepository implements IMatchRepository {
  final IMatchRemoteDataSource matchDataSource;

  MatchRepository({required this.matchDataSource});

  @override
  Future<Either<Failure, Unit>> createMatch(MatchEntity match) async {
    try {
      final matchModel = MatchModel.fromEntity(match);
      await matchDataSource.createMatch(matchModel);
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateMatch(MatchEntity match) async {
    try {
      final matchModel = MatchModel.fromEntity(match);
      await matchDataSource.updateMatch(matchModel);
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMatch(String matchId) async {
    try {
      await matchDataSource.deleteMatch(matchId);
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setMatchScore(
      SetMatchScoreParams params) async {
    try {
      await matchDataSource.setMatchScore(params);
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> assignPlayersToMatch(
      AssignPlayersToMatchParams params) async {
    try {
      await matchDataSource.assignPlayersToMatch(
          params.matchId, params.playerIds);
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MatchEntity>>> getAllMatches() async {
    try {
      final result = await matchDataSource.getAllMatches();
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MatchEntity>>> getUpcomingMatches() async {
    try {
      final result = await matchDataSource.getUpcomingMatches();
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MatchEntity>>> getLatestMatches() async {
    try {
      final result = await matchDataSource.getLatestMatches();
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MatchEntity?>> getMatchById(String matchId) async {
    try {
      final result = await matchDataSource.getMatchById(matchId);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MatchEntity>>> getMatchesByTeam(
      String teamId) async {
    try {
      final result = await matchDataSource.getMatchesByTeam(teamId);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MatchEntity>>> getMatchesByPlayer(
      String playerId) async {
    try {
      final result = await matchDataSource.getMatchesByPlayer(playerId);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MatchEntity>>> searchMatches(
      Map<String, dynamic> filters) async {
    try {
      final result = await matchDataSource.searchMatches(filters);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MatchStatsEntity?>> getMatchStats(
      String matchId) async {
    try {
      final result = await matchDataSource.getMatchStats(matchId);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PlayerEntity>>> getTopScorersInMatch(
      String matchId) async {
    try {
      final result = await matchDataSource.getTopScorersInMatch(matchId);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MatchEventEntity>>> getMatchEvents(
      String matchId) async {
    try {
      final result = await matchDataSource.getMatchEvents(matchId);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> generateMatchReport(String matchId) async {
    try {
      final result = await matchDataSource.generateMatchReport(matchId);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MatchEntity>>> getUpcomingMatchesByPlayer(
      String playerId) async {
    try {
      final result = await matchDataSource.getUpcomingMatchesByPlayer(playerId);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MatchEntity>>> getMatchesByPlayerTeam(
      GetMatchesByPlayerTeamParams params) async {
    try {
      final result = await matchDataSource.getMatchesByPlayerTeam(
        params.playerId,
        params.teamId,
      );
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
