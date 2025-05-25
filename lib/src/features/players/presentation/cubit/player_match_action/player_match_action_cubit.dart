import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_match_action_state.dart';

class PlayerMatchActionCubit extends Cubit<PlayerMatchActionState> {
  PlayerMatchActionCubit() : super(PlayerMatchActionInitial());
}
