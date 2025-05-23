part of 'call_up_cubit.dart';

sealed class CallUpState extends Equatable {
  const CallUpState();

  @override
  List<Object> get props => [];
}

final class CallUpInitial extends CallUpState {}

final class CallUpLoading extends CallUpState {}

final class CallUpLoaded extends CallUpState {
  final List<CallUpEntity> callUps;

  const CallUpLoaded({required this.callUps});

  @override
  List<Object> get props => [callUps];
}

final class CallUpFailure extends CallUpState {
  final String error;

  const CallUpFailure({required this.error});

  @override
  List<Object> get props => [error];
}
