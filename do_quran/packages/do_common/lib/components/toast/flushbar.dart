import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'flushbar_route.dart' as route;

// ignore: constant_identifier_names
const String FLUSHBAR_ROUTE_NAME = '/flushbarRoute';

typedef void FlushbarStatusCallback(FlushbarStatus status);
typedef void OnTap(Flushbar flushbar);

// ignore: must_be_immutable
class Flushbar<T> extends StatefulWidget {
  Flushbar(
      {Key key,
      String title,
      String message,
      Widget titleText,
      Widget messageText,
      Widget icon,
      bool shouldIconPulse = true,
      double maxWidth,
      EdgeInsets margin = const EdgeInsets.all(0.0),
      EdgeInsets padding = const EdgeInsets.all(16),
      double borderRadius = 0.0,
      Color borderColor,
      double borderWidth = 1.0,
      Color backgroundColor = const Color(0xFF303030),
      Color leftBarIndicatorColor,
      List<BoxShadow> boxShadows,
      Gradient backgroundGradient,
      Widget mainButton,
      OnTap onTap,
      Duration duration,
      bool isDismissible = true,
      FlushbarDismissDirection dismissDirection =
          FlushbarDismissDirection.VERTICAL,
      bool showProgressIndicator = false,
      AnimationController progressIndicatorController,
      Color progressIndicatorBackgroundColor,
      Animation<Color> progressIndicatorValueColor,
      FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM,
      FlushbarStyle flushbarStyle = FlushbarStyle.FLOATING,
      Curve forwardAnimationCurve = Curves.easeOutCirc,
      Curve reverseAnimationCurve = Curves.easeOutCirc,
      Duration animationDuration = const Duration(seconds: 1),
      FlushbarStatusCallback onStatusChanged,
      double barBlur = 0.0,
      bool blockBackgroundInteraction = false,
      double routeBlur,
      Color routeColor,
      Form userInputForm})
      : titleParam = title,
        messageParam = message,
        titleTextParam = titleText,
        messageTextParam = messageText,
        iconParam = icon,
        shouldIconPulseParam = shouldIconPulse,
        maxWidthParam = maxWidth,
        marginParam = margin,
        paddingParam = padding,
        borderRadiusParam = borderRadius,
        borderColorParam = borderColor,
        borderWidthParam = borderWidth,
        backgroundColorParam = backgroundColor,
        leftBarIndicatorColorParam = leftBarIndicatorColor,
        boxShadowsParam = boxShadows,
        backgroundGradientParam = backgroundGradient,
        mainButtonParam = mainButton,
        onTapParam = onTap,
        durationParam = duration,
        isDismissibleParam = isDismissible,
        dismissDirectionParam = dismissDirection,
        showProgressIndicatorParam = showProgressIndicator,
        progressIndicatorControllerParam = progressIndicatorController,
        progressIndicatorBackgroundColorParam =
            progressIndicatorBackgroundColor,
        progressIndicatorValueColorParam = progressIndicatorValueColor,
        flushbarPositionParam = flushbarPosition,
        flushbarStyleParam = flushbarStyle,
        forwardAnimationCurveParam = forwardAnimationCurve,
        reverseAnimationCurveParam = reverseAnimationCurve,
        animationDurationParam = animationDuration,
        barBlurParam = barBlur,
        blockBackgroundInteractionParam = blockBackgroundInteraction,
        routeBlurParam = routeBlur,
        routeColorParam = routeColor,
        userInputFormParam = userInputForm,
        super(key: key) {
    onStatusChangedParam = onStatusChanged ?? (status) {};
  }

  /// A callback for you to listen to the different Flushbar status
  FlushbarStatusCallback onStatusChangedParam;

  /// The title displayed to the user
  final String titleParam;

  /// The message displayed to the user.
  final String messageParam;

  final Widget titleTextParam;

  final Widget messageTextParam;

  final Color backgroundColorParam;

  final Color leftBarIndicatorColorParam;

  final List<BoxShadow> boxShadowsParam;

  final Gradient backgroundGradientParam;

  final Widget iconParam;

  /// An option to animate the icon (if present). Defaults to true.
  final bool shouldIconPulseParam;

