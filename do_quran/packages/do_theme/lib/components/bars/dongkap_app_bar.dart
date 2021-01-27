import 'package:flutter/material.dart';

class DongkapAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DongkapAppBar({
    Key key,
    this.title,
    this.children,
    @required this.animationController,
    @required this.topBarOpacity,
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final AnimationController animationController;
  final double topBarOpacity;

  @override
  _DongkapAppBarState createState() => _DongkapAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(83 - 19 * topBarOpacity);
}

class _DongkapAppBarState extends State<DongkapAppBar> {
  Animation<double> _topBarAnimation;

  @override
  void initState() {
    _topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    widget.animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: _topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - _topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .appBarTheme
                        .backgroundColor
                        .withOpacity(widget.topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Theme.of(context)
                              .appBarTheme
                              .shadowColor
                              .withOpacity(0.4 * widget.topBarOpacity),
                          offset: const Offset(0.1, 0.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * widget.topBarOpacity,
                            bottom: 12 - 6.0 * widget.topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.children != null
                              ? widget.children
                              : <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.title != null
                                            ? widget.title
                                            : '',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize:
                                              22 + 6 - 6 * widget.topBarOpacity,
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .titleTextStyle
                                              .color,
                                          fontFamily: Theme.of(context)
                                              .appBarTheme
                                              .titleTextStyle
                                              .fontFamily,
                                          fontWeight: Theme.of(context)
                                              .appBarTheme
                                              .titleTextStyle
                                              .fontWeight,
                                          letterSpacing: Theme.of(context)
                                              .appBarTheme
                                              .titleTextStyle
                                              .letterSpacing,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
