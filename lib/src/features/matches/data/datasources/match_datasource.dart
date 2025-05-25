import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../players/data/models/player_model.dart';
import '../models/match_event_model.dart';
import '../models/match_model.dart';
import '../models/match_stats_model.dart';
import 'i_match_datasource.dart';

class MatchRemoteDataSource implements IMatchRemoteDataSource {
  final SupabaseClient client;

  MatchRemoteDataSource({required this.client});

  @override
  Future<MatchModel> createMatch(MatchModel match) async {
    final res =
        await client.from('matches').insert(match.toMap()).select().single();
    return MatchModel.fromMap(res);
  }

  @override
  Future<MatchModel> updateMatch(MatchModel match) async {
    final res = await client
        .from('matches')
        .update(match.toMap())
        .eq('id', match.id!)
        .select()
        .single();
    return MatchModel.fromMap(res);
  }

  @override
  Future<void> deleteMatch(String matchId) async {
    await client.from('matches').delete().eq('id', matchId);
  }

  @override
  Future<void> setMatchScore(
      String matchId, Map<String, dynamic> scoreData) async {
    await client.from('matches').update(scoreData).eq('id', matchId);
  }

  @override
  Future<void> assignPlayersToMatch(
      String matchId, List<String> playerIds) async {
    // Supondo que você tenha uma tabela "match_players" que relaciona jogadores e partidas
    // Vamos inserir os pares (matchId, playerId)
    final inserts = playerIds
        .map((playerId) => {
              'match_id': matchId,
              'player_id': playerId,
            })
        .toList();

    await client.from('match_players').insert(inserts);
  }

  @override
  Future<List<MatchModel>> getAllMatches() async {
    final res = await client.from('matches').select('''
          *,
          home_team:teams(*),
          away_team:teams(*),
          match_players:match_players(*, player:players(*)),
          match_events:match_events(*),
          match_stats:match_stats(*)
        ''');
    return (res as List).map((e) => MatchModel.fromMap(e)).toList();
  }

  @override
  Future<List<MatchModel>> getUpcomingMatches() async {
    final res = await client.from('matches').select('''
          *,
          home_team:teams(*),
          away_team:teams(*)
        ''').gt('date', DateTime.now().toIso8601String());
    return (res as List).map((e) => MatchModel.fromMap(e)).toList();
  }

  @override
  Future<List<MatchModel>> getLatestMatches() async {
    final res = await client.from('matches').select('''
          *,
          home_team:teams(*),
          away_team:teams(*)
        ''').lt('date', DateTime.now().toIso8601String());
    return (res as List).map((e) => MatchModel.fromMap(e)).toList();
  }

  @override
  Future<MatchModel> getMatchById(String matchId) async {
    final res = await client.from('matches').select('''
          *,
          home_team:teams(*),
          away_team:teams(*),
          match_players:match_players(*, player:players(*)),
          match_events:match_events(*),
          match_stats:match_stats(*)
        ''').eq('id', matchId).single();
    return MatchModel.fromMap(res);
  }

  @override
  Future<List<MatchModel>> getMatchesByTeam(String teamId) async {
    final res = await client.from('matches').select('''
          *,
          home_team:teams(*),
          away_team:teams(*)
        ''').or('home_team_id.eq.$teamId,away_team_id.eq.$teamId');
    return (res as List).map((e) => MatchModel.fromMap(e)).toList();
  }

  @override
  Future<List<MatchModel>> getMatchesByPlayer(String playerId) async {
    final res = await client.from('match_players').select('''
          match:matches(*,
            home_team:teams(*),
            away_team:teams(*)
          )
        ''').eq('player_id', playerId);

    // A resposta traz a lista de 'match' aninhados
    return (res as List)
        .map((e) => MatchModel.fromMap(e['match'] as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<MatchModel>> searchMatches(Map<String, dynamic> filters) async {
    // Exemplo simples de filtro dinâmico - adapte conforme a necessidade
    var query = client.from('matches').select('''
      *,
      home_team:teams(*),
      away_team:teams(*)
    ''');

    if (filters.containsKey('teamId')) {
      final teamId = filters['teamId'];
      query = query.or('home_team_id.eq.$teamId,away_team_id.eq.$teamId');
    }

    if (filters.containsKey('dateFrom')) {
      query = query.gte(
          'date', (filters['dateFrom'] as DateTime).toIso8601String());
    }
    if (filters.containsKey('dateTo')) {
      query =
          query.lte('date', (filters['dateTo'] as DateTime).toIso8601String());
    }

    final res = await query;

    return (res as List).map((e) => MatchModel.fromMap(e)).toList();
  }

  @override
  Future<MatchStatsModel> getMatchStats(String matchId) async {
    final res = await client
        .from('match_stats')
        .select('*')
        .eq('match_id', matchId)
        .single();
    return MatchStatsModel.fromMap(res);
  }

  @override
  Future<List<PlayerModel>> getTopScorersInMatch(String matchId) async {
    final res = await client
        .from('match_players')
        .select('player:players(*)')
        .eq('match_id', matchId)
        .order('goals', ascending: false);
    return (res as List).map((e) => PlayerModel.fromMap(e['player'])).toList();
  }

  @override
  Future<List<MatchEventModel>> getMatchEvents(String matchId) async {
    final res =
        await client.from('match_events').select('*').eq('match_id', matchId);
    return (res as List).map((e) => MatchEventModel.fromMap(e)).toList();
  }

  @override
  Future<String> generateMatchReport(String matchId) async {
    // Aqui seria a implementação do backend ou função para gerar o PDF / relatório
    // Vamos simular um retorno com a URL do relatório
    return 'https://example.com/reports/match_$matchId.pdf';
  }
}
