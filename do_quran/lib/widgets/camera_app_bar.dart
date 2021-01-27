import 'package:flutter/material.dart';

class CameraAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CameraAppBar({
    Key key,
    this.title,
    this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  _CameraAppBarState createState() => _CameraAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(83);
}

class _CameraAppBarState extends State<CameraAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: Container(
            decoration: BoxDecoration(
              color:
                  Theme.of(context).appBarTheme.backgroundColor.withOpacity(1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Theme.of(context)
                        .appBarTheme
                        .shadowColor
                        .withOpacity(0.4),
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
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8.0, bottom: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.children != null
                        ? widget.children
                        : <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.title != null ? widget.title : '',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 22,
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
      ],
    );
  }
}
