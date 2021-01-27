import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogBottomSheet extends StatelessWidget {
  DialogBottomSheet(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.submit,
      this.onSubmit,
      this.height = 280.0,
      this.buttonColor = AppTheme.colorTheme,
      this.buttonDisabled = false,
      this.child})
      : super(key: key);

  final String title;
  final String subtitle;
  final String submit;
  final double height;
  final Color buttonColor;
  final bool buttonDisabled;
  final void Function() onSubmit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double sizeExitButton = 70.0;
    return Container(
      height: MediaQuery.of(context).viewInsets.bottom + height,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            height: sizeExitButton,
            width: sizeExitButton,
            padding: const EdgeInsets.only(bottom: 15),
            child: FloatingActionButton(
              backgroundColor:
                  Theme.of(context).bottomSheetTheme.backgroundColor,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              elevation: 0.0,
              highlightElevation: 0.0,
              child: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/close-outline.svg',
                  height: 35.0,
                  width: 35.0,
                  color: Theme.of(context).iconTheme.color),
            ),
          ),
          Container(
            height: height - sizeExitButton,
            color: Colors.transparent,
            child: Card(
              color: Theme.of(context).bottomSheetTheme.backgroundColor,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              borderOnForeground: true,
              elevation: 0,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 24,
                      left: 24,
                      bottom: 15,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      bottom: 20,
                    ),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        wordSpacing: 0.5,
                        height: 1.7,
                      ),
                    ),
                  ),
                  Container(
                    child: child,
                  ),
                  _buttonSubmitModal(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonSubmitModal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: ButtonTheme(
          minWidth: 400.0,
          height: 45.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(
                    color:
                        buttonDisabled ? AppTheme.buttonDisable : buttonColor,
                    width: 0.5)),
            color: buttonColor,
            disabledColor: AppTheme.buttonDisable,
            elevation: 1.0,
            highlightElevation: 1.0,
            onPressed: onSubmit,
            child: Text(
              submit,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:
                    buttonDisabled ? AppTheme.buttonTextDisable : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
