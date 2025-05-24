part of 'call_up_response_cubit.dart';

sealed class CallUpResponseState extends Equatable {
  const CallUpResponseState();

  @override
  List<Object> get props => [];
}

final class CallUpResponseInitial extends CallUpResponseState {}

final class CallUpResponseLoading extends CallUpResponseState {}

final class CallUpResponseSuccess extends CallUpResponseState {
  const CallUpResponseSuccess();

  @override
  List<Object> get props => [];
}

final class CallUpResponseFailure extends CallUpResponseState {
  final String error;

  const CallUpResponseFailure({required this.error});

  @override
  List<Object> get props => [error];
}
