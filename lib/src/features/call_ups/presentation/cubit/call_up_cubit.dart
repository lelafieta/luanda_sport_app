import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/usecases/cancel_call_up_usecase.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/usecases/create_call_up_usecase.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/usecases/delete_call_up_usecase.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/usecases/get_call_ups_by_coach_usecase.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/usecases/get_call_ups_by_player_usecase.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/usecases/update_call_up_status_usecase.dart';

import '../../domain/entities/call_up_entity.dart';
import '../../domain/usecases/get_call_ups_by_player_pending_usecase.dart';

part 'call_up_state.dart';

class CallUpCubit extends Cubit<CallUpState> {
  final GetCallUpsByCoachUseCase getCallUpByCoachUseCase;
  final GetCallUpsByPlayerUseCase getCallUpByPlayerUseCase;
  final GetCallUpsByPlayerPendingUseCase getCallUpByPlayerPendingUseCase;

  CallUpCubit(
      {required this.getCallUpByCoachUseCase,
      required this.getCallUpByPlayerUseCase,
      required this.getCallUpByPlayerPendingUseCase})
      : super(CallUpInitial());

  Future<void> getCallUpByCoach(String coachId) async {
    emit(CallUpLoading());

    final result = await getCallUpByCoachUseCase(coachId);

    result.fold(
      (failure) => emit(CallUpFailure(error: failure.message)),
      (callUps) => emit(CallUpLoaded(callUps: callUps)),
    );
  }

  Future<void> getCallUpByPlayer(String playerId) async {
    emit(CallUpLoading());

    final result = await getCallUpByPlayerUseCase(playerId);

    result.fold(
      (failure) => emit(CallUpFailure(error: failure.message)),
      (callUps) => emit(CallUpLoaded(callUps: callUps)),
    );
  }

  Future<void> getCallUpByPlayerPending(String playerId) async {
    emit(CallUpLoading());

    final result = await getCallUpByPlayerPendingUseCase(playerId);

    result.fold(
      (failure) => emit(CallUpFailure(error: failure.message)),
      (callUps) => emit(CallUpLoaded(callUps: callUps)),
    );
  }
}
