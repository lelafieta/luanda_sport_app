import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'training_session_state.dart';

class TrainingSessionCubit extends Cubit<TrainingSessionState> {
  TrainingSessionCubit() : super(TrainingSessionInitial());
}
