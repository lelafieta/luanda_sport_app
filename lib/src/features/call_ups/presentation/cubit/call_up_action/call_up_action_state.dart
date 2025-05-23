part of 'call_up_action_cubit.dart';

sealed class CallUpActionState extends Equatable {
  const CallUpActionState();

  @override
  List<Object> get props => [];
}

final class CallUpActionInitial extends CallUpActionState {}

final class CallUpActionLoading extends CallUpActionState {}

final class CallUpActionSuccess extends CallUpActionState {}

final class CallUpActionFailure extends CallUpActionState {
  final String error;

  const CallUpActionFailure({required this.error});

  List<Object> get props => [error];
}
