import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luanda_sport_app/src/features/players/domain/usecases/get_player_by_id_usecase.dart';

import '../../../domain/entities/player_entity.dart';

part 'get_my_player_data_state.dart';

class GetMyPlayerDataCubit extends Cubit<GetMyPlayerDataState> {
  final GetPlayerByIdUseCase getPlayerByIdUseCase;
  GetMyPlayerDataCubit({required this.getPlayerByIdUseCase})
      : super(GetMyPlayerDataInitial());

  Future<void> fetchPlayerData(String userId) async {
    emit(GetMyPlayerDataLoading());

    final result = await getPlayerByIdUseCase.call(userId);

    result.fold(
        (failure) => emit(GetMyPlayerDataFailure(error: failure.message)),
        (player) => emit(GetMyPlayerDataLoaded(player: player)));
  }
}
