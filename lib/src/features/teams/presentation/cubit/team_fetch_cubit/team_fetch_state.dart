part of 'team_fetch_cubit.dart';

sealed class TeamFetchState extends Equatable {
  const TeamFetchState();

  @override
  List<Object> get props => [];
}

final class TeamFetchInitial extends TeamFetchState {}

final class TeamFetchLoading extends TeamFetchState {}

final class TeamFetchLoaded extends TeamFetchState {
  final List<TeamEntity> teams;

  const TeamFetchLoaded({required this.teams});

  @override
  List<Object> get props => [teams];
}

final class TeamFetchFailure extends TeamFetchState {
  final String error;

  const TeamFetchFailure({required this.error});

  @override
  List<Object> get props => [error];
}
