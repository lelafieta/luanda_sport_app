import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_call_up_state.dart';

class PlayerCallUpCubit extends Cubit<PlayerCallUpState> {
  PlayerCallUpCubit() : super(PlayerCallUpInitial());
}
