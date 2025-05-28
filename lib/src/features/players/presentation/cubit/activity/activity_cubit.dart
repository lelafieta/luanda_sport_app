import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  // final TrainingSessionCubit trainingSessionCubit;
  // final
  ActivityCubit() : super(ActivityInitial());
}