  final Widget mainButtonParam;

  final OnTap onTapParam;

  final Duration durationParam;

  final bool showProgressIndicatorParam;

  final AnimationController progressIndicatorControllerParam;

  final Color progressIndicatorBackgroundColorParam;

  final Animation<Color> progressIndicatorValueColorParam;

  final bool isDismissibleParam;

  final double maxWidthParam;

  final EdgeInsets marginParam;

  final EdgeInsets paddingParam;

  final double borderRadiusParam;

  final Color borderColorParam;

  final double borderWidthParam;

  final FlushbarPosition flushbarPositionParam;

  final FlushbarDismissDirection dismissDirectionParam;

  final FlushbarStyle flushbarStyleParam;

  final Curve forwardAnimationCurveParam;

  final Curve reverseAnimationCurveParam;

  final Duration animationDurationParam;

  final double barBlurParam;

  final bool blockBackgroundInteractionParam;

  final double routeBlurParam;

  final Color routeColorParam;

  final Form userInputFormParam;

  route.FlushbarRoute<T> _flushbarRoute;

  Future<T> show(BuildContext context) async {
    _flushbarRoute = route.showFlushbar<T>(
      context: context,
      flushbar: this,
    );

    return await Navigator.of(context, rootNavigator: false)
        .push(_flushbarRoute);
  }

  /// Dismisses the flushbar causing is to return a future containing [result].
  /// When this future finishes, it is guaranteed that Flushbar was dismissed.
  Future<T> dismiss([T result]) async {
    // If route was never initialized, do nothing
    if (_flushbarRoute == null) {
      return null;
    }

    if (_flushbarRoute.isCurrent) {
      _flushbarRoute.navigator.pop(result);
      return _flushbarRoute.completed;
    } else if (_flushbarRoute.isActive) {
      _flushbarRoute.navigator.removeRoute(_flushbarRoute);
    }

    return null;
  }

  /// Checks if the flushbar is visible
  bool isShowing() {
    return _flushbarRoute?.currentStatus == FlushbarStatus.SHOWING;
  }

  /// Checks if the flushbar is dismissed
  bool isDismissed() {
    return _flushbarRoute?.currentStatus == FlushbarStatus.DISMISSED;
  }

  @override
  State createState() {
    return _FlushbarState<T>();
  }
}

