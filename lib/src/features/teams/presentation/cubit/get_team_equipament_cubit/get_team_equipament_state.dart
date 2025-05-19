part of 'get_team_equipament_cubit.dart';

sealed class GetTeamEquipamentState extends Equatable {
  const GetTeamEquipamentState();

  @override
  List<Object> get props => [];
}

final class GetTeamEquipamentInitial extends GetTeamEquipamentState {}

final class GetTeamEquipamentLoading extends GetTeamEquipamentState {}

final class GetTeamEquipamentFailure extends GetTeamEquipamentState {
  final String error;

  const GetTeamEquipamentFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class GetTeamEquipamentLoaded extends GetTeamEquipamentState {
  final TeamEntity? team;

  const GetTeamEquipamentLoaded({required this.team});

  @override
  List<Object> get props => [team!];
}
