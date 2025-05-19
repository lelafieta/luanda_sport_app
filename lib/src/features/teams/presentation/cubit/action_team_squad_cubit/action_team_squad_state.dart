part of 'action_team_squad_cubit.dart';

sealed class ActionTeamSquadState extends Equatable {
  const ActionTeamSquadState();

  @override
  List<Object> get props => [];
}

final class ActionTeamSquadInitial extends ActionTeamSquadState {}

final class ActionTeamSquadLoading extends ActionTeamSquadState {}

final class ActionTeamSquadSuccess extends ActionTeamSquadState {
  final String message;

  const ActionTeamSquadSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class ActionTeamSquadFailure extends ActionTeamSquadState {
  final String error;

  const ActionTeamSquadFailure({required this.error});

  @override
  List<Object> get props => [error];
}
