import 'package:flutter/material.dart';

class ErrorCameraWidget extends StatelessWidget {
  const ErrorCameraWidget({Key key, this.message = 'Camera Error'})
      : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Icon(Icons.error), Container(child: Text(message))]),
    );
  }
}
