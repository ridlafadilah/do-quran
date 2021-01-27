part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class CameraInitializedEvent extends CameraEvent {
  const CameraInitializedEvent();
}

class CameraStoppedEvent extends CameraEvent {
  const CameraStoppedEvent();
}

class CameraCapturedEvent extends CameraEvent {
  const CameraCapturedEvent();
}

class CameraFlippedEvent extends CameraEvent {
  const CameraFlippedEvent();
}

class CameraProfileUploadedEvent extends CameraEvent {
  const CameraProfileUploadedEvent({this.path});

  final String path;

  @override
  List<Object> get props => [path];
}

class CameraCanceledEvent extends CameraEvent {
  const CameraCanceledEvent({this.path});

  final String path;

  @override
  List<Object> get props => [path];
}

class CameraDeletedEvent extends CameraEvent {
  const CameraDeletedEvent({this.path});

  final String path;

  @override
  List<Object> get props => [path];
}
