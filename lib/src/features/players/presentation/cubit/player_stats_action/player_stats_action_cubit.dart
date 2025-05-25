import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_stats_action_state.dart';

class PlayerStatsActionCubit extends Cubit<PlayerStatsActionState> {
  PlayerStatsActionCubit() : super(PlayerStatsActionInitial());
}
