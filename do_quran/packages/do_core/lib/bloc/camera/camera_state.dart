part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {}

class CameraCaptureInProgress extends CameraState {}

class CameraCaptureSuccess extends CameraState {
  const CameraCaptureSuccess({this.path});

  final String path;

  @override
  List<String> get props => [path];
}

class CameraUploadInProgress extends CameraState {}

class CameraUploadSuccess extends CameraState {
  const CameraUploadSuccess({this.path});

  final String path;

  @override
  List<String> get props => [path];
}

class CameraFlipDone extends CameraState {
  const CameraFlipDone({this.direction});

  final String direction;

  @override
  List<String> get props => [direction];
}

class CameraFailure extends CameraState {
  const CameraFailure({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Camera Failure { error: $error }';
}

class CameraCaptureFailure extends CameraState {
  const CameraCaptureFailure({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Camera Capture Failure { error: $error }';
}

class CameraUploadFailure extends CameraState {
  const CameraUploadFailure({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Camera Upload Failure { error: $error }';
}