class _FlushbarState<K extends Object> extends State<Flushbar>
    with TickerProviderStateMixin {
  final Duration _pulseAnimationDuration = const Duration(seconds: 1);
  final Widget _emptyWidget = const SizedBox();
  final double _initialOpacity = 1.0;
  final double _finalOpacity = 0.4;

  GlobalKey _backgroundBoxKey;
  FlushbarStatus currentStatus;
  AnimationController _fadeController;
  Animation<double> _fadeAnimation;
  bool _isTitlePresent;
  double _messageTopMargin;
  FocusScopeNode _focusNode;
  FocusAttachment _focusAttachment;
  Completer<Size> _boxHeightCompleter;
  Function _progressListener;
  CurvedAnimation _progressAnimation;

  @override
  void initState() {
    super.initState();

    _backgroundBoxKey = GlobalKey();
    _boxHeightCompleter = Completer<Size>();

    assert(
        ((widget.userInputFormParam != null ||
            ((widget.messageParam != null && widget.messageParam.isNotEmpty) ||
                widget.messageTextParam != null))),
        '''
A message is mandatory if you are not using userInputForm. Set either a message or messageText''');

    _isTitlePresent =
        (widget.titleParam != null || widget.titleTextParam != null);
    _messageTopMargin = _isTitlePresent ? 6.0 : widget.paddingParam.top;

    _configureLeftBarFuture();
    _configureProgressIndicatorAnimation();

    if (widget.iconParam != null && widget.shouldIconPulseParam) {
      _configurePulseAnimation();
      _fadeController?.forward();
    }

    _focusNode = FocusScopeNode();
    _focusAttachment = _focusNode.attach(context);
  }

  @override
  void dispose() {
    _fadeController?.dispose();

    widget.progressIndicatorControllerParam?.removeListener(_progressListener);
    widget.progressIndicatorControllerParam?.dispose();

    _focusAttachment.detach();
    _focusNode.dispose();
    super.dispose();
  }

  void _configureLeftBarFuture() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        final keyContext = _backgroundBoxKey.currentContext;

        if (keyContext != null) {
          final RenderBox box = keyContext.findRenderObject();
          _boxHeightCompleter.complete(box.size);
        }
      },
    );
  }

  void _configureProgressIndicatorAnimation() {
    if (widget.showProgressIndicatorParam &&
        widget.progressIndicatorControllerParam != null) {
      _progressAnimation = CurvedAnimation(
          curve: Curves.linear,
          parent: widget.progressIndicatorControllerParam);
    }
  }

  void _configurePulseAnimation() {
    _fadeController =
        AnimationController(vsync: this, duration: _pulseAnimationDuration);
    _fadeAnimation = Tween(begin: _initialOpacity, end: _finalOpacity).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.linear,
      ),
    );

    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _fadeController.forward();
      }
    });

    _fadeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1.0,
      child: Material(
        color: widget.flushbarStyleParam == FlushbarStyle.FLOATING
            ? Colors.transparent
            : widget.backgroundColorParam,
        child: SafeArea(
          minimum: widget.flushbarPositionParam == FlushbarPosition.BOTTOM
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom)
              : EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
          bottom: widget.flushbarPositionParam == FlushbarPosition.BOTTOM,
          top: widget.flushbarPositionParam == FlushbarPosition.TOP,
          left: false,
          right: false,
          child: _getFlushbar(),
        ),
      ),
    );
  }

  Widget _getFlushbar() {
    Widget flushbar;

    if (widget.userInputFormParam != null) {
      flushbar = _generateInputFlushbar();
    } else {
      flushbar = _generateFlushbar();
    }

    return Stack(
      children: [
        FutureBuilder(
          future: _boxHeightCompleter.future,
          builder: (context, AsyncSnapshot<Size> snapshot) {
            if (snapshot.hasData) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadiusParam),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: widget.barBlurParam, sigmaY: widget.barBlurParam),
                  child: Container(
                    height: snapshot.data.height,
                    width: snapshot.data.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(widget.borderRadiusParam),
                    ),
                  ),
                ),
              );
            } else {
              return _emptyWidget;
            }
          },
        ),
        flushbar,
      ],
    );
  }

  Widget _generateInputFlushbar() {
    return Container(
      key: _backgroundBoxKey,
      constraints: widget.maxWidthParam != null
          ? BoxConstraints(maxWidth: widget.maxWidthParam)
          : null,
      decoration: BoxDecoration(
        color: widget.backgroundColorParam,
        gradient: widget.backgroundGradientParam,
        boxShadow: widget.boxShadowsParam,
        borderRadius: BorderRadius.circular(widget.borderRadiusParam),
        border: widget.borderColorParam != null
            ? Border.all(
                color: widget.borderColorParam, width: widget.borderWidthParam)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, bottom: 8.0, top: 16.0),
        child: FocusScope(
          child: widget.userInputFormParam,
          node: _focusNode,
          autofocus: true,
        ),
      ),
    );
  }

  Widget _generateFlushbar() {
    return Container(
      key: _backgroundBoxKey,
      constraints: widget.maxWidthParam != null
          ? BoxConstraints(maxWidth: widget.maxWidthParam)
          : null,
      decoration: BoxDecoration(
        color: widget.backgroundColorParam,
        gradient: widget.backgroundGradientParam,
        boxShadow: widget.boxShadowsParam,
        borderRadius: BorderRadius.circular(widget.borderRadiusParam),
        border: widget.borderColorParam != null
            ? Border.all(
                color: widget.borderColorParam, width: widget.borderWidthParam)
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressIndicator(),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: _getAppropriateRowLayout(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    if (widget.showProgressIndicatorParam && _progressAnimation != null) {
      return AnimatedBuilder(
          animation: _progressAnimation,
          builder: (_, __) {
            return LinearProgressIndicator(
              value: _progressAnimation.value,
              backgroundColor: widget.progressIndicatorBackgroundColorParam,
              valueColor: widget.progressIndicatorValueColorParam,
            );
          });
    }

    if (widget.showProgressIndicatorParam) {
      return LinearProgressIndicator(
        backgroundColor: widget.progressIndicatorBackgroundColorParam,
        valueColor: widget.progressIndicatorValueColorParam,
      );
    }

    return _emptyWidget;
  }

  List<Widget> _getAppropriateRowLayout() {
    double buttonRightPadding;
    double iconPadding = 0;
    if (widget.paddingParam.right - 12 < 0) {
      buttonRightPadding = 4;
    } else {
      buttonRightPadding = widget.paddingParam.right - 12;
    }

    if (widget.paddingParam.left > 16.0) {
      iconPadding = widget.paddingParam.left;
    }

    if (widget.iconParam == null && widget.mainButtonParam == null) {
      return [
        _buildLeftBarIndicator(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.paddingParam.top,
                        left: widget.paddingParam.left,
                        right: widget.paddingParam.right,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.paddingParam.left,
                  right: widget.paddingParam.right,
                  bottom: widget.paddingParam.bottom,
                ),
                child: widget.messageTextParam ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    } else if (widget.iconParam != null && widget.mainButtonParam == null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 42.0 + iconPadding),
          child: _getIcon(),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.paddingParam.top,
                        left: 4.0,
                        right: widget.paddingParam.left,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: 4.0,
                  right: widget.paddingParam.right,
                  bottom: widget.paddingParam.bottom,
                ),
                child: widget.messageTextParam ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    } else if (widget.iconParam == null && widget.mainButtonParam != null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.paddingParam.top,
                        left: widget.paddingParam.left,
                        right: widget.paddingParam.right,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.paddingParam.left,
                  right: 8.0,
                  bottom: widget.paddingParam.bottom,
                ),
                child: widget.messageTextParam ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: buttonRightPadding),
          child: _getMainActionButton(),
        ),
      ];
    } else {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 42.0 + iconPadding),
          child: _getIcon(),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.paddingParam.top,
                        left: 4.0,
                        right: 8.0,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: 4.0,
                  right: 8.0,
                  bottom: widget.paddingParam.bottom,
                ),
                child: widget.messageTextParam ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        Padding(
              padding: EdgeInsets.only(right: buttonRightPadding),
              child: _getMainActionButton(),
            ) ??
            _emptyWidget,
      ];
    }
  }

  Widget _buildLeftBarIndicator() {
    if (widget.leftBarIndicatorColorParam != null) {
      return FutureBuilder(
        future: _boxHeightCompleter.future,
        builder: (BuildContext buildContext, AsyncSnapshot<Size> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: widget.leftBarIndicatorColorParam,
              width: 5.0,
              height: snapshot.data.height,
            );
          } else {
            return _emptyWidget;
          }
        },
      );
    } else {
      return _emptyWidget;
    }
  }

  Widget _getIcon() {
    if (widget.iconParam != null &&
        widget.iconParam is Icon &&
        widget.shouldIconPulseParam) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: widget.iconParam,
      );
    } else if (widget.iconParam != null) {
      return widget.iconParam;
    } else {
      return _emptyWidget;
    }
  }

  Widget _getTitleText() {
    return widget.titleTextParam != null
        ? widget.titleTextParam
        : Text(
            widget.titleParam ?? '',
            style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          );
  }

  Text _getDefaultNotificationText() {
    return Text(
      widget.messageParam ?? '',
      style: const TextStyle(fontSize: 14.0, color: Colors.white),
    );
  }

  Widget _getMainActionButton() {
    if (widget.mainButtonParam != null) {
      return widget.mainButtonParam;
    } else {
      return null;
    }
  }
}

// ignore: constant_identifier_names
enum FlushbarPosition { TOP, BOTTOM }

// ignore: constant_identifier_names
enum FlushbarStyle { FLOATING, GROUNDED }

// ignore: constant_identifier_names
enum FlushbarDismissDirection { HORIZONTAL, VERTICAL }

// ignore: constant_identifier_names
enum FlushbarStatus { SHOWING, DISMISSED, IS_APPEARING, IS_HIDING }
