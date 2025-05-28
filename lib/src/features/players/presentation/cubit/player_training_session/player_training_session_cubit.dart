import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_training_session_state.dart';

class PlayerTrainingSessionCubit extends Cubit<PlayerTrainingSessionState> {
  PlayerTrainingSessionCubit() : super(PlayerTrainingSessionInitial());
}
