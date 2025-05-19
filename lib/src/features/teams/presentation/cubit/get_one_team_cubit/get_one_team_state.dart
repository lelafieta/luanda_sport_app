part of 'get_one_team_cubit.dart';

sealed class GetOneTeamState extends Equatable {
  const GetOneTeamState();

  @override
  List<Object> get props => [];
}

final class GetOneTeamInitial extends GetOneTeamState {}

final class GetOneTeamLoading extends GetOneTeamState {}

final class GetOneTeamLoaded extends GetOneTeamState {
  final TeamEntity? team;

  const GetOneTeamLoaded({required this.team});

  @override
  List<Object> get props => [team!];
}

final class GetOneTeamFailure extends GetOneTeamState {
  final String error;

  const GetOneTeamFailure({required this.error});

  @override
  List<Object> get props => [error];
}
