import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class RollingSwitch extends StatefulWidget {
  RollingSwitch(
      {this.value = false,
      this.textOff = 'Off',
      this.textOn = 'On',
      this.textSize = 14.0,
      this.colorOn = Colors.white,
      this.colorOff = Colors.grey,
      this.colorIconOn = Colors.grey,
      this.colorIconOff = Colors.white,
      this.iconOff,
      this.iconOn,
      this.animationDuration = const Duration(milliseconds: 600),
      this.onTap,
      this.onDoubleTap,
      this.onSwipe,
      this.onChanged});

  @required
  final bool value;
  @required
  final Function(bool) onChanged;
  final String textOff;
  final String textOn;
  final Color colorOn;
  final Color colorOff;
  final Color colorIconOn;
  final Color colorIconOff;
  final double textSize;
  final Duration animationDuration;
  final Widget iconOn;
  final Widget iconOff;
  final Function onTap;
  final Function onDoubleTap;
  final Function onSwipe;

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<RollingSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  double value = 0.0;

  bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    //_determine();
    setState(() {
      (turnState)
          ? animationController.forward()
          : animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color transitionCircleColor =
        Color.lerp(widget.colorIconOff, widget.colorIconOn, value);

    return GestureDetector(
      onDoubleTap: () {
        _action();
        if (widget.onDoubleTap != null) widget.onDoubleTap();
      },
      onTap: () {
        _action();
        if (widget.onTap != null) widget.onTap();
      },
      onPanEnd: (details) {
        _action();
        if (widget.onSwipe != null) widget.onSwipe();
        //widget.onSwipe();
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 50,
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(0 * (value), 0),
              child: Transform.rotate(
                angle: lerpDouble(0, 2 * pi, value),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: transitionCircleColor),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          opacity: (1 - value).clamp(0.0, 1.0),
                          child: widget.iconOff,
                        ),
                      ),
                      Center(
                        child: Opacity(
                            opacity: value.clamp(0.0, 1.0),
                            child: widget.iconOn),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();

      widget.onChanged(turnState);
    });
  }
}
