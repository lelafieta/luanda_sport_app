part of 'team_action_cubit.dart';

sealed class TeamActionState extends Equatable {
  const TeamActionState();

  @override
  List<Object> get props => [];
}

final class TeamActionInitial extends TeamActionState {}

final class TeamActionLoading extends TeamActionState {}

final class TeamActionSuccess extends TeamActionState {
  final String message;

  const TeamActionSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class TeamActionFailure extends TeamActionState {
  final String error;

  const TeamActionFailure({required this.error});

  @override
  List<Object> get props => [error];
}
