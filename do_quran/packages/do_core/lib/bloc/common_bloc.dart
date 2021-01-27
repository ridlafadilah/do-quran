import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'common_event.dart';
part 'common_state.dart';

abstract class CommonBloc<X, Y, Z> extends Bloc<CommonEvent, CommonState> {
  CommonBloc(CommonState state) : super(state);

  @override
  Stream<CommonState> mapEventToState(CommonEvent event) async* {
    if (event is RequestedEvent) {
      yield RequestInProgressState();
      try {
        X data = await getData();
        yield RequestSuccessState<X>(data: data);
      } on ServerError catch (e) {
        yield RequestFailureState(error: e.getErrorMessage());
      }
    } else if (event is SubmittedEvent<Y>) {
      yield SubmitInProgressState();
      try {
        Z data = await putData(event.data);
        yield SubmitSuccessState<Z>(data: data);
      } on ServerError catch (e) {
        yield SubmitFailureState(error: e.getErrorMessage());
      }
    }
  }

  Future<X> getData();

  Future<Z> putData(Y data);
}
