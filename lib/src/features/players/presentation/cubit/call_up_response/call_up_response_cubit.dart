import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/entities/call_up_entity.dart';
import '../../../../call_ups/domain/params/update_call_up_status_params.dart';
import '../../../../call_ups/domain/usecases/update_call_up_status_usecase.dart';
part 'call_up_response_state.dart';

class CallUpResponseCubit extends Cubit<CallUpResponseState> {
  final UpdateCallUpStatusUseCase updateCallUpStatusUseCase;
  CallUpResponseCubit({
    required this.updateCallUpStatusUseCase,
  }) : super(CallUpResponseInitial());

  Future<void> callUpUpdateStatus(UpdateCallUpStatusParams params) async {
    emit(CallUpResponseLoading());
    final result = await updateCallUpStatusUseCase(params);

    result.fold(
        (failure) => emit(CallUpResponseFailure(error: failure.message)),
        (callUp) => emit(CallUpResponseUpdated(callUp: callUp)));
  }
}
