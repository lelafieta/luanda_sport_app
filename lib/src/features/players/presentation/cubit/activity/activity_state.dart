part of 'activity_cubit.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final List<ActivityEntity> activities;

  const ActivityLoaded(this.activities);

  @override
  List<Object> get props => [activities];
}

class ActivityFailure extends ActivityState {
  final String error;

  const ActivityFailure({required this.error});

  @override
  List<Object> get props => [error];
}
