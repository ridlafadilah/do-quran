import 'dart:io';

import 'package:camera/camera.dart';
import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_quran/keys/camera_keys.dart';
import 'package:do_quran/widgets/camera_app_bar.dart';
import 'package:do_quran/widgets/error_camera_widget.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key key, @required this.header}) : super(key: key);

  final String header;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<CameraBloc>(context);

    // App state changed before we got the chance to initialize.
    if (!bloc.isInitialized()) return;

    if (state == AppLifecycleState.inactive)
      bloc.add(const CameraStoppedEvent());
    else if (state == AppLifecycleState.resumed)
      bloc.add(const CameraInitializedEvent());
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<CameraBloc, CameraState>(
        listener: (context, state) {
          if (state is CameraUploadSuccess) {
            Navigator.of(context).pop(true);
            Navigator.of(context).pop(state.path);
          } else if (state is CameraUploadInProgress) {
            _loading(context);
          } else if (state is CameraUploadFailure) {
            Flushbar(
              messageText: Text(
                state.error,
                style: const TextStyle(color: Colors.white),
              ),
              icon: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/alert-triangle-outline.svg',
                  color: AppTheme.lightColor),
              duration: const Duration(seconds: 3),
              backgroundColor: AppTheme.lightDanger,
              isDismissible: false,
              dismissDirection: FlushbarDismissDirection.VERTICAL,
            )..show(context);
          } else if (state is CameraCaptureFailure) {
            Flushbar(
              messageText: Text(
                state.error,
                style: const TextStyle(color: Colors.white),
              ),
              icon: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/alert-triangle-outline.svg',
                  color: AppTheme.lightColor),
              duration: const Duration(seconds: 3),
              backgroundColor: AppTheme.lightDanger,
              isDismissible: false,
              dismissDirection: FlushbarDismissDirection.VERTICAL,
            )..show(context);
          }
        },
        builder: (context, state) {
          if (state is CameraCaptureSuccess) {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Scaffold(
                key: globalKey,
                backgroundColor: Colors.transparent,
                extendBodyBehindAppBar: true,
                appBar: appBar(state),
                body: Center(child: Image.file(File(state.path))),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton(
                          heroTag: 'btnUpload',
                          backgroundColor: Theme.of(context)
                              .floatingActionButtonTheme
                              .foregroundColor,
                          child: SvgPicture.asset(
                              'assets/eva_icons/fill/svg/upload.svg',
                              color: Theme.of(context).iconTheme.color),
                          onPressed: () {
                            BlocProvider.of<CameraBloc>(context).add(
                                CameraProfileUploadedEvent(path: state.path));
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          heroTag: 'btnCancel',
                          backgroundColor: Theme.of(context)
                              .floatingActionButtonTheme
                              .foregroundColor,
                          mini: true,
                          child: SvgPicture.asset(
                            'assets/eva_icons/fill/svg/close.svg',
                            color: AppTheme.danger,
                            height: 20.0,
                          ),
                          onPressed: () {
                            BlocProvider.of<CameraBloc>(context)
                                .add(CameraCanceledEvent(path: state.path));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              ),
            );
          } else {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Scaffold(
                key: globalKey,
                backgroundColor: Colors.transparent,
                extendBodyBehindAppBar: true,
                appBar: appBar(state),
                body: state is CameraReady
                    ? Container(
                        key: CameraKeys.cameraPreviewScreen,
                        child: CameraPreview(
                            BlocProvider.of<CameraBloc>(context)
                                .getController()))
                    : state is CameraFailure
                        ? ErrorCameraWidget(
                            key: CameraKeys.errorCameraScreen,
                            message: state.error)
                        : Container(
                            key: CameraKeys.emptyContainerScreen,
                          ),
                floatingActionButton: state is CameraReady
                    ? Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: FloatingActionButton(
                                heroTag: 'btnCapture',
                                backgroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .foregroundColor,
                                shape: const CircleBorder(
                                    side: BorderSide(
                                        color: AppTheme.darkGrey, width: 3.5)),
                                child: SvgPicture.asset(
                                  'assets/eva_icons/fill/svg/camera.svg',
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                onPressed: () =>
                                    BlocProvider.of<CameraBloc>(context)
                                        .add(const CameraCapturedEvent()),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: FloatingActionButton(
                                heroTag: 'btnFlip',
                                backgroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .foregroundColor,
                                mini: true,
                                child: SvgPicture.asset(
                                  'assets/eva_icons/fill/svg/flip-2.svg',
                                  color: Theme.of(context).iconTheme.color,
                                  height: 20.0,
                                ),
                                onPressed: () {
                                  BlocProvider.of<CameraBloc>(context)
                                      .add(const CameraFlippedEvent());
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              ),
            );
          }
        },
      );

  void _loading(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0)),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget appBar(CameraState state) {
    return CameraAppBar(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 40,
          width: 40,
          child: InkWell(
            highlightColor: AppTheme.darkBlueGrey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            onTap: () {
              if (state is CameraCaptureSuccess) {
                BlocProvider.of<CameraBloc>(context)
                    .add(CameraDeletedEvent(path: state.path));
                Navigator.of(context).pop(true);
              } else {
                Navigator.of(context).pop(true);
              }
            },
            child: Center(
              child: SvgPicture.asset(
                'assets/eva_icons/outline/svg/arrow-back-outline.svg',
                color: Theme.of(context).appBarTheme.iconTheme.color,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.header,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22 + 6 - 6 * 0.0,
              color: Theme.of(context).appBarTheme.titleTextStyle.color,
              fontFamily:
                  Theme.of(context).appBarTheme.titleTextStyle.fontFamily,
              fontWeight:
                  Theme.of(context).appBarTheme.titleTextStyle.fontWeight,
              letterSpacing:
                  Theme.of(context).appBarTheme.titleTextStyle.letterSpacing,
            ),
          ),
        ),
      ),
    ]);
  }
}
