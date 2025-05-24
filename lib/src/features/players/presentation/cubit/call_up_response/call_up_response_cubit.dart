import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'call_up_response_state.dart';

class CallUpResponseCubit extends Cubit<CallUpResponseState> {
  CallUpResponseCubit() : super(CallUpResponseInitial());
}
