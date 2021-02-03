import 'package:do_core/core.dart';
import 'package:do_quran/patch/patcher.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patch_event.dart';
part 'patch_state.dart';

class PatchBloc extends Bloc<PatchEvent, PatchState> {
  PatchBloc() : super(InitialState());

  @override
  Stream<PatchState> mapEventToState(PatchEvent event) async* {
    if (event is ModulePatchEvent) {
      yield PatchInProgressState();
      try {
        for (CommonModulePatch patch in Patcher.listPatches) {
          try {
            bool isPatched = await patch.doCheck();
            if (!isPatched) {
              yield RequestInProgressState(status: patch.description);
              await patch.doProcess();
            }
            yield RequestSuccessState();
          } catch (e) {
            yield RequestFailureState(error: e.toString());
          }
        }
        yield PatchSuccessState();
      } catch (e) {
        yield PatchFailureState(error: e.toString());
      }
    }
  }
}
