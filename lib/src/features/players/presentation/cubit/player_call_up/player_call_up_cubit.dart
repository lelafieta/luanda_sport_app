import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/entities/call_up_entity.dart';

import '../../../../call_ups/domain/usecases/get_call_ups_by_player_usecase.dart';
part 'player_call_up_state.dart';

class PlayerCallUpCubit extends Cubit<PlayerCallUpState> {
  final GetCallUpsByPlayerUseCase getCallUpsByPlayerUseCase;
  PlayerCallUpCubit({required this.getCallUpsByPlayerUseCase})
      : super(PlayerCallUpInitial());

  Future<void> getCallUpsByPlayer(String playerId) async {
    emit(PlayerCallUpLoading());
    final result = await getCallUpsByPlayerUseCase(playerId);

    result.fold(
      (failure) => emit(PlayerCallUpError(error: failure.message)),
      (callUps) => emit(PlayerCallUpLoaded(callUps: callUps)),
    );
  }
}
