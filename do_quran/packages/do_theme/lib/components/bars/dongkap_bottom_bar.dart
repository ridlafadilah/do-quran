import 'dart:math' as math;
import 'package:do_theme/models/tabIcon_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DongkapBottomBar extends StatefulWidget {
  const DongkapBottomBar(
      {Key key, this.tabIconsList, this.changeIndex, this.addClick})
      : super(key: key);

  final Function(int index) changeIndex;
  final Function addClick;
  final List<TabIconData> tabIconsList;
  @override
  _DongkapBottomBarState createState() => _DongkapBottomBarState();
}

class _DongkapBottomBarState extends State<DongkapBottomBar>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Container(
          height: 62,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return Transform(
                transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                child: PhysicalShape(
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  elevation: 30.0,
                  clipper: TabClipper(
                      radius: Tween<double>(begin: 0.0, end: 0.0)
                              .animate(CurvedAnimation(
                                  parent: animationController,
                                  curve: Curves.fastOutSlowIn))
                              .value *
                          0.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 62,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 4),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TabIcons(
                                    tabIconData: widget.tabIconsList[0],
                                    removeAllSelect: () {
                                      setRemoveAllSelection(
                                          widget.tabIconsList[0]);
                                      widget.changeIndex(0);
                                    }),
                              ),
                              Expanded(
                                child: TabIcons(
                                    tabIconData: widget.tabIconsList[1],
                                    removeAllSelect: () {
                                      setRemoveAllSelection(
                                          widget.tabIconsList[1]);
                                      widget.changeIndex(1);
                                    }),
                              ),
                              Expanded(
                                child: TabIcons(
                                    tabIconData: widget.tabIconsList[2],
                                    removeAllSelect: () {
                                      setRemoveAllSelection(
                                          widget.tabIconsList[2]);
                                      widget.changeIndex(2);
                                    }),
                              ),
                              Expanded(
                                child: TabIcons(
                                    tabIconData: widget.tabIconsList[3],
                                    removeAllSelect: () {
                                      setRemoveAllSelection(
                                          widget.tabIconsList[3]);
                                      widget.changeIndex(3);
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void setRemoveAllSelection(TabIconData tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}

class TabIcons extends StatefulWidget {
  const TabIcons({Key key, this.tabIconData, this.removeAllSelect})
      : super(key: key);

  final TabIconData tabIconData;
  final Function removeAllSelect;
  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect();
          widget.tabIconData.animationController.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.tabIconData.isSelected) {
              setAnimation();
            }
          },
          child: IgnorePointer(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.88, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController,
                            curve: const Interval(0.1, 1.0,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      height: 70,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                                widget.tabIconData.isSelected
                                    ? widget.tabIconData.selectedImagePath
                                    : widget.tabIconData.imagePath,
                                color: widget.tabIconData.isSelected
                                    ? Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .selectedIconTheme
                                        .color
                                    : Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .unselectedIconTheme
                                        .color,
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 38.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
  }
}
