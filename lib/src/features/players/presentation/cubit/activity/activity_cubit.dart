import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../call_ups/presentation/cubit/call_up_cubit.dart';
import '../../../../training_sessions/presentation/cubits/training_session/training_session_cubit.dart';
import '../player_match/player_match_cubit.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  // final PlayerTrainingSessionCubit trainingSessionCubit;
  // final PlayerCallUpCubit callUpCubit;
  // final PlayerMatchCubit playerMatchCubit;

  ActivityCubit() : super(ActivityInitial());
}
