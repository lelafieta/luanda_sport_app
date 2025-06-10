import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/call_up_model.dart';
import 'i_call_up_datasource.dart';

class CallUpRemoteDataSource extends ICallUpRemoteDataSource {
  final SupabaseClient client;

  CallUpRemoteDataSource({required this.client});

  @override
  Future<Unit> cancelCallUp(String id) async {
    await client.from('call_ups').update({'is_cancelled': true}).eq('id', id);
    return unit;
  }

  @override
  Future<Unit> createCallUp(CallUpModel callUp) async {
    await client.from('call_ups').insert(callUp.toMap());
    return unit;
  }

  @override
  Future<Unit> deleteCallUp(String id) async {
    await client.from('call_ups').delete().eq('id', id);
    return unit;
  }

  @override
  Future<List<CallUpModel>> getCallUpsByCoach(String coachId) async {
    final response = await client
        .from('call_ups')
        .select('*,  coeches(*), players(*), competitions(*)')
        .eq('coach_id', coachId);

    return (response as List).map((json) => CallUpModel.fromMap(json)).toList();
  }

  @override
  Future<List<CallUpModel>> getCallUpsByPlayer(String playerId) async {
    final response = await client
        .from('call_ups')
        .select('*,  coaches(*), players(*), competitions(*), match:matches(*)')
        .eq('player_id', playerId);

    return (response as List).map((json) => CallUpModel.fromMap(json)).toList();
  }

  @override
  Future<CallUpModel> updateCallUpStatus(String id, String status) async {
    final response = await client
        .from('call_ups')
        .update({'status': status})
        .eq('id', id)
        .select('*, coaches(*), players(*), competitions(*), match:matches(*)')
        .single();

    return CallUpModel.fromMap(response);
  }

  @override
  Future<List<CallUpModel>> getCallUpsByPlayerPending(String playerId) async {
    final response = await client
        .from('call_ups')
        .select(''
            '*,  coach:coach_id(*), player:player_id(*),'
            ' competition:competition_id(*),'
            'match:match_id(*,'
            ' home_team:home_team_id(*), '
            ' away_team:away_team_id(*))'
            '')
        .eq('status', 'pending')
        .eq('player_id', playerId);

    return (response as List).map((json) => CallUpModel.fromMap(json)).toList();
  }
}
