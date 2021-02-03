part of 'patch_bloc.dart';

abstract class PatchEvent extends Equatable {
  const PatchEvent();

  @override
  List<Object> get props => [];
}

class ModulePatchEvent extends PatchEvent {
  const ModulePatchEvent();
}

class PatchedEvent extends PatchEvent {
  const PatchedEvent();
}
