import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:do_core/core.dart';
import 'package:do_core/utils/camera_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc({
    @required this.cameraUtils,
    this.authService,
    this.resolutionPreset = ResolutionPreset.high,
  }) : super(CameraInitial());

  final CameraUtils cameraUtils;
  final AuthService authService;
  final ResolutionPreset resolutionPreset;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;

  CameraController _controller;
  CameraController getController() => _controller;

  bool isInitialized() => _controller.value.isInitialized ?? false;

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is CameraInitializedEvent) {
      yield* _mapCameraInitializedToState(event);
    } else if (event is CameraCapturedEvent) {
      yield* _mapCameraCapturedToState(event);
    } else if (event is CameraFlippedEvent) {
      yield* _mapCameraFlippedToState(event);
    } else if (event is CameraProfileUploadedEvent) {
      yield* _mapCameraProfileUploadedToState(event);
    } else if (event is CameraCanceledEvent) {
      yield* _mapCameraCanceledToState(event);
    } else if (event is CameraDeletedEvent) {
      yield* _mapCameraDeletedToState(event);
    } else if (event is CameraStoppedEvent) {
      yield* _mapCameraStoppedToState(event);
    }
  }

  Stream<CameraState> _mapCameraInitializedToState(
      CameraInitializedEvent event) async* {
    try {
      _controller = await cameraUtils.getCameraController(
          resolutionPreset, cameraLensDirection);
      await _controller.initialize();
      yield CameraReady();
    } on CameraException catch (error) {
      await _controller?.dispose();
      yield CameraFailure(error: error.description);
    } catch (error) {
      yield CameraFailure(error: error.toString());
    }
  }

  Stream<CameraState> _mapCameraCapturedToState(
      CameraCapturedEvent event) async* {
    if (state is CameraReady) {
      yield CameraCaptureInProgress();
      try {
        final path = await cameraUtils.getPath();
        await _controller.takePicture(path);
        yield CameraCaptureSuccess(path: path);
      } on CameraException catch (error) {
        yield CameraCaptureFailure(error: error.description);
      }
    }
  }

  Stream<CameraState> _mapCameraFlippedToState(
      CameraFlippedEvent event) async* {
    if (state is CameraReady) {
      await _controller?.dispose();
      yield CameraCaptureInProgress();
      try {
        if (cameraLensDirection == CameraLensDirection.front) {
          cameraLensDirection = CameraLensDirection.back;
        } else {
          cameraLensDirection = CameraLensDirection.front;
        }
        _controller = await cameraUtils.getCameraController(
            resolutionPreset, cameraLensDirection);
        await _controller.initialize();
        yield CameraReady();
      } on CameraException catch (error) {
        await _controller?.dispose();
        yield CameraFailure(error: error.description);
      } catch (error) {
        yield CameraFailure(error: error.toString());
      }
    }
  }

  Stream<CameraState> _mapCameraProfileUploadedToState(
      CameraProfileUploadedEvent event) async* {
    if (state is CameraCaptureSuccess) {
      yield CameraUploadInProgress();
      try {
        ProfileService profileService =
            ProfileService(authService: authService);
        await profileService.putPhotoProfile(File(event.path));
        cameraUtils.deleteFile(event.path);
        await _controller?.dispose();
        yield CameraUploadSuccess(path: event.path);
      } on CameraException catch (error) {
        yield CameraUploadFailure(error: error.description);
      }
    }
  }

  Stream<CameraState> _mapCameraCanceledToState(
      CameraCanceledEvent event) async* {
    if (state is CameraCaptureSuccess) {
      try {
        cameraUtils.deleteFile(event.path);
        yield CameraReady();
      } on CameraException catch (error) {
        await _controller?.dispose();
        yield CameraFailure(error: error.description);
      } catch (error) {
        yield CameraFailure(error: error.toString());
      }
    }
  }

  Stream<CameraState> _mapCameraDeletedToState(
      CameraDeletedEvent event) async* {
    if (state is CameraCaptureSuccess) {
      cameraUtils.deleteFile(event.path);
      await _controller?.dispose();
      yield CameraInitial();
    }
  }

  Stream<CameraState> _mapCameraStoppedToState(
      CameraStoppedEvent event) async* {
    await _controller?.dispose();
    yield CameraInitial();
  }
}
